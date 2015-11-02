"use strict"

path = require "path"
gulpsmith = require "gulpsmith"
permalinks = require "./permalinks"
collections = require "metalsmith-collections"
layouts = require "metalsmith-layouts"
publish = require "./publish"
metadata = require path.resolve __dirname, "../../metadata"

module.exports = ->
    gulpsmith()
    .metadata metadata
#    .use ->
#        console.log arguments
    .use publish
        draftDir: "_draft"
        publicDir: "."
        publishKey: "public"
#    .use ->
#        console.log arguments[0]
    .use collections
        article:
            pattern: "articles/*.html"
            sortBy: "date"
            reverse: true
    .use permalinks "articles/*.html", "articles/:slug"
    .use permalinks "documents/*.html", "documents/:slug"
    .use permalinks "pages/*.html", ":slug"
    .use permalinks "pages/*/*.html", ":parent/:slug"
    .use layouts
        engine: "jade"
        directory: "src/templates"
        default: "test.jade"
