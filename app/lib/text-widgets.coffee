translate = require 't7e'
labels = require './notes'
Geocoder = require './geocoder'

class Toolbar
  
  constructor: ->
    @template = require('../views/toolbars/diary')( @ )
    
class DiaryToolbar extends Toolbar
  
  tags: labels.toolbars.diary
  
class OrdersToolbar extends Toolbar
  
  tags: labels.toolbars.orders
  
class SignalsToolbar extends Toolbar
  
  tags: labels.toolbars.signals

class ReportToolbar extends Toolbar
  
  tags: labels.toolbars.report
  
class DefaultToolbar extends Toolbar
  
  constructor: ->
    @template = require('../views/toolbars/default')( @ )


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
    
    box = shapes[2][1].getBBox()
    y_offset = 15 + box.height / 2
    
    if y < 300
      labely = y - y_offset
    else
      labely = y + y_offset
      
    shapes[1].attr cx: x, cy: y
    shapes[0].attr x: x-10, y: y-10
    shapes[2].attr x: x, y: labely
    
    box = shapes[2][1].getBBox()
    shapes[2][0].attr x: box.x - 2, y: box.y - 2, width: box.width + 4, height: box.height + 4
    
    
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
  help: '/diary/place'
  
  gc: new Geocoder
  
  updateNote: (target)->
    
    @el
      .find('.suggestions')
      .html('')
      .removeClass 'open'
    
    placename = @el.find('input[name=place]').val()
    
    @gc.geocode( placename )
      .pipe( (places) =>
        @choose_place places
      )
      .progress( (place)=>
        console?.log place
        @update_place place
      )
      .done (place)=>
        @update_place place
      
        
    note = @update_notes()
    console?.log note
    note
  
  update_notes: =>
    note =
      place: ''
      lat: ''
      long: ''
      location: false
      name: ''
      id: ''
      
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
    {lat, long, name, id} = place
  
    @el
      .find( 'input[name=lat]' )
      .val( lat )
      .end()
      .find( 'input[name=long]' )
      .val( long )
      .end()
      .find( 'input[name=name]')
      .val( name )
      .end()
      .find( 'input[name=id]')
      .val( id )
    
    placename = @el.find('input[name=place]').val()
  
    @show_place lat, long
    
  getLabel: (target) ->
    $(target)
      .parents('.annotation')
      .find('input[name=place]')
      .val()
  
  render: (el)->
    super
    return unless google? && google.maps?
    try
      map_options =
        zoom: 9
        mapTypeId: google.maps.MapTypeId.TERRAIN
        mapTypeControl: false
        zoomControl: true,
        zoomControlOptions:
          style: google.maps.ZoomControlStyle.SMALL
          
      @gmap = new google.maps.Map $('.map', @el)[0], map_options
      lat = el.find( 'input[name=lat]' ).val()
      long = el.find( 'input[name=long]' ).val()
    
      @show_place( lat, long )
    catch e
      console?.log 'Google maps not available'

  show_place: (lat, long) =>
    return unless google? && google.maps?
    try
      latlng = new google.maps.LatLng lat,long
      @marker?= new google.maps.Marker 
        position: latlng
        map: @gmap
        bounds: false
      @marker[0].setPosition latlng
      google.maps.event.trigger @gmap, 'resize'
      @gmap.setCenter latlng
    catch e
      console?.log e.message
  
  choose_place: (places) =>
    promise = new $.Deferred
    
    
    $suggestions = @el.find '.suggestions'
    $placename = @el.find('input[name=place]')
    $id = @el.find('input[name=id]')
    
    group_id = $suggestions.uniqueId().attr 'id'
    
    console?.log $id.val()
    
    selected = false
    nowhere =
      placename: @el.find('input[name=place]').val()
      lat: null
      long: null
      name: ''
      id: ''
    
    build_input = (label, place) =>
      label = $("<label><span>#{label}</span></label>")
      input = 
        $("<input/>")
        .attr( "type", 'radio' )
        .attr( 'name', group_id)
        .on( 'change', place, (e)->
          place = e.data
          e.preventDefault()
          e.stopPropagation()
          promise.notify place
          $suggestions.find('label').off 'mouseover focus'
          $placename.trigger 'change'
          
        )
      label.prepend input
      label.on 'mouseover focus', place, (e)=>
        place = e.data
        @show_place place.lat, place.long
        
      $suggestions.append label
      if place.id == $id.val()
        input.attr('checked', 'checked').prop 'checked', true 
        @show_place place.lat, place.long
        selected = true
      
      input
      
    not_sure = build_input translate('span', 'classifier.place.none'), nowhere    
    build_input place.name, place for place in places
      
    $suggestions.addClass 'open'
    $suggestions.find('label').off 'mouseover focus' if selected
    unless selected
      not_sure.attr('checked', 'checked').prop 'checked', true 
      @show_place nowhere.lat, nowhere.long
      promise.notify nowhere
    
    promise

    
      
    


