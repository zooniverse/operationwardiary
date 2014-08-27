TabController = require './tab_controller'
Footer = require 'zooniverse/controllers/footer'

class Home extends TabController
  template: require '../views/home'
  className: 'home'
  
  constructor: ->
    super
    
    @el.attr 'aria-labelledby': 'homeTab'
    @render()
    
    # footer = new Footer
    # @el.append footer.el

  render: =>
    @html @template()
    @el.attr id: 'home'

module.exports = Home