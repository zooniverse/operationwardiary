Subject = require 'zooniverse/models/subject'

require '../lib/jstorage.js'
store = $.jStorage

class CachedSubject extends Subject
  
  @first: =>
    console?.log 'subject.first', @instances
    store.set 'subjects', @instances
    super
  
  @next: (done, fail) =>
    console?.log 'subject.next', @instances
    super done, fail
    
  @fetch: (params, done, fail) =>
    promise = new $.Deferred
    subjects = store.get 'subjects', []
    
    if subjects.length > 0
      subject = new CachedSubject subject for subject in subjects
      console?.log 'from cache', subjects
      promise.resolve subjects
    else
      promise = super params, done, fail
    
      promise.done (subjects) =>
        console?.log 'from API', subjects
        store.set 'subjects', subjects
    
    promise
  
module.exports = CachedSubject