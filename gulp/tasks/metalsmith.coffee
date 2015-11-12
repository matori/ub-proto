"use strict"

{exec} = require "child_process"
gulp = require "gulp"

gulp.task "metalsmith", (cb) ->
    exec "node metalsmith", (err, stdout, stderr) ->
        console.log stdout
        console.log stderr
        cb err
