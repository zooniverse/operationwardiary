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
    'change .categories': 'onCategoryChange'

  elements:
    '.subject-container': 'subjectContainer'
    
  helper:
    selectedCategory: (note) =>
      if note is 'date'
        'checked'

  constructor: ->
    super
    
    @defaults = 
      category: 'date'
    
    @render()

    @category = @defaults.category
	
    @surface ?= new MarkingSurface
      tool: TextTool
      container: @subjectContainer
      width: 1024
      height: 560
      
    @surface.image.attr src: 'img/0199.jpg'
    @surface.zoom 1
    @surface.category = @defaults.category

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
    @classification.annotate Date.now()
    console.log @classification

  onFinishTask: =>
    @classification.send()

    Subject.next()

  onZoomIn: =>
    @surface.zoom @surface.zoomBy + .2
    
  onZoomOut: =>
    @surface.zoom @surface.zoomBy - .2
    
  onCategoryChange: (e) =>
    @category = $(e.target).val()
    @surface.category = @category


module.exports = Classifier
