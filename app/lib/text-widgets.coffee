$ = require 'jqueryify'
require './jquery-ui-1.10.3.custom.min.js'
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


class WidgetFactory
  
  @registry = {}
  
  @makeWidget: (type, dotRadius = 12) =>
    new WidgetFactory.registry[type] dotRadius

class TextWidget
  template: require '../views/tools/person'
  
  colour: 'white'
  
  constructor: (@dotRadius) ->
    @icon = "images/icons/#{@type}.png"
  
  render: (el)->
    @el = el
    
  mark: (tool) ->
    circle = tool.addShape 'circle', 0, 0, @dotRadius, fill: 'transparent', stroke: @colour, 'stroke-width': 2
    icon = tool.addShape 'image', @icon, 0, 0, 20, 20
    circle.node.setAttributeNS null,"tabindex" , "0"
    [
      icon
      circle
      tool.label
    ]
    
  move: (shapes, x, y)->
    
    if y < 300
      labely = y - 20
    else
      labely = y + 20
      
    shapes[1].attr cx: x, cy: y
    shapes[0].attr x: x-10, y: y-10
    shapes[2].attr x: x, y: labely
    
    box = shapes[2].getBBox()
    shapes[2][0].attr x: box.x - 2, y: box.y - 2
    
    
  updateNote: (target)->
    $(target).val()
    
  getLabel: (target) ->
    $(target).val() ? ''
  
  setNote: (note) =>
    
    if typeof note is 'string'
      @el.find(':input').first().val note
    else
      for name, value of note
        $input = @el.find("[name=#{name}]")
        if $input.attr('type') is 'checkbox'
          $input.prop 'checked', value
        else
          $input.val value


WidgetFactory.registry.place = class PlaceWidget extends TextWidget
  template: require '../views/tools/place'
  
  type: 'place'
  
  gc: new Geocoder
  
  updateNote: (target)->
    
    @el
      .find('.suggestions')
      .html ''
    
    note = @update_notes()
    
    @gc.geocode( note.place )
      .pipe( (places) =>
        @choose_place places
      )
      .progress( (place)=>
        @update_place place
      )
      .done (place)=>
        @update_place place
      
        
    note
  
  update_notes: =>
    note =
      place: ''
      lat: ''
      long: ''
      location: false
      name: ''
      
    $inputs = @el.find( '.annotation :input' )
      
    $inputs
      .each ->
        note[@name] = @value
      
    note.location = 
      $inputs
        .filter('input[name=location]')
        .is(':checked')
    
    note
  
  update_place: (place) =>
    {lat, long, name} = place
  
    @el
      .find( 'input[name=lat]' )
      .val( lat )
      .end()
      .find( 'input[name=long]' )
      .val( long )
      .end()
      .find( 'input[name=name]')
      .val( name )
    
    note = @update_notes()
    @gc.save_place( note.place, place )
  
    @show_place lat, long
    
  getLabel: (target) ->
    $(target)
      .parents('.annotation')
      .find('input[name=place]')
      .val()
  
  render: (el)->
    super
    return unless google? && google.maps?
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
    google.maps.event.trigger map, 'resize'
    map.setCenter latlng
  
  choose_place: (places) =>
    promise = new $.Deferred
    
    if places.length == 1
      place = places[0]
      promise.resolve place
    else
      $suggestions = @el.find '.suggestions'
      for place in places
        input = 
          $("<input/>")
          .attr( "type", 'radio' )
          .attr( 'name', 'placeOption')
          .on( 'change', place, (e)->
            place = e.data
            e.preventDefault()
            e.stopPropagation()
            promise.notify place
          )
        label = $("<label><span>#{place.name}<span></label>").prepend input
        $suggestions.append label
      
      input = 
        $("<input/>")
        .attr( "type", 'radio' )
        .attr( 'name', 'placeOption')
        .on( 'change', (e)=>
          place =
            placename: @el.find('input[name=place]').val()
            lat: null
            long: null
            name: ''
            id: null
          e.preventDefault()
          e.stopPropagation()
          promise.notify place
        )
      label = $("<label><span>None of these<span></label>").prepend input
      $suggestions.append label
    
    promise

    
      
    


WidgetFactory.registry.person = class PersonWidget extends TextWidget
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
  
  type: 'person'
  
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



WidgetFactory.registry.unit = class UnitWidget extends TextWidget
  
  template: require('../views/tools/unit')( context: labels.unit )
  
  type: 'unit'
  
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
    
    "#{note.name}"
  


WidgetFactory.registry.casualties = class CasualtiesWidget extends TextWidget
  template: require('../views/tools/casualties')( choices: labels.casualties )
  
  type: 'casualty'
  
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

    total = (note[choice] for choice of note).reduce (a,b) -> a + b
      
    "Casualties: #{total}"




