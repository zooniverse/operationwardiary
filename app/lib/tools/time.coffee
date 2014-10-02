TextWidget = require './text-widget'

class TimeWidget extends TextWidget
  template: require '../../views/tools/time'
  
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
    
  setNote: (note) =>
    return unless note?
    time = 
      hour: note[0..1]
      minute: note[2..3]
      am: note[4..5]
      
    super time

module.exports = TimeWidget