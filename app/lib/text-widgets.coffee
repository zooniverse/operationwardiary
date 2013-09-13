$ = require 'jqueryify'
require './jquery-ui-1.10.3.custom.min.js'

require './google.maps.js'
require './jquery.ui.map.full.min.js'

translate = require 't7e'
labels = require './notes'
Geocoder = require './geocoder'

class Toolbar
  
  constructor: ->
    @template = require('../views/toolbars/diary')( @ )
    
class DiaryToolbar extends Toolbar
  
  tags: labels.toolbars.tags
  
class OrdersToolbar extends Toolbar
  
  tags: labels.toolbars.orders
  
class SignalsToolbar extends Toolbar
  
  tags: labels.toolbars.signals

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
  
  @gc: new Geocoder
  
  updateNote: (target)->
    
    $target = $( target )
    
    $inputs = 
      $target
      .parents( '.annotation' )
      .find( ':input')
    
    note =
      place: ''
      lat: ''
      long: ''
      location: false
      name: ''
      
    update_notes = =>
      $inputs
        .each ->
          note[@name] = @value
        
      note.location = 
        $inputs
          .filter('input[name=location]')
          .is(':checked')
    
    update_notes()
    
    PlaceWidget.gc.geocode( note.place ).done (lat,long, name)=>
      @show_place lat, long
      
      $target
        .parents( '.annotation' )
        .find( 'input[name=lat]' )
        .val( lat )
        .end()
        .find( 'input[name=long]' )
        .val( long )
        .end()
        .find( 'input[name=name]')
        .val( name )
        
      update_notes()
      
        
    note
    
  getLabel: (target) ->
    $(target)
      .parents('.annotation')
      .find('input[name=place]')
      .val()
  
  render: (el)->
    @gmap = $('.map', el)
      .gmap
        zoom: 9
        mapTypeId: google.maps.MapTypeId.TERRAIN
        mapTypeControl: false
    
    lat = el.find( 'input[name=lat]' ).val()
    long = el.find( 'input[name=long]' ).val()
    
    @show_place( lat, long )

  show_place: (lat, long) => 
      latlng = new google.maps.LatLng lat,long
      @marker?= @gmap.gmap 'addMarker', {position: latlng, bounds: false }
      @marker[0].setPosition latlng
      map = @gmap.gmap( 'get', 'map')
      google.maps.event.trigger(map, 'resize');
      map.setCenter latlng

    
      
    
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
      number: ''
      context: ''
      unit: ''
    
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
  
  template: require('../views/tools/unit')( context: labels.unit )
  
  updateNote: (target) ->
    
    note = 
      context: ''
      name: ''
    
    $(target)
      .parents( '.annotation' )
      .find( ':input' )
      .each ->
        note[@name] = @value
    
    note
  
  getLabel: (target) ->
    
    note = @updateNote( target )
    
    context = $(target)
      .parents( '.annotation' )
      .find( 'select[name=context] :selected' )
      .text()
    
    "#{context} #{note.name}"
  
class CasualtiesWidget extends TextWidget
  template: require('../views/tools/casualties')( choices: labels.casualties )
  
  updateNote: (target) ->
    
    note = 
      killed: 0
      died: 0
      wounded: 0
      prisoner: 0
    
    $(target)
      .parents( '.annotation' )
      .find( ':input' )
      .each ->
        note[@name] = parseInt @value
    
    note
  
  getLabel: (target) ->
    
    note = @updateNote( target )
    
    output = []
    
    for choice in labels.casualties
      el = translate 'span', "casualties.#{choice}"
      output.push $(el).text() + ': ' + note[choice]
      
    output.join '\n'

class ActvityWidget extends TextWidget
  
  template: require('../views/tools/activity')( choices: labels.activities )
  
  colour: 'blue'
  
  getLabel: (target) ->
    activity = $(target).val() ? 'trench'
    $(target).find(':selected').text()

class QuartersWidget extends TextWidget
  
  template: require('../views/tools/quarters')( choices: labels.quarters )
  
  getLabel: (target) ->
    activity = $(target).val() ? 'billets'
    $(target).find(':selected').text()

class WeatherWidget extends TextWidget
  
  template: require('../views/tools/weather')( choices: labels.weather )
  
  getLabel: (target) ->
    weather = $(target).val() ? 'fine'
    $(target).find(':selected').text()
  
    
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
  
  
    
  move: (shapes, x, y) ->
    super
    
    _newPath = Raphael.transformPath "M0,0H1026", "T0,#{y}"
    shapes.animate { path: _newPath }, 0
    
  updateNote: (target) ->
    DateWidget.date = super

class DiaryDateWidget extends DateWidget
  mark: (tool)->
    shapes = super
    line = tool.addShape 'path', "M0,0H1026", fill: 'black', stroke: @colour, 'stroke-width': 1, opacity: .3
    shapes.push line
    
    shapes
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
  

class DiaryTimeWidget extends TimeWidget
  mark: (tool)->
    shapes = super
    line = tool.addShape 'path', "M0,0H1026", fill: 'black', stroke: @colour, 'stroke-width': 1, opacity: .3
    shapes.push line
    
    shapes
  
  
class OrdersWidget extends TextWidget
  template: require( '../views/tools/orders' )( types: labels.orders )

class ReferenceWidget extends TextWidget
  template: require '../views/tools/reference'
  
  updateNote: (target) ->
    
    note = 
      reference: ''
    
    $(target)
      .parents( '.annotation' )
      .find( ':input' )
      .each ->
        note[@name] = @value
    
    note
  
class MapRefWidget extends TextWidget
  template: require '../views/tools/mapref'
  
  updateNote: (target) ->
    
    note = 
      mapref: ''
    
    $(target)
      .parents( '.annotation' )
      .find( ':input' )
      .each ->
        note[@name] = @value
    
    note

widgets = 
  date: DateWidget
  time: TimeWidget
  diaryDate: DiaryDateWidget
  diaryTime: DiaryTimeWidget
  person: PersonWidget
  unit: UnitWidget
  place: PlaceWidget
  activity: ActvityWidget
  quarters: QuartersWidget
  casualties: CasualtiesWidget
  weather: WeatherWidget
  orders: OrdersWidget
  reference: ReferenceWidget
  mapref: MapRefWidget
  
Editor =
  widgets: widgets
  DiaryToolbar: DiaryToolbar
  OrdersToolbar: OrdersToolbar
  SignalsToolbar: SignalsToolbar

module.exports = Editor