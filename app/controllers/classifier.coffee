$ = require 'jqueryify'
Spine = require 'spine'

Classification = require 'zooniverse/models/classification'
Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'

MarkingSurface = require 'marking-surface'
TextTool = require './text-tool'
{ToolControls} = MarkingSurface
{Tool} = MarkingSurface


class Classifier extends Spine.Controller
  
  template: require '../views/classifier'

  events:
    'click .task': 'onDoTask'
    'click .finish': 'onFinishTask'
    'click .zoom-in': 'onZoomIn'
    'click .zoom-out': 'onZoomOut'

  elements:
    '.subject-container': 'subjectContainer'
    
  helper:
    selectedCategory: (note) =>
      if note is 'date'
        'checked'
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
	
    @surface ?= new MarkingSurface
      tool: TextTool
      container: @subjectContainer
      width: 1024
      height: 560
      
    @subjectContainer.css 'position', 'relative'
    @surface.image.attr src: "img/0#{@subject_id}.jpg"
    # HACK: turn off image scaling/resizing in SVG.
    @surface.image.node.setAttributeNS null,"preserveAspectRatio" , "xMidYMid meet"
    @surface.zoom 1

    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect

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
    @surface.image.attr src: "img/0#{@subject_id}.jpg"
    @surface.zoom 1
    # Subject.next()

  onZoomIn: =>
    @surface.zoom @surface.zoomBy + .2
    
  onZoomOut: =>
    @surface.zoom @surface.zoomBy - .2


module.exports = Classifier
