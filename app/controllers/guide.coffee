Spine = require 'spine'

class Guide extends Spine.Controller
  template: require '../views/guide'

  constructor: ->
    super
    @render()

  render: =>
    @html @template()
    
    @el.attr id: 'guide'
    @el
      .find('.accordion')
      .accordion
        active: false
        collapsible: true
        heightStyle: 'content'

module.exports = Guide