Spine = require 'spine'

class PageTimeline extends Spine.Controller
  
  template: require '../../views/classifier/page_timeline'
  className: 'subject-timeline'
  
  entries: []
  
  constructor: ->
    super
    @render()
    
    @el.attr role: 'dialog'
    
    Spine.bind 'tools:change', (tools) =>
      @createEntries tools
      @render()
    
  render: =>
    
    @html @template
      entries: @entries
      
    timeline = @el.find 'ul'
    timeline.css 'opacity', 0
    timeline.animate opacity: 1, 500 
  
  createEntries: ( tools ) ->
    
    @entries = []
    
    items = []
    
    for tool in tools
      item = @createItem tool
      items.push item
        
    @sort items
      
    @entries = @parseLeftColumn items, [ 'diaryDate', 'place', 'time']
    
        
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
      # are we in the left column?
      left = false
      # dates/times count wherever they are in x
      left = true if type in ['diaryDate', 'time']
      # places count if location is ticked
      left = true if item.type == 'place' && item.note.location
      if item.type == type && left
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
    console?.log @entries
      
  createItem: ( tool ) =>
    
    x = parseInt tool.mark.p0[0] / 60
    y = parseInt tool.mark.p0[1] / 10
    
    item =
      x: x
      y: y
      type: tool.mark.type
      note: tool.mark.note
      label: tool.label[1].attr 'text'
      
module.exports = PageTimeline