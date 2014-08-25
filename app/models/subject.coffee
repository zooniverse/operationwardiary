Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'

require '../lib/jstorage.js'
store = $.jStorage

class CachedSubject extends Subject
  
  is_favourite: false
  
  @trackSeenSubject: (subject) ->
    
  
  constructor: ->
    super
    CachedSubject.cache = CachedSubject.get_cache()
    
  
  @set_cache: (subjects)=>
    return unless @group && User.current
    @cache = 
      subjects: subjects
      active_group: @group
      
    store.set "subjects#{User.current.zooniverse_id}", @cache
    # console?.log 'setting', @cache[@group][0]
  
  @get_cache: =>
    return { subjects: [] } unless User.current
    store.get "subjects#{User.current.zooniverse_id}", { subjects:[] }
    
  @destroyAll: =>
    super
    
    if @group
      @set_cache []
    
  destroy: =>
    cached_subjects = CachedSubject.get_cache().subjects
    for subject, i in cached_subjects when subject.zooniverse_id == @zooniverse_id
      cached_subjects.splice i, 1
      break
    CachedSubject.set_cache cached_subjects
    
    super
    
    
  @fetch: (params, done, fail) =>
    promise = new $.Deferred
    cache = @get_cache()
    cache.subjects ?= []
    
    cached_subjects = cache.subjects
    
    if cached_subjects.length > 0
      # destroy jQueryEventProxy if it was accidentally saved.
      subject.jQueryEventProxy = null for subject in cached_subjects
      cached_subjects = (new CachedSubject subject for subject in cached_subjects)
      @trigger 'fetch', [cached_subjects]
      console?.log cached_subjects
      promise.resolve cached_subjects
    else
      promise = super params, done, fail
    
      promise.done (subjects) =>
        console?.log 'from API', subjects
        @set_cache subjects
    
    promise
  
module.exports = CachedSubject