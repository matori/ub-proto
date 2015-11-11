"use strict"

fs = require "fs"
path = require "path"
{extname} = path
{basename} = path
yaml = require "js-yaml"
_ = require "lodash"

loadData = (dir, srcPath, filePath) ->
    absPath = path.resolve dir, srcPath, filePath
    file = fs.readFileSync absPath, "utf-8"
    yaml.safeLoad file

createAssignData = (dir, srcPath, filePath) ->
    ext = extname filePath
    keyName = basename filePath, ext
    data = {}
    data[keyName] = loadData dir, srcPath, filePath
    data

getMetadata = (dir, srcPath, filePaths) ->
    pkgPath = path.resolve dir, "package.json"
    metadata =
        pkg: require pkgPath
    for filePath in filePaths
        data = createAssignData dir, srcPath, filePath
        metadata = _.assign metadata, data
    metadata

module.exports = getMetadata
