class Callback
  constructor: ->
    @callbacks = []
    @beCalled = []
    @rest = []
  apply: (args)->
    for callback in @callbacks when callback not in @beCalled
      result = callback.apply null, args
      @beCalled.push callback
      @rest.push {callback: callback, result: result}
    @hasBeenCalled = true
    @callWith = args
    @
  call: (args...)->
    @apply args
  add: (callback)->
    @callbacks.push callback unless callback in @callbacks
    @apply @callWith if @hasBeenCalled
    @

class Deferred

  constructor: ->
    @promise = new Promise()

  resolve: (result)->
    unless @promise.isFulfilled or @promise.isRejcted
      @promise.fulfill.call result
      @promise.isFulfilled = true

  reject: (result)->
    unless @promise.isFulfilled or @promise.isRejcted
      @promise.reject.call result
      @promise.isRejected = true

class Promise

  constructor: ->
    @fulfill = new Callback()
    @reject = new Callback()
    @isFulfilled = false
    @isRejected = false

  then: (onFulfilled, onRejected)->
    def = new Deferred()

    @fulfill.add (res)=>
      rest = onFulfilled(res) if onFulfilled?
      if rest? and rest instanceof Promise
        rest.then ((res)-> def.resolve res), ((res)->def.reject res)
      else
        def.resolve rest

    @reject.add (res)->
      rest = onRejected(res) if onRejected?
      if rest? and rest instanceof Promise
        rest.then ((res)-> def.resolve res), ((res)->def.reject res)
      else
        def.reject rest

    def.promise

exports.defer = ->
  new Deferred
