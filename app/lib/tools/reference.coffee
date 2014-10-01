TextWidget = require './text-widget'
labels = require '../notes'

class ReferenceWidget extends TextWidget
  template: require '../../views/tools/reference'
  
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
    
module.exports = ReferenceWidget