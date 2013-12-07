Spine = require 'spine'
Subject = require 'zooniverse/models/subject'
Api = require 'zooniverse/lib/api'
User = require 'zooniverse/models/user'
{WidgetFactory} = require '../../lib/text-widgets'
DateWidget = WidgetFactory.registry.date


class Comments extends Spine.Controller
  template: require '../../views/classifier/comments'
  className: 'subject-comments'
    
  elements:
    'textarea': 'comment_text'
    'button': 'comment_button'
  
  comments: []
    
  constructor: ->
    super
    $(@el).draggable()
    # uncomment this for testing
    # @zooniverse_id = 'AWD00001qt'
    
    @render()

  render: =>
    @html @template
      comments: @comments
      talk_url: "http://zooniverse-demo.s3-website-us-east-1.amazonaws.com/diaries_talk/#/subjects/#{@zooniverse_id}"
      user: User.current
    
    @comment_button.on 'click', @submitComment
    
    $('p.author img', @el).one 'error', ->
      @.src = '//zooniverse-avatars.s3.amazonaws.com/default_forum_avatar.png'
    
    
  onCommentsFetch: ({discussion}) =>
    @comments = discussion.comments
    
    for comment in @comments
      comment.timeago = $.timeago comment.updated_at
      comment.date = DateWidget.formatDate 'd MM yy', new Date comment.updated_at
    @render()
    
  submitComment: =>
    console.log 'CLICK'
    comment = @comment_text.val()
    request = Api.current.post "/projects/#{Api.current.project}/talk/subjects/#{@zooniverse_id}/comments", comment: comment
    time = new Date
    
    @comments.unshift
      user_name: User.current.name
      user_zooniverse_id: User.current.zooniverse_id
      body: comment
      timeago: $.timeago time
      date: DateWidget.formatDate 'd MM yy', time
    
    @render()
  
  fetchComments: (@zooniverse_id) =>
    console.log @zooniverse_id
    request = Api.current.get "/projects/#{Api.current.project}/talk/subjects/#{@zooniverse_id}"
    
    request.done @onCommentsFetch

module.exports = Comments