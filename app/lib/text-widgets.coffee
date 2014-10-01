translate = require 't7e'
labels = require './notes'
widgets =
  activity: require './tools/activity' 
  casualties: require './tools/casualties'
  date: require './tools/date'
  diaryDate: require './tools/diaryDate'
  diaryTime: require './tools/diaryTime'
  domestic: require './tools/domestic'
  gridRef: require './tools/gridRef'
  mapRef: require './tools/mapRef'
  orders: require './tools/orders'
  person: require './tools/person'
  place: require './tools/place'
  quarters: require './tools/quarters'
  reference: require './tools/reference'
  signals: require './tools/signals'
  strength: require './tools/strength'
  time: require './tools/time'
  title: require './tools/title'
  unit: require './tools/unit'
  weather: require './tools/weather'

class Toolbar
  
  constructor: ->
    @template = require('../views/toolbars/diary')( @ )
    
class DiaryToolbar extends Toolbar
  
  tags: labels.toolbars.diary
  
class OrdersToolbar extends Toolbar
  
  tags: labels.toolbars.orders
  
class SignalsToolbar extends Toolbar
  
  tags: labels.toolbars.signals

class ReportToolbar extends Toolbar
  
  tags: labels.toolbars.report
  
class DefaultToolbar extends Toolbar
  
  constructor: ->
    @template = require('../views/toolbars/default')( @ )


class WidgetFactory
  
  @makeWidget: (type, dotRadius = 12) =>
    Widget = widgets[type]
    new Widget dotRadius


Editor =
  WidgetFactory: WidgetFactory
  toolbars:
    diary: new DiaryToolbar
    orders: new OrdersToolbar
    signals: new SignalsToolbar
    blank: new DefaultToolbar
    cover: new DefaultToolbar
    report: new ReportToolbar
    other: new DefaultToolbar

module.exports = Editor