Spine = require 'spine'

Classification = require 'zooniverse/models/classification'
Subject = require 'zooniverse/models/subject'
User = require 'zooniverse/models/user'

class Classifier extends Spine.Controller
  template: require '../views/classifier'

  events:
    'click .task': 'onDoTask'
    'click .finish': 'onFinishTask'

  constructor: ->
    super

    @render()

    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect

  render: =>
    @html @template()

  onUserChange: (e, user) =>
    # user, User.current

    if user
      alert 'hello user!'
    else
      alert 'you arent a user!'

    Subject.next()

  onSubjectSelect: (e, subject) =>
    # Subject.current

    @classification = new Classification { subject }
    console.log @classification

  onDoTask: =>
    @classification.annotate Date.now()
    console.log @classification

  onFinishTask: =>
    @classification.send()

    Subject.next()

module.exports = Classifier