WidgetFactory.registry.person = class PersonWidget extends TextWidget
  @ranks = [
    'Assistant Paymaster'
    'Battery Sergeant Major'
    'Bombardier'
    'Brigadier'
    'Brigadier General'
    'Captain'
    'Chaplain'
    'Colonel'
    'Colour Sergeant'
    'Company Quarter Master Sergeant'
    'Company Sergeant Major '
    'Corporal'
    'Driver'
    'Drummer'
    'Farrier'
    'Farrier Sergeant'
    'Field Marshal'
    'Fusilier'
    'General'
    'Guardsman'
    'Gunner'
    'Lance Bombardier'
    'Lance Corporal'
    'Lance Sergeant'
    'Lieutenant'
    'Lieutenant Colonel'
    'Lieutenant General'
    'Major'
    'Major General'
    'Officer Cadet'
    'Paymaster'
    'Pioneer'
    'Private'
    'Quarter Master Sergeant'
    'Regimental Quarter Master Sergeant'
    'Regimental Sergeant Major'
    'Rifleman'
    'Sapper'
    'Second Corporal'
    'Second Lieutenant'
    'Sergeant'
    'Sergeant Major'
    'Shoeing Smith'
    'Signaller'
    'Staff Sergeant'
    'Trooper'
    'Warrant Officer'
    'Warrant Officer Class I'
    'Warrant Officer Class II'
  ]
  
  template: require('../views/tools/person')( ranks: PersonWidget.ranks, context: labels.person )
  
  type: 'person'
  help: '/diary/person'
  
  updateNote: (target)->
    note =
      rank: ''
      first: ''
      surname: ''
      number: ''
      reason: ''
      unit: ''
    
    $( target )
      .parents( '.annotation')
      .find( ':input')
      .each ->
        note[@name] = @value
    
    note
    
  getLabel: (target) ->
    note = @updateNote(target)
    reason = @el.find('select[name=reason] :selected').text()
    "#{note.rank} #{note.first} #{note.surname}\n(#{reason})"



WidgetFactory.registry.unit = class UnitWidget extends TextWidget
  
  template: require('../views/tools/unit')( context: labels.unit )
  
  type: 'unit'
  help: '/diary/unit'
  
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
  help: '/diary/casualties'
  
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
        @value = 0 if @value == ''
        note[@name] = parseInt @value
    
    note
  
  getLabel: (target) ->
    
    note = @updateNote( target )

    total = (note[choice] for choice of note).reduce (a,b) -> a + b
      
    "Casualties: #{total}"

WidgetFactory.registry.strength = class StrengthWidget extends CasualtiesWidget
  template: require('../views/tools/strength')( choices: labels.strength )

  type: 'strength'
  
  updateNote: (target) ->
    
    note = 
      officer: 0
      nco: 0
      other: 0
    
    $(target)
      .parents( '.annotation' )
      .find( ':input' )
      .each ->
        @value = 0 if @value == ''
        note[@name] = parseInt @value
    
    note
  
  getLabel: (target) ->
    
    note = @updateNote( target )

    total = (note[choice] for choice of note).reduce (a,b) -> a + b
      
    "Strength: #{total}"
WidgetFactory.registry.activity = class ActvityWidget extends TextWidget
  
  template: require('../views/tools/activity')( choices: labels.activity )
  
  type: 'activity'
  help: '/diary/activity'
  
  getLabel: (target) ->
    $(target).find(':selected').text()

WidgetFactory.registry.domestic = class DomesticWidget extends TextWidget
  
  template: require('../views/tools/domestic')( choices: labels.domestic )
  
  type: 'domestic'
  help: '/diary/domestic'
  
  getLabel: (target) ->
    $(target).find(':selected').text()

WidgetFactory.registry.quarters = class QuartersWidget extends TextWidget
  
  template: require('../views/tools/quarters')( choices: labels.quarters )
  
  type: 'quarters'
  help: '/diary/quarters'
  
  getLabel: (target) ->
    activity = $(target).val() ? 'billets'
    $(target).find(':selected').text()



