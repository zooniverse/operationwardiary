translate = require 't7e'
widgets = require './text-widgets'

ZoomableSurface = require './zoom_surface'
{Tool} = ZoomableSurface
AxesTool = require 'marking-surface/lib/tools/axes'
{ToolControls} = ZoomableSurface

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

    setTimeout (=> 
      @textInput.focus()
      @onTextChange
        currentTarget: @textInput
    ), 250

  bind_events: ->
    @el.on 'click', 'button[name="delete-mark"]', (e) =>
      return if @tool.surface.disabled
      e.preventDefault()
      @onClickDelete arguments...
      
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
    
    label = @widget.getLabel currentTarget ? ''
    
    @tool.mark.note = @widget.updateNote currentTarget
    @tool.label.attr 'text', label
    
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
    
    @widget = @controls.widget
    
    @controls.toggleButton.html translate 'span', "noteTypes.#{@mark.type}"
    @controls.el.addClass @mark.type
    @draw()
    
  draw: ->
    label = @widget.getLabel @controls.textInput  ? ''
    
    @label = @addShape 'text', 0, 0, label, dy: -50, font: '12px "Arial"', fill: @widget.colour 
    dotShapes = @widget.mark @
      
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
    @widget.move @dots, @mark.p0[0], @mark.p0[1]
      
      
    {left, top} = @surface.getOffset()
    @controls.moveTo (@mark.p0[0]  - left) * @surface.zoomBy, (@mark.p0[1]  - top) * @surface.zoomBy
    
  mouseOffset: (e) ->
    {x,y} = super
    {left, top} = @surface.getOffset()
    x: (x / @surface.zoomBy) + left, y: (y / @surface.zoomBy) + top



module.exports = TextTool
