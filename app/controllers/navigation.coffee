Spine = require 'spine'
{Route} = Spine


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
    
    @menu.on 'click', 'a[role=tab]', (e)=>
      href = e.currentTarget.getAttribute 'href'
      return unless href[0] == '#'
      # home is a special case
      href = '#' if href == '#home'
      Route.navigate href.replace '#', '#/'
      e.preventDefault()
      
  render: =>
    @html @template()

module.exports = Navigation
