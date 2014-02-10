Spine = require 'spine'
Api = require 'zooniverse/lib/api'

class Recents extends Spine.Controller
  template: require '../views/recents'
  
  delay: null

  constructor: ->
    super
    @render []
    
  
  activate: (params) =>
    super
    
    @fetch()
  
  deactivate: =>
    super
    
    clearTimeout @fetch_comments if @fetch_comments?

  render: (subjects = []) =>
    @html @template
      subjects: subjects
    
    @el.attr id: 'recents'
    @el.css 'opacity', 0
    @el.animate opacity: 1, 500
    
  
  fetch: =>
    Api.current.get("/projects/#{Api.current.project}/talk/recents/subjects")
      .done (subjects)=>
        @render subjects
    
    @fetch_comments = setTimeout @fetch, @delay * 1000 if @delay?

module.exports = Recents