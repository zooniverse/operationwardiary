TextWidget = require './text-widget'
labels = require '../notes'

class QuartersWidget extends TextWidget
  
  template: require('../../views/tools/quarters')( choices: labels.quarters )
  
  type: 'quarters'
  help: '/diary/quarters'
  
  getLabel: (target) ->
    activity = $(target).val() ? 'billets'
    $(target).find(':selected').text()

module.exports = QuartersWidget
