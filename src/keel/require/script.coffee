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

  constructor: (src)->
    @_create()
    @setUrl src
    @deferred = promise.defer()

  setUrl: (src)->
    @src = src if src
    @script.src = @src if @src

  _create: ->
    @script = document.createElement 'script'
    @script.type = 'text/javascript'
    @script.charset = 'utf-8'
    @script.async = 'async'

  append: ->
    @addEvents()
    currentAddingScript = @script
    append @script
    currentAddingScript = null

  remove: ->
    remove @script

  addEvents: ->
    if 'onload' of @script
      @script.onload = => @onload()
      @script.onerror = => @onerror()
    else
      @script.onreadystatechange = =>
        @onload() if @script.readyState in ['loaded', 'complete']

  clearEvents: ->
    @script.onload = @script.onerror = @script.onreadystatechange = null

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
