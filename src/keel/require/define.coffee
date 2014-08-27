util = require './util'

Module = require './module'

# Public: function for define a module
#
# id      - {string} the name of definition.
# deps    - {array} the dependencies of this module.
# factory - {function} or {object} the factory of this module.
#
# Returns the [Description] as `undefined`.
define = (id, deps, factory)->
  argsLen = arguments.length

  if argsLen is 1
    factory = id
    id = null
  else if argsLen is 2
    factory = deps
    if util.is_a id
      deps = id
      id = null
    else
      deps = null

  if !util.is_a(deps) and util.is_f(factory)
    deps = util.getDeps factory

  Module.create id, deps, factory
