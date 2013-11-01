Spine = require 'spine'
Subject = require 'zooniverse/models/subject'
Group = require 'zooniverse/models/project-group'
{WidgetFactory} = require '../../lib/text-widgets'

require '../../lib/jstorage.js'
store = $.jStorage


class GroupDetails extends Spine.Controller
  template: require '../../views/classifier/group'
  className: 'diary-title'
  elements:
    '.discuss': 'talkButton'
    '.timeline': 'timelineButton'
    
  constructor: ->
    super
    
    Group.on 'fetch', @onGroupFetch

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
      @el.trigger 'subject:discuss'
      @talkButton.toggleClass 'active'
    
    @timelineButton.on 'click', =>
      @el.trigger 'subject:timeline'
      @timelineButton.toggleClass 'active'
    
  onGroupFetch: (e, groups) =>
    group_id = store.get 'group_id', '5241bcf43ae7406825000003'
    group = (group for group in groups when group.id == group_id)
    @render group[0]

module.exports = GroupDetails