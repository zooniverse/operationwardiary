$ = require 'jqueryify'
require './jstorage.js'
store = $.jStorage

class Geocoder
  
  constructor: (@service = 'geonames') ->

  geocode: (placename) =>
    
    promise = new $.Deferred
    
    return promise unless placename
    
    cache = store.get placename
    console.log cache
    
    if cache?
      [lat, long, name]  = cache
      promise.resolve lat,long,name
    else
      promise = @call_webservice placename
    
      
    promise
    
  call_webservice: (placename) =>
    
    queries =
      geoplanet: "select * from geo.placefinder where text='#{placename}' and countrycode in ('BE','FR','GB') limit 1"
      geonames: "select * from xml where url='http://api.geonames.org/search?q=#{placename}&country=BE&country=GB&country=FR&maxRows=1&username=zooniverse'"
    
    query = queries[@service]
    
    promise = new $.Deferred

    yql = "http://query.yahooapis.com/v1/public/yql?q=#{ escape query }&format=json&callback=?"
    # TODO: OAuth this call to avoid rate-limiting. Cache results too.
    
    $.getJSON( yql ).done (response)=>
    
      results = response.query.results
    
      return promise unless results
    
      switch @service
        when 'geonames'
          lat = parseFloat results.geonames?.geoname.lat
          long = parseFloat results.geonames?.geoname.lng
          name = results.geonames?.geoname.toponymName
        when 'geoplanet'
          lat = parseFloat results.Result?.latitude
          long = parseFloat results.Result?.longitude
          name = if results.Result?.neighborhood? then results.Result.neighborhood else results.Result.city
    
      store.set placename, [lat, long, name]
      promise.resolve lat,long,name
      
    promise
    
module.exports = Geocoder