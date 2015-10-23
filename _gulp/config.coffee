"use strict"

dest = "_build"
assetsDest = "#{dest}/assets"
src = "src"
assetsSrc = "#{src}/assets"

module.exports =

    gulpsmith:
        src: "./contents/**/*.html"
        template: ""
        data: ""
        dest: dest
