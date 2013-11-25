Spine = require 'spine'
User = require 'zooniverse/models/user'
Group = require 'zooniverse/models/project-group'

class Groups extends Spine.Controller
  template: require '../views/groups'

  constructor: ->
    super
    @el.attr id: 'groups'
    Group.on 'fetch', @onGroupFetch

  render: =>
      
    @html @template
      user: User.current
      groups: @groups
    
  onGroupFetch: (e, @groups) =>
    @render()

module.exports = Groups