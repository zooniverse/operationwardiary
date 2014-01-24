Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'

require '../lib/jstorage.js'
store = $.jStorage

class CachedSubject extends Subject
  
  is_favourite: false
  
  constructor: ->
    super
    CachedSubject.cache = CachedSubject.get_cache()
    
  
  @set_cache: (subjects = @instances)=>
    return unless @group && User.current
    @cache = 
      subjects: subjects
      active_group: @group
      
    store.set "subjects#{User.current.zooniverse_id}", @cache
    # console?.log 'setting', @cache[@group][0]
  
  @get_cache: =>
    return {} unless User.current
    @cache = store.get "subjects#{User.current.zooniverse_id}", {}
    # console?.log 'getting', @cache[@group]?[0]
    
    @cache
    
  @destroyAll: =>
    super
    
    if @group
      @set_cache()
    
  @first: =>
    instance = super
    @set_cache()
    
    instance
    
    
  @fetch: (params, done, fail) =>
    promise = new $.Deferred
    @get_cache()
    
    cached_subjects = @cache.subjects ? []
    
    if cached_subjects.length > 0
      cached_subjects = (new CachedSubject subject for subject in cached_subjects)
      @trigger 'fetch', cached_subjects
      console?.log cached_subjects
      promise.resolve cached_subjects
    else
      promise = super params, done, fail
    
      promise.done (subjects) =>
        console?.log 'from API', subjects
        @cache[ @group ] = subjects
        @set_cache subjects
    
    promise
  
module.exports = CachedSubject