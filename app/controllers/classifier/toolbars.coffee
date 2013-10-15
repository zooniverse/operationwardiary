Spine = require 'spine'

Editor = require '../../lib/text-widgets'
{WidgetFactory} = Editor
{toolbars} = Editor


class Toolbars extends Spine.Controller
  template: require '../../views/classifier/toolbars'
      
  elements:
    '#document-metadata': 'metadata'
    
  helper:
    selectedCategory: (note) =>
      return
    selectedDocument: (document) =>
      return
        
  events:
    'change .documents': ->
      @el.trigger 'pickDocument'
      @toggleCategories()
    'change .categories': ->
      @el.trigger 'pickCategory'

  constructor: ->
    super
    
    @render()

  render: =>
    @html @template(@)
    
  toggleCategories: ->
    category = $('.documents :checked').val()
    @metadata.html ''
    
    toolbar = toolbars[ category ] ? { template: '' }
      
    switch category
      when 'orders'
        orders = WidgetFactory.makeWidget 'orders'
        @metadata.html orders.template
      
    $('.toolbar').html toolbar.template
    $('.categories').css
      'visibility': 'visible'
  
  selectPageType: (type) =>
    selector = "#document-#{type}"
    $( selector )
      .attr( 'checked', 'checked' )
      .prop( 'checked', true )
      
  select: (type) =>
    $( "#category-#{type}" )
      .attr('checked', 'checked')
      .prop('checked', true)
  
  reset: =>
    $('.categories :checked, .documents :checked')
      .removeAttr('checked')
      .prop('checked', false)
  

module.exports = Toolbars