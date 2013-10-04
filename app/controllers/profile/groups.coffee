Spine = require 'spine'
User = require 'zooniverse/models/user'
Group = require 'zooniverse/models/project-group'

class Groups extends Spine.Controller
  template: require '../../views/profile/groups'

  constructor: ->
    super
    
    User.on 'change', @onUserChange
    Group.on 'fetch', @onGroupFetch

  render: =>
    console.log User.current
    return unless User.current? && @groups?
    user_groups = User.current?.project.groups
    group_classifications = @groups?.map (group) ->
      name: group.name, classifications: user_groups[group.id].classification_count
      
    @html @template
      groups: group_classifications
  
  onGroupFetch: (e, @groups)=>
    @render()
  
  onUserChange: =>
    @render()

module.exports = Groups