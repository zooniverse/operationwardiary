require './lib/jquery.timeago.js'

require './lib/setup'

Spine = require 'spine'
require 'spine/lib/manager'
require 'spine/lib/route'

BrowserDialog = require 'zooniverse/controllers/browser-dialog'

try
  Api = require 'zooniverse/lib/api'
  User = require 'zooniverse/models/user'
  Group = require 'zooniverse/models/project-group'
  TopBar = require 'zooniverse/controllers/top-bar'
catch e
  BrowserDialog.show()
  console?.log e

api = new Api project: 'war_diary'

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

  default: 'home'

try
  Navigation = require './controllers/navigation'
  navigation = new Navigation
  navigation.el.prependTo 'body'
catch e
  BrowserDialog.show()
  console?.log e

try
  app.topBar = new TopBar
  app.topBar.el.prependTo 'body'
catch e
  BrowserDialog.show()
  console?.log e

app.stack.el.appendTo app.container

Footer = require './controllers/footer'
footer = new Footer
app.stack.el.parent().after footer.el

User.fetch()
Spine.Route.setup()

GoogleAnalytics = require 'zooniverse/lib/google-analytics'
ga = new GoogleAnalytics account: 'UA-1224199-51'

BrowserDialog.check msie: 9