translate = require 't7e'

MarkingSurface = require 'marking-surface'
{Tool} = MarkingSurface
AxesTool = require 'marking-surface/lib/tools/axes'
{ToolControls} = MarkingSurface
controlsTemplate = require '../views/chooser'

dotRadius = if 'Touch' of window then 10 else 5

class TextControls extends ToolControls
  constructor: ->
    super

    @el.append controlsTemplate
    @toggleButton = @el.find 'button[name="toggle"]'
    @toggleButton.html translate 'span', "noteTypes.#{@tool.surface.category}"

    @el.on 'click', 'button[name="toggle"]', @onClickToggle

    @toggleButton.click()

  onClickToggle: =>
    @el.removeClass 'closed'

  onClickCategory: ({currentTarget}) =>
    target = $(currentTarget)

    @toggleButton.html target.html()
    @toggleButton.attr title: target.attr 'title'

    setTimeout (=> @el.addClass 'closed'), 250

class TextTool extends Tool
  
  @Controls: TextControls
  
  markDefaults:
    p0: [-20, -20]

  cursors:
    'dots': 'move'

  constructor: ->
    super

  initialize: ->

    dotShapes = for i in [0]
      @addShape 'circle', 0, 0, dotRadius, fill: 'black', stroke: 'purple', 'stroke-width': 3

    @dots = @surface.paper.set dotShapes

  onFirstClick: (e) ->
    {x, y} = @mouseOffset e
    points = ['p0']
    @mark.set point, [x, y] for point in points

  render: ->
    for point, i in ['p0']
      @dots[i].attr cx: @mark[point][0], cy: @mark[point][1]

    @controls.moveTo @mark[point][0], @mark[point][1]

  setCategory: (category) ->
    @category = category
    
module.exports = TextTool
