"use strict"

_ = require "lodash"
validator = require "validator"
match = require "multimatch"
url = require "url"

errorCheck = (opts) ->
    if _.isEmpty opts.hostname
        return "`hostname` option is required"

    if not _.isString opts.hostname
        return "`hostname` must be string"

    if not validator.isURL opts.hostname, {require_protocol: true}
        return "`hostname` must be valid url (required protocol)"

    return false

isMatch = (file, pattern) ->
    not _.isEmpty match file, pattern

formatUrl = (file, opts) ->
    permalink = url.resolve opts.hostname, file

    if opts.dropIndex
        permalink = permalink.replace /index\.html$/, ""

    permalink

plugin = (userSettings) ->
    defaultSettings =
        filter: "**/*.html"
        dropIndex: true
        hostname: null
        dest: "sitemap.xml"
        lastmodKey: "lastmod"
        changefreq: null
        priority: null
        data: {}

    if userSettings.data?.contents
        userSettings.data.contents = new Buffer userSettings.data.contents, "utf8"

    opts = _.assign defaultSettings, userSettings
    error = errorCheck opts

    if error
        throw new Error error

    sitemapData = _.assign {contents: new Buffer "", "utf8"}, opts.data

    (files, metalsmith, done) ->
        sitemapItems = []

        _.forEach files, (fileObj, file) ->
            unless isMatch file, opts.filter
                return

            itemObj = {
                permalink: formatUrl file, opts
                lastmod: _.get fileObj, opts.lastmodKey
                changefreq: fileObj.changefreq or opts.changefreq
                priority: fileObj.priority or opts.priority
            }

            sitemapItems.push itemObj

        files[opts.dest] = sitemapData
        metalsmith._metadata["sitemap"] = sitemapItems
        do done

module.exports = plugin
