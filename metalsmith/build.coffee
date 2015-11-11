"use strict"

_ = require "lodash"
Metalsmith = require "metalsmith"
msIf = require "metalsmith-if"
collections = require "metalsmith-collections"
tags = require "metalsmith-tags"
htmlMinifier = require "metalsmith-html-minifier"
layouts = require "metalsmith-layouts"
permalinks = require "./lib/permalinks"
feed = require "./lib/feed"
publish = require "./lib/publish"
options = require "./lib/options"
config = require "./_config"

build = (dir) ->
    metalsmith = new Metalsmith dir

    # initialize
    metalsmith
    .source config.src
    .ignore config.ignore
    .destination config.build
    .clean config.clean

    metalsmith
    .use msIf options.publish, publish config.publishPlugin
    .use collections config.collectionsPlugin
    .use tags config.tagsPlugin

    for permalink in config.permalinksPlugin
        metalsmith
        .use permalinks permalink.matchFilter, permalink.pattern

    metalsmith
    .use layouts config.layoutsPlugin
    .use msIf options.publish, htmlMinifier config.htmlMinifierPlugin
    .use feed config.feedPlugin

    # build
    metalsmith
    .build (err, files) ->
        if err then throw err
        console.log "Metalsmith created #{Object.keys(files).length} files."

module.exports = build
