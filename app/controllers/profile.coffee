Spine = require 'spine'
User = require 'zooniverse/models/user'

Groups = require './profile/groups'
Recents = require './profile/recents'
Favourites = require './profile/favourites'

class Profile extends Spine.Controller
  template: require '../views/profile/'

  constructor: ->
    super
    
    @groups = new Groups
    @recents = new Recents
    @favourites = new Favourites

    User.on 'change', @onUserChange

  render: =>
      
    @html @template
      user: User.current
      
    @el.attr id: 'profile'
    
    return unless User.current?
    
    @groups.el.appendTo @el
    @recents.el.appendTo @el
    @favourites.el.appendTo @el
      
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