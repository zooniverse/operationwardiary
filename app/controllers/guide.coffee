Spine = require 'spine'

class About extends Spine.Controller
  template: require '../views/guide'

  constructor: ->
    super
    @render()

  render: =>
    @html @template()

module.exports = About