Spine = require 'spine'

class Home extends Spine.Controller
  template: require '../views/home'
  
  constructor: ->
    super
    @render()

  render: =>
    @html @template()
  
  active: =>
    super
    Spine.trigger 'nav:open'

module.exports = Home