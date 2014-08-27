// Generated by CoffeeScript 1.7.1
var to_s;

to_s = Object.prototype.toString;

exports.is_s = function(str) {
  return to_s.call(str) === '[object String]';
};

exports.is_a = function(arr) {
  return to_s.call(arr) === '[object Array]';
};

exports.is_o = function(obj) {
  return typeof obj === 'object';
};

exports.is_f = function(func) {
  return typeof func === 'function';
};

exports.is_reg = function(reg) {
  return to_s.call(reg) === '[object RegExp]';
};

exports.getDeps = function(func) {
  var cjsRequireRegExp, commentRegExp, deps, func_source;
  func_source = func.toString();
  commentRegExp = /(\/\*([\s\S]*?)\*\/|([^:]|^)\/\/(.*)$)/mg;
  cjsRequireRegExp = /[^.]\s*require\s*\(\s*["']([^'"\s]+)["']\s*\)/g;
  deps = [];
  func_source.replace(commentRegExp, '').replace(cjsRequireRegExp, function(matched, dep) {
    return deps.push(dep);
  });
  return deps;
};