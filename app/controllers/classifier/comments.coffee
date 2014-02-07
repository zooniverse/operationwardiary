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
    '.warning .count': 'count'
  
  comments: []
  
  refresh: 120
  
  comment_length: 140
    
  constructor: ->
    super
    @render()
    
    @el.attr role: 'dialog'
    # uncomment this for testing
    # @zooniverse_id = 'AWD00001qt'
    console.log @comment_length

  render: =>
    @html @template
      comments: @comments
      talk_url: "http://talk.operationwardiary.org/#/subjects/#{Subject.current?.zooniverse_id}"
      user: User.current
    
    @comment_button.on 'click', @submitComment
    
    @comment_text.on 'focus', =>
      clearTimeout @timeout if @timeout?
    
    @comment_text.on 'keyup', @updateCount
    
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
    
  updateCount: =>
    count = @comment_text.val().length
    @count.text @comment_length - count
    
  validateComment: (comment)=>
    is_valid = comment.length > 0 && comment.length <= @comment_length
    
  submitComment: =>
    comment = @comment_text.val()
    is_valid = @validateComment comment
    return unless is_valid
    request = Api.current.post "/projects/#{Api.current.project}/talk/subjects/#{Subject.current?.zooniverse_id}/comments", comment: comment
    time = new Date
    
    @comments.unshift
      user_name: User.current.name
      user_zooniverse_id: User.current.zooniverse_id
      body: comment
      timeago: $.timeago time
      date: DateWidget.formatDate 'd MM yy', time
    
    @render()
    
    clearTimeout @timeout if @timeout?
    
    @timeout = setTimeout => 
      @fetchComments()
    , @refresh * 1000 if @refresh?
  
  fetchComments: =>
    request = Api.current.get "/projects/#{Api.current.project}/talk/subjects/#{Subject.current?.zooniverse_id}"
    
    request.done @onCommentsFetch
    
    clearTimeout @timeout if @timeout?
    
    @timeout = setTimeout => 
      @fetchComments()
    , @refresh * 1000 if @refresh?

module.exports = Comments