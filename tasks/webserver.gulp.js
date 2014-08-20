module.exports = function(gulp) {
    var webserver = require('gulp-webserver'),
        path = require('path'),
        join = path.join,
        root = join(__dirname, '..');

    gulp.task('webserver', function() {
        gulp.src(root).pipe(webserver({
            port: 3000,
            livereload: true,
            directoryListing: true
        }));
    });
};
