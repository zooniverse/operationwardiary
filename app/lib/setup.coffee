
translate = require 't7e'
enGb = require './en-gb'
translate.load enGb

Editor = require 't7e/editor'
if (!!~location.search.indexOf 'translate')
  Editor.init()
