var join = require('path').join,
gulp = require('gulp'),
_ref = require('fs'),
exists = _ref.existsSync,
stat = _ref.lstatSync,
readdir = _ref.readdirSync,
TaskManager = (function() {
    function TaskManager(gulp) {
        this.tasks = [];
        this.gulp = gulp;
    }

    TaskManager.prototype.load = function(moduleName) {
        var task, _i, _len, _ref1;
        this.lookup(moduleName);
        _ref1 = this.tasks;
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
            task = _ref1[_i];
            require(task)(this.gulp);
        }
        this.tasks = [];
        return this;
    };

    TaskManager.prototype.lookup = function(moduleName) {
        var s;
        if (moduleName == null) {
            moduleName = process.cwd() + '/tasks';
        }
        if (exists(moduleName)) {
            s = stat(moduleName);
            if (s.isFile() && /\.gulp\.(js|coffee)$/.test(moduleName)) {
                this.tasks.push(moduleName);
            }
            if (s.isDirectory()) {
                this.lookupDir(moduleName);
            }
        }
        return this;
    };

    TaskManager.prototype.lookupDir = function(dir) {
        var file, files, _i, _len, _results;
        files = readdir(dir);
        _results = [];
        for (_i = 0, _len = files.length; _i < _len; _i++) {
            file = files[_i];
            _results.push(this.lookup(join(dir, file)));
        }
        return _results;
    };

    return TaskManager;

})();

(function(gulp) {
    var tm;
    tm = new TaskManager(gulp);
    return gulp.loadTasks = function(moduleName) {
        return tm.load(moduleName);
    };
}(gulp));

gulp.loadTasks(join(__dirname, 'tasks'));
