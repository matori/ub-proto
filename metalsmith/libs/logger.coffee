"use strict"

prettyHrtime = require "pretty-hrtime"
gutil = require "gulp-util"

startTime = undefined

logger =

    start: (srcDir) ->
        startTime = do process.hrtime
        gutil.log gutil.colors.blue "Metalsmith start:", gutil.colors.green srcDir

    end: (srcDir, destDir, files) ->
        taskTime = process.hrtime startTime
        prettyTime = prettyHrtime taskTime
        gutil.log gutil.colors.blue("Metalsmith end:"),
            gutil.colors.green(srcDir), "in", gutil.colors.magenta(prettyTime)
        gutil.log gutil.colors.blue("Metalsmith created:"),
            gutil.colors.magenta("#{Object.keys(files).length} files"), "in", gutil.colors.green(destDir)

module.exports = logger