WidgetFactory.registry.activity = class ActvityWidget extends TextWidget
  
  template: require('../views/tools/activity')( choices: labels.activities )
  
  type: 'activity'
  
  getLabel: (target) ->
    $(target).find(':selected').text()



WidgetFactory.registry.quarters = class QuartersWidget extends TextWidget
  
  template: require('../views/tools/quarters')( choices: labels.quarters )
  
  type: 'quarters'
  
  getLabel: (target) ->
    activity = $(target).val() ? 'billets'
    $(target).find(':selected').text()



WidgetFactory.registry.weather = class WeatherWidget extends TextWidget
  
  template: require('../views/tools/weather')( choices: labels.weather )
  
  type: 'weather'
  
  getLabel: (target) ->
    'Weather: ' + $(target).find(':selected').text()
  
    


WidgetFactory.registry.date = class DateWidget extends TextWidget
  template: require '../views/tools/date'
  
  type: 'date'
  
  @date: '1 May 1915'
  
  @formatDate: (format, date) =>
    $.datepicker.formatDate format, date
  
  render: (el)->
    super
    @input = $('.date', el)
    @calendar = $('.calendar', el)
    
    @calendar
      .datepicker
        dateFormat: 'd MM yy'
        changeMonth: true
        changeYear: true
        defaultDate: DateWidget.date
        altField: @input
        onSelect: =>
          @input.trigger 'change'
    
    @input.on 'change', =>
      @updateNote @input
      @calendar.datepicker 'setDate', @input.val()
  
  
    
  move: (shapes, x, y) ->
    super
    
    _newPath = Raphael.transformPath "M0,0H1026", "T0,#{y}"
    shapes.animate { path: _newPath }, 0
    
  updateNote: (target) =>
    date = @input.val()
    @calendar.datepicker('setDate', date)
    DateWidget.date = date
    
    
  getLabel: (target) =>
    @input.val() ? ''

WidgetFactory.registry.diaryDate = class DiaryDateWidget extends DateWidget
  
  type: 'date'
  
  mark: (tool)->
    shapes = super
    line = tool.addShape 'path', "M0,0H1026", fill: 'black', stroke: @colour, 'stroke-width': 1, opacity: .3
    shapes.push line
    
    shapes


WidgetFactory.registry.time = class TimeWidget extends TextWidget
  template: require '../views/tools/time'
  
  type: 'time'
  
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
    
  setNote: (note, el) =>
    return unless note?
    time = 
      hour: note[0..1]
      minute: note[2..3]
      am: note[4..5]
      
    super time, el
  


WidgetFactory.registry.diaryTime = class DiaryTimeWidget extends TimeWidget
  
  type: 'time'
  
  mark: (tool)->
    shapes = super
    line = tool.addShape 'path', "M0,0H1026", fill: 'black', stroke: @colour, 'stroke-width': 1, opacity: .3
    shapes.push line
    
    shapes
  

WidgetFactory.registry.orders = class OrdersWidget extends TextWidget
  template: require( '../views/tools/orders' )( types: labels.orders )
  
  type: 'orders'


WidgetFactory.registry.reference = class ReferenceWidget extends TextWidget
  template: require '../views/tools/reference'
  
  type: 'reference'
  
  updateNote: (target) ->
    
    note = 
      reference: ''
    
    $(target)
      .parents( '.annotation' )
      .find( ':input' )
      .each ->
        note[@name] = @value
    
    note
 

WidgetFactory.registry.mapRef = class MapRefWidget extends TextWidget
  template: require '../views/tools/mapref'
  
  type: 'map_ref'
  
  render: (el)->
    super
    $('.date', el)
      .datepicker
        dateFormat: 'd MM yy'
        changeMonth: true
        changeYear: true
        defaultDate: DateWidget.date
      .val DateWidget.date
  
  updateNote: (target) ->
    
    note = 
      sheet: ''
      scale: ''
      date: ''
    
    $(target)
      .parents( '.annotation' )
      .find( ':input' )
      .each ->
        note[@name] = @value
    
    note
    
  getLabel: (target) ->
    
    note = @updateNote( target )
    
    "Sheet #{note.sheet}, #{note.scale}, #{note.date}"


WidgetFactory.registry.gridRef = class GridRefWidget extends TextWidget
  template: require '../views/tools/gridref'
  
  type: 'grid'
  
  updateNote: (target) ->
    
    note = 
      gridref: ''
    
    $(target)
      .parents( '.annotation' )
      .find( ':input' )
      .each ->
        note[@name] = @value
    
    note


Editor =
  WidgetFactory: WidgetFactory
  toolbars:
    diary: new DiaryToolbar
    orders: new OrdersToolbar
    signals: new SignalsToolbar

module.exports = Editor