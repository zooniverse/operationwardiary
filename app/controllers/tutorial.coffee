Spine = require 'spine'
Classifier = require './classifier'
{Tutorial} = require 'zootorial'
steps = require '../lib/tutorial/steps'

class ClassifierTutorial extends Classifier
  
  constructor: ->
    super
    
    @el.attr id: 'tutorial'
    
    tutorial = new Tutorial steps
    
    tutorial.start()
      
module.exports = ClassifierTutorial