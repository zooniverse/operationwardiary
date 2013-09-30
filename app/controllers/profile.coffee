Spine = require 'spine'
User = require 'zooniverse/models/user'
Group = require 'zooniverse/models/project-group'

class Profile extends Spine.Controller
  template: require '../views/profile'

  constructor: ->
    super

    @render()

    User.on 'change', @render
    Group.on 'fetch', @onGroupFetch

  render: =>
    @html @template
      user: User.current
      groups: @groups
      
  
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