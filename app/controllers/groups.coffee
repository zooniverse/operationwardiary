TabController = require './tab_controller'
User = require 'zooniverse/models/user'
Group = require 'zooniverse/models/project-group'
Api = require 'zooniverse/lib/api'
DateWidget = require '../lib/tools/date'

class Groups extends TabController
  template: require '../views/groups'

  constructor: ->
    super
    @el.attr id: 'diaries'
    @el.attr 'aria-labelledby': 'diariesTab'

  activate: (params) =>
    super
    params.page ?= 1
    Api.current.get("/projects/#{Api.current.project}/groups/active", {page: params.page, per_page: 20})
      .done (groups) =>
        @onGroupFetch groups
        @page_nav
          .removeClass('current')
          .filter("a[href='#/diaries/#{params.page}']")
          .addClass 'current'

  render: =>
      
    @html @template
      user: User.current
      groups: @groups
    
    @page_nav = $('.pages a', @el)
    
  onGroupFetch: (@groups) =>
    for group in @groups
      group.startdate = DateWidget.formatDate 'd M yy', new Date group.metadata.start_date
      group.enddate = DateWidget.formatDate 'd M yy', new Date group.metadata.end_date
      
    @render()

module.exports = Groups