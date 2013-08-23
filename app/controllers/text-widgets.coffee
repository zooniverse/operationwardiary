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
    
class PersonWidget extends TextWidget
  @ranks = [
    'Lieut'
    '2 Lieut'
    'Major'
    'Capt'
    'Sgt'
    'Cpl'
    'Pvt'
  ]
  
  template: require('../views/tools/person')( ranks: PersonWidget.ranks )
  
  colour: 'red'
  
  updateNote: (target)->
    notes = []
    $( target )
      .parents( '.annotation')
      .find( ':input')
      .each ->
        notes.push $(@).val()
    
    notes.join ' '
    
  getLabel: (target) ->
    @updateNote(target)

class UnitWidget extends TextWidget
  template: require '../views/tools/unit'

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

module.exports = widgets