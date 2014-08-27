to_s = Object::toString

exports.is_s = (str)-> to_s.call(str) is '[object String]'

exports.is_a = (arr)-> to_s.call(arr) is '[object Array]'

exports.is_o = (obj)-> typeof obj is 'object'

exports.is_f = (func)-> typeof func is 'function'

exports.is_reg = (reg)-> to_s.call(reg) is '[object RegExp]'

exports.getDeps = (func)->
  func_source = func.toString()

  commentRegExp = /(\/\*([\s\S]*?)\*\/|([^:]|^)\/\/(.*)$)/mg
  cjsRequireRegExp = /[^.]\s*require\s*\(\s*["']([^'"\s]+)["']\s*\)/g

  deps = []

  func_source.replace(commentRegExp, '')
    .replace(cjsRequireRegExp, (matched, dep)->
      deps.push dep
    )

  deps


## utils path

# RegExp for match path
EXTNAME_REG = /(\.\w+)(:?\?|$|\#)/
DIRNAME_REG = /[^?#]*\//
DOT_REG = /\/\.\//g
DOUBLE_DOT_REG = /\/[^\/]+\/\.\.\//
MULTI_SLASH_REG = /([^:\/])\/+\//g

# extname
exports.extname = (path)->
  EXTNAME_REG.exec(path)[1]

# Extract the dirctory portion of a path
# dirname('path/to/file.js?t=123#off') => 'path/to/'
exports.dirname = (path)->
  DIRNAME_REG.exec(path)[0]

# Canonicalize a path
# realpath
exports.realpath = (path)->
  path = '' + path
  path = path.replace DOT_REG, '/'

  path = path.replace MULTI_SLASH_REG, '$1/'

  while path.match DOUBLE_DOT_REG
    path = path.replace DOUBLE_DOT_REG, '/'

  path
