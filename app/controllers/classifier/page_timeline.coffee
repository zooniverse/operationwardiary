Spine = require 'spine'

class PageTimeline extends Spine.Controller
  
  template: require '../../views/classifier/page_timeline'
  
  entries: []
  
  constructor: ->
    super
    
  render: =>
    @html @template
      entries: @entries
  
  createEntries: ( tools ) ->
    
    @entries = []
    
    items = []
    
    for tool in tools
      item = @createItem tool
      items.push item
        
    @sort items
      
    @parseEntries items
    
    @log()
    
        
  sort: (items) =>
    # sort by entry.y then entry.x ascending
    
    sortBy = (key, a, b) ->
        return 1 if a[key] > b[key]
        return -1 if a[key] < b[key]
        return 0
    
    items.sort (a,b) ->
      return sortBy('y', a, b) or sortBy('x', a, b)
  
  parseEntries: (items) =>
    entry = 
      date: null
      x: null
      y: null
      items: []
    for item in items
      if item.type == 'diaryDate'
        entry.items = @parsePlaces entry.items
        @entries.push entry if entry.date? || entry.items.length > 0
        entry = 
          date: item.note
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
      place: null
      x: null
      y: null
      items: []
    
    for item in items
      if item.type == 'place' && item.x < 3
        entry.items = @parseTimes entry.items
        entries.push entry if entry.place? || entry.items.length > 0
        entry =
          place: item.note
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
      time: null
      x: null
      y: null
      items: []
    
    for item in items
      if item.type == 'diaryTime' && item.x < 3
        entries.push entry if entry.time? || entry.items.length > 0
        entry =
          time: item.note
          x: item.x
          y: item.y
          items: []
      else
        entry.items.push item
    
    entries.push entry if entry.time? || entry.items.length > 0
    entries
    
  log: =>
    for entry in @entries
      console.log entry.date
      console.log (item for item in entry.items)
      
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