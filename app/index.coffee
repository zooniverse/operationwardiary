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

  routes:
    '/': 'home'
    'classify': 'classifier'
    'about': 'about'
    'guide': 'guide'
    'profile': 'profile'

  default: 'home'

app.stack.el.appendTo app.container

User.fetch()
Group.fetch()
Spine.Route.setup()