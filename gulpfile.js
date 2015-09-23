var gulp = require("gulp");
var webserver = require("gulp-webserver");
var webpackGulp = require("gulp-webpack");
var webdriver = require('gulp-webdriver');
var server = gulp.src('./')
  .pipe(webserver({
    port: 3000,
    fallback: 'index.html'
  }));

gulp.task('test:local:e2e', function () {
  return gulp.src('wdio.conf.local.js')
    .pipe(webdriver())
    .once('end', function () {
      server.emit('kill');
    });
})

gulp.task('test:cloud:e2e', function () {
  return gulp.src('wdio.conf.cloud.js')
    .pipe(webdriver())
    .once('end', function () {
      server.emit('kill');
    });
})

gulp.task('test:build:e2e', function () {
  return gulp.src('wdio.conf.build.js')
    .pipe(webdriver())
    .once('end', function () {
      server.emit('kill');
    });
})

gulp.task("build", function () {
  return gulp.src('coffee/we_vision_external.coffee')
    .pipe(webpackGulp(require('./webpack.config.js')))
    .pipe(gulp.dest('build'));
});
