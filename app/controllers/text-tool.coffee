translate = require 't7e'
widgets = require './text-widgets'

ZoomableSurface = require './zoom_surface'
{Tool} = ZoomableSurface
AxesTool = require 'marking-surface/lib/tools/axes'
{ToolControls} = ZoomableSurface


  
dotRadius = if 'Touch' of window then 10 else 5

class TextControls extends ToolControls
  
  constructor: (params = {})->
    super
    
    category = $( '.categories :checked' ).val()
    @widget = new widgets[ category ]
    @el.append @widget.template
    @widget.render @el
    @toggleButton = @el.find 'button[name="toggle"]'
    @textInput = @el.find 'input[type=text], select'

    @bind_events()

    setTimeout (=> @textInput.focus()), 250

  bind_events: ->
    @el.on 'click', 'button[name="toggle"]', @onClickToggle
    
    @el.on 'change', 'input[type=text]', @onTextChange
    
    @el.on 'change', 'select', @onTextChange
    
    @el.on 'blur', 'input[type=text], select', @onTextBlur
    
  onClickToggle: =>
    @el.toggleClass 'closed'
    @textInput.focus() if @el.is ':visible'

  onClickCategory: ({currentTarget}) =>
    target = $(currentTarget)

    @toggleButton.html target.html()
    @toggleButton.attr title: target.attr 'title'

    setTimeout (=> @el.addClass 'closed'), 250
    
  onTextChange: ({currentTarget}) =>
    
    @tool.updateNote $(currentTarget).val()
    
  onTextBlur: ({currentTarget}) =>
    
    setTimeout (=> @el.addClass 'closed'), 500

class TextTool extends Tool
  
  @Controls: TextControls
  
  markDefaults:
    p0: [-20, -20]
    type: 'date'

  cursors:
    'dots': 'move'

  constructor: (params = {}) ->
    super

  initialize: ->
    
    category = $( '.categories :checked' ).val()
    @mark.type = category
    
    @controls.toggleButton.html translate 'span', "noteTypes.#{@mark.type}"
    @controls.el.addClass @mark.type
    @draw()
    
  draw: ->
    dotShapes = @addShape 'circle', 0, 0, dotRadius, fill: 'black', stroke: @controls.widget.colour, 'stroke-width': 3
    @dots = @surface.paper.set dotShapes

  onFirstClick: (e) ->
    {x, y} = @mouseOffset e
    points = ['p0']
    @mark.set point, [x,y] for point in points
    @render()
    
  onFirstDrag: (e) ->
    {x, y} = @mouseOffset e
    points = ['p0']
    @mark.set point, [x,y]for point in points
    @render()
    
  isComplete: ->
    @clicks is 1

  'on drag dots': (e, shape) ->
    index = $.inArray shape, @dots
    {x, y} = @mouseOffset e
    @mark.set "p#{index}", [x,y]
    @render()
    
  'on click': ->
    console.log 'woo'
    
  render: ->
    for point, i in ['p0']
      @dots[i].attr cx: @mark[point][0], cy: @mark[point][1]

    {left, top} = @surface.getOffset()
    @controls.moveTo (@mark[point][0]  - left) * @surface.zoomBy, (@mark[point][1]  - top) * @surface.zoomBy
    
  updateNote: ( note ) ->
    @mark.note = note
    
  mouseOffset: (e) ->
    {x,y} = super
    {left, top} = @surface.getOffset()
    x: (x / @surface.zoomBy) + left, y: (y / @surface.zoomBy) + top



module.exports = TextTool
