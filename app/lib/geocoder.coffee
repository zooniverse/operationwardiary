$ = require 'jqueryify'
require './jstorage.js'
store = $.jStorage

YQL = require './yql'

class Geocoder
  
  localCache = false
  
  constructor: (@service = 'geonames') ->

  geocode: (placename) =>
    
    promise = new $.Deferred
    
    return promise unless placename
    
    cache = store.get placename if @localCache
    
    if cache?
      [lat, long, name]  = cache
      promise.resolve lat,long,name
    else
      promise = @call_webservice placename
    
      
    promise
    
  call_webservice: (placename) =>
    
    queries =
      geoplanet: "select * from geo.placefinder where text='#{escape placename}' and countrycode in ('BE','FR','GB') limit 1"
      geonames: "select * from xml where url='http://api.geonames.org/search?name=#{escape placename}&featureClass=P&isNameRequired=true&country=BE&country=GB&country=FR&maxRows=3&username=zooniverse'"
    
    query = queries[@service]
    
    promise = new $.Deferred
    
    process_request = (response)=>
      results = response.query.results
      
      defaults =
        lat: null
        long: null
        name: ''
        id: null
    
      promise.resolve lat, long, name unless results?
    
      switch @service
        when 'geonames'
          if results.geonames.geoname? && results.geonames.geoname.length?
            places = results.geonames.geoname
          else
            places = [results.geonames.geoname]
          places = places.map (gnplace) ->
            if gnplace?
              place = 
                lat: gnplace.lat
                long: gnplace.lng
                name: gnplace.toponymName
                id: gnplace.geonameId
            else
              place = defaults
            
            place
            
          console.log places
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
              
            place
            
      promise.resolve places
    
    yql = new YQL query
    yql.signed_request().done process_request
      
      
    promise
    
  save_place: (placename, place) =>
    store.set placename, place if @localCache
    
module.exports = Geocoder