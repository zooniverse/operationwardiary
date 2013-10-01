Spine = require 'spine'
User = require 'zooniverse/models/user'
Group = require 'zooniverse/models/project-group'
Recents = require 'zooniverse/models/recent'

class Profile extends Spine.Controller
  template: require '../views/profile'

  constructor: ->
    super
    
    @recents = []

    User.on 'change', @onUserChange
    Group.on 'fetch', @onGroupFetch
    Recents.on 'fetch', @onRecentsFetch

  render: =>
    console.log User.current
    user_groups = User.current?.project.groups
    group_classifications = @groups?.map (group) ->
      name: group.name, classifications: user_groups[group.id].classification_count
      
    @html @template
      user: User.current
      groups: group_classifications
      recents: @recents
      
  onUserChange: (e, user)=>
    console.log 'USER LOGGED IN'
    console.log 'FETCHING RECENTS'
    Recents.fetch()
    @render()
  
  onGroupFetch: (e, @groups)=>
    console.log 'GROUPS FETCHED'
    @render()
    
  onRecentsFetch: (e, recents)=>
    console.log 'RECENTS FETCHED'
    console.log recents
    @recents = (recent.subjects[0] for recent in recents)
    @render()

  active: =>
    super
    @el.css 'opacity', '0.5'

    # @loading = new Spinner().spin @el.get(0)

    User.fetch().done =>
      @el.css 'opacity', '1'
      # @loading.stop()
      # @render()

module.exports = Profile