translate = require 't7e'
Spine = require 'spine'
{Route} = Spine

require '../lib/jstorage.js'
store = $.jStorage

Classification = require 'zooniverse/models/classification'
Group = require 'zooniverse/models/project-group'
User = require 'zooniverse/models/user'
Recent = require 'zooniverse/models/recent'
Api = require 'zooniverse/lib/api'
Dialog = require 'zooniverse/controllers/dialog'

ZoomableSurface = require '../lib/zoom_surface'
TextTool = require '../lib/text-tool'
Subject = require '../models/subject'
TabController = require './tab_controller'

GroupDetails = require './classifier/group'
Toolbars = require './classifier/toolbars'
Rights = require './classifier/rights'
  
{Tutorial} = require 'zootorial'
steps = require '../lib/tutorial/steps'
tutorial_subject = require '../lib/tutorial/subjects'

class Classifier extends TabController
  
  template: require '../views/classifier/'

  events:
    'click .task': 'onDoTask'
    'click .finish': 'onFinishTask'
    'mousedown .zoom-in': 'onZoomIn'
    'mousedown .zoom-out': 'onZoomOut'
    'touchstart .zoom-in': 'onZoomIn'
    'touchstart .zoom-out': 'onZoomOut'
    'keydown .zoom-in': 'onKeyZoomIn'
    'keydown .zoom-out': 'onKeyZoomOut'
    'mouseup .zoom-in': 'onStopZoom'
    'mouseup .zoom-out': 'onStopZoom'
    'touchend .zoom-in': 'onStopZoom'
    'touchend .zoom-out': 'onStopZoom'
    'keyup .zoom-in': 'onStopZoom'
    'keyup .zoom-out': 'onStopZoom'

  elements:
    '.subject-container': 'subjectContainer'
    # '#diary_id': 'diaryDisplay'
    
  
  cacheNotes: true
  dontCache: ['diaryDate', 'date', 'person', 'casualties']
  
  tutorial_done = false
    
  defaults = 
    category: 'date'

  constructor: ->
    super
    
    @tutorial = new Tutorial steps
    
    @render()
    
    @el.attr id: 'classify'
    @el.attr 'aria-labelledby': 'classifyTab'
    
    @toolbars = new Toolbars el: @el.find '.tools'
    
    @group_details = new GroupDetails
    @el.find('.tools').before @group_details.el
    
    @rights = new Rights
    @el.find('.subject-container').after @rights.el
    
    @toolbars.el.on 'page_type:change', @onPageChange
    @toolbars.el.on 'tag:change', @onTagChange
    @toolbars.on 'reset', @onToolbarReset
    
    @el.on 'subject:favourite', @onFavourite
       

    Subject.queueLength = 10
    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect
    Subject.on 'no-more', @onNoMoreSubjects
    Classification.on 'send-pending', @onPendingClassification
    
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
      clickDelay: 500
      
    @surface.dotRadius = 5
    
  active: (params) =>
    super
    @surface.image.attr opacity: 1
    tool.render() for tool in @surface.tools
    
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
      store.set 'document', page_type
      @surface.enable()
      $('button.finish')
        .removeAttr( 'disabled' )
        .prop disabled: false
      
      for key, value of metadata
        @toolbars.metadata.find("[name=#{key}]").val value
        
      for mark in marks
        mark.type = 'time' if mark.type == 'diaryTime'
        @toolbars.select mark.type
        @surface.addMark mark
      
      if page_type == 'diary'
        Spine.trigger 'tools:change', @surface.tools

  onGroupChange: (group_id)=>
    Subject.destroyAll()
    Subject.group = group_id
    Subject.next()
    @getGroupDetails()
    
  onGroupFetch: (e, @groups) =>
    @getGroupDetails()
  
  getGroupDetails: =>
    return unless Subject.group
    console?.log 'requesting /groups/', Subject.group
    Api.current.get("/projects/#{Api.current.project}/groups/#{Subject.group}").done @onGroupReady
    
  onGroupReady: (group) =>
    console?.log group
    @group_details.render group
    @rights.render group
  
  onToolbarReset: =>
    if @surface.tools.length
      @reset() if window.confirm  translate('common.reset_tags')
      # @update_history()
    else
      @toolbars.reset()
      
  onPageChange: (e, type)=>
    if @surface.tools.length
      if window.confirm translate('common.reset_tags')
        @reset()
        @toolbars.selectPageType( type ).focus()
      else
        @toolbars.selectPageType( store.get 'document', '' ).focus()
        @toolbars.toggleCategories()
        return
        
    @surface.enable()
    store.set 'document', type
    @toolbars.toggleCategories()
    $('button.finish')
      .removeAttr( 'disabled' )
      .prop disabled: false
      
  onTagChange: (e,type)=>
    @surface.markingMode = true
    @surface.selection?.deselect()

  onToolChange: (e, tool)=>
    @update_history()
    mark = tool.mark
    store.set mark.type, mark.note if @cacheNotes && mark? && mark.type not in @dontCache

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
      note = store.get type, undefined if type? && type not in @dontCache
      if type?
        @surface.markDefaults.note = note ? undefined
        @surface.markDefaults.type = type

  onToolSelect: (e, mark)=>
    type = mark.type
    @toolbars.select type
  
  onUserChange: (e, user) =>
    # user, User.current
    user_changed = @user != user?.zooniverse_id
    
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
    @user = User.current.zooniverse_id
    
    @getRecentSubject()
      .fail( =>
        @run_tutorial() unless @tutorial_done
      )
      .done ({group_id}) =>
        @tutorial_done = true
        @onGroupChange group_id unless @tutorial.started?
      
  onUserLogout: =>
    @user = false
    Route.navigate '/classify/tutorial'
    
  getRecentSubject: =>
    promise = new $.Deferred
    
    {active_group} = Subject.get_cache()
    console?.log active_group
    
    if active_group?
      promise.resolve
        group_id: active_group
    else
      promise = Recent.fetch()
        .pipe( (recents) =>
          # recents = []
        
          if recents.length
            subject_id = recents[recents.length-1]?.subjects[0].zooniverse_id
            promise = Api.current.get "/projects/#{Api.current.project}/talk/subjects/#{subject_id}"
          else
            promise.reject()
        
          promise
        )
      
      promise
        
  onFavourite: =>
    
    @group_details.addFavourite Subject.current if Subject.current && User.current
    
    
  onNoMoreSubjects: =>
    return unless @group_details.group?
    select = translate 'span', 'classify.select'
    thanks = translate 'span', 'classify.thanks'
    completed = translate 'span', 'classify.completed'
    dialog = new Dialog 
      content: "<p>#{thanks} #{@group_details.group.name}. #{completed}</p> <p><a class='button' href='#/diaries'>#{select}</a></p>"
    
    dialog.el.find('a').on 'click', ->
      dialog.hide()
      dialog.el.remove()
    
    dialog.show()
    
  onSubjectSelect: (e, subject) =>
    
    if @user
      # migrate old surface history and delete
      old_history = store.get 'history', {}
      key = "history#{@user.zooniverse_id}"
      surface_history = store.get key, old_history
    
      store.set "sub#{User.current.zooniverse_id}#{subject.id}", surface_history[ subject.id ] if surface_history[subject.id]?
      store.deleteKey key
      store.deleteKey 'history'
      surface_history = null
      
      # start = "sub#{@user.zooniverse_id}"
      # old_keys = store.index().filter (key) -> start == key.substr 0, start.length
      # old_keys = old_keys.filter (key) -> key!= "sub#{User.current.zooniverse_id}#{subject.id}"
      # store.deleteKey old_key for old_key in old_keys
      console?.log store.storageSize()
    
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
        
        if User.current
          snapshot = store.get "sub#{User.current.zooniverse_id}#{subject.id}", {}
    
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
    
    Route.navigate '/diaries' if @classification.subject.metadata.tutorial?
  
  nextSubject: =>
    $('button.finish')
      .attr( 'disabled', 'disabled' )
      .prop disabled: true
      
    done = (response)=>
    
      Subject.first().destroy()
      subject = Subject.first()
    
      if subject? then subject.select() else Subject.next()
      
      if User.current
        store.deleteKey key for key in store.index() when key[..."sub#{User.current.zooniverse_id}".length] is "sub#{User.current.zooniverse_id}"
    
    fail = (response)=>
    
      Subject.first().destroy()
      subject = Subject.first()
    
      if subject? then subject.select() else Subject.next()
    
    @classification.send done, fail
  
  onPendingClassification: (e, response) =>
    
    return unless User.current
    
    store.deleteKey key for key in store.index() when key[..."sub#{User.current.zooniverse_id}".length] is "sub#{User.current.zooniverse_id}"
    

  onZoomIn: (e)=>
    e.preventDefault()
    @onZoom e.currentTarget, .1
    
  onZoomOut: (e)=>
    e.preventDefault()
    @onZoom e.currentTarget, -.1
    
  onKeyZoomIn: (e) =>
    return unless e.which == 13
    @onZoom e.currentTarget, .1
  
  onKeyZoomOut: (e) =>
    return unless e.which == 13
    @onZoom e.currentTarget, -.1
  
  onStopZoom: (e) =>
    e.stopPropagation()
    @onZoom e.currentTarget, 0
    
  onZoom: (currentTarget, delta)=>
    @surface.markingMode = false
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
    
    return unless Subject.current? && User.current
    
    snapshot = new Transcription @
    
    key = "sub#{User.current.zooniverse_id}#{Subject.current.id}"
    store.set key, snapshot
    
  reset: (subject)=>
    @toolbars.reset()
      
    for tool in @surface.tools
      tool.controls.el.remove() 
      tool.shapeSet.remove()
      
    @surface.resetTools()
    
    Spine.trigger 'tools:change', @surface.tools
    
    $('button.finish')
      .attr( 'disabled', 'disabled' )
      .prop disabled: true
    
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
