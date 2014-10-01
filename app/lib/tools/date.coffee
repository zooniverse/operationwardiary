TextWidget = require './text-widget'
labels = require '../notes'

class DateWidget extends TextWidget
  template: require '../../views/tools/date'
  
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

module.exports = DateWidget