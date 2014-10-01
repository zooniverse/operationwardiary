DateWidget = require './date'

class DiaryDateWidget extends DateWidget
  
  type: 'date'
  help: '/diary/diaryDate'
  
  mark: (tool)->
    shapes = super
    line = tool.addShape 'path', "M0,0H1026", fill: 'black', stroke: @colour, 'stroke-width': 1, opacity: .3
    shapes.push line
    
    shapes
    
module.exports = DiaryDateWidget
