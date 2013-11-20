Spine = require 'spine'

class Guide extends Spine.Controller
  template: require '../views/guide'
  elements:
    'input[type=search]': 'searchbox'

  constructor: ->
    super
    @render()
    
    @searchbox.on 'change', @search

  render: =>
    @html @template()
    
    @el.attr id: 'guide'
    @el
      .find('.accordion')
      .accordion
        active: false
        collapsible: true
        heightStyle: 'content'
        icons: false
        beforeActivate: @override_accordion
  
  search: =>
    term = @searchbox.val()
    console.log term
    
    accordions = @el
      .find( '.ui-accordion-content' )
      .each ->
        $(@)
          .removeClass( 'accordion-content-active' )
          .hide()
          .prev( '.ui-accordion-header' )
          .removeClass( 'accordion-header-active ui-state-active ui-corner-top' )
          .attr 'aria-selected', 'false'
      .filter( ":contains('#{term}')")
      .each ->
        $(@)
          .addClass( 'accordion-content-active' )
          .show()
          .prev( '.ui-accordion-header' )
          .addClass( 'accordion-header-active ui-state-active ui-corner-top' )
          .attr 'aria-selected', 'true'
    
  override_accordion: (event, ui) ->
    # Adapted from http://stackoverflow.com/questions/15702444/jquery-ui-accordion-open-multiple-panels-at-once
    if ui.newHeader[0]
      currHeader  = ui.newHeader
      currContent = currHeader.next '.ui-accordion-content'
 
    else
      currHeader  = ui.oldHeader
      currContent = currHeader.next '.ui-accordion-content'

    isPanelSelected = currHeader.attr('aria-selected') == 'true'


    currHeader
      .toggleClass('ui-corner-all',isPanelSelected)
      .toggleClass('accordion-header-active ui-state-active ui-corner-top',!isPanelSelected)
      .attr 'aria-selected',(!isPanelSelected).toString()

    currHeader
      .children('.ui-icon')
      .toggleClass('ui-icon-triangle-1-e',isPanelSelected)
      .toggleClass('ui-icon-triangle-1-s',!isPanelSelected)

    currContent.toggleClass 'accordion-content-active',!isPanelSelected 
    if isPanelSelected
      currContent.slideUp()
    else
      currContent.slideDown()

    false

module.exports = Guide