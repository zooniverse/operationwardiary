Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'

require '../lib/jstorage.js'
store = $.jStorage

class CachedSubject extends Subject
  
  constructor: ->
    super
    CachedSubject.cache = {}
    
  @destroyAll: =>
    super
    
    if @group
      @cache[ @group ] = @instances
      store.set "subjects#{User.current.zooniverse_id}", @cache
    
  @first: =>
    instance = super
    console?.log 'subject.first', @instances
    @cache[ @group ] = @instances
    store.set "subjects#{User.current.zooniverse_id}", @cache
    
    instance
    
    
  
  @next: (done, fail) =>
    console?.log @group
    console?.log 'subject.next', @instances
    super done, fail
    
  @fetch: (params, done, fail) =>
    promise = new $.Deferred
    cache = store.get "subjects#{User.current.zooniverse_id}", {}
    
    console?.log @group
    
    cached_subjects = cache[ @group ] ? []
    
    if cached_subjects.length > 0
      cached_subjects = (new CachedSubject subject for subject in cached_subjects)
      console?.log 'from cache', cached_subjects
      promise.resolve cached_subjects
    else
      promise = super params, done, fail
    
      promise.done (subjects) =>
        console?.log 'from API', subjects
        cache[ @group ] = subjects
        store.set "subjects#{User.current.zooniverse_id}", cache
    
    promise
  
module.exports = CachedSubject