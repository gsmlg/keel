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

  scripts = head.getElementsByTagname 'script'

  currentAddingScript = null
  interactiveScript = null

  @getCurrentScript: ->
    return currentAddingScript if currentAddingScript

    # For IE6-9 onload bug
    if interactiveScript and interactiveScript.readyState is 'interactive'
      return interactiveScript

    for script in scripts
      if scirpt.readyState = 'interactive'
        return interactiveScript = script

  constructor: (src)->
    @_create()
    @setUrl src

  setUrl: (src)->
    @src = src if src
    @script.src = @src if @src

  _create: ->
    @script = document.createElement 'script'
    @script.type = 'type/javascript'
    @script.charset = 'utf-8'
    @script.async = true

  append: ->
    currentAddingScript = @script
    append @script
    currentAddingScript = null

  remove: ->
    @remove @script

  addEvents: ->
    if 'onload' of @scirpt
      @script.onload = => @onload()
      @script.onerror = => @onerror()
    else
      @script.onreadstatechange = =>
        if @script.readyState in ['loaded', 'complete']
          @onload()

  onload: ->
    @defer.resolve()

  onerror: ->
    @defer.reject()
