TextWidget = require './text-widget'
labels = require '../notes'

class WeatherWidget extends TextWidget
  
  template: require('../../views/tools/weather')( choices: labels.weather )
  
  type: 'weather'
  help: '/diary/weather'
  
  getLabel: (target) ->
    'Weather: ' + $(target).find(':selected').text()

module.exports = WeatherWidget