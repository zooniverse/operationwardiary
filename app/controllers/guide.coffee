Spine = require 'spine'

class Guide extends Spine.Controller
  template: require '../views/guide'

  constructor: ->
    super
    @render()

  render: =>
    @html @template()
    
    @el.attr id: 'guide'

module.exports = Guide