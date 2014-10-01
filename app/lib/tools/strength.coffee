CasualtiesWidget = require './casualties'
labels = require '../notes'

class StrengthWidget extends CasualtiesWidget
  template: require('../../views/tools/strength')( choices: labels.strength )

  type: 'strength'
  help: '/diary/strength'
  
  updateNote: (target) ->
    
    note = 
      officer: 0
      nco: 0
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
      
    "Strength: #{total}"

module.exports = StrengthWidget