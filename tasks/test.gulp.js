module.exports = function(gulp) {
    var join, karma, _, karmaCommonConf;
    karma = require('karma').server;
    _ = require('underscore');
    join = require('path').join;

    karmaCommonConf = {
        basePath: join(__dirname, '..'),
        frameworks: ['jasmine', 'commonjs'],
        files: [
            {pattern: 'vendor/**/*.js', included: false, watched: false},
            'lib/**/*.js',
            'test/**/*spec.js',
            'test/**/*spec.coffee',
            {pattern: 'test/**/*.coffee', included: false}
        ],
        exclude: [],
        preprocessors: {
            '**/*.coffee': ['coffee', 'commonjs'],
            'lib/**/*.js': ['commonjs']
        },
        reporters: ['growl', 'mocha'],
        port: 9876,
        colors: true,
        autoWatch: true,
        browsers: ['PhantomJS'],
        singleRun: false,
        coffeePreprocessor: {
            options: {
                bare: true,
                sourceMap: false
            }
        },
        commonjsPreprocessor: {
        }
    };

    gulp.task('test', function(done) {
        var conf;
        conf = _.extend({}, karmaCommonConf, {
            singleRun: true
        });

        karma.start(conf, function() {
            done();
            process.exit();
        });
    });

    gulp.task('test:serve', function(done){
        var conf;
        conf = _.extend({}, karmaCommonConf, {
            autoWatch: true,
            singleRun: false
        });

        karma.start(conf, function() {
            done();
            process.exit();
        });
    });

    gulp.task('test:debug', function(done){
        var conf;
        conf = _.extend({}, karmaCommonConf, {
            autoWatch: false,
            logLevel: 'DEBUG',
            singleRun: true
        });

        karma.start(conf, function() {
            done();
            process.exit();
        });
    });
};
