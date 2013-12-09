# $ = require 'jqueryify'
# require './lib/jquery-ui-1.10.3.custom.min.js'
require './lib/jquery.ui.map.full.min.js'
require './lib/jquery.timeago.js'

require './lib/setup'

Spine = require 'spine'
require 'spine/lib/manager'
require 'spine/lib/route'

Api = require 'zooniverse/lib/api'
User = require 'zooniverse/models/user'
Group = require 'zooniverse/models/project-group'
TopBar = require 'zooniverse/controllers/top-bar'

api = new Api project: 'war_diary'

# Build app
app = {}
app.container = '#app'

Navigation = require './controllers/navigation'
navigation = new Navigation
navigation.el.prependTo 'body'

app.topBar = new TopBar
app.topBar.el.prependTo 'body'

app.stack = new Spine.Stack
  controllers:
    'home': require './controllers/home'
    'classifier': require './controllers/classifier'
    'about': require './controllers/about'
    'guide': require './controllers/guide'
    'profile': require './controllers/profile'
    'groups': require './controllers/groups'

  routes:
    '/': 'home'
    'classify': 'classifier'
    'about': 'about'
    'guide': 'guide'
    'profile': 'profile'
    'groups': 'groups'
    '/classify/:group_id': 'classifier'
    '/classify': 'classifier'
    '/about': 'about'
    '/guide': 'guide'
    '/profile': 'profile'
    '/groups': 'groups'

  default: 'home'

app.stack.el.appendTo app.container

Group.fetch().done( User.fetch() )
Spine.Route.setup()

GoogleAnalytics = require 'zooniverse/lib/google-analytics'
ga = new GoogleAnalytics account: 'UA-1224199-51'