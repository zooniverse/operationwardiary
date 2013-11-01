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
    
    @setNote()

    setTimeout (=> 
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
        @tool.surface.trigger 'delete', @tool
        @el.find('.deleted').hide()
      ), 500
      
      
    @el.on 'click', 'button[name="toggle"]', =>
      @save()
    
    @el.on 'change', ':input', @onTextChange
    
    @tool.on 'select', @open
    
    @tool.on 'deselect', @close
    
  onClickToggle: =>
    @el.toggleClass 'closed'
    @widget.updateNote @textInput[0] if @el.is(':visible')
    
    
  onTextChange: ({currentTarget}) =>
    
    label = @widget.getLabel currentTarget ? ''
    
    @tool.mark.note = @widget.updateNote currentTarget
    @tool.label[1].attr 'text', label
    
    box = @tool.label[1].getBBox()
    @tool.label[0].attr x: box.x - 2, y: box.y - 2, width: box.width + 4, height: box.height + 4
    
  save: =>
    @tool.surface.trigger 'change', @tool
    
    @el.find('.saved')
      .show()
      .css 'line-height': @el.height() + 'px'
    
    setTimeout (=>
      @tool.deselect()
      @el.find('.saved').hide()
    ), 500
    
  moveTo: (x, y) ->
    super
    @el.removeAttr 'style'
    
    if y < 300
      top = y + 20
    else
      top = y - ( @el.height() + 20 )
      
    left = Math.max x - 88, 10
    left = Math.min left, @tool.surface.width - 186

    @el.css
      left: left
      position: 'absolute'
      right: ''
      top: top
    
  setNote: (note = @tool.mark.note) =>
    @widget.setNote note
    
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
    
    category = $( '.categories :checked' ).val()
    @mark.type = category
    
    @widget = @controls.widget
    
    tmp = translate 'span', "noteTypes.#{@mark.type}"
    @controls.el.addClass @mark.type
    @draw()
    
  draw: ->
    label = @widget.getLabel @controls.textInput[0]  ? ''
    
    text = @addShape 'text', 0, 0, label, font: '12px "Arial"', fill: 'black'
    box = text.getBBox()
    textbox = @addShape 'rect', box.x - 2 - box.width / 2, box.y - 2 - box.height / 2, box.width + 4, box.height + 4, fill: 'white', stroke: 'white'
    text.toFront()
    @label = @addShape 'set'
    @label.push textbox, text
    dotShapes = @widget.mark @
    
    @dots = @surface.paper.set dotShapes
    
  select: =>
    super
    
    @shapeSet.attr opacity: 1
    
    @label.show()
    
  deselect: =>
    super
    
    @shapeSet.attr opacity: 0.7
    
    @label.hide()

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
  
  'on mouseover dots': (e, shape)=>
    @label.show()
    
  'on mouseout dots': (e, shape)=>
    @label.hide() unless @ is @surface.selection
    
  render: ->
    @widget.move @dots, @mark.p0[0], @mark.p0[1]
      
      
    {left, top} = @surface.getOffset()
    @controls.moveTo (@mark.p0[0]  - left) * @surface.zoomBy, (@mark.p0[1]  - top) * @surface.zoomBy
    
  mouseOffset: (e) ->
    {x,y} = super
    {left, top} = @surface.getOffset()
    x: (x / @surface.zoomBy) + left, y: (y / @surface.zoomBy) + top

  


module.exports = TextTool
