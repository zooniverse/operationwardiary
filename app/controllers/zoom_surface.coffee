MarkingSurface = require 'marking-surface'

class ZoomableSurface extends MarkingSurface
  
  constructor: (params = {}) ->
    super
    @panX = @width / 2
    @panY = @height / 2
    
    @markingMode = false
    
  zoom: (@zoomBy = 1) ->
    @zoomBy = Math.max @zoomBy, 1
    
    
    @pan()
    
  pan: (@panX = @panX, @panY = @panY) ->
    
    left = @panX - @width / (2 * @zoomBy)
    top = @panY - @height / (2 * @zoomBy)
    
    left = Math.min left, @width, @width - (@width / @zoomBy)
    top = Math.min top, @height, @height - (@height / @zoomBy)
    left = Math.max left, 0
    top = Math.max top, 0
    
    @panX = left + @width / (2 * @zoomBy)
    @panY = top + @height / (2 * @zoomBy)

    @paper.setViewBox left, top, @width / @zoomBy, @height / @zoomBy

    tool.render() for tool in @tools
    
  onMouseDown: (e) ->
    return if @disabled
    return unless e.target in [@container.get(0), @paper.canvas, @image.node]
    return if e.isDefaultPrevented()

    e.preventDefault()

    $(document.activeElement).blur()
    @container.focus()

    if @markingMode
      tool = @createTool()
      tool.select()
      tool.onInitialClick e

    onDrag = => @onDrag arguments...
    
    doc = $(document)
    
    doc.on 'mousemove touchmove', onDrag
    doc.one 'mouseup touchend', =>
      @onRelease arguments...
      doc.off 'mousemove touchmove', onDrag
  
  onMouseMove: ->
    return
    
  onDrag: (e) ->
    return if @markingMode or @zoomBy is 1
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
    
module.exports = ZoomableSurface