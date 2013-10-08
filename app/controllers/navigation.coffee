$ = require 'jqueryify'
Spine = require 'spine'


class Navigation extends Spine.Controller
  tag: 'nav'
  className: 'site-navigation'
  template: require '../views/navigation'
    
  elements:
    '.links button': 'menuButton'
    '.links ul': 'menu'
    
  constructor: ->
    super
    @render()
    
    @menuButton.on 'click', =>
      @menu.toggleClass 'closed'
    
    Spine.bind 'nav:close', =>
      @menu.addClass 'closed'
      
  render: =>
    @html @template()

module.exports = Navigation
