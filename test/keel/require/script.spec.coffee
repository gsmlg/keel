Script = require '../../../lib/keel/require/script'

describe 'Script', ->
  script = null
  beforeEach ->
    script = new Script()

  afterEach ->
    script.remove
    script = null

  it 'should loaded', (done)->
    expect(typeof $).toEqual 'undefined'
    script.setUrl '/base/vendor/jquery.js'
    script.append()
    script.then (s)->
      head = document.getElementsByTagName('head')[0]
      inhead = script.el in head.getElementsByTagName('script')
      expect(s).toBe script
      expect(inhead).toBe true
      setTimeout (->
        expect($.fn.jquery).toEqual '1.11.1'
        done()
      ), 1000


  it 'should load error', (done)->
    script.setUrl '/undefined'
    script.append()
    script.then ((s)->), ((s)->
      expect(s).toBe script
      done()
    )
