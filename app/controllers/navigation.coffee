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
    console.log @menuButton[0]
    console.log @menu[0]
    
    @menuButton.on 'click', =>
      console.log 'CLICK'
      @menu.toggleClass 'closed'
      
  render: =>
    @html @template()

module.exports = Navigation
