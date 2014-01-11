Spine = require 'spine'
User = require 'zooniverse/models/user'
Group = require 'zooniverse/models/project-group'
Api = require 'zooniverse/lib/api'
{WidgetFactory} = require '../lib/text-widgets'
DateWidget = WidgetFactory.registry.date

class Groups extends Spine.Controller
  template: require '../views/groups'

  constructor: ->
    super
    @el.attr id: 'diaries'
    Api.current.get("/projects/#{Api.current.project}/groups/active", {page: 1, per_page: 20}).done @onGroupFetch

  render: =>
      
    @html @template
      user: User.current
      groups: @groups
    
  onGroupFetch: (@groups) =>
    for group in @groups
      group.startdate = DateWidget.formatDate 'd M yy', new Date group.metadata.start_date
      group.enddate = DateWidget.formatDate 'd M yy', new Date group.metadata.end_date
      
    @render()

module.exports = Groups