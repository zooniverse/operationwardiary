Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'

require '../lib/jstorage.js'
store = $.jStorage

class CachedSubject extends Subject
  
  constructor: ->
    super
    CachedSubject.cache = {}
    
  @destroyAll: =>
    console?.log @group
    @cache[ @group ] = [] if @group
    super
    
  @first: =>
    console?.log 'subject.first', @instances
    @cache[ @group ] = @instances
    store.set "subjects#{User.current.zooniverse_id}", @cache
    super
  
  @next: (done, fail) =>
    console?.log @group
    console?.log 'subject.next', @instances
    super done, fail
    
  @fetch: (params, done, fail) =>
    promise = new $.Deferred
    cache = store.get "subjects#{User.current.zooniverse_id}", {}
    
    console?.log @group
    
    subjects = cache[ @group ] ? []
    
    if subjects.length > 0
      subject = new CachedSubject subject for subject in subjects
      console?.log 'from cache', subjects
      promise.resolve subjects
    else
      promise = super params, done, fail
    
      promise.done (subjects) =>
        console?.log 'from API', subjects
        cache[ @group ] = subjects
        store.set "subjects#{User.current.zooniverse_id}", cache
    
    promise
  
module.exports = CachedSubject