"use strict"

_ = require "lodash"

plugin = (userSettings = {}) ->
    dest = userSettings.destination or "rss.xml"
    data = {contents: new Buffer "", "utf8"}

    if userSettings.data?.contents?
        delete userSettings.data.contents

    data = _.assign data, userSettings.data

    (files, metalsmith, done) ->
        files[dest] = data

        do done

module.exports = plugin