WidgetFactory.registry.weather = class WeatherWidget extends TextWidget
  
  template: require('../views/tools/weather')( choices: labels.weather )
  
  type: 'weather'
  help: '/diary/weather'
  
  getLabel: (target) ->
    'Weather: ' + $(target).find(':selected').text()
  
    


WidgetFactory.registry.date = class DateWidget extends TextWidget
  template: require '../views/tools/date'
  
  type: 'date'
  help: '/signals/date'
  
  @date: '1 May 1915'
  
  @formatDate: (format, date) =>
    $.datepicker.formatDate format, date
  
  render: (el)->
    super
    @input = $('.date', el)
    @calendar = $('.calendar', el)
    
    @input.on 'change', =>
      @updateNote @input
    
    @calendar
      .datepicker
        dateFormat: 'd M yy'
        changeMonth: true
        changeYear: true
        defaultDate: DateWidget.date
        altField: @input
        altFormat: 'd M yy'
        onSelect: =>
          @input.trigger 'change'
        onChangeMonthYear: (year, month, inst) =>
          date = @calendar.datepicker 'getDate'
          return unless date?
          date.setMonth month - 1
          date.setYear year
          @calendar.datepicker 'setDate', date
          @input.trigger 'change'
  
  
    
  move: (shapes, x, y) ->
    super
    
    _newPath = Raphael.transformPath "M0,0H1026", "T0,#{y}"
    shapes.animate { path: _newPath }, 0
    
  updateNote: (target) =>
    date = @input.val()
    
    try 
      @setDate 'd M yy', date
    catch e
      try 
        @setDate 'd MM yy', date
    
  getLabel: (target) =>
    @input.val() ? ''
  
  setDate: (format, date) =>
    @calendar.datepicker 'setDate', $.datepicker.parseDate format, date
    DateWidget.date = date
    

WidgetFactory.registry.diaryDate = class DiaryDateWidget extends DateWidget
  
  type: 'date'
  help: '/diary/diaryDate'
  
  mark: (tool)->
    shapes = super
    line = tool.addShape 'path', "M0,0H1026", fill: 'black', stroke: @colour, 'stroke-width': 1, opacity: .3
    shapes.push line
    
    shapes


WidgetFactory.registry.time = class TimeWidget extends TextWidget
  template: require '../views/tools/time'
  
  type: 'time'
  help: '/diary/time'
  
  updateNote: (target)->
    note = ''
    $( target )
      .parents( '.annotation')
      .find( 'select, input')
      .each ->
        note += "0#{ $(@).val() }"[-2..-1]
    
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
  help: '/diary/diaryTime'
  
  mark: (tool)->
    shapes = super
    line = tool.addShape 'path', "M0,0H1026", fill: 'black', stroke: @colour, 'stroke-width': 1, opacity: .3
    shapes.push line
    
    shapes
  

WidgetFactory.registry.orders = class OrdersWidget extends TextWidget
  template: require( '../views/tools/orders' )( types: labels.orders )
  
  type: 'orders'
  help: '/orders/orders'
  
  getLabel: (target) ->
    $(target).find(':selected').text()
  
WidgetFactory.registry.signals = class SignalsWidget extends TextWidget
  template: require( '../views/tools/signals' )( types: labels.signals )
  
  type: 'signals'
  help: '/signals/signals'
  
  getLabel: (target) ->
    $(target).find(':selected').text()

WidgetFactory.registry.title = class TitleWidget extends TextWidget
  template: require '../views/tools/title'
  
  type: 'title'
  help: '/report/title'
  

WidgetFactory.registry.reference = class ReferenceWidget extends TextWidget
  template: require '../views/tools/reference'
  
  type: 'reference'
  help: '/diary/reference'
  
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
  
  type: 'mapref'
  help: '/diary/mapRef'
  
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
  
  type: 'gridref'
  help: '/diary/gridRef'
  
  render: (el)->
    super
    id = el
      .find('label')
      .uniqueId()
      .attr('id')
    
    el
      .find( 'input' )
      .attr('aria-labelledby', id)
    
  
  updateNote: (target) ->
    
    note = {}
    
    @el
      .find( '.annotation :input' )
      .each ->
        note[@name] = @value
    
    note
    
  getLabel: (target) ->
    
    note = @updateNote( target )
    
    labels = (value for key, value of note)
    
    labels.join ' '


Editor =
  WidgetFactory: WidgetFactory
  toolbars:
    diary: new DiaryToolbar
    orders: new OrdersToolbar
    signals: new SignalsToolbar
    blank: new DefaultToolbar
    cover: new DefaultToolbar
    report: new ReportToolbar
    other: new DefaultToolbar

module.exports = Editor