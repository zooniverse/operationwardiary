Spine = require 'spine'
User = require 'zooniverse/models/user'
Group = require 'zooniverse/models/project-group'

class Profile extends Spine.Controller
  template: require '../views/profile'

  constructor: ->
    super

    User.on 'change', @render
    Group.on 'fetch', @onGroupFetch

  render: =>
    console.log User.current
    user_groups = User.current?.project.groups
    group_classifications = @groups?.map (group) ->
      name: group.name, classifications: user_groups[group.id].classification_count
      
    @html @template
      user: User.current
      groups: group_classifications
      
  
  onGroupFetch: (e, @groups)=>
    @render()
    

  active: =>
    super
    @el.css 'opacity', '0.5'

    # @loading = new Spinner().spin @el.get(0)

    User.fetch().done =>
      @el.css 'opacity', '1'
      # @loading.stop()
      @render()

module.exports = Profile