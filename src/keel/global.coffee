if typeof window is 'object'
  self = window
else if typeof global is 'object'
  self = global
else
  throw new Error 'no global object found'

module.exports = self
