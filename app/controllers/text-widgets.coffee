labels = require '../lib/notes'
dotRadius = if 'Touch' of window then 10 else 5

class TextWidget
  template: require '../views/tools/person'
  
  colour: 'grey'
  
  render: ->
    
  mark: (tool) ->
    tool.addShape 'circle', 0, 0, dotRadius, fill: 'black', stroke: @colour, 'stroke-width': 3
    
  move: (shapes, x, y)->
    shapes.attr cx: x, cy: y
    

class PlaceWidget extends TextWidget
  template: require '../views/tools/place'
  
  colour: 'green'
    
class PersonWidget extends TextWidget
  template: require '../views/tools/person'
  
  colour: 'red'

class UnitWidget extends TextWidget
  template: require '../views/tools/unit'

class ActvityWidget extends TextWidget
  
  template: require('../views/tools/activity')( choices: labels.activities )
  
  colour: 'blue'

class QuartersWidget extends TextWidget
  
  template: require('../views/tools/quarters')( choices: labels.quarters )
    
class DateWidget extends TextWidget
  template: require '../views/tools/date'
  
  colour: 'purple'
  
  render: (el)->
    $('.date', el).datepicker
      dateFormat: 'd MM yy'
      changeMonth: true
      changeYear: true
  
  mark: (tool)->
    [
      tool.addShape 'circle', 0, 0, dotRadius, fill: 'black', stroke: @colour, 'stroke-width': 3
      tool.addShape 'path', "M0,0H1026", fill: 'black', stroke: @colour, 'stroke-width': 1
    ]
    
  move: (shapes, x, y) ->
    super
    
    _newPath = Raphael.transformPath "M0,0H1026", "T0,#{y}"
    shapes.animate { path: _newPath }, 0

widgets = 
  date: DateWidget
  person: PersonWidget
  unit: UnitWidget
  place: PlaceWidget
  activity: ActvityWidget
  quarters: QuartersWidget

module.exports = widgets