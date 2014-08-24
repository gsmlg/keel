uri =
  extname: (name)->
    /(\.\w+)?$/.exec(name)[1]

  isAbsolute: (name)->
    name = ''+name
    name.charAt(0) isnt '.'



module.exports = uri
