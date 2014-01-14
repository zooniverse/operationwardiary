Spine = require 'spine'
Subject = require 'zooniverse/models/subject'
Group = require 'zooniverse/models/project-group'


class Rights extends Spine.Controller
  template: require '../../views/classifier/rights'
  tag: 'p'
  className: 'copyright'
  elements:
    '#page_number': 'page'
  
  offset: 0
    
  constructor: ->
    super
    
    @render({})
  
  render: (group) =>
    @offset = group.metadata.page_offset
    @html @template
      group: group
  
  show_page: (page_number) =>
    @page.text page_number - @offset + 1
  

module.exports = Rights