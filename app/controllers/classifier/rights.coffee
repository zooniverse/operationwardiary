Spine = require 'spine'
Subject = require 'zooniverse/models/subject'
Group = require 'zooniverse/models/project-group'


class Rights extends Spine.Controller
  template: require '../../views/classifier/rights'
  tag: 'p'
  className: 'copyright'
    
  constructor: ->
    super
    
    @render()
  
  render: =>
    @html @template
  

module.exports = Rights