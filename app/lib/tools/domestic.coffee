TextWidget = require './text-widget'
labels = require '../notes'

class DomesticWidget extends TextWidget
  
  template: require('../../views/tools/domestic')( choices: labels.domestic )
  
  type: 'domestic'
  help: '/diary/domestic'
  
  getLabel: (target) ->
    $(target).find(':selected').text()

module.exports = DomesticWidget