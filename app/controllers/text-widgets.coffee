labels = require '../lib/notes'

class TextWidget
  widget: require '../views/tools/person'
  
  colour: 'grey'
  
  render: ->

class PlaceWidget extends TextWidget
  widget: require '../views/tools/place'
  
  colour: 'green'
    
class PersonWidget extends TextWidget
  widget: require '../views/tools/person'
  
  colour: 'red'

class UnitWidget extends TextWidget
  widget: require '../views/tools/unit'

class ActvityWidget extends TextWidget
  
  widget: require('../views/tools/activity')( choices: labels.activities )
  
  colour: 'blue'

class QuartersWidget extends TextWidget
  
  widget: require('../views/tools/quarters')( choices: labels.quarters )
    
class DateWidget extends TextWidget
  widget: require '../views/tools/date'
  
  colour: 'purple'
  
  render: (el)->
    $('.date', el).datepicker
      dateFormat: 'd MM yy'
      changeMonth: true
      changeYear: true

widgets = 
  date: DateWidget
  person: PersonWidget
  unit: UnitWidget
  place: PlaceWidget
  activity: ActvityWidget
  quarters: QuartersWidget

module.exports = widgets