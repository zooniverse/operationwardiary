OAuth = require './oauth.js'

class YQL
  @consumer_key: "dj0yJmk9aGRGNkljemE4YmdmJmQ9WVdrOVlteHhlV2R3TjJFbWNHbzlNemMwTlRrMk16WXkmcz1jb25zdW1lcnNlY3JldCZ4PWE0"
  @consumer_secret: "5c18b03860c7c28522cc11f1aedc7bc8e220fc14"
  @cache_life = 3600
  
  constructor: (query, @callback = 'process_request')->
    @signed_url = "http://query.yahooapis.com/v1/yql?q=#{ escape query }&format=json&callback=#{ @callback }&_maxage=#{YQL.cache_life}"
    @unsigned_url = "http://query.yahooapis.com/v1/public/yql?q=#{ escape query }&format=json&callback=?&_maxage=#{YQL.cache_life}"
    
  
  unsigned_request: =>
    $.getJSON @unsigned_url
    
    
  
  signed_request: =>
    accessor = 
      consumerSecret: YQL.consumer_secret
      tokenSecret: ""          
    message = 
      action: @signed_url
      method: "GET"
      parameters: [
        ["oauth_version","1.0"]
        ["oauth_consumer_key",YQL.consumer_key]
      ]
 
    OAuth.setTimestampAndNonce message
    OAuth.SignatureMethod.sign message, accessor
 
    parameterMap = OAuth.getParameterMap message
    baseStr = OAuth.decodeForm OAuth.SignatureMethod.getBaseString(message)
    theSig = ""
    
    theSig = (parameter[1] for parameter in parameterMap.parameters when parameter[0] == 'oauth_signature')
    theSig = theSig[0]
 
    paramList = baseStr[2][0].split "&"
    paramList.push "oauth_signature=#{encodeURIComponent theSig}"
    
    paramList.sort (a,b) ->
      return -1 if a[0] < b[0]
      return 1 if a[0] > b[0]
      return  -1 if a[1] < b[1]
      return 1 if a[1] > b[1]
      return 0
 
    locString = ""
    locString = paramList.join '&'
 
    finalStr = baseStr[1][0] + "?" + locString
    
    promise = new $.Deferred
    
    headID = document.getElementsByTagName("head")[0]         
    newScript = document.createElement 'script'
    newScript.type = 'text/javascript'
    newScript.src = finalStr
    
    window[@callback] = (response) ->
      promise.resolve response
      $( newScript ).remove()
      window[@callback] = null
    
    headID.appendChild newScript
    
    promise

module.exports = YQL
  