"use strict"

_ = require "lodash"
getDateTime = require "../libs/getDateTime"

plugin = (userSetting) ->
    defaultSetting =
        format: ""
        locale: undefined

    opts = _.assign defaultSetting, userSetting

    (files, metalsmith, done) ->
        metalsmith._metadata["lastBuild"] = getDateTime opts.format, opts.locale
        do done

module.exports = plugin
