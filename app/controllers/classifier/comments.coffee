$ = require 'jqueryify'
Spine = require 'spine'
Subject = require 'zooniverse/models/subject'
Api = require 'zooniverse/lib/api'


class Comments extends Spine.Controller
  template: require '../../views/classifier/comments'
  className: 'subject-comments'
    
  constructor: (zooniverse_id)->
    super
    
    # uncomment this for testing
    # zooniverse_id = 'AWD00001qt'
    request = Api.current.get "/projects/#{Api.current.project}/talk/subjects/#{zooniverse_id}"
    
    request.done @onCommentsFetch

  render: =>
    @html @template
      comments: @comments
    
  onCommentsFetch: ({discussion}) =>
    @comments = discussion.comments
    @render()

module.exports = Comments