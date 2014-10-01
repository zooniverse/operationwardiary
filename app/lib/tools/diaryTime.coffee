TimeWidget = require './time'

class DiaryTimeWidget extends TimeWidget
  
  type: 'time'
  help: '/diary/diaryTime'
  
  mark: (tool)->
    shapes = super
    line = tool.addShape 'path', "M0,0H1026", fill: 'black', stroke: @colour, 'stroke-width': 1, opacity: .3
    shapes.push line
    
    shapes

module.exports = DiaryTimeWidget