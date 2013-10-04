$ = require 'jqueryify'
Spine = require 'spine'
{Route} = Spine

require '../lib/jstorage.js'
store = $.jStorage

Classification = require 'zooniverse/models/classification'
Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'

ZoomableSurface = require '../lib/zoom_surface'
TextTool = require '../lib/text-tool'

GroupPicker = require './classifier/group_picker'
GroupDetails = require './classifier/group'
Toolbars = require './classifier/toolbars'

class Classifier extends Spine.Controller
  
  template: require '../views/classifier/'

  events:
    'click .task': 'onDoTask'
    'click .finish': 'onFinishTask'
    'click .back': 'onGoBack'
    'mousedown .zoom-in': 'onZoomIn'
    'mousedown .zoom-out': 'onZoomOut'

  elements:
    '.subject-container': 'subjectContainer'
    '#diary_id': 'diaryDisplay'
    
  defaults = 
    category: 'date'

  constructor: ->
    super
    
    @defaults = defaults
    @surface_history = {}
    @category = @defaults.category
    
    @render()
    
    @toolbars = new Toolbars
    @el.find('.tools').prepend @toolbars.el
    
    @group_picker = new GroupPicker
    @el.find('#group-picker').prepend @group_picker.el
    
    @group_details = new GroupDetails
    @el.prepend @group_details.el
    
    @toolbars.el.on 'pickDocument', =>
      @surface.enable()
    
    @toolbars.el.on 'pickCategory', =>
      @surface.markingMode = true
      tool.controls.el.addClass 'closed' for tool in @surface.tools
    
    @group_picker.el.on 'groupChange', (e, group)=>
      @group_details.render group
    

    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect
    # Subject.on 'fetch', @onSubjectFetch
    

  render: =>
    console.log 'RENDERING CLASSIFIER'
    
    @html @template(@)
    
    @surface ?= new ZoomableSurface
      tool: TextTool
      container: @subjectContainer
      width: 800
      height: 440
      clickDelay: 300
      
    @surface.dotRadius = 5
    
  render_annotation: ( history ) ->
    
    $('.categories :checked, .documents :checked')
      .removeAttr('checked')
      .prop('checked', false)
    
    for tool in @surface.tools
      tool.controls.el.remove() 
      tool.shapeSet.remove()
  
    @surface.resetTools()
    
    history?.render()
    @toolbars.toggleCategories()

  onUserChange: (e, user) =>
    # user, User.current

    if user
      @group_picker.el.trigger 'change'
    else
      Route.navigate '/'

    

  onSubjectFetch: (e, subjects) =>
      
    pages = (subject.metadata.page_number for subject in Subject.instances)
    console?.log pages
    
  onSubjectSelect: (e, subject) =>
    
    @classification = new Classification { subject }
      
    @surface
      .loadImage(subject.location.standard)
      .done( =>
        @render_annotation @surface_history[ subject.id ]
      )
    @diaryDisplay.text subject.metadata.file_name
    
  onDoTask: =>
    document = $( '.documents :checked' ).val()
    metadata = {}
    
    @toolbars.metadata 
       .find( ':input' )
       .each ->
         metadata[@name] = @value
         
    annotation = 
      document: document
      metadata: metadata
      marks: @surface.marks.slice(0)
    @classification.annotate annotation
    console?.log 'Classifying', JSON.stringify @classification

  onFinishTask: =>
    @onDoTask()
    @classification.send()
      
    @update_history()
    
    Subject.current.destroy()
    subject = Subject.first()
    
    if subject? then subject.select() else Subject.next()

  onZoomIn: ({currentTarget})=>
    
    timeout = @onZoom currentTarget, .2
    
  onZoomOut: ({currentTarget})=>
    
    timeout = @onZoom currentTarget, -.2
    
  onZoom: (currentTarget, delta)=>
    @surface.selection?.deselect()
    timeout = null

    zoom = =>
      @surface.zoom @surface.zoomBy + delta
      clearTimeout timeout if timeout
      timeout = setTimeout zoom, 200
      
    zoom()
    
    $( currentTarget ).one( 'mouseup', -> clearTimeout timeout )
    
  onGoBack: ->
    
    
  
  update_history: ->
    
    snapshot = new MarkingHistory @surface
    
    @surface_history[ Subject.current.id ] = snapshot
    


class MarkingHistory
  
  surface: null
  
  constructor: ( @surface ) ->
    
    @document = $( '.documents :checked' ).val()
    @tools = []
    @marks = []
    
    for tool in @surface.tools
      @tools.push tool
      @marks.push tool.mark
  
  render: ->
    
    $( "#document-#{@document}")
      .attr('checked', 'checked')
      .prop('checked', true)
    
    for tool in @tools
      @surface.tools.push tool
      @surface.marks.push tool.mark
      tool.draw()
      tool.controls.el.appendTo tool.surface.container
      tool.controls.bind_events()
      tool.render()
      
    @surface.enable()


module.exports = Classifier
