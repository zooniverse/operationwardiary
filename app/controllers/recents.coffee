Spine = require 'spine'
Api = require 'zooniverse/lib/api'

class Recents extends Spine.Controller
  template: require '../views/recents'

  constructor: ->
    super
    @render []
    @fetch()

  render: (subjects = []) =>
    @html @template
      subjects: subjects
    
    @el.attr id: 'recents'
    
  
  fetch: =>
    Api.current.get("/projects/#{Api.current.project}/talk/recents")
      .done ({subjects})=>
        console.log subjects
        @render subjects

module.exports = Recents