class Deferred

  constructor: ->
    @promise = new Promise

  resolve: (args...)->
    cb = @promise.fulfill.shift
    result = cb.apply null, args if cb

  reject: (args...)->
    cb = @promise.reject.shift
    result = cb.apply null, args if cb


class Promise

  constructor: ->
    @promise = @
    @fulfill = []
    @reject = []

  _addFulfill: (cb)->
    @fulfile.push cb

  _addReject: (cb)->
    @reject.push cb

  then: (onFulfilled, onRejcted)->
    @addFulfill onFulfilled if onFulfilled
    @addReject onRejected if onRejected
    @

  catch: (callback)->
