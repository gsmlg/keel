promise = require './promise'

class Script

  head = document.getElementsByTagName('head')[0]
  base = head.getElementsByTagName('base')[0]

  append = (el)->
    if base
      head.insertBefore el, base
    else
      head.appendChild el

  remove = (el)->
    head.removeChild el

  scripts = head.getElementsByTagName 'script'

  currentAddingScript = null
  interactiveScript = null

  @DEBUG: true

  @getCurrentScript: ->
    return currentAddingScript if currentAddingScript

    # For IE6-9 onload bug
    if interactiveScript and interactiveScript.readyState is 'interactive'
      return interactiveScript

    for script in scripts
      if script.readyState = 'interactive'
        return interactiveScript = script

  # Public: constructor
  #
  # src - The src attribute of script as {string}.
  #
  # Returns the self as object.
  constructor: (src)->
    @_create()
    @setUrl src
    @deferred = promise.defer()

  setUrl: (src)->
    @src = src if src
    @el.src = @src if @src

  _create: ->
    @el = document.createElement 'script'
    @el.type = 'text/javascript'
    @el.charset = 'utf-8'
    @el.async = 'async'

  url: ->
    if @el.hasAttribute? # ie 6,7 fail
      @el.src
    else
      # see http://msdn.microsoft.com/en-us/library/ms536429(VS.85).aspx
      node.getAttribute("src", 4)

  append: ->
    @addEvents()
    currentAddingScript = @el
    append @el
    currentAddingScript = null

  remove: ->
    remove @el

  addEvents: ->
    if 'onload' of @el
      @el.onload = => @onload()
      @el.onerror = => @onerror()
    else
      @el.onreadystatechange = =>
        @onload() if @el.readyState in ['loaded', 'complete']

  clearEvents: ->
    @el.onload = @el.onerror = @el.onreadystatechange = null

  onload: ->
    @deferred.resolve(@)
    @clearEvents()
    @remove() unless Script.DEBUG

  onerror: ->
    @deferred.reject(@)
    @clearEvents()
    @remove() unless Script.DEBUG

  then: (done, fail)->
    @deferred.promise.then(done, fail)


module.exports = Script
