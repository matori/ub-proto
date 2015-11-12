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
formatDate = require "./lib/formatDate"
loadMetadata = require "./lib/loadMetadata"
lastBuild = require "./lib/lastBuild"
options = require "./lib/options"
logger = require "./lib/logger"
config = require "./config"
displayMsObj = require "./lib/displayMsObj"

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
    .use formatDate config.formatDatePlugin

    for permalink in config.permalinksPlugin
        metalsmith
        .use permalinks permalink.matchFilter, permalink.pattern

    metalsmith
    .use collections config.collectionsPlugin
    .use tags config.tagsPlugin
    .use lastBuild config.lastBuildPlugin
    .use feed config.feedPlugin
    .use layouts config.layoutsPlugin
    .use msIf options.publish, htmlMinifier config.htmlMinifierPlugin

    # build
    metalsmith
    .use displayMsObj()
    .build (err, files) ->
        if err then throw err
        logger.end config.src, config.build, files

module.exports = build
