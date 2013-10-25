Spine = require 'spine'

class PageTimeline extends Spine.Controller
  
  template: require '../../views/classifier/page_timeline'
  
  entries: []
  
  constructor: ->
    super
    
  render: =>
    @el.hide()
    @html @template
      entries: @entries
    @el.fadeIn()
  
  createEntries: ( tools ) ->
    
    @entries = []
    
    items = []
    
    for tool in tools
      item = @createItem tool
      items.push item
        
    @sort items
      
    @entries = @parseLeftColumn items, [ 'diaryDate', 'place', 'diaryTime']
    
        
  sort: (items) =>
    # sort by entry.y then entry.x ascending
    
    sortBy = (key, a, b) ->
        return 1 if a[key] > b[key]
        return -1 if a[key] < b[key]
        return 0
    
    items.sort (a,b) ->
      return sortBy('y', a, b) or sortBy('x', a, b)
      
  parseLeftColumn: (items, entities) =>
    
    entities = entities.slice 0
    
    entries = []
    entry =
      label: null
      note: null
      x: null
      y: null
      items: []
    
    type = entities.shift()
    
    for item in items
      if item.type == type && item.x < 3
        entries.push entry if entry.note? || entry.items.length > 0
        entry =
          label: item.label
          note: item.note
          x: item.x
          y: item.y
          items: []
      else
        entry.items.push item
    
    entries.push entry if entry.note? || entry.items.length > 0
    
    if entities.length > 0
      entry.items = @parseLeftColumn entry.items, entities for entry in entries
      
    entries
    
  log: =>
    console.log @entries
      
  createItem: ( tool ) =>
    
    x = parseInt tool.mark.p0[0] / 60
    y = parseInt tool.mark.p0[1] / 10
    
    item =
      x: x
      y: y
      type: tool.mark.type
      note: tool.mark.note
      label: tool.label.node.textContent
      
module.exports = PageTimeline