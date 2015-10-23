"use strict"

_ = require "lodash"

module.exports = (file) ->
    _.assign file, file.frontMatter
    delete file.frontMatter
