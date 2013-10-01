Spine = require 'spine'
Group = require 'zooniverse/models/project-group'

require '../../lib/jstorage.js'
store = $.jStorage

class GroupPicker extends Spine.Controller
  template: require '../../views/classifier/group_picker'
    
  events:
    'change #diary_picker': ->
      group_id = $('#diary_picker').val()
      store.set 'group_id', group_id
      group = (group for group in @groups when group.id == group_id)
    
      @el.trigger 'groupChange', group

  constructor: ->
    super
    
    Group.on 'fetch', @onGroupFetch

  render: =>
      
    @html @template
      groups: @groups
  
  onGroupFetch: (e, @groups) =>
    @render()

module.exports = GroupPicker