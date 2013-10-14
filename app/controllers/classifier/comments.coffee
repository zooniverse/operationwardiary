$ = require 'jqueryify'
Spine = require 'spine'
Subject = require 'zooniverse/models/subject'
Api = require 'zooniverse/lib/api'
User = require 'zooniverse/models/user'


class Comments extends Spine.Controller
  template: require '../../views/classifier/comments'
  className: 'subject-comments'
    
  elements:
    'textarea': 'comment_text'
    'button': 'comment_button'
  
  comments: []
    
  constructor: (@zooniverse_id)->
    super
    console.log User.current
    # uncomment this for testing
    # zooniverse_id = 'AWD00001qt'
    request = Api.current.get "/projects/#{Api.current.project}/talk/subjects/#{@zooniverse_id}"
    
    request.done @onCommentsFetch
    
    @render()

  render: =>
    @html @template
      comments: @comments
    
    @comment_button.on 'click', @submitComment
    
    
  onCommentsFetch: ({discussion}) =>
    @comments = discussion.comments
    @render()
    
  submitComment: =>
    console.log 'CLICK'
    comment = @comment_text.val()
    request = Api.current.post "/projects/#{Api.current.project}/talk/subjects/#{@zooniverse_id}/comments", comment: comment
    
    @comments.push
      user_name: User.current.name
      body: comment
    
    @render()

module.exports = Comments