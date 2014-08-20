module.exports = function(gulp) {
    var es = require('event-stream'),
        RcLoader = require('rcloader'),
        beautify = require('js-beautify'),
        path = require('path'),
        join = path.join,
        root = join(__dirname, '..'),
        beauty = function beauty(opts, type) {
            var rcLoader = new RcLoader('.' + type + 'beautifyrc', opts, {
                loader: 'async'
            });

            var modifyFile = function(file, cb) {
                if (file.isNull()) {
                    return cb(null, file); // pass along
                }
                if (file.isStream()) {
                    return cb(new Error('beautify: Streaming not supported'));
                }
                rcLoader.for(file.path, function(err, opts) {
                    if (err) {
                        return cb(err);
                    }

                    var str = file.contents.toString('utf8'),
                        formatter = beautify[type];

                    file.contents = new Buffer(formatter(str, opts));
                    cb(null, file);
                });
            };

            return es.map(modifyFile);
        };

    gulp.task('beauty:js', function() {
        return gulp.src(join(root, 'src', '**', '*.js'))
            .pipe(beauty({}, 'js'))
            .pipe(gulp.dest('src'));
    });

    gulp.task('beauty:css', function() {
        return gulp.src(join(root, 'src', '**', '*.css'))
            .pipe(beauty({}, 'css'))
            .pipe(gulp.dest('src'));
    });

    gulp.task('beauty:html', function() {
        return gulp.src(join(root, 'src', '**', '*.html'))
            .pipe(beauty({}, 'html'))
            .pipe(gulp.dest('src'));
    });

    gulp.task('beauty', ['beauty:js', 'beauty:css', 'beauty:html'],
        function(done) {
            done();
        });

};
