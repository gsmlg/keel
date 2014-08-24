promise = require '../../../lib/keel/require/promise'

describe 'require/promise', ->
  deferred = null

  beforeEach ->
    deferred = promise.defer()

  it 'have promise', ->
    expect(!!deferred.promise).toBe true

  it 'execute after 300ms', (done)->
    pm = deferred.promise
    t = +new Date
    setTimeout((->
      deferred.resolve true
    ), 300)

    pm.then (rest)->
      expect(rest).toBe true
      expect(new Date - t >= 300).toBe(true)
      done()


  it 'delay 1s and 1s', (done)->
    pm = deferred.promise

    setTimeout (->
      deferred.resolve 'first'
    ), 1000

    pm.then((rest)->
      expect(rest).toEqual 'first'
      defer = promise.defer()
      setTimeout (->
        defer.resolve 'second'
      ), 1000
      defer.promise
    ).then((rest)->
      expect(rest).toEqual 'second'
      done()
    )
