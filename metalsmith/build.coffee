"use strict"

_ = require "lodash"
Metalsmith = require "metalsmith"
msIf = require "metalsmith-if"
fileMetadata = require "metalsmith-filemetadata"
collections = require "metalsmith-collections"
tags = require "metalsmith-tags"
htmlMinifier = require "metalsmith-html-minifier"
layouts = require "metalsmith-layouts"
permalinks = require "./plugins/permalinks"
feed = require "./plugins/feed"
publish = require "./plugins/publish"
formatDate = require "./plugins/formatDate"
lastBuild = require "./plugins/lastBuild"
sitemap = require "./plugins/sitemap"
htmltidy = require "./plugins/htmltidy"
displayMsObj = require "./plugins/displayMsObj"
loadMetadata = require "./libs/loadMetadata"
options = require "./libs/options"
logger = require "./libs/logger"
config = require "./config"

build = (dir) ->
    logger.start config.src
    metalsmith = new Metalsmith dir

    msMetadata = loadMetadata dir, config.src, config.metadataFiles
    msMetadata["lodash"] = require "lodash"
    sitemapObj = _.assign config.sitemapPlugin, {hostname: msMetadata.site.url}

    # initialize
    metalsmith
    .source config.src
    .ignore config.ignore
    .destination config.build
    .clean config.clean
    .metadata msMetadata

    metalsmith
    .use msIf options.publish, publish config.publishPlugin
    .use formatDate config.formatDatePlugin
    .use fileMetadata config.fileMetadataPlugin
    .use tags config.tagsPlugin

    for permalink in config.permalinksPlugin
        metalsmith
        .use permalinks permalink.matchFilter, permalink.pattern

    metalsmith
    .use sitemap sitemapObj
    .use collections config.collectionsPlugin
    .use lastBuild config.lastBuildPlugin
    .use feed config.feedPlugin
    .use layouts config.layoutsPlugin
    .use htmltidy config.htmltidyPlugin
    .use msIf options.publish, htmlMinifier config.htmlMinifierPlugin

    # build
    metalsmith
#    .use displayMsObj()
    .build (err, files) ->
        if err then throw err
        logger.end config.src, config.build, files

module.exports = build
