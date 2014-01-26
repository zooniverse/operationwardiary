TabController = require './tab_controller'

class Guide extends TabController
  template: require '../views/guide'
  elements:
    'input[type=search]': 'searchbox'

  constructor: ->
    super
    @el.attr 'aria-labelledby': 'guideTab'
    @render()
    
    @searchbox.on 'change', @search
    @searchbox.on 'keydown', (e) =>
      return unless e.which == 13
      @search()
      return false

  activate: (params) =>
    super
    
    @open params.page, params.tag if params.page?
    
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
  
  open: (page, tag) =>
    scrollTop = null
    
    if page?
      scrollTop = $("h2.#{page}")
        .addClass( 'accordion-header-active ui-state-active ui-corner-top' )
        .attr( 'aria-selected', 'true' )
        .next()
        .addClass( 'accordion-content-active' )
        .attr( 'aria-hidden', 'false' )
        .attr( 'aria-expanded', 'true' )
        .show()
        .end()
        .offset()
        .top
    
    if tag?
      scrollTop = $("h3.#{tag}")
        .addClass( 'accordion-header-active ui-state-active ui-corner-top' )
        .attr( 'aria-selected', 'true' )
        .next()
        .addClass( 'accordion-content-active' )
        .attr( 'aria-hidden', 'false' )
        .attr( 'aria-expanded', 'true' )
        .show()
        .end()
        .offset()
        .top
    
    $(document).scrollTop scrollTop if scrollTop?
    
  search: =>
    term = @searchbox.val()
    
    @el
      .find( 'b.highlight' )
      .each ->
        $el = $(@)
        text = $el.text()
        $el.replaceWith text
          
    
    accordions = @el
      .find( '.ui-accordion-content' )
      .each ->
        $(@)
          .removeClass( 'accordion-content-active' )
          .attr( 'aria-hidden', 'true' )
          .attr( 'aria-expanded', 'false' )
          .hide()
          .prev( '.ui-accordion-header' )
          .removeClass( 'accordion-header-active ui-state-active ui-corner-top' )
          .attr 'aria-selected', 'false'
      .filter( ":contains('#{term}')")
      .each ->
        $(@)
          .addClass( 'accordion-content-active' )
          .attr( 'aria-hidden', 'false' )
          .attr( 'aria-expanded', 'true' )
          .show()
          .prev( '.ui-accordion-header' )
          .addClass( 'accordion-header-active ui-state-active ui-corner-top' )
          .attr 'aria-selected', 'true'
    
    accordions
      .find( "p:contains('#{term}')" )
      .each ->
        $el = $(@)
        new_html = $el.html().replace new RegExp(term, 'g'), "<b class='highlight'>#{term}</b>"
        $el.html new_html
    
    false
    
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
      currContent
        .attr( 'aria-hidden', 'true' )
        .attr( 'aria-expanded', 'false' )
        .slideUp()
    else
      currContent
        .attr( 'aria-hidden', 'false' )
        .attr( 'aria-expanded', 'true' )
        .slideDown()

    false

module.exports = Guide