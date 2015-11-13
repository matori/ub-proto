"use strict"

_ = require "lodash"
getDateTime = require "../libs/getDateTime"

plugin = (userSettings = []) ->
    defaultSettings = [
        key: "date"
        newKey: "fmtDate"
        format: undefined
        locale: undefined
    ]
    opts = _.assign defaultSettings, userSettings

    (files, metalsmith, done) ->

        _.forEach files, (fileObj, file) ->

            opts.forEach (el, idx) ->
                if fileObj.hasOwnProperty(el.key) and fileObj[el.key]
                    fileObj[el.newKey] = getDateTime el.format, el.locale, fileObj[el.key]

        do done

module.exports = plugin
