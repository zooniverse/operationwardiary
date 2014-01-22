Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'

require '../lib/jstorage.js'
store = $.jStorage

class CachedSubject extends Subject
  
  constructor: ->
    super
    CachedSubject.cache = CachedSubject.get_cache()
    
  
  @set_cache: =>
    return unless @group && User.current
    @cache[ @group ] = @instances
    @cache.active_group = @group
    store.set "subjects#{User.current.zooniverse_id}", @cache
  
  @get_cache: =>
    return {} unless User.current
    @cache = store.get "subjects#{User.current.zooniverse_id}", {}
    
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
    
    cached_subjects = @cache[ @group ] ? []
    
    if cached_subjects.length > 0
      cached_subjects = (new CachedSubject subject for subject in cached_subjects)
      @trigger 'fetch', cached_subjects
      promise.resolve cached_subjects
    else
      promise = super params, done, fail
    
      promise.done (subjects) =>
        console?.log 'from API', @instances
        @cache[ @group ] = subjects
        @set_cache()
    
    promise
  
module.exports = CachedSubject