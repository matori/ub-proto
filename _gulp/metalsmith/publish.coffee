"use strict"

fs = require "fs-extra"
path = require "path"
_ = require "lodash"

getParentDir = (files, rootDir) ->
    fileRelPath = Object.keys(files)[0]
    fileAbsPath = files[fileRelPath].history[0]
    regex = new RegExp "^#{rootDir}|#{fileRelPath}$", "g"
    fileAbsPath.replace regex, ""

isDraft = (file, fileObj, config) ->
    file.indexOf(config.draftDir) is 0 and fileObj.hasOwnProperty config.publishKey

getNewPath = (originalPath, config) ->
    newPath = originalPath.replace config.draftDir, config.publicDir
    path.resolve newPath

createFileKey = (rootDir, parentDir, newPath)->
    parentPath = path.join rootDir, parentDir
    newPath.replace parentPath, ""

moveFile = (files, fileObj, dir, config) ->
    originalPath = path.resolve fileObj.history[0]
    newPath = getNewPath originalPath, config
    newFile = createFileKey dir.root, dir.parent, newPath

    fileObj.history = [newPath]
    files[newFile] = _.assign {}, fileObj
    console.log files[newFile]

    fs.move originalPath, newPath, (err) ->
        if err then console.error err

    files

publish = (userConfig) ->
    opts =
        draftDir: "draft"
        publicDir: "public"
        publishKey: "public"

    config = _.assign opts, userConfig

    (files, metalsmith, done) ->
        rootDir = do metalsmith.directory
        dir =
            root: rootDir
            parent: getParentDir files, rootDir

        _.forEach files, (fileObj, file) ->
            unless isDraft file, fileObj, config
                return

            if fileObj[config.publishKey] is true
                files = moveFile files, fileObj, dir, config

            delete files[file]

        do done

module.exports = publish
