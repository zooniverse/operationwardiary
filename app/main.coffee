require './lib/jquery.timeago.js'

require './lib/setup'

require './lib/jstorage.js'
store = $.jStorage

Spine = require 'spine'
require 'spine/lib/manager'
require 'spine/lib/route'

BrowserDialog = require 'zooniverse/controllers/browser-dialog'

# delete any cached geocoder results in local storage.
keys = JSON.parse window.localStorage.getItem 'jStorage'
for key, value of keys
  store.deleteKey key if value.hasOwnProperty 'lat' or value[0]?.hasOwnProperty 'lat' unless key is 'place'

try
  Api = require 'zooniverse/lib/api'
catch e
  BrowserDialog.show()
  console?.log 'Failed to load zoo api'
  console?.log JSON.stringify e

try
  User = require 'zooniverse/models/user'
catch e
  BrowserDialog.show()
  console?.log 'Failed to load zoo user'
  console?.log JSON.stringify e

try
  Group = require 'zooniverse/models/project-group'
catch e
  BrowserDialog.show()
  console?.log 'Failed to load zoo project group'
  console?.log JSON.stringify e

try
  TopBar = require 'zooniverse/controllers/top-bar'
catch e
  BrowserDialog.show()
  console?.log 'Failed to load zoo top bar'
  console?.log JSON.stringify e

api = if window.location.hostname is 'www.operationwardiary.org'
  new Api project: 'war_diary', host: 'http://www.operationwardiary.org', path: '/_ouroboros_api/proxy'
else
  new Api project: 'war_diary'

# Build app
app = {}
app.container = '#app'


app.stack = new Spine.Stack
  controllers:
    'home': require './controllers/home'
    'classifier': require './controllers/classifier'
    'about': require './controllers/about'
    'guide': require './controllers/guide'
    'profile': require './controllers/profile'
    'groups': require './controllers/groups'
    'recents': require './controllers/recents'
    'debug': require './controllers/debug'

  routes:
    '/': 'home'
    'classify': 'classifier'
    'about': 'about'
    'guide': 'guide'
    'profile': 'profile'
    'diaries': 'groups'
    '/classify/:group_id': 'classifier'
    '/classify': 'classifier'
    '/about': 'about'
    '/guide': 'guide'
    '/guide/:page': 'guide'
    '/guide/:page/:tag': 'guide'
    '/profile': 'profile'
    '/diaries/:page' : 'groups'
    '/diaries': 'groups'
    '/recents': 'recents'
    'debug': 'debug'

  default: 'home'

try
  Navigation = require './controllers/navigation'
  navigation = new Navigation
  navigation.el.prependTo 'body'
catch e
  BrowserDialog.show()
  console?.log 'Failed to create navigation'
  console?.log JSON.stringify e

try
  app.topBar = new TopBar
  app.topBar.el.prependTo 'body'
catch e
  BrowserDialog.show()
  console?.log 'Failed to create zoo top bar'
  console?.log JSON.stringify e

app.stack.el.appendTo app.container

Footer = require './controllers/footer'
footer = new Footer
app.stack.el.parent().after footer.el

User.fetch()
Spine.Route.setup()

GoogleAnalytics = require 'zooniverse/lib/google-analytics'
ga = new GoogleAnalytics account: 'UA-1224199-51'

BrowserDialog.check msie: 9