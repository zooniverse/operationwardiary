Spine = require 'spine'
User = require 'zooniverse/models/user'
Group = require 'zooniverse/models/project-group'
Api = require 'zooniverse/lib/api'

class Groups extends Spine.Controller
  template: require '../../views/profile/groups'

  constructor: ->
    super
    
    @group_classifications = {}
    User.on 'change', @onUserChange

  render: =>
    return unless User.current
    
    user_groups = User.current?.project.groups
    for group_id of user_groups
      @group_classifications[group_id]?.classifications = user_groups[group_id].classification_count
      
    @html @template
      groups: @group_classifications
  
  onUserChange: =>
    @fetchGroup group_id for group_id of User.current?.project.groups
    @render()
    
  fetchGroup: (group_id) =>
    return if @group_classifications[group_id]?
    Api.current.get("/projects/#{Api.current.project}/groups/#{group_id}")
      .done (group)=>
        user_groups = User.current?.project.groups
        @group_classifications[group.id] = 
          id: group.id
          name: group.name
          total: group.stats.total
        @render()

module.exports = Groups