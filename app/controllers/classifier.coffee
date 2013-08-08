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
    
    @render()

    @category = @defaults.category
    @subject_id = 194
	
    @surface ?= new ZoomableSurface
      tool: TextTool
      container: @subjectContainer
      width: 1024
      height: 560
      
    @subjectContainer.css 'position', 'relative'
    @loadImage "img/0#{@subject_id}.jpg"
    # HACK: turn off image scaling/resizing in SVG.
    @surface.image.node.setAttributeNS null,"preserveAspectRatio" , "xMidYMid meet"

    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect
    
  loadImage: (src) ->
    new_image = new Image()
    new_image.src = src
    new_image.onload = =>
      @surface.image.attr src: src
      @surface.zoom 1
    

  render: =>

    @html @template(@)

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

  onDoTask: =>
    document = $( '.documents :checked' ).val()
    @classification.annotate document
    @classification.annotate mark for mark in @surface.marks
    console?.log 'Classifying', JSON.stringify @classification

  onFinishTask: =>
    @classification.send()

    @subject_id++
    @loadImage "img/0#{@subject_id}.jpg"
    # Subject.next()

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
    @subject_id--
    @surface.image.attr src: "img/0#{@subject_id}.jpg"
    @surface.zoom 1


module.exports = Classifier
