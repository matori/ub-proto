"use strict"

fs = require "fs-extra"
path = require "path"
_ = require "lodash"

publish = (userConfig) ->
    opts =
        draftDir: "draft"
        publicDir: "public"
        publishKey: "public"

    config = _.assign opts, userConfig

    (files, metalsmith, done) ->
        Object.keys(files).forEach (file) ->
            fileObj = files[file]

            if file.indexOf(config.draftDir) isnt 0 or not fileObj.hasOwnProperty(config.publishKey)
                return

            if fileObj[config.publishKey] is true
                originalPath = fileObj.history[0]
                newFile = file.replace config.draftDir, config.publicDir
                if newFile.charAt(0) is "."
                    newFile = newFile.slice 2
                srcPath = originalPath
                destPath = originalPath.replace config.draftDir, config.publicDir
                files[newFile] = _.assign {}, files[file]
                files[newFile].history = [destPath]
                fs.move srcPath, destPath, (err) ->
                    if err
                        console.error err

            delete files[file]

        do done

module.exports = publish
