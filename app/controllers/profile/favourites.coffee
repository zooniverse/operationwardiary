Spine = require 'spine'
User = require 'zooniverse/models/user'
Favorite = require 'zooniverse/models/favorite'

class Favourites extends Spine.Controller
  template: require '../../views/profile/favourites'

  constructor: ->
    super
    
    User.on 'change', @onUserChange
    Favorite.on 'fetch', @onFavoriteFetch

  render: =>
      
    @html @template
      favourites: @favourites
  
  onFavoriteFetch: (e, favourites)=>
    @favourites = (favourite.subjects[0] for favourite in favourites)
    @render()
  
  onUserChange: =>
    Favorite.fetch() if User.current

module.exports = Favourites