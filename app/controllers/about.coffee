TabController = require './tab_controller'

class About extends TabController
  template: require '../views/about'

  constructor: ->
    super
    @el.attr 'aria-labelledby': 'aboutTab'
    @render()

  render: =>
    @html @template()
    
    @el.attr id: 'about'

module.exports = About