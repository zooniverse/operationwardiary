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
    console.log 'RENDERING RECENTS'
      
    @html @template
      recents: @recents
  
  onRecentFetch: (e, recents)=>
    console.log 'RECENTS FETCHED'
    @recents = (recent.subjects[0] for recent in recents)
    @render()
  
  onUserChange: =>
    console.log 'FETCHING RECENTS'
    Recent.fetch()

module.exports = Recents