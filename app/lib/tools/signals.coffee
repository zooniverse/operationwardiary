TextWidget = require './text-widget'
labels = require '../notes'

class SignalsWidget extends TextWidget
  template: require( '../../views/tools/signals' )( types: labels.signals )
  
  type: 'signals'
  help: '/signals/signals'
  
  getLabel: (target) ->
    $(target).find(':selected').text()
    
module.exports = SignalsWidget