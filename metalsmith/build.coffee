"use strict"

Metalsmith = require "metalsmith"
msIf = require "metalsmith-if"
collections = require "metalsmith-collections"
tags = require "metalsmith-tags"
htmlMinifier = require "metalsmith-html-minifier"
layouts = require "metalsmith-layouts"
permalinks = require "./lib/permalinks"
publish = require "./lib/publish"
options = require "./lib/options"
config = require "./_config"

build = (dir) ->

    Metalsmith dir
    .source config.src
    .ignore config.ignore
    .destination config.build
    .clean config.clean
    .use msIf options.publish, publish config.publishPlugin
    .use collections config.collectionsPlugin
    .use tags config.tagsPlugin
    .use permalinks "{public,draft}/articles/*.html", "articles/:slug"
    .use permalinks "{public,draft}/documents/*.html", "documents/:slug"
    .use permalinks "public/pages/*.html", ":slug"
    .use permalinks "public/pages/*/*.html", ":parent/:slug"
    .use permalinks "categories/**/*.html", ""
    .use layouts config.layoutsPlugin
    .use msIf options.publish, htmlMinifier config.htmlMinifierPlugin
    .build (err, files) ->
        if err then throw err
        console.log "Metalsmith created #{Object.keys(files).length} files."

module.exports = build
