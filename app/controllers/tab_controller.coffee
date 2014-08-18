Spine = require 'spine'

class TabController extends Spine.Controller
  
  constructor: ->
    super
    
    @el.attr 'aria-selected': 'false'
    @el.attr 'aria-hidden': 'true'

  activate: (params) =>
    super
    
    @el.attr 'aria-selected': 'true'
    @el.attr 'aria-hidden': 'false'
    
    @labelled_by().attr 'aria-selected': 'true'
  
  deactivate: =>
    super
    
    @el.attr 'aria-selected': 'false'
    @el.attr 'aria-hidden': 'true'
    
    @labelled_by().attr 'aria-selected': 'false'
  
  labelled_by: =>
    return @tab if @tab? && @tab[0]?
    
    tab_id = @el.attr 'aria-labelledby'
    @tab = $ "##{tab_id}"
    
    @tab

module.exports = TabController