"use strict"

branch = require "metalsmith-branch"
permalinks = require "metalsmith-permalinks"

module.exports = (filter, pattern) ->
    branch filter
    .use permalinks
        pattern: pattern
