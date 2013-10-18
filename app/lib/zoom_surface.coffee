MarkingSurface = require 'marking-surface'

class ZoomableSurface extends MarkingSurface
  
  clickDelay: 500
  markDefaults:
    type: 'date'
    note: ''
  
  constructor: (params = {}) ->
    super
    @panX = @width / (2 * @zoomBy)
    @panY = @height / (2 * @zoomBy)
    
    @markingMode = false
    
    # HACK: turn off image scaling/resizing in SVG.
    @image.node.setAttributeNS null,"preserveAspectRatio" , "xMidYMid meet"
    
    @image.attr src: ""
    
    @container.on 'keydown', (e)=>
      @selection?.controls.save() if e.which == 13
    
    @container.on 'mousewheel', (e)=>
      
      mouse_delta = e.originalEvent.wheelDelta
      
      @onScroll mouse_delta
    
    @container.on 'wheel', (e)=>
      
      mouse_delta = e.originalEvent.deltaY
      
      @onScroll mouse_delta
    
  zoom: (@zoomBy = 1) ->
    # return if @disabled
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
    new_image = $('#loader')
    new_image.attr src: src
    
    new_image.on 'load', =>
      
      w = new_image.width()
      px =  "#{ (@width / 2) - (w / 2) }px"
    
      new_image.removeClass 'offscreen'
      new_image.css left: px
      @image.animate opacity:0, 800
    
    new_image.one 'transitionend', =>
      
      @image.attr opacity: 1
      @image.attr src: src
      new_image.attr src: ''
      new_image.addClass 'offscreen'
      new_image.removeAttr 'style'
      @zoomBy = 1
      @pan()
      promise.resolve()
    
    new_image.trigger 'transitionend' if @image.attr('src') == ''
    
    return promise
  
  resetTools: ->
    @tools  = []
    @marks = []
    @selection?.deselect()
    @markingMode = false
    
  onMouseDown: (e) ->
    # return if @disabled
    return unless e.target in [@container.get(0), @paper.canvas, @image.node]
    return if e.isDefaultPrevented()

    e.preventDefault()

    $(document.activeElement).blur()
    @container.focus()
    
    setTimeout (=>
      if @markingMode
        @trigger 'create-tool'
        tool = @createTool()
        tool.onInitialClick e
    ), @clickDelay unless @disabled

    

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
    
  onScroll: (mouse_delta) =>
    
    return unless @hasFocus()
    
    delta = if mouse_delta > 0 then .05 else -.05
    
    @zoom( @zoomBy + delta )
    
    false
    
  createTool: (markDefaults = @markDefaults)->
    
    if not @selection? or @selection.isComplete()
      tool = new @tool 
        surface: @
        markDefaults: markDefaults
      mark = tool.mark

      @tools.push tool
      @marks.push mark

      tool.on 'select', =>
        @selection?.deselect() unless @selection is tool
        @trigger 'select', tool.mark

        index = i for t, i in @tools when t is tool
        @tools.splice index, 1
        @tools.push tool

        @selection = tool

      tool.on 'deselect', =>
        @trigger 'deselect', tool.mark
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
    
  hasFocus: =>
    
    return @container[0] == document.activeElement || $.contains @container[0], document.activeElement
    
  addMark: (mark_params) =>
    
    tool = @createTool mark_params
    tool.render()
    tool.deselect()
    
module.exports = ZoomableSurface