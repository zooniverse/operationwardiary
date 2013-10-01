Spine = require 'spine'
User = require 'zooniverse/models/user'

Groups = require './profile/groups'
Recents = require './profile/recents'

class Profile extends Spine.Controller
  template: require '../views/profile/'

  constructor: ->
    super
    
    @groups = new Groups
    @recents = new Recents

    User.on 'change', @onUserChange

  render: =>
      
    @html @template
      user: User.current
      
    @groups.el.appendTo @el
    @recents.el.appendTo @el
      
  onUserChange: (e, user)=>
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