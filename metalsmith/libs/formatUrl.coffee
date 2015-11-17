"use strict"

url = require "url"

formatUrl = (file, hostname, dropIndex) ->
    permalink = url.resolve hostname, file

    if dropIndex
        permalink = permalink.replace /index\.html$/, ""

    permalink: permalink
    rootRelative: permalink.replace hostname, ""

module.exports = formatUrl
