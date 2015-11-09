"use strict"

path = require "path"
gulpsmith = require "gulpsmith"
permalinks = require "./permalinks"
collections = require "metalsmith-collections"
layouts = require "metalsmith-layouts"
publish = require "./publish"
metadata = require path.resolve __dirname, "../../metadata"
tags = require "metalsmith-tags"

module.exports = ->
    gulpsmith()
    .metadata metadata
    .use publish
        draftDir: "draft"
        publicDir: "."
        publishKey: "public"
    .use collections
        article:
            pattern: "articles/*.html"
            sortBy: "date"
            reverse: true
    .use tags
        handle: "category"
        path: "categories/:tag.html"
        layout: "category.jade"
        sortBy: "date"
        reverse: true
        skipMetadata: false
    .use ->
        console.log arguments
    .use permalinks "articles/*.html", "articles/:slug"
    .use permalinks "documents/*.html", "documents/:slug"
    .use permalinks "pages/*.html", ":slug"
    .use permalinks "pages/*/*.html", ":parent/:slug"
    .use permalinks "categories/**/*.html", ""
    .use layouts
        engine: "jade"
        directory: "src/templates"
        default: "test.jade"
