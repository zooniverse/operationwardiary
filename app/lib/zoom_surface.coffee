MarkingSurface = require 'marking-surface'

class ZoomableSurface extends MarkingSurface
  
  clickDelay: 500
  
  constructor: (params = {}) ->
    super
    @panX = @width / (2 * @zoomBy)
    @panY = @height / (2 * @zoomBy)
    
    @markingMode = false
    
    @container.on 'keydown', (e)=>
      @selection.controls.onClickToggle e if e.which == 13
    
    @container.on 'mousewheel', (e)=>
      return unless @hasFocus()
      e.stopPropagation()
      mouse_delta = e.originalEvent.wheelDelta
      
      delta = if mouse_delta > 0 then .2 else -.2
      
      @zoom( @zoomBy + delta )
      
      false
    
    @container.on 'wheel', (e)=>
      return unless @hasFocus()
      e.stopPropagation()
      mouse_delta = e.originalEvent.deltaY
      
      delta = if mouse_delta > 0 then .2 else -.2
      
      @zoom( @zoomBy + delta )
      
      false
    
  zoom: (@zoomBy = 1) ->
    return if @disabled
    @zoomBy = Math.max @zoomBy, 1
    
    
    @pan()
    
  pan: (@panX = @panX, @panY = @panY) ->
    
    {left, top} = @getOffset()
    
    left = Math.min left, @width, @width - (@width / @zoomBy)
    top = Math.min top, @height, @height - (@height / @zoomBy)
    left = Math.max left, 0
    top = Math.max top, 0
    
    @panX = left + @width / (2 * @zoomBy)
    @panY = top + @height / (2 * @zoomBy)

    @paper.setViewBox left, top, @width / @zoomBy, @height / @zoomBy

    tool.render() for tool in @tools
    
  loadImage: (src) ->
    @disable()
    
    {left, top} = @getOffset()
    
    promise = new $.Deferred()
    new_image = new Image()
    new_image.src = src
    
    @image.attr src: ""
    message = @paper.text left + @width / (2 * @zoomBy), top + @height / (2 * @zoomBy), 'Loading', font: '12px "Arial"', fill: 'black'
    new_image.onload = =>
      message.remove()
      @image.attr src: src
      @zoomBy = 1
      @pan()
      promise.resolve()
    
    return promise
  
  resetTools: ->
    @tools  = []
    @marks = []
    @selection?.deselect()
    @markingMode = false
    
  onMouseDown: (e) ->
    return if @disabled
    return unless e.target in [@container.get(0), @paper.canvas, @image.node]
    return if e.isDefaultPrevented()

    e.preventDefault()

    $(document.activeElement).blur()
    @container.focus()
    
    setTimeout (=>
      if @markingMode
        tool = @createTool()
        @selection?.deselect()
        tool.select()
        tool.onInitialClick e
    ), @clickDelay

    

    onDrag = => @onDrag arguments...
    
    doc = $(document)
    
    doc.on 'mousemove touchmove', onDrag
    doc.one 'mouseup touchend', =>
      @onRelease arguments...
      doc.off 'mousemove touchmove', onDrag
  
  onMouseMove: ->
    return
    
  onDrag: (e) =>
    return if @zoomBy is 1
    @markingMode = false
    @selection?.deselect()
    tool.controls.el.addClass 'closed' for tool in @tools
    
    {x, y} = @mouseOffset e
    
    if @oldX
      @panX = @panX + @oldX - x
      @panY = @panY + @oldY - y
      @pan()
    
    @oldX = x
    @oldY = y
  
  onRelease: (e) ->
    e.preventDefault()
    @oldX = null
    @oldY = null
    @selection?.onInitialRelease e
    @markingMode = true
    
  createTool: ->
    if not @selection? or @selection.isComplete()
      tool = new @tool surface: @
      mark = tool.mark

      @tools.push tool
      @marks.push mark

      tool.on 'select', =>
        @selection?.deselect() unless @selection is tool

        index = i for t, i in @tools when t is tool
        @tools.splice index, 1
        @tools.push tool

        @selection = tool

      tool.on 'deselect', =>
        @selection = null

      tool.on 'destroy', =>
        tool.deselect()
        index = i for t, i in @tools when t is tool
        @tools.splice index, 1
        @tools[@tools.length - 1]?.select() if tool is @selection

      mark.on 'destroy', =>
        index = i for m, i in @marks when m is mark
        @marks.splice index, 1
        @trigger 'destroy-mark', [mark]

      tool.select()
      @trigger 'create-mark', [mark, tool]

    else
      tool = @selection
      
    return tool
    
  getOffset: ->
    left = @panX - @width / (2 * @zoomBy)
    top = @panY - @height / (2 * @zoomBy)
    left: left, top: top
  
  disable: ->
    super
    
    @container
      .find( '.zoom-controls button')
      .attr( 'disabled', 'disabled' )
      
  enable: ->
    super
    
    @container
      .find( '.zoom-controls button')
      .removeAttr( 'disabled' )
    
  hasFocus: =>
    
    return @container[0] == document.activeElement || $.contains @container[0], document.activeElement
    
module.exports = ZoomableSurface