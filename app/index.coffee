require './lib/setup'

Spine = require 'spine'
require 'spine/lib/manager'
require 'spine/lib/route'

Api = require 'zooniverse/lib/api'
User = require 'zooniverse/models/user'
Footer = require 'zooniverse/controllers/footer'
TopBar = require 'zooniverse/controllers/top-bar'

api = new Api project: 'worms'

# Build app
app = {}
app.container = '#app'

Navigation = require './controllers/navigation'
navigation = new Navigation
navigation.el.prependTo 'body'

app.topBar = new TopBar
app.topBar.el.prependTo 'body'

app.footer = new Footer
app.footer.el.appendTo 'body'

app.stack = new Spine.Stack
  controllers:
    'home': require './controllers/home'
    'classifier': require './controllers/classifier'
    'about': require './controllers/about'

  routes:
    '/': 'home'
    '/classify': 'classifier'
    '/about': 'about'

  default: 'home'

app.stack.el.appendTo app.container

User.fetch()
Spine.Route.setup()