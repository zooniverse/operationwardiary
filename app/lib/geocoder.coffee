$ = require 'jquerify'

class Geocoder
  
  service: 'geonames'
  
  constructor: (@service) =>

  geocode: (placename) =>
    promise = new $.Deferred
    
    return promise unless placename
    
    queries = 
      geoplanet: "select * from geo.placefinder where text='#{placename}' and countrycode in ('BE','FR','GB') limit 1"
      geonames: "select * from xml where url='http://api.geonames.org/search?q=#{placename}&country=BE&country=GB&country=FR&maxRows=1&username=zooniverse'"
    
    query = queries[@service]
    console.log query
    console.log @service
    pf_url = "http://query.yahooapis.com/v1/public/yql?q=#{ escape query }&format=json&callback=?"
    # TODO: OAuth this call to avoid rate-limiting. Cache results too.
    
    $.getJSON( pf_url ).done (response)->
      
      results = response.query.results
      
      return unless results
      
      switch @service
        when 'geonames'
          lat = parseFloat results.geonames?.geoname.lat
          long = parseFloat results.geonames?.geoname.lng
          name = results.geonames?.geoname.toponymName
        when 'geoplanet'
          lat = parseFloat results.Result?.latitude
          long = parseFloat results.Result?.longitude
          name = if results.Result?.neighborhood? then results.Result.neighborhood else results.Result.city
      
      promise.resolve lat,long,name
      
    promise
    
module.exports = Geocoder