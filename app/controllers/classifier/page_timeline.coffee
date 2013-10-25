Spine = require 'spine'

class PageTimeline extends Spine.Controller
  
  template: require '../../views/classifier/page_timeline'
  
  entries: []
  
  constructor: ->
    super
    
  render: =>
    @log()
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
      
    # @entries = @parseLeftColumn items, [ 'diaryDate', 'place', 'diaryTime']
    @parseEntries items
    
        
  sort: (items) =>
    # sort by entry.y then entry.x ascending
    
    sortBy = (key, a, b) ->
        return 1 if a[key] > b[key]
        return -1 if a[key] < b[key]
        return 0
    
    items.sort (a,b) ->
      return sortBy('y', a, b) or sortBy('x', a, b)
      
  parseLeftColumn: (items, entities) =>
    entries = []
    entry =
      note: null
      x: null
      y: null
      items: []
    
    type = entities.shift()
    
    for item in items
      if item.type == type && item.x < 3
        console.log type
        console.log item
        console.log entities
        entry.items = @parseLeftColumn entry.items, entities if entities.length > 0
        entries.push entry if entry.note? || entry.items.length > 0
        entry =
          note: item.note
          x: item.x
          y: item.y
          items: []
      else
        entry.items.push item
    
    entry.items = @parseLeftColumn entry.items, entities if entities.length > 0
    entries.push entry if entry.note? || entry.items.length > 0
    entries
  
  parseEntries: (items) =>
    entry = 
      note: null
      x: null
      y: null
      items: []
    for item in items
      if item.type == 'diaryDate'
        entry.items = @parsePlaces entry.items
        @entries.push entry if entry.date? || entry.items.length > 0
        entry = 
          note: item.note
          x: item.x
          y: item.y
          items: []
      else
        entry.items.push item 
    entry.items = @parsePlaces entry.items
    @entries.push entry if entry.date? || entry.items.length > 0
  
  parsePlaces: (items) =>
    entries = []
    entry =
      note: null
      x: null
      y: null
      items: []
    
    for item in items
      if item.type == 'place' && item.x < 3
        entry.items = @parseTimes entry.items
        entries.push entry if entry.place? || entry.items.length > 0
        entry =
          note: item.note
          x: item.x
          y: item.y
          items: []
      else
        entry.items.push item
    
    entry.items = @parseTimes entry.items
    entries.push entry if entry.place? || entry.items.length > 0
    entries
  
  parseTimes: (items) =>
    entries = []
    entry =
      note: null
      x: null
      y: null
      items: []
    
    for item in items
      if item.type == 'diaryTime' && item.x < 3
        entries.push entry if entry.time? || entry.items.length > 0
        entry =
          note: item.note
          x: item.x
          y: item.y
          items: []
      else
        entry.items.push item
    
    entries.push entry if entry.time? || entry.items.length > 0
    entries
    
  log: =>
    console.log @entries
      
  createItem: ( tool ) =>
    
    x = parseInt tool.mark.p0[0] / 60
    y = parseInt tool.mark.p0[1] / 6
    
    item =
      x: x
      y: y
      type: tool.mark.type
      note: tool.mark.note
      label: tool.label.node.textContent
      
module.exports = PageTimeline