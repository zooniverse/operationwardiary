Spine = require 'spine'
User = require 'zooniverse/models/user'
Group = require 'zooniverse/models/project-group'
{WidgetFactory} = require '../lib/text-widgets'
DateWidget = WidgetFactory.registry.date

class Groups extends Spine.Controller
  template: require '../views/groups'

  constructor: ->
    super
    @el.attr id: 'diaries'
    Group.on 'fetch', @onGroupFetch

  render: =>
      
    @html @template
      user: User.current
      groups: @groups
    
  onGroupFetch: (e, @groups) =>
    for group in @groups
      group.startdate = DateWidget.formatDate 'd MM yy', new Date group.metadata.start_date
      group.enddate = DateWidget.formatDate 'd MM yy', new Date group.metadata.end_date
      
    @render()

module.exports = Groups