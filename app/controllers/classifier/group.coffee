Spine = require 'spine'
Subject = require 'zooniverse/models/subject'
Group = require 'zooniverse/models/project-group'
Favorite = require 'zooniverse/models/favorite'
{WidgetFactory} = require '../../lib/text-widgets'
Comments = require './comments'

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
    
    # Group.on 'fetch', @onGroupFetch
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
        
    Subject.group = @group.id
    Subject.destroyAll()
    Subject.next()

    @talkButton.on 'click', =>
      @comments.el.toggleClass 'open'
      @el.trigger 'subject:discuss'
      @talkButton.toggleClass 'active'
    
    @timelineButton.on 'click', =>
      @el.trigger 'subject:timeline'
      @timelineButton.toggleClass 'active'
    
    @favouriteButton.on 'click', =>
      @el.trigger 'subject:favourite'
      @favouriteButton.toggleClass 'active'
  
  onSubjectSelect: (e, {zooniverse_id}) =>
    
    favourite = (favourite for favourite in @favourites when favourite.zooniverse_id == zooniverse_id)[0] if @favourites?
    console.log favourite
    @favouriteButton.removeClass 'active'
    @favouriteButton.addClass 'active' if favourite?
    
    @comments?.el.remove()
    @comments = new Comments zooniverse_id
    @el.append @comments.el
  
  onFavoriteFetch: (e, favourites)=>
    
    @favourites = (favourite.subjects[0] for favourite in favourites)
    
  onGroupFetch: (e, groups) =>
    group_id = store.get 'group_id', '5241bcf43ae7406825000003'
    group = (group for group in groups when group.id == group_id)
    @render group[0]

module.exports = GroupDetails