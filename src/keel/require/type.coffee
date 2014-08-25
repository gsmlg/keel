to_s = Object::toString

exports.is_s = (str)-> to_s.call(str) is '[object String]'

exports.is_a = (arr)-> to_s.call(arr) is '[object Array]'

exports.is_o = (obj)-> typeof obj is 'object'

exports.is_f = (func)-> typeof func is 'function'

exports.is_reg = (reg)-> to_s.call(reg) is '[object RegExp]'
