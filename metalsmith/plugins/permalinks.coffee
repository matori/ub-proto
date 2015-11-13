"use strict"

branch = require "metalsmith-branch"
permalinks = require "metalsmith-permalinks"

plugin = (filter, pattern) ->
    branch filter
    .use permalinks
        pattern: pattern

module.exports = plugin
