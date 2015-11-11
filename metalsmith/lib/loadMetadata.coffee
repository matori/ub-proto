"use strict"

fs = require "fs"
path = require "path"
yaml = require "js-yaml"
_ = require "lodash"

loadData = (dir, srcPath, filePath) ->
    absPath = path.resolve dir, srcPath, filePath
    file = fs.readFileSync absPath, "utf-8"
    yaml.safeLoad file

getMetadata = (dir, srcPath, filePaths) ->
    pkgPath = path.resolve dir, "package.json"
    metadata =
        pkg: require pkgPath
    for filePath in filePaths
        data = loadData dir, srcPath, filePath
        metadata = _.assign metadata, data
    metadata

module.exports = getMetadata
