Spine = require 'spine'


class Footer extends Spine.Controller
  tag: 'footer'
  className: 'site-footer'
  template: require '../views/footer'
    
  constructor: ->
    super
    @render()
      
  render: =>
    @html @template()

module.exports = Footer
