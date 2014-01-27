Spine = require 'spine'
Api = require 'zooniverse/lib/api'
User = require 'zooniverse/models/user'
{WidgetFactory} = require '../../lib/text-widgets'
DateWidget = WidgetFactory.registry.date

Subject = require '../../models/subject'


class Comments extends Spine.Controller
  template: require '../../views/classifier/comments'
  className: 'subject-comments'
    
  elements:
    'textarea': 'comment_text'
    'button': 'comment_button'
  
  comments: []
  
  refresh: 120
    
  constructor: ->
    super
    @render()
    
    @el.attr role: 'dialog'
    # uncomment this for testing
    # @zooniverse_id = 'AWD00001qt'

  render: =>
    @html @template
      comments: @comments
      talk_url: "http://talk.operationwardiary.org/#/subjects/#{@zooniverse_id}"
      user: User.current
    
    @comment_button.on 'click', @submitComment
    
    $('p.author img', @el).one 'error', ->
      @.src = '//zooniverse-avatars.s3.amazonaws.com/default_forum_avatar.png'
    
    comments = @el.find '> div'
    comments.css 'opacity', 0
    comments.animate opacity: 1, 500
    
    
  onCommentsFetch: ({discussion}) =>
    @comments = discussion.comments
    
    for comment in @comments
      comment.timeago = $.timeago comment.updated_at
      comment.date = DateWidget.formatDate 'd MM yy', new Date comment.updated_at
    @render()
    
  submitComment: =>
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
  
  fetchComments: (zooniverse_id) =>
    @zooniverse_id = zooniverse_id
    request = Api.current.get "/projects/#{Api.current.project}/talk/subjects/#{zooniverse_id}"
    
    request.done @onCommentsFetch
    
    clearTimeout @timeout if @timeout?
    
    @timeout = setTimeout => 
      @fetchComments zooniverse_id
    , @refresh * 1000

module.exports = Comments