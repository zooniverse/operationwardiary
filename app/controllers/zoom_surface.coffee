MarkingSurface = require 'marking-surface'

class ZoomableSurface extends MarkingSurface
  
  constructor: (params = {}) ->
    super
    
    @markingMode = false
    
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
    
    @container.on 'mousemove touchmove', onDrag
    @container.one 'mouseup touchend', =>
      @onRelease arguments...
      @container.off 'mousemove touchmove', onDrag
  
  onMouseMove: ->
    return
    
  onDrag: (e) ->
    return if @zoomBy is 1
    {x, y} = @mouseOffset e
    @panX = (@width - (@width / @zoomBy)) * (x / @width)
    @panY = (@height - (@height / @zoomBy)) * (y / @height)
    @pan()
  
  onRelease: (e) ->
    e.preventDefault()
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