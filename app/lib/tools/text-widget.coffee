class TextWidget
  template: require '../../views/tools/person'
  
  colour: 'white'
  
  constructor: (@dotRadius) ->
    @icon = "images/icons/#{@type}.png"
  
  render: (el)->
    @el = el
    
  mark: (tool) ->
    circle = tool.addShape 'circle', 0, 0, @dotRadius, fill: 'transparent', stroke: @colour, 'stroke-width': 2
    icon = tool.addShape 'image', @icon, 0, 0, 20, 20
    circle.node.setAttributeNS null,"tabindex" , "0"
    [
      icon
      circle
      tool.label
    ]
    
  move: (shapes, x, y)->
    
    box = shapes[2][1].getBBox()
    y_offset = 15 + box.height / 2
    
    if y < 300
      labely = y - y_offset
    else
      labely = y + y_offset
      
    shapes[1].attr cx: x, cy: y
    shapes[0].attr x: x-10, y: y-10
    shapes[2].attr x: x, y: labely
    
    box = shapes[2][1].getBBox()
    shapes[2][0].attr x: box.x - 2, y: box.y - 2, width: box.width + 4, height: box.height + 4
    
    
  updateNote: (target)->
    $(target).val()
    
  getLabel: (target) ->
    $(target).val() ? ''
  
  setNote: (note) =>
    
    if typeof note is 'string'
      @el.find(':input').first().val note
    else
      for name, value of note
        $input = @el.find("[name=#{name}]")
        if $input.attr('type') is 'checkbox'
          $input.prop 'checked', value
        else
          $input.val value

module.exports = TextWidget
