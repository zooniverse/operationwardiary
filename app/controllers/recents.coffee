Spine = require 'spine'
Api = require 'zooniverse/lib/api'

class Recents extends Spine.Controller
  template: require '../views/recents'
  
  delay: 120

  constructor: ->
    super
    @render []
    @fetch()

  render: (subjects = []) =>
    @html @template
      subjects: subjects
    
    @el.attr id: 'recents'
    @el.css 'opacity', 0
    @el.animate opacity: 1, 500
    
  
  fetch: =>
    Api.current.get("/projects/#{Api.current.project}/talk/recents")
      .done ({subjects})=>
        console.log subjects
        @render subjects
    
    setTimeout @fetch, @delay * 1000 if @delay?

module.exports = Recents