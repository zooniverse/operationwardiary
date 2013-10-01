Spine = require 'spine'
User = require 'zooniverse/models/user'
Recent = require 'zooniverse/models/recent'

class Recents extends Spine.Controller
  template: require '../../views/profile/recents'

  constructor: ->
    super
    
    User.on 'change', @onUserChange
    Recent.on 'fetch', @onRecentFetch

  render: =>
      
    @html @template
      recents: @recents
  
  onRecentFetch: (e, recents)=>
    @recents = (recent.subjects[0] for recent in recents)
    @render()
  
  onUserChange: =>
    Recent.fetch() if User.current

module.exports = Recents