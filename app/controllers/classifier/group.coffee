Spine = require 'spine'
Group = require 'zooniverse/models/project-group'
Favorite = require 'zooniverse/models/favorite'
{WidgetFactory} = require '../../lib/text-widgets'
Comments = require './comments'
PageTimeline = require './page_timeline'

Subject = require '../models/subject'

require '../../lib/jstorage.js'
store = $.jStorage


class GroupDetails extends Spine.Controller
  template: require '../../views/classifier/group'
  className: 'diary-title'
  elements:
    '.discuss': 'talkButton'
    '.timeline': 'timelineButton'
    '.favourite': 'favouriteButton'
    
  constructor: ->
    super
    
    @comments = new Comments
    @timeline = new PageTimeline
    
    Subject.on 'select', @onSubjectSelect
    Favorite.on 'fetch', @onFavoriteFetch
    
    @render({})
    

  render: (@group)=>
    
    if @group.metadata?
      DateWidget = WidgetFactory.registry.date
      @group.startdate ?= DateWidget.formatDate 'd M yy', new Date @group.metadata.start_date
      @group.enddate ?= DateWidget.formatDate 'd M yy', new Date @group.metadata.end_date
      DateWidget.date = DateWidget.formatDate 'd M yy', new Date @group.metadata.start_date
    
    @html @template
      group: @group
    
    @el.append popup.el.draggable().removeClass 'open' for popup in [@comments, @timeline]

    @talkButton.on 'click', =>
      @comments.el.toggleClass 'open'
      @el.trigger 'subject:discuss'
      @talkButton.toggleClass 'active'
    
    @timelineButton.on 'click', =>
      @timeline.el.toggleClass 'open'
      @timelineButton.toggleClass 'active'
    
    @favouriteButton.on 'click', =>
      @el.trigger 'subject:favourite'
      @favouriteButton.toggleClass 'active'
  
  onSubjectSelect: (e, {zooniverse_id}) =>
    
    is_favourite = (favourite for favourite in @favourites when favourite.zooniverse_id == zooniverse_id)[0]? if @favourites?
    @favouriteButton.removeClass 'active'
    @favouriteButton.addClass 'active' if is_favourite
    
    popup.el.removeClass 'open' for popup in [@comments, @timeline]
    button.removeClass 'active' for button in [@timelineButton, @talkButton]
    @comments.fetchComments zooniverse_id
  
  onFavoriteFetch: (e, favourites)=>
    
    @favourites = (favourite.subjects[0] for favourite in favourites)
  
  addFavourite: (subject) =>
    new_favourite = new Favorite subjects: [subject]
    
    new_favourite
      .send()
      .done =>
        is_favourite = (favourite for favourite in @favourites when favourite.zooniverse_id == subject.zooniverse_id)[0]?

        new_favourite.delete() if is_favourite 
    
        Favorite.fetch()

module.exports = GroupDetails