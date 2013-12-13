Spine = require 'spine'
Subject = require 'zooniverse/models/subject'
Group = require 'zooniverse/models/project-group'
Favorite = require 'zooniverse/models/favorite'
{WidgetFactory} = require '../../lib/text-widgets'
Comments = require './comments'
PageTimeline = require './page_timeline'

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
    

  render: (@group)=>
    startdate = new Date @group.metadata.start_date
    enddate = new Date @group.metadata.end_date
    
    DateWidget = WidgetFactory.registry.date
    DateWidget.date = DateWidget.formatDate 'd MM yy', startdate
    
    @html @template
      group:
        name: group.name
        startdate: DateWidget.formatDate 'd MM yy', startdate
        enddate: DateWidget.formatDate 'd MM yy', enddate
    
    
    @el.append @comments.el
    @el.append @timeline.el

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
    console.log is_favourite
    @favouriteButton.removeClass 'active'
    @favouriteButton.addClass 'active' if is_favourite
    
    @comments.fetchComments zooniverse_id
  
  onFavoriteFetch: (e, favourites)=>
    
    @favourites = (favourite.subjects[0] for favourite in favourites)
  
  addFavourite: (subject) =>
    new_favourite = new Favorite subjects: [subject]
    
    new_favourite
      .send()
      .done =>
        is_favourite = (favourite for favourite in @favourites when favourite.zooniverse_id == subject.zooniverse_id)[0]?
    
        console.log is_favourite

        new_favourite.delete() if is_favourite 
    
        Favorite.fetch()

module.exports = GroupDetails