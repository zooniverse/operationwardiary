TextWidget = require './text-widget'
labels = require '../notes'

class CasualtiesWidget extends TextWidget
  template: require('../../views/tools/casualties')( choices: labels.casualties )
  
  type: 'casualty'
  help: '/diary/casualties'
  
  updateNote: (target) ->
    
    note = 
      killed: 0
      died: 0
      wounded: 0
      prisoner: 0
      non_combat: 0
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
      
    "Casualties: #{total}"
    
module.exports = CasualtiesWidget