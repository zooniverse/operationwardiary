$ = require 'jqueryify'
Spine = require 'spine'

Classification = require 'zooniverse/models/classification'
Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'

ZoomableSurface = require './zoom_surface'
TextTool = require './text-tool'
{ToolControls} = ZoomableSurface
{Tool} = ZoomableSurface


class Classifier extends Spine.Controller
  
  template: require '../views/classifier'

  events:
    'click .task': 'onDoTask'
    'click .finish': 'onFinishTask'
    'click .back': 'onGoBack'
    'click .zoom-in': 'onZoomIn'
    'click .zoom-out': 'onZoomOut'
    'click .categories': ->
      @surface.markingMode = true

  elements:
    '.subject-container': 'subjectContainer'
    
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
    
    @render()

    @category = @defaults.category
    @subject_id = 194
	
    @surface ?= new ZoomableSurface
      tool: TextTool
      container: @subjectContainer
      width: 1024
      height: 560
      
    @subjectContainer.css 'position', 'relative'
    @surface.loadImage "img/0#{@subject_id}.jpg"
    # HACK: turn off image scaling/resizing in SVG.
    @surface.image.node.setAttributeNS null,"preserveAspectRatio" , "xMidYMid meet"

    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect
    

  render: =>

    @html @template(@)
  
  render_annotation: ( surface ) ->
    for tool in @surface.tools
      tool.controls.destroy()
      tool.mark.destroy()
      tool.shapeSet.remove()
      
    return unless surface
    console.log surface
    
    $( "#document-#{surface.document}")
      .attr('checked', 'checked')
      .prop('checked', true)
      
    @surface.tools = surface.tools
    @surface.marks = surface.marks
    
    for tool in @surface.tools
      tool.draw()
      tool.controls.el.appendTo tool.surface.container
      tool.controls.bind_events()
      tool.render()

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
    console.log @classification
    console.log @surface_history
    
  onDoTask: =>
    document = $( '.documents :checked' ).val()
    annotation = 
      document: document
      marks: @surface.marks.slice(0)
    @classification.annotate annotation
    console?.log 'Classifying', JSON.stringify @classification

  onFinishTask: =>
    # @classification.send()
      
    @surface_history[ @subject_id ] =
      document: $( '.documents :checked' ).val()
      tools: @surface.tools.slice(0)
      marks: @surface.marks.slice(0)
    

    @subject_id++
    @surface.loadImage "img/0#{@subject_id}.jpg"
    @classification.subject.trigger 'select'
    @render_annotation @surface_history[ @subject_id ]

  onZoomIn: =>
    @surface.markingMode = false
    @surface.selection = null
    $('.categories :checked')
      .removeAttr('checked')
      .prop('checked', false)
    @surface.zoom @surface.zoomBy + .2
    
  onZoomOut: =>
    @surface.markingMode = false
    @surface.selection = null
    $('.categories :checked')
      .removeAttr('checked')
      .prop('checked', false)
    @surface.zoom @surface.zoomBy - .2
    
  onGoBack: ->
    @surface_history[ @subject_id ] =
      document: $( '.documents :checked' ).val()
      tools: @surface.tools.slice(0)
      marks: @surface.marks.slice(0)
    @subject_id--
    @surface.loadImage "img/0#{@subject_id}.jpg"
    
    console?.log 'Classifying', JSON.stringify @classification
    @render_annotation @surface_history[ @subject_id ]
    


module.exports = Classifier
