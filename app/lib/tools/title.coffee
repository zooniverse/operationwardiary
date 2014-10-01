TextWidget = require './text-widget'
labels = require '../notes'

class TitleWidget extends TextWidget
  template: require '../../views/tools/title'
  
  type: 'title'
  help: '/report/title'
  
module.exports = TitleWidget