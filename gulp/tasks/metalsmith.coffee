"use strict"

{exec} = require "child_process"
gulp = require "gulp"

gulp.task "metalsmith", (cb) ->
    exec "node metalsmith", (err, stdout, stderr) ->
        if stdout then console.log stdout
        if stderr then console.log stderr
        cb err
