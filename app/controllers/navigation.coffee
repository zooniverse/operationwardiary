$ = require 'jqueryify'
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
    @render()
    
    @menuButton.on 'click', =>
      @menu.toggleClass 'closed'
    
    Spine.bind 'nav:close', =>
      @menu.addClass 'closed'
    
    Spine.bind 'nav:open', =>
      @menu.removeClass 'closed'
      
    @menu.on 'click', 'a', ({currentTarget})=>
      @menu.find('a').removeClass 'active'
      $(currentTarget).addClass 'active'
      
    @home.on 'click', =>
      @menu.find('a').removeClass 'active'
      @menu.find('a[href="#/"]').addClass 'active'
      
  render: =>
    @html @template()
    
    hash = window.location.hash
    
    if hash != ''
      @menu.find('a').removeClass 'active'
      @menu.find("a[href='#{hash}']").addClass 'active'

module.exports = Navigation
