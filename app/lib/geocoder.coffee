require './jstorage.js'
store = $.jStorage

class Geocoder
  
  localCache: true
  
  constructor: (@service = 'geonames') ->

  geocode: (placename) =>
    
    promise = new $.Deferred
    
    return promise unless placename
    
    cache = JSON.parse window.sessionStorage.getItem placename if @localCache
    
    if cache?
      # cqche entry should be an array of places
      unless cache.length?
        return @call_webservice placename
      promise.resolve cache
    else
      promise = @call_webservice placename
    
      
    promise
    
  call_webservice: (placename) =>

    queries =
      geoplanet: "select * from geo.placefinder where text='#{encodeURIComponent placename}' and countrycode in ('BE','FR','GB') limit 5"
      geonames: "select * from xml where url='http://api.geonames.org/search?name=#{encodeURIComponent placename}&featureClass=P&featureClass=L&featureClass=T&featureClass=V&country=BE&country=GB&country=FR&country=DE&maxRows=5&username=zooniverse'"
    
    query = queries[@service]
    geonames_url = "https://secure.geonames.org/searchJSON?name=#{encodeURIComponent placename}&featureClass=P&featureClass=L&featureClass=T&featureClass=V&country=BE&country=GB&country=FR&country=DE&maxRows=5&username=zooniverse"
    
    promise = new $.Deferred
    
    defaults =
      placename: null
      lat: null
      long: null
      name: ''
      id: null
    
    callback = placename.toLowerCase()
    callback = callback.replace /[^\p{ASCII}]+/g, ''
    $.getJSON(geonames_url + "&callback=?")
      .done( (response) =>
        promise.resolve @process_request placename, response
      )
      .fail(=>
        promise.resolve [defaults]
      )
      
      
    promise
  
  process_request: (placename, response)=>
    results = response.geonames
    
    defaults =
      placename: null
      lat: null
      long: null
      name: ''
      id: null
  
    return [defaults] unless results?
  
    switch @service
      when 'geonames'
        if results.length?
          places = results
        else
          places = [defaults]
        places = places.map (gnplace) ->
          if gnplace?
            place = 
              lat: gnplace.lat
              long: gnplace.lng
              name: gnplace.toponymName
              id: gnplace.geonameId.toString()
          else
            place = defaults
            
          place.placename = placename
          
          place
          
      when 'geoplanet'
        if results.Result? && results.Result.length?
          places = results.Result
        else
          places = [results.Result]
          
        places = places.map (gpplace) ->
          if gpplace?
            place = 
              lat: gpplace.latitude
              long: gpplace.longitude
              name: if gpplace.neighborhood? then gpplace.neighborhood else gpplace.city
              id: gpplace.woeid
          else
            place = defaults
            
            place.placename = placename
            
          place
          
    console?.log 'RECEIVED:', places
    @save_place placename, places
    places
  
  save_place: (placename, places) =>
    return unless places[0].id?
    value = JSON.stringify places
    window.sessionStorage.setItem placename, value if @localCache
    
module.exports = Geocoder