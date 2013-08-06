translate = require 't7e'

ZoomableSurface = require './zoom_surface'
{Tool} = ZoomableSurface
AxesTool = require 'marking-surface/lib/tools/axes'
{ToolControls} = ZoomableSurface

controlsTemplates = 
  date: require '../views/tools/date'
  person: require '../views/tools/person'
  place: require '../views/tools/place'
  activity: require '../views/tools/activity'
  quarters: require '../views/tools/quarters'

dotRadius = if 'Touch' of window then 10 else 5

class TextControls extends ToolControls
  constructor: (params = {})->
    super
    
    category = $( '.categories :checked' ).val()
    @el.append controlsTemplates[category]
    @toggleButton = @el.find 'button[name="toggle"]'
    @textInput = @el.find 'input[type=text], select'

    @el.on 'click', 'button[name="toggle"]', @onClickToggle
    
    @el.on 'change', 'input[type=text]', @onTextChange
    
    @el.on 'change', 'select', @onTextChange
    
    @el.on 'blur', 'input[type=text], select', @onTextBlur

    setTimeout (=> @textInput.focus()), 250

  onClickToggle: =>
    @el.toggleClass 'closed'

  onClickCategory: ({currentTarget}) =>
    target = $(currentTarget)

    @toggleButton.html target.html()
    @toggleButton.attr title: target.attr 'title'

    setTimeout (=> @el.addClass 'closed'), 250
    
  onTextChange: ({currentTarget}) =>
    
    @tool.updateNote $(currentTarget).val()
    
  onTextBlur: ({currentTarget}) =>
    
    setTimeout (=> @el.addClass 'closed'), 250

class TextTool extends Tool
  
  @Controls: TextControls
  
  markDefaults:
    p0: [-20, -20]
    type: 'date'

  cursors:
    'dots': 'move'
  
  colours:
    'date': 'purple'
    'person': 'red'
    'place': 'green'
    'activity': 'blue'

  constructor: (params = {}) ->
    super

  initialize: ->
    
    category = $( '.categories :checked' ).val()
    @mark.type = category
    @controls.toggleButton.html translate 'span', "noteTypes.#{@mark.type}"
    @controls.el.addClass @mark.type
    dotShapes = for i in [0]
      @addShape 'circle', 0, 0, dotRadius, fill: 'black', stroke: @colours[@mark.type], 'stroke-width': 3

    @dots = @surface.paper.set dotShapes

  onFirstClick: (e) ->
    {x, y} = @mouseOffset e
    points = ['p0']
    @mark.set point, [x, y] for point in points
    
  onFirstDrag: (e) ->
    {x, y} = @mouseOffset e
    points = ['p0']
    @mark.set point, [x, y] for point in points
    
  isComplete: ->
    @clicks is 1

  'on drag dots': (e, shape) ->
    index = $.inArray shape, @dots
    {x, y} = @mouseOffset e
    @mark.set "p#{index}", [x, y]
    
  'on click': ->
    console.log 'woo'
    
  render: ->
    for point, i in ['p0']
      @dots[i].attr cx: @mark[point][0], cy: @mark[point][1]

    @controls.moveTo @mark[point][0], @mark[point][1]
    
  updateNote: ( note ) ->
    @mark.note = note
    
module.exports = TextTool
