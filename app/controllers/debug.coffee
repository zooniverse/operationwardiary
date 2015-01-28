TabController = require './tab_controller'
require '../lib/jstorage.js'
store = $.jStorage

class Debug extends TabController
  template: require '../views/debug'

  constructor: ->
    super
    # @el.attr 'aria-labelledby': 'debugTab'
    @render()

  render: =>
    try
      store.set 'test-key', 'some value'
      store.deleteKey 'test-key'
      store.error = 'read/write test passed.'
    catch e
      store.error = JSON.stringify e
      
    @html @template store
    
    @el.attr id: 'debug'

module.exports = Debug