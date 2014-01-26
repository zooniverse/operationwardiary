TabController = require './tab_controller'
User = require 'zooniverse/models/user'

Groups = require './profile/groups'
Recents = require './profile/recents'
Favourites = require './profile/favourites'

class Profile extends TabController
  template: require '../views/profile/'

  constructor: ->
    super
    
    @el.attr 'aria-labelledby': 'profileTab'
    
    @groups = new Groups
    @recents = new Recents
    @favourites = new Favourites

    User.on 'change', @onUserChange

  render: =>
      
    @html @template
      user: User.current
      
    @el.attr id: 'profile'
    
    if User.current
    
      @groups.el.appendTo @el
      @recents.el.appendTo @el
      @favourites.el.appendTo @el
      
  onUserChange: (e, user)=>
    @render()

  active: =>
    super

    User.fetch()

module.exports = Profile