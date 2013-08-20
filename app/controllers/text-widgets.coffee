labels = require '../lib/notes'

class TextWidget
  widget: require '../views/tools/person'
  
  render: ->

class PlaceWidget extends TextWidget
  widget: require '../views/tools/place'
    
class PersonWidget extends TextWidget
  widget: require '../views/tools/person'

class UnitWidget extends TextWidget
  widget: require '../views/tools/unit'

class ActvityWidget extends TextWidget
  
  widget: require('../views/tools/activity')( choices: labels.activities )

class QuartersWidget extends TextWidget
  
  widget: require('../views/tools/quarters')( choices: labels.quarters )
    
class DateWidget extends TextWidget
  widget: require '../views/tools/date'
  
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