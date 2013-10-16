translate = require 't7e'
{WidgetFactory} = require './text-widgets'

ZoomableSurface = require './zoom_surface'
{Tool} = ZoomableSurface
AxesTool = require 'marking-surface/lib/tools/axes'
{ToolControls} = ZoomableSurface

class TextControls extends ToolControls
  
  template: '''
    <div class="marking-tool-controls">
      <span class="handle"></span>
      <span class="label"></span>
      <button name="toggle">&#x2714;</button>
      <button name="delete">&times;</button>
      <div class="deleted" aria-hidden="true">Deleted</div>
      <div class="saved" aria-hidden="true">Saved</div>
    </div>
  '''
  
  constructor: (params = {})->
    super
    
    category = $( '.categories :checked' ).val()
    @widget = WidgetFactory.makeWidget category
    @el.prepend @widget.template
    @widget.render @el
    @toggleButton = @el.find 'button[name="toggle"]'
    @textInput = @el.find '.annotation :input'

    @bind_events()

    setTimeout (=> 
      @textInput[0].focus()
      @onTextChange
        currentTarget: @textInput
    ), 250

  bind_events: ->
    @el.on 'click', 'button[name="delete"]', (e) =>
      return if @tool.surface.disabled
      e.preventDefault()
      @el.find('.deleted')
        .show()
        .css 'line-height': @el.height() + 'px'
      
      setTimeout (=>
        console.log 'DELETING'
        @onClickDelete arguments...
        @el.find('.deleted').hide()
        @tool.surface.trigger 'change'
      ), 500
      
      
    @el.on 'click', 'button[name="toggle"]', =>
      @onClickToggle
      @save()
    
    @el.on 'change', ':input', @onTextChange
    
    @tool.on 'select', @open
    
    @tool.on 'deselect', @close
    
    # @el.on 'blur', 'input[type=text], select', @onTextBlur
    
  onClickToggle: =>
    @el.toggleClass 'closed'
    
    
  onTextChange: ({currentTarget}) =>
    
    label = @widget.getLabel currentTarget ? ''
    
    @tool.mark.note = @widget.updateNote currentTarget
    @tool.label.attr 'text', label
    
  save: =>
    
    @el.find('.saved')
      .show()
      .css 'line-height': @el.height() + 'px'
    
    setTimeout (=>
      @close()
      @textInput[0].focus() if @el.is ':visible'
      @el.find('.saved').hide()
      @tool.surface.trigger 'change'
    ), 500
    
  onTextBlur: ({currentTarget}) =>
    
    setTimeout (=> @el.addClass 'closed'), 500
    
  moveTo: (x, y) ->
    super
    @el.removeAttr 'style'
    
    if y < 300
      top = y + 20
    else
      top = y - ( @el.height() + 20 )

    @el.css
      left: x - 88
      position: 'absolute'
      right: ''
      top: top
    
  setNote: (note = @tool.mark.note) =>
    @widget.setNote note, @el
    
  open: =>
    @el.removeClass 'closed'
  
  close: =>
    @el.addClass 'closed'

class TextTool extends Tool
  
  @Controls: TextControls
  
  markDefaults:
    type: 'date'

  cursors:
    'dots': 'move'

  constructor: (params = {}) ->
    super

  initialize: ->
    
    tool.controls.el.addClass 'closed' for tool in @surface.tools
    
    category = $( '.categories :checked' ).val()
    @mark.type = category
    
    @widget = @controls.widget
    
    tmp = translate 'span', "noteTypes.#{@mark.type}"
    @controls.toggleButton.attr title: $(tmp).text()
    @controls.el.addClass @mark.type
    @draw()
    
  draw: ->
    label = @widget.getLabel @controls.textInput[0]  ? ''
    
    @label = @addShape 'text', 0, 0, label, font: '12px "Arial"', fill: @widget.colour 
    dotShapes = @widget.mark @
    
    @dots = @surface.paper.set dotShapes
    
  select: =>
    super
    
    @dots[2]?.attr opacity: .5
    @surface.trigger 'select', @mark
    
  deselect: =>
    super
    
    @dots[2]?.attr opacity: .3

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
    
  onFirstRelease: (e) ->
    @deselect()
    
  isComplete: ->
    @clicks is 1

  'on drag dots': (e, shape) ->
    # @controls.el.addClass 'closed'
    index = $.inArray shape, @dots
    {x, y} = @mouseOffset e
    @mark.set "p#{index}", [x,y]
    @render()
    
  'on mousedown dots': (e, shape)->
    @controls.onClickToggle e
    
  render: ->
    @widget.move @dots, @mark.p0[0], @mark.p0[1]
      
      
    {left, top} = @surface.getOffset()
    @controls.moveTo (@mark.p0[0]  - left) * @surface.zoomBy, (@mark.p0[1]  - top) * @surface.zoomBy
    
  mouseOffset: (e) ->
    {x,y} = super
    {left, top} = @surface.getOffset()
    x: (x / @surface.zoomBy) + left, y: (y / @surface.zoomBy) + top

  


module.exports = TextTool
