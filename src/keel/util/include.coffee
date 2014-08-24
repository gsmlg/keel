INCLUDE_IGNORE = ['included']
hasProp = Object::hasOwnProperty

include = (obj)->
  throw Error 'aguments must be object' unless typeof obj is 'object'
  for key,value of obj when key not in INCLUDED_IGNORE and hasProp.call obj, key
    this::[key] = value
  unless typeof obj.included isnt 'function'
    obj.included.call this, this
  this

module.exports = include
