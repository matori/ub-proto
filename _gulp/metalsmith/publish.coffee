"use strict"

fs = require "fs-extra"
path = require "path"
_ = require "lodash"

publish = (draftDir, publishKey) ->
    (files, metalsmith, done) ->
        Object.keys(files).forEach (file) ->

            fileObj = files[file]

            if file.indexOf(draftDir) isnt 0 or not fileObj.hasOwnProperty(publishKey)
                return

            if fileObj[publishKey] is false
                delete files[file]
            else
                newFile = file.replace "_draft/", ""
                srcPath = path.resolve "contents", file
                destPath = path.resolve "contents", newFile
                files[newFile] = _.assign {}, files[file]
                delete files[file]
                fs.move srcPath, destPath, (err) ->
                    if err
                        console.error err

        do done

module.exports = publish
