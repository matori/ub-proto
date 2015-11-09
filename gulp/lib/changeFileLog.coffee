"use strict"

path = require "path"
gutil = require "gulp-util"

module.exports = (filePath, msg = "") ->
    gutil.log "#{gutil.colors.green(path.relative process.cwd(), filePath)} #{gutil.colors.blue(msg)}"
