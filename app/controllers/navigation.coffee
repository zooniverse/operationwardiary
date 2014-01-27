Spine = require 'spine'


class Navigation extends Spine.Controller
  tag: 'nav'
  className: 'site-navigation'
  template: require '../views/navigation'
    
  elements:
    '.links button': 'menuButton'
    '.links ul': 'menu'
    'h1 a': 'home'
    
  constructor: ->
    super
    @el.attr role: 'navigation'
    @render()
    
    @menuButton.on 'click', =>
      @menu.toggleClass 'closed'
    
    Spine.bind 'nav:close', =>
      @menu.addClass 'closed'
    
    Spine.bind 'nav:open', =>
      @menu.removeClass 'closed'
      
  render: =>
    @html @template()

module.exports = Navigation
