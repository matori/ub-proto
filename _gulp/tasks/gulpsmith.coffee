"use strict"

gulp = require "gulp"
frontMatter = require "gulp-front-matter"
_ = require "lodash"
metalsmith = require "../metalsmith/metalsmith"
assignFrontMatter = require "../metalsmith/assignFrontMatter"

config = require "./../config"

gulp.task "gulpsmith", ->
    gulp.src config.gulpsmith.src
    .pipe frontMatter()
    .on "data", assignFrontMatter
    .pipe metalsmith()
    .pipe gulp.dest config.gulpsmith.dest
