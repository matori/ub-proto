"use strict"

fs = require "fs-extra"
path = require "path"
_ = require "lodash"

isDraft = (file, fileObj, opts) ->
    isDraftDir = file.slice(0, opts.draftDir.length) is opts.draftDir
    hasPublishKey = fileObj.hasOwnProperty opts.publishKey
    isDraftDir and hasPublishKey

createPaths = (file, dir,  opts) ->
    newKey = opts.publicDir + file.slice opts.draftDir.length
    originalPath = path.resolve dir.source, file
    newPath = path.resolve dir.source, newKey

    # return
    original: originalPath
    key: newKey
    path: newPath


moveFile = (files, file, fileObj, dir, opts) ->

    paths = createPaths file, dir, opts

    files[paths.key] = _.assign {}, fileObj

    fs.move paths.original, paths.path, (err) ->
        if err then throw err

    files

plugin = (userSettings) ->
    opts =
        draftDir: "draft"
        publicDir: "public"
        publishKey: "public"

    opts = _.assign opts, userSettings

    (files, metalsmith, done) ->
        dir =
            root: path.resolve metalsmith._directory
            source: path.resolve metalsmith._source

        _.forEach files, (fileObj, file) ->
            unless isDraft file, fileObj, opts
                return

            if fileObj[opts.publishKey] is true
                files = moveFile files, file, fileObj, dir, opts

            delete files[file]

        do done

module.exports = plugin
