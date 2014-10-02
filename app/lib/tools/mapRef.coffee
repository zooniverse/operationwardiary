TextWidget = require './text-widget'
labels = require '../notes'
DateWidget = require './date'

class MapRefWidget extends TextWidget
  template: require '../../views/tools/mapref'
  
  type: 'mapref'
  help: '/diary/mapRef'
  
  render: =>
    super
    $('.date', @el)
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

module.exports = MapRefWidget
