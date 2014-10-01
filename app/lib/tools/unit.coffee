TextWidget = require './text-widget'
labels = require '../notes'

class UnitWidget extends TextWidget
  
  template: require('../../views/tools/unit')( context: labels.unit )
  
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

module.exports = UnitWidget