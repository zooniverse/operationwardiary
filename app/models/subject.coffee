Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'

require '../lib/jstorage.js'
store = $.jStorage

class CachedSubject extends Subject
  
  constructor: ->
    super
    CachedSubject.cache = {}
    
  
  @set_cache: =>
    return unless User.current
    @cache[ @group ] = @instances
    console?.log 'set cache', @cache
    store.set "subjects#{User.current.zooniverse_id}", @cache
  
  @get_cache: =>
    return unless User.current
    @cache = store.get "subjects#{User.current.zooniverse_id}", {}
    
  @destroyAll: =>
    super
    
    if @group
      @set_cache()
    
  @first: =>
    instance = super
    @set_cache()
    
    instance
    
    
  
  @next: (done, fail) =>
    console?.log @group
    console?.log 'subject.next', @instances
    super done, fail
    
  @fetch: (params, done, fail) =>
    promise = new $.Deferred
    @get_cache()
    
    cached_subjects = @cache[ @group ] ? []
    console?.log 'cache contents', cached_subjects
    
    if cached_subjects.length > 0
      cached_subjects = (new CachedSubject subject for subject in cached_subjects)
      console?.log 'from cache', @instances
      promise.resolve cached_subjects
    else
      promise = super params, done, fail
    
      promise.done (subjects) =>
        console?.log 'from API', @instances
        @cache[ @group ] = subjects
        @set_cache()
    
    promise
  
module.exports = CachedSubject