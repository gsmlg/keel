type = require './type'

define = (id, deps, factory)->
  argsLen = arguments.length

  if argsLen is 1
    factory = id
    id = null
  else if argsLen is 2
    factory = deps
    if type.is_a id
      deps = id
      id = null
