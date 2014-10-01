TextWidget = require './text-widget'
labels = require '../notes'

class ActivityWidget extends TextWidget
  
  template: require('../../views/tools/activity')( choices: labels.activity )
  
  type: 'activity'
  help: '/diary/activity'
  
  getLabel: (target) ->
    $(target).find(':selected').text()

module.exports = ActivityWidget