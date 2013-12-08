Spine = require 'spine'
{Route} = Spine

require '../lib/jstorage.js'
store = $.jStorage

Classification = require 'zooniverse/models/classification'
Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'
Recent = require 'zooniverse/models/recent'
Api = require 'zooniverse/lib/api'

ZoomableSurface = require '../lib/zoom_surface'
TextTool = require '../lib/text-tool'

GroupPicker = require './classifier/group_picker'
GroupDetails = require './classifier/group'
Toolbars = require './classifier/toolbars'
  
{Tutorial} = require 'zootorial'
steps = require '../lib/tutorial/steps'
tutorial_subject = require '../lib/tutorial/subjects'

class Classifier extends Spine.Controller
  
  template: require '../views/classifier/'

  events:
    'click .task': 'onDoTask'
    'click .finish': 'onFinishTask'
    'click .back': 'onGoBack'
    'mousedown .zoom-in': 'onZoomIn'
    'mousedown .zoom-out': 'onZoomOut'
    'keydown .zoom-in': 'onKeyZoomIn'
    'keydown .zoom-out': 'onKeyZoomOut'

  elements:
    '.subject-container': 'subjectContainer'
    # '#diary_id': 'diaryDisplay'
    
  
  cacheNotes: true
  
  tutorial_done = false
    
  defaults = 
    category: 'date'

  constructor: ->
    super
    
    @defaults = defaults
    @surface_history = store.get 'history', {}
    @category = @defaults.category
    @tutorial = new Tutorial steps
    
    @render()
    
    @el.attr id: 'classify'
    
    @toolbars = new Toolbars
    @el.find('.tools').prepend @toolbars.el
    
    @group_picker = new GroupPicker
    @el.find('#group-picker').prepend @group_picker.el
    
    @group_details = new GroupDetails
    @el.find('.tools').before @group_details.el
    
    @toolbars.el.on 'pickDocument', =>
      @surface.enable()
      page_type = $( '.documents :checked' ).val()
      store.set 'document', page_type
      $('button.finish').attr disabled: false
    
    @toolbars.el.on 'pickCategory', (e,type)=>
      @surface.markingMode = true
      @surface.selection?.deselect()
      
      if @cacheNotes
        note = store.get type, undefined
      
        @surface.markDefaults.type = type
        @surface.markDefaults.note = note ? undefined
    
    @group_picker.el.on 'groupChange', (e, group)=>
      @group_details.render group
    
    @el.on 'subject:favourite', =>
      @onFavourite()
       

    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect
    
    @surface.on 'select', (e, mark)=>
      type = mark.type
      @toolbars.select type
        
    @surface.on 'create-tool', =>
      type = $('.categories :checked').val()
      
      if @cacheNotes
        note = store.get type, undefined if type?
        if note?
          @surface.markDefaults.note = note
          @surface.markDefaults.type = type
    # @surface.on 'deselect', (e, mark)=>
    #   type = mark.type
    #   @toolbars.deselect type
    
    @surface.on 'change', (e, tool)=>
      @update_history()
      mark = tool.mark
      store.set mark.type, mark.note if @cacheNotes && mark? && mark.type not in ['diaryDate', 'date']
      
      page_type = $( '.documents :checked' ).val()
      if page_type == 'diary'
       Spine.trigger 'tools:change', @surface.tools
      
    
    @surface.on 'delete', (e, tool)=>
      @update_history()
      page_type = $( '.documents :checked' ).val()
      if page_type == 'diary'
        Spine.trigger 'tools:change', @surface.tools
      
      
    @toolbars.on 'reset', =>
      @update_history()
    
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
    Spine.trigger 'nav:close'
    tool.render() for tool in @surface.tools
    
    if params.group_id?
      if params.group_id == 'tutorial'
        @run_tutorial() if @tutorial_done
      else
        @group_picker.set_group params.group_id
    else
      # @navigate '/groups' unless @group_details.group
      
    $('.site-navigation .links ul')
      .find('a')
      .removeClass('active')
      .filter("[href='#/classify']")
      .addClass 'active'
    
  activate: =>
    super
    # @navigate '/classify', 'tutorial' unless User.current
    if @user?
      @run_tutorial() unless @tutorial_done
    else
      User.one 'change', (e, user)=>
        @run_tutorial() unless user
      
  render_annotation: ( history ) ->

    history?.render()
    @toolbars.toggleCategories()

  onUserChange: (e, user) =>
    # user, User.current
    user_changed = @user?.zooniverse_id != user?.zooniverse_id
    @user = user
    
    if user_changed
      Subject.destroyAll()
      
      if user
        @getRecentGroup()
          .done ({group_id}) =>
            console.log @user
            @tutorial_done = true
            @group_picker.set_group group_id unless @tutorial.started?
          .fail =>
            # @navigate '/groups'
      else
        Subject.next()
    
    else
      @user ?= false
      console.log @user
  
  getRecentGroup: =>
    Recent.fetch()
      .pipe( (recents) =>
        # recents = []
        
        if recents.length
          subject_id = recents[recents.length-1]?.subjects[0].zooniverse_id
          console.log subject_id
          promise = Api.current.get "/projects/#{Api.current.project}/talk/subjects/#{subject_id}"
        else
          promise = new $.Deferred
          promise.reject()
        
        promise
      )
        
  onFavourite: =>
    
    @group_details.addFavourite @classification.subject
    
    
  onSubjectSelect: (e, subject) =>
    
    @classification = new Classification { subject }
      
    @reset subject
    
    # @toolbars.el.find( '.timeline' ).html @timeline.el
    
    @surface
      .loadImage(subject.location.standard)
      .done( =>
        # @diaryDisplay.text subject.metadata.file_name
        
        snapshot = @surface_history[subject.id]
    
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
      x = parseInt 100 * x / @surface.width
      y = parseInt 100 * y / @surface.height
      @classification.annotate
        type: mark.type
        coords: [x,y]
        note: mark.note
    console?.log 'Classifying', JSON.stringify @classification
    console.log (mark.note for mark in @surface.marks)

  onFinishTask: =>
    @onDoTask()
    
    console.log @classification.subject.metadata.tutorial
    @nextSubject() unless @classification.subject.metadata.tutorial
  
  nextSubject: =>
    @classification.send()
      
    @update_history()
    
    Subject.current.destroy()
    subject = Subject.first()
    
    if subject? then subject.select() else Subject.next()

  onZoomIn: ({currentTarget})=>
    
    timeout = @onZoom currentTarget, .2
    
  onZoomOut: ({currentTarget})=>
    
    timeout = @onZoom currentTarget, -.2
    
  onKeyZoomIn: (e) =>
    return unless e.which == 13
    @onZoom e.currentTarget, .2
  
  onKeyZoomOut: (e) =>
    return unless e.which == 13
    @onZoom e.currentTarget, -.2
    
  onZoom: (currentTarget, delta)=>
    @surface.selection?.deselect()
    timeout = null

    zoom = =>
      @surface.zoom @surface.zoomBy + delta
      clearTimeout timeout if timeout
      timeout = setTimeout zoom, 200
      
    zoom()
    
    $( currentTarget ).one( 'mouseup keyup', -> clearTimeout timeout )
    
  onGoBack: ->
    
    
  
  update_history: ->
    
    return unless Subject.current
    
    snapshot = new Transcription @
    
    @surface_history[ Subject.current.id ] = snapshot
    
    
    store.set 'history', @surface_history
    
  reset: (subject)=>
    @toolbars.reset()
      
    for tool in @surface.tools
      tool.controls.el.remove() 
      tool.shapeSet.remove()
      
    @surface.resetTools()
    
    Spine.trigger 'tools:change', @surface.tools
    
    $('button.finish').attr disabled: true
    
  run_tutorial: =>
    
    @group_details.render tutorial_subject.group
    Subject.one 'select', =>
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
