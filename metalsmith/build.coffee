"use strict"

Metalsmith = require "metalsmith"
msIf = require "metalsmith-if"
collections = require "metalsmith-collections"
tags = require "metalsmith-tags"
htmlMinifier = require "metalsmith-html-minifier"
layouts = require "metalsmith-layouts"
permalinks = require "./lib/permalinks"
feed = require "./lib/feed"
publish = require "./lib/publish"
loadMetadata = require "./lib/loadMetadata"
options = require "./lib/options"
logger = require "./lib/logger"
config = require "./_config"


build = (dir) ->
    logger.start config.src
    metalsmith = new Metalsmith dir

    # initialize
    metalsmith
    .source config.src
    .ignore config.ignore
    .destination config.build
    .clean config.clean
    .metadata loadMetadata dir, config.src, config.metadataFiles

    metalsmith
    .use msIf options.publish, publish config.publishPlugin
    .use collections config.collectionsPlugin
    .use tags config.tagsPlugin

    for permalink in config.permalinksPlugin
        metalsmith
        .use permalinks permalink.matchFilter, permalink.pattern

    metalsmith
    .use feed config.feedPlugin
    .use layouts config.layoutsPlugin
    .use msIf options.publish, htmlMinifier config.htmlMinifierPlugin

    # build
    metalsmith
    .use (files) ->
        console.log files
    .build (err, files) ->
        if err then throw err
        logger.end config.src, config.build, files

module.exports = build
