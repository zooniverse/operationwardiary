Spine = require 'spine'
Footer = require 'zooniverse/controllers/footer'

class Home extends Spine.Controller
  template: require '../views/home'
  className: 'home'
  
  constructor: ->
    super
    
    @render()
    
    footer = new Footer
    @el.append footer.el

  render: =>
    @html @template()
  
  active: =>
    super
    Spine.trigger 'nav:open'

module.exports = Home