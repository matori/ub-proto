"use strict"

dest = "_build"
assetsDest = "#{dest}/assets"
src = "src"
assetsSrc = "#{src}/assets"

module.exports =

    metalsmith:
        patterns:
            article: "articls/*.html"

    gulpsmith:
        src: "./contents/**/*.html"
        template: ""
        data: ""
        dest: dest
