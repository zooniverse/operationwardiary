$ = require 'jqueryify'
Spine = require 'spine'
{Route} = Spine

require '../lib/jstorage.js'
store = $.jStorage

Classification = require 'zooniverse/models/classification'
Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'
Group = require 'zooniverse/models/project-group'

ZoomableSurface = require '../lib/zoom_surface'
TextTool = require '../lib/text-tool'

Editor = require '../lib/text-widgets'
{WidgetFactory} = Editor
{toolbars} = Editor

GroupPicker = require './classifier/group_picker'

# groups = require '../lib/localdata'

group_id = store.get 'group_id', '1900/2'

# group = groups[group_id]

class Classifier extends Spine.Controller
  
  template: require '../views/classifier'

  events:
    'click .task': 'onDoTask'
    'click .finish': 'onFinishTask'
    'click .back': 'onGoBack'
    'mousedown .zoom-in': 'onZoomIn'
    'mousedown .zoom-out': 'onZoomOut'
    'change .documents': ->
      @surface.enable()
      @toggleCategories()
    'change .categories': ->
      @surface.markingMode = true
      tool.controls.el.addClass 'closed' for tool in @surface.tools

  elements:
    '.subject-container': 'subjectContainer'
    '#document-metadata': 'metadata'
    '#subject': 'pageNumber'
    '#diary_id': 'diaryDisplay'
    '.diary_dates': 'diaryDates'
    '.diary_title': 'diaryTitle'
    
  helper:
    selectedCategory: (note) =>
      return
    selectedDocument: (document) =>
      return
        
  defaults = 
    category: 'date'

  constructor: ->
    super
    
    @defaults = defaults
    @surface_history = {}
    @category = @defaults.category
    
    @render()
    
    @group_picker = new GroupPicker
    @el.find('#group-picker').prepend @group_picker.el
    
    @group_picker.el.on 'groupChange', (e, group)=>
      @render_group group
    

    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect
    Subject.on 'fetch', @onSubjectFetch
    Group.on 'fetch', @onGroupFetch
    

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
    
  render_group: (group) =>
    
    console?.log 'RENDERING GROUP DETAILS'
    @diaryTitle.text group.name
    
    startdate = new Date group.metadata.start_date
    enddate = new Date group.metadata.end_date
    
    DateWidget = WidgetFactory.registry.date
    DateWidget.date = DateWidget.formatDate 'd MM yy', startdate
    @diaryDates.text "#{DateWidget.formatDate 'd MM yy', startdate} - #{DateWidget.formatDate 'd MM yy', enddate}"
    
    Subject.group = group.id
    # Subject.queueLength = 1
    Subject.destroyAll()
    Subject.next()
    
  render_annotation: ( history ) ->
    
    $('.categories :checked, .documents :checked')
      .removeAttr('checked')
      .prop('checked', false)
    
    for tool in @surface.tools
      tool.controls.el.remove() 
      tool.shapeSet.remove()
  
    @surface.resetTools()
    
    history?.render()
    @toggleCategories()

  onUserChange: (e, user) =>
    # user, User.current

    if user
      # @render_group group
    else
      Route.navigate '/'

    

  onSubjectFetch: (e, subjects) =>
    
    Subject.instances.sort (a,b) ->
      return if a.metadata.page_number > b.metadata.page_number then 1 else -1
      
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
    
  onGroupFetch: (e, @groups) =>
    group_id = store.get 'group_id', '5241bcf43ae7406825000003'
    group = (group for group in @groups when group.id == group_id)
    @render_group group[0]
    
  onDoTask: =>
    document = $( '.documents :checked' ).val()
    annotation = 
      document: document
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
