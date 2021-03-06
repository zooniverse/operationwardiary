translate = require 't7e'
{WidgetFactory} = require './text-widgets'

ZoomableSurface = require './zoom_surface'
{Tool} = ZoomableSurface
AxesTool = require 'marking-surface/lib/tools/axes'
{ToolControls} = ZoomableSurface

class TextControls extends ToolControls
  
  template: """
    <div tabindex="0" class="marking-tool-controls closed" role="dialog">
      <p class="help"><a target="help" href="#/guide">#{translate 'span', 'common.help'}</a></p>
      <span class="handle"></span>
      <span class="label"></span>
      <button name="toggle">&#x2714;</button>
      <button name="delete">&times;</button>
      <div class="deleted" aria-hidden="true">#{translate 'span', 'common.deleted'}</div>
      <div class="saved" aria-hidden="true">#{translate 'span', 'common.saved'}</div>
    </div>
  """
  
  constructor: (params = {})->
    super
    @active = false
    category = $( '.categories :checked' ).val()
    
    @widget = WidgetFactory.makeWidget category
    @help = @el.find 'p.help'
    @help.after @widget.el
    @help
      .find( 'a' )
      .attr 'href', (i, href)=>
        href + @widget.help
    @toggleButton = @el.find 'button[name="toggle"]'
    @textInput = @el.find '.annotation :input'
    @setNote()
    
    @el.off 'mousedown touchstart'
    @el.on 'mouseup touchend', '.annotation, button, a', (e) ->
      e.stopPropagation()
    
    @tool.on 'select', =>
      @active = true
      @bind_events()
      @open()
    
    @tool.on 'deselect', =>
      @unbind()
      @close()
      @active = false
    
    @el.on 'focus', =>
      @tool.select() unless @active
      
    setTimeout (=> 
      @onTextChange
        currentTarget: @textInput
    ), 250

  bind_events: =>
    @el.on 'click', 'button[name="delete"]', (e) =>
      return if @tool.surface.disabled
      e.preventDefault()
      @el.find('.deleted')
        .show()
        .css 'line-height': @el.height() + 'px'
      
      setTimeout (=>
        @onClickDelete arguments...
        @tool.surface.trigger 'delete', @tool
      ), 500
      
    @el.on 'click', 'button[name="toggle"]', =>
      @save()
    
    @el.on 'change', ':input', @onTextChange
    
    @el.on 'keydown', '.annotation :input', (e)=>
      e.stopPropagation()
      if e.which == 13
        $( e.currentTarget ).trigger 'change'
        @save() unless @widget.type in ['place', 'person', 'gridref', 'mapref']
        return false
    
    @el.on 'keypress', '.annotation :input', (e)=>
      e.stopPropagation() if e.which == 8
  
  unbind: =>
    @el.off 'click', 'button[name="delete"]'
    @el.off 'click', 'button[name="toggle"]'
    @el.off 'change', ':input'
    @el.off 'keydown', '.annotation :input'
    
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
      top = y - 40 - @el.height()
      
    left = Math.max x - 107, 10
    left = Math.min left, @tool.surface.width - 214

    @el.css
      left: left
      position: 'absolute'
      right: ''
      top: top
    
  setNote: (note = @tool.mark.note) =>
    @widget.setNote note
    
  open: =>
    return unless @el.hasClass 'closed'
    @el.removeClass 'closed'
    @el.draggable
      cancel: "input,textarea,button,select,option,label,.map,.annotation,a"
    
    @el.on 'mousedown mouseover mousemove', 'select', (e)=>
      e.stopPropagation()
    @el.on 'mousewheel wheel', (e)=>
      e.stopPropagation()
    
    input = @textInput.filter(':first')
    input.focus() unless document.activeElement == input[0]
    
    @tool.render() if @tool.mark.p0?
  
  close: =>
    return if @el.hasClass 'closed'
    try
      @el.off 'mousedown mouseover mousemove', 'select'
      @el.off 'mousewheel wheel'
      @el.draggable 'destroy'
    catch e
      console?.log e
      
    @el.addClass 'closed'
    
  destroy: =>
    @close()
    super

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
    
    text = @addShape 'text', 0, 0, label, fill: 'grey'
    box = text.getBBox()
    x = box.x - box.width / 2
    y = box.y - box.height / 2
    textbox = @addShape 'rect', x - 2, y - 2, box.width + 4, box.height + 4, fill: 'white', stroke: 'white'
    text.toFront()
    @label = @addShape 'set'
    @label.push textbox, text
    dotShapes = @widget.mark @
    
    @dots = @surface.paper.set dotShapes
  
  bounce: =>
    r = @dots[1].attr 'r'
    w = @dots[0].attr 'width'
    h = @dots[0].attr 'height'
    @dots[0].attr
      width: 0
      height: 0
    @dots[1].attr r: 0
    @shapeSet.attr opacity: 0
    
    @dots[0].animate { width: w, height: h }, 100, 'ease-in'
    @dots[1].animate r: r, 100, 'ease-in'
    @shapeSet.animate opacity: 1, 100, 'ease-in'
    
  select: =>
    super
    
    @shapeSet.attr opacity: 1
    
    @label.show()
    
  deselect: =>
    super
    
    @shapeSet.attr opacity: 0.4
    
    @label.hide()
    
    $('svg > *').css('-webkit-transform', 'rotate(0.0001deg)')

  onFirstClick: (e) ->
    {x, y} = @mouseOffset e
    points = ['p0']
    @mark.set point, [x,y] for point in points
    @render()
    @bounce()
    
  onFirstDrag: (e) ->
    {x, y} = @mouseOffset e
    points = ['p0']
    @mark.set point, [x,y]for point in points
    @render()
    
  isComplete: ->
    @clicks is 1

  'on drag dots': (e, shape) ->
    # @controls.el.addClass 'closed'
    index = $.inArray shape, @dots
    {x, y} = @mouseOffset e
    @mark.set "p#{index}", [x,y]
    @render()
  
  'on mouseover dots': (e, shape)=>
    @label.show()
    @shapeSet.attr opacity: 1
    
  'on mouseout dots': (e, shape)=>
    unless @ is @surface.selection
      @label.hide()
      @shapeSet.attr opacity: 0.4
    
  render: ->
    [x, y] = @mark.p0
    x = Math.max x, 0
    x = Math.min x, @surface.image.attr 'width'
    y = Math.max y, 0
    y = Math.min y, @surface.image.attr 'height'
    @mark.p0 = [x,y]
    @widget.move @dots, x, y
      
      
    {left, top} = @surface.getOffset()
    @controls.moveTo (x  - left) * @surface.zoomBy, (y  - top) * @surface.zoomBy
    
  mouseOffset: (e) ->
    {x,y} = super
    {left, top} = @surface.getOffset()
    x: (x / @surface.zoomBy) + left, y: (y / @surface.zoomBy) + top

  


module.exports = TextTool