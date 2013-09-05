translate = require 't7e'
labels = require '../lib/notes'

class TextWidget
  template: require '../views/tools/person'
  
  colour: 'black'
  
  constructor: (@dotRadius) ->
  
  render: ->
    
  mark: (tool) ->
    [
      tool.addShape 'circle', 0, 0, @dotRadius, fill: 'black', stroke: @colour, 'stroke-width': 3
      tool.label
    ]
    
  move: (shapes, x, y)->
    shapes[0].attr cx: x, cy: y
    shapes[1].attr x: x, y: y - 15
    
    
  updateNote: (target)->
    $(target).val()
    
  getLabel: (target) ->
    $(target).val() ? ''
    

class PlaceWidget extends TextWidget
  template: require '../views/tools/place'
  
  colour: 'green'
  
  updateNote: (target)->
    
    $target = $( target )
    
    note =
      place: $target.val()
      lat: ''
      long: ''
    
    @geocode( note.place ).done (lat,long)=>
      @show_place lat, long
      
      $target
        .parents( '.annotation' )
        .find( 'input[name=lat]' )
        .val( lat )
        .end()
        .find( 'input[name=long]' )
        .val( long )
        .end()
        .find( ':input')
        .each ->
          note[@name] = @value
        
    note
  
  render: (el)->
    @gmap = $('.map', el)
      .gmap
        zoom: 9
        
  
  geocode: (placename, service='geonames') =>
    promise = new $.Deferred
    
    return promise unless placename
    
    queries = 
      geoplanet: "select * from geo.placefinder where text='#{placename}' and countrycode in ('BE','FR','GB') limit 1"
      geonames: "select * from xml where url='http://api.geonames.org/search?q=#{placename}&country=BE&country=GB&country=FR&maxRows=1&username=zooniverse'"
    
    query = queries[service]
    console.log query
    pf_url = "http://query.yahooapis.com/v1/public/yql?q=#{ escape query }&format=json&callback=?"
    # TODO: OAuth this call to avoid rate-limiting. Cache results too.
    
    $.getJSON( pf_url ).done (response)->
      
      results = response.query.results
      
      return unless results
      
      switch service
        when 'geonames'
          lat = parseFloat results.geonames?.geoname.lat
          long = parseFloat results.geonames?.geoname.lng
        when 'geoplanet'
          lat = parseFloat results.Result?.latitude
          long = parseFloat results.Result?.longitude
      
      promise.resolve lat,long
      
    promise
    
  
  show_place: (lat, long) => 
      latlng = new google.maps.LatLng lat,long
      @marker?= @gmap.gmap 'addMarker', {position: latlng, bounds: false }
      @marker[0].setPosition latlng
      @gmap.gmap( 'get', 'map').panTo latlng

    
      
    
class PersonWidget extends TextWidget
  @ranks = [
    'Colonel'
    'Lieut-Colonel'
    'Major'
    'Capt'
    'Lieut'
    '2 Lieut'
    'Sgt'
    'Cpl'
    'Pvt'
  ]
  
  template: require('../views/tools/person')( ranks: PersonWidget.ranks, context: labels.person )
  
  colour: 'red'
  
  updateNote: (target)->
    note =
      rank: ''
      first: ''
      surname: ''
    
    $( target )
      .parents( '.annotation')
      .find( ':input')
      .each ->
        note[@name] = @value
    
    note
    
  getLabel: (target) ->
    note = @updateNote(target)
    "#{note.rank} #{note.first} #{note.surname}"

class UnitWidget extends TextWidget
  @units = [
    'Corps'
    'Brigade'
    'Battalion'
    'Company'
  ]
  
  template: require('../views/tools/unit')( units: UnitWidget.units )
  
  updateNote: (target) ->
    
    note = 
      type: ''
      name: ''
    
    $(target)
      .parents( '.annotation' )
      .find( ':input' )
      .each ->
        note[@name] = @value
    
    note
  
  getLabel: (target) ->
    
    note = @updateNote( target )
    
    "#{note.type}: #{note.name}"
  
class CasualtiesWidget extends TextWidget
  template: require '../views/tools/casualties'
  
  updateNote: (target) ->
    
    note = 
      killed: 0
      dow: 0
      wounded: 0
    
    $(target)
      .parents( '.annotation' )
      .find( ':input' )
      .each ->
        note[@name] = parseInt @value
    
    note
  
  getLabel: (target) ->
    
    note = @updateNote( target )
    
    "Killed: #{note.killed}\n Died of wounds: #{note.dow}\n Wounded: #{note.wounded}"

class ActvityWidget extends TextWidget
  
  template: require('../views/tools/activity')( choices: labels.activities )
  
  colour: 'blue'
  
  getLabel: (target) ->
    activity = $(target).val() ? 'trench'
    el = translate 'span', "activities.#{activity}"
    $(el).text()

class QuartersWidget extends TextWidget
  
  template: require('../views/tools/quarters')( choices: labels.quarters )
  
  getLabel: (target) ->
    activity = $(target).val() ? 'billets'
    el = translate 'span', "quarters.#{activity}"
    $(el).text()

class WeatherWidget extends TextWidget
  
  template: require('../views/tools/weather')( choices: labels.weather )
  
  getLabel: (target) ->
    weather = $(target).val() ? 'fine'
    el = translate 'span', "weather.#{weather}"
    $(el).text()
  
    
class DateWidget extends TextWidget
  template: require '../views/tools/date'
  
  colour: 'purple'
  
  @date: '1 May 1915'
  
  render: (el)->
    $('.date', el)
      .datepicker
        dateFormat: 'd MM yy'
        changeMonth: true
        changeYear: true
        defaultDate: DateWidget.date
      .val DateWidget.date
  
  mark: (tool)->
    
    [
      tool.addShape 'circle', 0, 0, @dotRadius, fill: 'black', stroke: @colour, 'stroke-width': 3
      tool.label
      tool.addShape 'path', "M0,0H1026", fill: 'black', stroke: @colour, 'stroke-width': 1
    ]
    
  move: (shapes, x, y) ->
    super
    
    _newPath = Raphael.transformPath "M0,0H1026", "T0,#{y}"
    shapes.animate { path: _newPath }, 0
    
  updateNote: (target) ->
    DateWidget.date = super

class TimeWidget extends DateWidget
  template: require '../views/tools/time'
  
  updateNote: (target)->
    note = ''
    $( target )
      .parents( '.annotation')
      .find( 'select')
      .each ->
        note += $(@).val()
    
    note
    
  getLabel: (target) ->
    @updateNote(target)
  
widgets = 
  date: DateWidget
  time: TimeWidget
  person: PersonWidget
  unit: UnitWidget
  place: PlaceWidget
  activity: ActvityWidget
  quarters: QuartersWidget
  casualties: CasualtiesWidget
  weather: WeatherWidget

module.exports = widgets