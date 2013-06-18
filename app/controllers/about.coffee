Spine = require 'spine'

class About extends Spine.Controller
  template: require '../views/about'

  constructor: ->
    super
    @render()

  render: =>
    @html @template()

module.exports = About