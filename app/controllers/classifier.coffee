translate = require 't7e'
Spine = require 'spine'
{Route} = Spine

require '../lib/jstorage.js'
store = $.jStorage

Classification = require 'zooniverse/models/classification'
Group = require 'zooniverse/models/project-group'
Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'
Recent = require 'zooniverse/models/recent'
Api = require 'zooniverse/lib/api'
Dialog = require 'zooniverse/controllers/dialog'

ZoomableSurface = require '../lib/zoom_surface'
TextTool = require '../lib/text-tool'

GroupDetails = require './classifier/group'
Toolbars = require './classifier/toolbars'
Rights = require './classifier/rights'
  
{Tutorial} = require 'zootorial'
steps = require '../lib/tutorial/steps'
tutorial_subject = require '../lib/tutorial/subjects'

class Classifier extends Spine.Controller
  
  template: require '../views/classifier/'

  events:
    'click .task': 'onDoTask'
    'click .finish': 'onFinishTask'
    'mousedown .zoom-in': 'onZoomIn'
    'mousedown .zoom-out': 'onZoomOut'
    'keydown .zoom-in': 'onKeyZoomIn'
    'keydown .zoom-out': 'onKeyZoomOut'
    'mouseup .zoom-in': 'onStopZoom'
    'mouseup .zoom-out': 'onStopZoom'
    'keyup .zoom-in': 'onStopZoom'
    'keyup .zoom-out': 'onStopZoom'

  elements:
    '.subject-container': 'subjectContainer'
    # '#diary_id': 'diaryDisplay'
    
  
  cacheNotes: true
  
  tutorial_done = false
    
  defaults = 
    category: 'date'

  constructor: ->
    super
    
    @tutorial = new Tutorial steps
    
    @render()
    
    @el.attr id: 'classify'
    
    @toolbars = new Toolbars el: @el.find '.tools'
    
    @group_details = new GroupDetails
    @el.find('.tools').before @group_details.el
    
    @rights = new Rights
    @el.find('.subject-container').after @rights.el
    
    @toolbars.el.on 'page_type:change', @onPageChange
    @toolbars.el.on 'tag:change', @onTagChange
    @toolbars.on 'reset', @update_history
    
    @el.on 'subject:favourite', @onFavourite
       

    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect
    Subject.on 'no-more', @onNoMoreSubjects
    
    @surface.on 'select', @onToolSelect
    @surface.on 'create-tool', @onToolCreate
    @surface.on 'change', @onToolChange
    @surface.on 'delete', @onToolDelete
    
    Spine.bind 'tutorial:done', =>
      @tutorial_done = true

  render: =>
    
    @html @template(@)
    
    @surface ?= new ZoomableSurface
      tool: TextTool
      container: @subjectContainer
      width: 1000
      height: 600
      clickDelay: 300
      
    @surface.dotRadius = 5
    
  active: (params) =>
    super
    tool.render() for tool in @surface.tools
      
    $('.site-navigation .links ul')
      .find('a')
      .removeClass('active')
      .filter("[href='#/classify']")
      .addClass 'active'
    
  activate: (params)=>
    super
    # @navigate '/classify', 'tutorial' unless User.current
    
    if params.group_id?
      if params.group_id == 'tutorial'
        @run_tutorial()
      else
        @onGroupChange params.group_id if @user?
    else
      @run_tutorial() unless @tutorial_done or @group_details.group.name?
      # @navigate '/groups' unless @group_details.group
      
  render_tags: ( snapshot ) =>
    console?.log 'rendering tags for', Subject.current.zooniverse_id

    marks = snapshot?.marks
    marks ?= []
    
    page_type = snapshot?.document
    metadata = snapshot?.metadata

    if page_type
      @toolbars.selectPageType page_type
      @toolbars.toggleCategories()
      @surface.enable()
      $('button.finish').attr disabled: false
      
      for key, value of metadata
        @toolbars.metadata.find("[name=#{key}]").val value
        
      for mark in marks
        mark.type = 'time' if mark.type == 'diaryTime'
        @toolbars.select mark.type
        @surface.addMark mark
      
      if page_type == 'diary'
        Spine.trigger 'tools:change', @surface.tools

  onGroupChange: (group_id)=>
    Subject.group = group_id
    Subject.destroyAll()
    Subject.next()
    @getGroupDetails()
    
  onGroupFetch: (e, @groups) =>
    @getGroupDetails()
  
  getGroupDetails: =>
    return unless Subject.group
    console?.log 'requesting /groups/', Subject.group
    Api.current.get("/projects/#{Api.current.project}/groups/#{Subject.group}").done @onGroupReady
    
  onGroupReady: (group) =>
    console.log group
    @group_details.render group
    @rights.render group
    
  onPageChange: (e, type)=>
    @surface.enable()
    store.set 'document', type
    $('button.finish').attr disabled: false
  
  onTagChange: (e,type)=>
    @surface.markingMode = true
    @surface.selection?.deselect()

  onToolChange: (e, tool)=>
    @update_history()
    mark = tool.mark
    store.set mark.type, mark.note if @cacheNotes && mark? && mark.type not in ['diaryDate', 'date', 'person']

    page_type = $( '.documents :checked' ).val()
    if page_type == 'diary'
      Spine.trigger 'tools:change', @surface.tools
  
  onToolDelete: (e, tool)=>
    @update_history()
    page_type = $( '.documents :checked' ).val()
    if page_type == 'diary'
      Spine.trigger 'tools:change', @surface.tools
  
  onToolCreate: =>
    type = $('.categories :checked').val()
  
    if @cacheNotes
      note = store.get type, undefined if type? && type not in ['diaryDate', 'date', 'person']
      if type?
        @surface.markDefaults.note = note ? undefined
        @surface.markDefaults.type = type

  onToolSelect: (e, mark)=>
    type = mark.type
    @toolbars.select type
  
  onUserChange: (e, user) =>
    # user, User.current
    user_changed = @user?.zooniverse_id != user?.zooniverse_id
    @user = user
    
    if user_changed
      Subject.destroyAll()
      
      if user
        @onUserLogin user
      else
        @onUserLogout()
    
    else
      @user ?= false
      @run_tutorial() unless @user
  
  onUserLogin: (user) =>
    old_history = store.get 'history', {}
    key = "history#{@user.zooniverse_id}"
    @surface_history = store.get key, old_history
    if user.project.classification_count > 0
      @getRecentSubject()
        .done ({group_id}) =>
          @tutorial_done = true
          @onGroupChange group_id unless @tutorial.started?
    else
      @run_tutorial() unless @tutorial_done
      
  onUserLogout: =>
    @surface_history = null
    Subject.next()
    
  getRecentSubject: =>
    Recent.fetch()
      .pipe( (recents) =>
        # recents = []
        
        if recents.length
          subject_id = recents[recents.length-1]?.subjects[0].zooniverse_id
          promise = Api.current.get "/projects/#{Api.current.project}/talk/subjects/#{subject_id}"
        else
          promise = new $.Deferred
          promise.reject()
        
        promise
      )
        
  onFavourite: =>
    
    @group_details.addFavourite @classification.subject
    
    
  onNoMoreSubjects: =>
    select = translate 'span', 'classify.select'
    thanks = translate 'span', 'classify.thanks'
    dialog = new Dialog 
      content: "<p>#{thanks} #{@group_details.group.name}.</p> <p><a class='button' href='#/diaries'>#{select}</a></p>"
    
    dialog.el.find('a').on 'click', ->
      dialog.hide()
      dialog.el.remove()
    
    dialog.show()
    
  onSubjectSelect: (e, subject) =>
    console?.log 'selecting ', subject.zooniverse_id
    
    @surface.width = @subjectContainer.width()
    @surface.height = @subjectContainer.height()
    # @surface.pan 0, 0
    
    @classification = new Classification { subject }
    
    # @toolbars.el.find( '.timeline' ).html @timeline.el
    
    @loadImage subject
    
    unless User.current
      require('zooniverse/controllers/signup-dialog').show() if @tutorial_done
  
  loadImage: (subject) =>
    @surface
      .loadImage(subject.location.standard)
      .done( =>
        # @diaryDisplay.text subject.metadata.file_name
        @reset subject
        
        snapshot = @surface_history[subject.id] if @surface_history?
    
        @render_tags snapshot
        
        @rights.show_page subject.metadata.page_number
      )
    
  onDoTask: =>
    document = $( '.documents :checked' ).val()
    metadata = {}
    
    @toolbars.metadata 
       .find( ':input' )
       .each ->
         metadata[@name] = @value
         
    @classification.annotate
      document: document
    
    for mark in @surface.marks
      [x,y] = mark.p0
      x = parseInt 100 * x / 1000
      y = parseInt 100 * y / 600
      @classification.annotate
        type: mark.type
        coords: [x,y]
        note: mark.note
    console?.log 'Classifying', JSON.stringify @classification

  onFinishTask: =>
    @onDoTask()
    
    @nextSubject() unless @classification.subject.metadata.tutorial?
  
  nextSubject: =>
    $('button.finish').attr disabled: true
    
    @classification.send()
    
    Subject.current.destroy()
    subject = Subject.first()
    
    if subject? then subject.select() else Subject.next()

  onZoomIn: ({currentTarget})=>
    
    @onZoom currentTarget, .1
    
  onZoomOut: ({currentTarget})=>
    
    @onZoom currentTarget, -.1
    
  onKeyZoomIn: (e) =>
    return unless e.which == 13
    @onZoom e.currentTarget, .1
  
  onKeyZoomOut: (e) =>
    return unless e.which == 13
    @onZoom e.currentTarget, -.1
  
  onStopZoom: ({currentTarget}) =>
    @onZoom currentTarget, 0
    
  onZoom: (currentTarget, delta)=>
    @surface.selection?.deselect()
    clearTimeout @zoom_timeout if @zoom_timeout?

    zoom = =>
      return if delta == 0
      @surface.zoom @surface.zoomBy + delta
      clearTimeout @zoom_timeout if @zoom_timeout?
      @zoom_timeout = setTimeout zoom, 200
      
    zoom()
    
  onGoBack: ->
    
    
  
  update_history: ->
    
    return unless Subject.current && @surface_history?
    
    snapshot = new Transcription @
    
    @surface_history[ Subject.current.id ] = snapshot
    
    key = "history#{@user.zooniverse_id}"
    store.set key, @surface_history
    
  reset: (subject)=>
    @toolbars.reset()
      
    for tool in @surface.tools
      tool.controls.el.remove() 
      tool.shapeSet.remove()
      
    @surface.resetTools()
    
    Spine.trigger 'tools:change', @surface.tools
    
    $('button.finish').attr disabled: true
    
  run_tutorial: =>
    return if @tutorial.started?
    return unless @user? and @isActive()
    
    @group_details.render tutorial_subject.group
    @rights.render tutorial_subject.group
    subject = new Subject tutorial_subject
    subject.select()
    @tutorial.start()
    


class Transcription
  
  constructor: ( classifier ) ->
    
    @document = $( '.documents :checked' ).val()
    @metadata = {}
    @marks = classifier.surface.marks
    
    classifier.toolbars.metadata 
       .find( ':input' )
       .each (i, input)=>
         @metadata[input.name] = input.value
  
  render: ->
    


module.exports = Classifier
