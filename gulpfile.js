var gulp = require("gulp");
var gutil = require("gulp-util");
var webpack = require("webpack");
var rename = require("gulp-rename");
var concat = require("gulp-concat");
var minify = require("gulp-clean-css");
var webpackGulp = require("gulp-webpack");
var webpack = require("webpack-dev-server");
var webpackConfig = require("./webpack.config.js");

gulp.task("webpack", function () {
  gulp.src('coffee/we_vision_external.coffee')
    .pipe(webpackGulp(require('./webpack.config.js')))
    .pipe(gulp.dest('build'));

  gulp.src('css/main.css')
    .pipe(minify())
    .pipe(rename('we_vision.min.css'))
    .pipe(gulp.dest('build'))
});
