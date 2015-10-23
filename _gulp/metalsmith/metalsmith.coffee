"use strict"

gulpsmith = require "gulpsmith"
permalinks = require "./permalinks"

module.exports = ->
    gulpsmith()
    .use permalinks "articles/*.html", "articles/:slug"
    .use permalinks "documents/*.html", "documents/:slug"
    .use permalinks "pages/*.html", ":slug"
    .use permalinks "pages/*/*.html", ":parent/:slug"
