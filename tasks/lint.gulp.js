module.exports = function (gulp) {
    var jshint = require('gulp-jshint'),
        csslint = require('gulp-csslint'),
        path = require('path'),
        join = path.join,
        root = join(__dirname, '..');

    gulp.task('jshint', function () {
        var files = [];
        files.push(join(root, 'src', '**', '*.js'));
        files.push(join(root, 'tasks', '**', '*.js'));
        return gulp.src(files)
            .pipe(jshint())
            .pipe(jshint.reporter('jshint-stylish'));
    });

    gulp.task('csslint', function () {
        var files = [];
        files.push( join(root, 'src', '**', '*.css'));
        return gulp.src(files)
            .pipe(csslint('.csslintrc'))
            .pipe(csslint.reporter());
    });

    gulp.task('lint', ['jshint', 'csslint']);

};
