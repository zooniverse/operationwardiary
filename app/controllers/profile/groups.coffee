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
    console.log 'RENDERING GROUPS'
    user_groups = User.current?.project.groups
    group_classifications = @groups?.map (group) ->
      name: group.name, classifications: user_groups[group.id].classification_count
      
    @html @template
      groups: group_classifications
  
  onGroupFetch: (e, @groups)=>
    console.log 'GROUPS FETCHED'
    @render()
  
  onUserChange: =>
    Group.fetch()

module.exports = Groups