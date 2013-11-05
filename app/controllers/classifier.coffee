$ = require 'jqueryify'
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
Comments = require './classifier/comments'
PageTimeline = require './classifier/page_timeline'

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
    '#diary_id': 'diaryDisplay'
    
  
  cacheNotes: true
  
  user: null
    
  defaults = 
    category: 'date'

  constructor: ->
    super
    
    @defaults = defaults
    @surface_history = store.get 'history', {}
    @category = @defaults.category
    
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
    
    @toolbars.el.on 'pickCategory', (e,type)=>
      @surface.markingMode = true
      @surface.selection?.deselect()
      
      if @cacheNotes
        note = store.get type, undefined
      
        @surface.markDefaults.type = type
        @surface.markDefaults.note = note ? undefined
    
    @group_picker.el.on 'groupChange', (e, group)=>
      @group_details.render group
    
    
    @el.on 'subject:discuss', =>
      @comments.el.toggleClass 'open'
    
    @el.on 'subject:timeline', =>
      @timeline.el.toggleClass 'open'
       

    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect
    # Subject.on 'fetch', @onSubjectFetch
    
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
        @timeline.createEntries @surface.tools
        @timeline.render()
      
    
    @surface.on 'delete', (e, tool)=>
      @update_history()
      page_type = $( '.documents :checked' ).val()
      if page_type == 'diary'
        @timeline.createEntries @surface.tools
        @timeline.render()
      
    

  render: =>
    
    @html @template(@)
    
    @surface ?= new ZoomableSurface
      tool: TextTool
      container: @subjectContainer
      width: 1000
      height: 600
      clickDelay: 300
      
    @surface.dotRadius = 5
    
  active: =>
    super
    Spine.trigger 'nav:close'
    tool.render() for tool in @surface.tools
    
  render_annotation: ( history ) ->

    history?.render()
    @toolbars.toggleCategories()

  onUserChange: (e, user) =>
    # user, User.current
    user_changed = @user?.zooniverse_id != user?.zooniverse_id
    @user = user
    
    if user_changed
      Recent.one 'fetch', (e, recents)=>
        subject_id = recents[recents.length-1].subjects[0].zooniverse_id
        console.log subject_id
        request = Api.current.get "/projects/#{Api.current.project}/talk/subjects/#{subject_id}"
        
        request.done ({group_id}) =>
          console.log group_id
          $('#diary_picker').val group_id
          @group_picker.refresh_group()
    

  onSubjectFetch: (e, subjects) =>
      
    pages = (subject.metadata.page_number for subject in Subject.instances)
    console?.log pages
    
  onSubjectSelect: (e, subject) =>
    
    @classification = new Classification { subject }
      
    @toolbars.reset()
      
    for tool in @surface.tools
      tool.controls.el.remove() 
      tool.shapeSet.remove()
      
    @surface.resetTools()
    
    @timeline = new PageTimeline
    
    # @toolbars.el.find( '.timeline' ).html @timeline.el
    
    snapshot = @surface_history[subject.id]
    
    marks = snapshot?.marks
    marks ?= []
    
    @surface
      .loadImage(subject.location.standard)
      .done( =>
        page_type = snapshot?.document
        metadata = snapshot?.metadata
    
        if page_type
          @toolbars.selectPageType page_type
          @toolbars.toggleCategories()
          @surface.enable()
          
          for key, value of metadata
            @toolbars.metadata.find("[name=#{key}]").val value
            
          for mark in marks
            mark.type = 'time' if mark.type == 'diaryTime'
            @toolbars.select mark.type
            @surface.addMark mark
          
          if page_type == 'diary'
            @timeline.createEntries @surface.tools
          
        @timeline.render()
      )
    @diaryDisplay.text subject.metadata.file_name
    @talk_url = "http://zooniverse-demo.s3-website-us-east-1.amazonaws.com/diaries_talk/#/subjects/#{subject.zooniverse_id}"
    
    @comments = new Comments subject.zooniverse_id
    
    @group_details.el.append @comments.el
    
    @group_details.el.append @timeline.el
    
  onDoTask: =>
    document = $( '.documents :checked' ).val()
    metadata = {}
    
    @toolbars.metadata 
       .find( ':input' )
       .each ->
         metadata[@name] = @value
         
    annotation = 
      document: document
      metadata: metadata
      marks: @surface.marks.slice(0)
      timeline: @timeline.entries
    @classification.annotate annotation
    console?.log 'Classifying', JSON.stringify @classification
    console.log (mark.note for mark in annotation.marks)

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
