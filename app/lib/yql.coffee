OAuth = require './oauth.js'

class YQL
  @consumer_key: "dj0yJmk9R2t0dzBOdU5TSFZwJmQ9WVdrOWNVSjBWMHB5TkRJbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD04NQ--"
  @consumer_secret: "6be8e90d9b3fe81bfe846a148bcd69a65981b928"
  
  constructor: (query)->
    @signed_url = "https://query.yahooapis.com/v1/yql?q=#{ escape query }&format=json"
    @unsigned_url = "http://query.yahooapis.com/v1/public/yql?q=#{ escape query }&format=json"
    
  
  unsigned_request: =>
    @unsigned_url
    
  
  signed_request: =>
    console.log 'SIGNED REQUEST'
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
    
    console.log paramList
    # paramList.sort (a,b) ->
    #   if (a[0] < b[0]) return -1
    #   if (a[0] > b[0]) return 1
    #   if (a[1] < b[1]) return  -1
    #   if (a[1] > b[1]) return 1
    #   return 0
 
    locString = ""
    locString = paramList.join '&'
    
    console.log locString
    console.log baseStr
 
    finalStr = baseStr[1][0] + "?" + locString + "&callback=?"

module.exports = YQL
  