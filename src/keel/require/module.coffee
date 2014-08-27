Script = require './script'

class Module

  FETCHED_MODULES = []

  id2uri_map = {}
  id2el_map = {}

  @create: (id, deps, factory)->

  @get: (id)->

  @fetch: (src)->
    new Script(src)

  constructor: (id)->


  fetch: ->
    @script = new Script

module.exports = Module
