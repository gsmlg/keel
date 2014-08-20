
module.exports = function(gulp) {
    var path = require('path'),
        fs = require('fs'),
        util = require('util'),
        build = require('keel-build-tool').build,
        UglifyJS = require('uglify-js'),
        join = path.join,
        _ = require('underscore'),
        root = join(__dirname, '..');

    var pkg = require(join(root, 'package.json'));

    var spm = pkg.spm;

    var buildOpt = {
        ignore: _.keys(spm.dependencies),
        base: join(root, path.dirname(spm.main)),
        input: join(root, spm.main),
        output: join(root, 'dist', path.basename(spm.main))
    };

    gulp.task('build', function(done) {
        var output = build(buildOpt);

        fs.writeFile(buildOpt.output, output, function(err){
            if (err) {
                util.error(err);
                return done(err);
            }
            var min = UglifyJS.minify(buildOpt.output, {
                warnings: true,
                mangle: false
            });
            var fileName = buildOpt.output.replace(/\.js$/, '.min.js');
            fs.writeFile(fileName, min.code, done);
        });
    });
};
