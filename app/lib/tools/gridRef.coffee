TextWidget = require './text-widget'
labels = require '../notes'

class GridRefWidget extends TextWidget
  template: require '../../views/tools/gridref'
  
  type: 'gridref'
  help: '/diary/gridRef'
  
  render: =>
    super
    id = @el
      .find('label')
      .uniqueId()
      .attr('id')
    
    @el
      .find( 'input' )
      .attr('aria-labelledby', id)
    
  
  updateNote: (target) ->
    
    note = {}
    
    @el
      .find( '.annotation :input' )
      .each ->
        note[@name] = @value
    
    note
    
  getLabel: (target) ->
    
    note = @updateNote( target )
    
    labels = (value for key, value of note)
    
    labels.join ' '
    
module.exports = GridRefWidget