"use strict"

{tidy} = require "htmltidy2"
_ = require "lodash"

plugin = (userSettings = {}) ->

    htmlOpts = _.assign {}, userSettings
    xmlOpts = _.assign {}, userSettings, {"input-xml": true}

    (files, metalsmith, done) ->
        targetFiles = []
        size = 0
        count = 0

        _.forEach files, (fileObj, file) ->
            if /\.(?:html?|xml)$/i.test file
                targetFiles.push file
                size++

        targetFiles.forEach (file) ->

            opts = if /xml$/i.test file then xmlOpts else htmlOpts

            tidy files[file].contents.toString(), opts, (err, result) ->
                if err then throw err
                files[file].contents = new Buffer result, "utf8"
                count++
                if count is size
                    do done

module.exports = plugin
