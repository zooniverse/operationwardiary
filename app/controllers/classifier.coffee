$ = require 'jqueryify'
Spine = require 'spine'

require '../lib/jstorage.js'
store = $.jStorage

Classification = require 'zooniverse/models/classification'
Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'
Group = require 'zooniverse/models/project-group'

ZoomableSurface = require '../lib/zoom_surface'
TextTool = require '../lib/text-tool'
{ToolControls} = ZoomableSurface
{Tool} = ZoomableSurface

Editor = require '../lib/text-widgets'
{WidgetFactory} = Editor
{toolbars} = Editor

diaries = require '../lib/localdata'

group = {"id":"5241bcf43ae74068250005c7","categories":[],"created_at":"2013-09-24T21:03:32Z","metadata":{"year":1900,"diary_number":1,"page_offset":2,"start_date":"1918-04-01T00:00:00Z","end_date":"1919-06-30T00:00:00Z"},"name":"14 Division: 42 Infantry Brigade: 14 Battalion Argyll and Sutherland Highlanders","project_id":"5241bcf43ae7406825000001","project_name":"war_diary","random":0.8868732809455531,"state":"active","stats":{"active":191,"complete":0,"inactive":0,"paused":0,"total":191},"subjects":[{"zooniverse_id":"AWD000014z","location":{"standard":"http://zooniverse-demo.s3.amazonaws.com/war_diaries/subjects/standard/5241bcf43ae74068250005c8.jpg"}},{"zooniverse_id":"AWD0000150","location":{"standard":"http://zooniverse-demo.s3.amazonaws.com/war_diaries/subjects/standard/5241bcf43ae74068250005c9.jpg"}},{"zooniverse_id":"AWD0000151","location":{"standard":"http://zooniverse-demo.s3.amazonaws.com/war_diaries/subjects/standard/5241bcf43ae74068250005ca.jpg"}},{"zooniverse_id":"AWD0000152","location":{"standard":"http://zooniverse-demo.s3.amazonaws.com/war_diaries/subjects/standard/5241bcf43ae74068250005cb.jpg"}},{"zooniverse_id":"AWD0000153","location":{"standard":"http://zooniverse-demo.s3.amazonaws.com/war_diaries/subjects/standard/5241bcf43ae74068250005cc.jpg"}}],"updated_at":"2013-09-24T21:03:32Z","zooniverse_id":"GWD0000003"}

Subject.group = group.id

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
    'change #diary_picker': ->
      
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
	
    @surface ?= new ZoomableSurface
      tool: TextTool
      container: @subjectContainer
      width: 800
      height: 440
      clickDelay: 300
      
    @surface.dotRadius = 5
      
    @subjectContainer.css 'position', 'relative'
    # HACK: turn off image scaling/resizing in SVG.
    @surface.image.node.setAttributeNS null,"preserveAspectRatio" , "xMidYMid meet"
    
    console.log group
    @diaryTitle.text group.name
    
    startdate = new Date group.metadata.start_date
    enddate = new Date group.metadata.end_date
    
    DateWidget = WidgetFactory.registry.date
    DateWidget.date = DateWidget.formatDate 'd MM yy', startdate
    @diaryDates.text "#{DateWidget.formatDate 'd MM yy', startdate} - #{DateWidget.formatDate 'd MM yy', enddate}"
    

    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect
    Group.on 'fetch', @onGroupFetch
    

  render: =>

    @html @template(@)
  
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
      #alert 'hello user!'
    else
      alert 'you arent a user!'

    Subject.next()

  onSubjectSelect: (e, subject) =>
    # Subject.current
    console.log subject
    
    @classification = new Classification { subject }
      
    @surface.loadImage subject.location.standard
    @diaryDisplay.text subject.metadata.file_name
    
  onGroupFetch: (e, group) =>
    console.log group
    
  onDoTask: =>
    document = $( '.documents :checked' ).val()
    annotation = 
      document: document
      marks: @surface.marks.slice(0)
    @classification.annotate annotation
    console?.log 'Classifying', JSON.stringify @classification

  onFinishTask: =>
    @classification.send()
      
    # @update_history()
    
    Subject.next()

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
    @update_history()
    @subject_id--
    store.set 'subject_id', @subject_id
    
    filename = "000#{@subject_id}"[-4..-1]
    @pageNumber.text( filename )
    @surface
      .loadImage("img/#{@path}/#{filename}.jpg")
      .done( =>
        @classification.subject.trigger 'select'
        @render_annotation @surface_history[ @subject_id ]
      )
    
  
  update_history: ->
    
    snapshot = new MarkingHistory @surface
    
    @surface_history[ @subject_id ] = snapshot
    
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
