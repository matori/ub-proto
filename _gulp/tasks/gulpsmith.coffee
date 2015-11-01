"use strict"

gulp = require "gulp"
frontMatter = require "gulp-front-matter"
_ = require "lodash"
gulpsmith = require "../metalsmith/gulpsmith"

config = require "./../config"

gulp.task "gulpsmith", ->
    gulp.src config.gulpsmith.src
    .pipe frontMatter()
    .on "data", (file) ->
        _.assign file, file.frontMatter
        delete file.frontMatter
    .pipe gulpsmith()
    .pipe gulp.dest config.gulpsmith.dest
