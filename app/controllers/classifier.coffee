$ = require 'jqueryify'
Spine = require 'spine'

require '../lib/jstorage.js'
store = $.jStorage

Classification = require 'zooniverse/models/classification'
Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'

ZoomableSurface = require '../lib/zoom_surface'
TextTool = require '../lib/text-tool'
{ToolControls} = ZoomableSurface
{Tool} = ZoomableSurface

Editor = require '../lib/text-widgets'
{WidgetFactory} = Editor
{toolbars} = Editor

diaries =
  '1874/0':
    title: "14 Division: Headquarters: General Staff"
    begins: 1
    startdate: "1 January 1918"
    enddate: "31 March 1918"
  '1899/0':
    title: "14 Division: 42 Infantry Brigade: Headquarters"
    begins: 1
    startdate: "1 November 1917"
    enddate: "31 May 1919"
  '1900/1':
    title: "14 Division: 42 Infantry Brigade: 14 Battalion Argyll and Sutherland Highlanders"
    begins: 2
    startdate: '1 April 1918'
    enddate: '30 June 1919'
  '1900/2':
    title: "14 Division: 42 Infantry Brigade: 9 Battalion King's Royal Rifle Corps"
    begins: 194
    startdate: '1 May 1915'
    enddate: '30 June 1918'
  '1900/3':
    title: "14 Division: 42 Infantry Brigade: 16 Battalion Manchester Regiment"
    begins: 785
    startdate: '1 July 1918'
    enddate: '30 June 1919'
  '1900/4':
    title: "14 Division: 42 Infantry Brigade: 5 Battalion Oxfordshire and Buckinghamshire Light Infantry"
    begins: 820
    startdate: '1 May 1915'
    enddate: '30 June 1918'

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
      @path = $('#diary_picker').val()
      store.set 'diary_id', @path
      @diary = diaries[@path]
      @subject_id = @diary.begins
      filename = "000#{@subject_id}"[-4..-1]
      @surface.loadImage "img/#{@path}/#{filename}.jpg"
      @pageNumber.text( filename )
      store.deleteKey 'subject_id'
      
    'change .categories': ->
      @surface.markingMode = true
      tool.controls.el.addClass 'closed' for tool in @surface.tools

  elements:
    '.subject-container': 'subjectContainer'
    '#document-metadata': 'metadata'
    '#subject': 'pageNumber'
    
  helper:
    selectedCategory: (note) =>
      return
    selectedDocument: (document) =>
      return
        
  defaults = 
    category: 'date'

  constructor: ->
    super
    
    @path = store.get 'diary_id'
    @path?= '1900/2'
    @diary = diaries[@path]
    
    $('#diary_picker').val @path
    
    @defaults = defaults
    @surface_history = {}
    @category = @defaults.category
    @subject_id = store.get 'subject_id' 
    @subject_id?= @diary.begins
    
    @render()
	
    @surface ?= new ZoomableSurface
      tool: TextTool
      container: @subjectContainer
      width: 1024
      height: 560
      clickDelay: 300
      
    @surface.dotRadius = 5
      
    @subjectContainer.css 'position', 'relative'
    # HACK: turn off image scaling/resizing in SVG.
    @surface.image.node.setAttributeNS null,"preserveAspectRatio" , "xMidYMid meet"
    
    filename = "000#{@subject_id}"[-4..-1]
    @surface.loadImage "img/#{@path}/#{filename}.jpg"
    @pageNumber.text( filename )
    
    

    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect
    

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

    @classification = new Classification { subject }
    
  onDoTask: =>
    document = $( '.documents :checked' ).val()
    annotation = 
      document: document
      marks: @surface.marks.slice(0)
    @classification.annotate annotation
    console?.log 'Classifying', JSON.stringify @classification

  onFinishTask: =>
    # @classification.send()
      
    @update_history()

    @subject_id++
    store.set 'subject_id', @subject_id
    filename = "000#{@subject_id}"[-4..-1]
    @pageNumber.text( filename )
    @surface
      .loadImage("img/#{@path}/#{filename}.jpg")
      .done( =>
        @classification.subject.trigger 'select'
        @render_annotation @surface_history[ @subject_id ]
      )

  onZoomIn: ({currentTarget})=>
    @surface.selection?.deselect()
    timeout = null

    zoom_in = =>
      @surface.zoom @surface.zoomBy + .2
      clearTimeout timeout if timeout
      timeout = setTimeout zoom_in, 200
      
    zoom_in()
    
    $( currentTarget ).one( 'mouseup', -> clearTimeout timeout )
    
  onZoomOut: ({currentTarget})=>
    @surface.selection?.deselect()
    timeout = null

    zoom_out = =>
      @surface.zoom @surface.zoomBy - .2
      clearTimeout timeout if timeout
      timeout = setTimeout zoom_out, 200
      
    zoom_out()
    
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
