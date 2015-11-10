"use strict"

module.exports =

    src: "src/_contents"
    ignore: ["resources", "**/.gitkeep"]
    clean: false
    build: "build"

    publishPlugin:
        draftDir: "draft"
        publicDir: "public"
        publishKey: "public"

    collectionsPlugin:
        article:
            pattern: "{public,draft}/articles/*.html"
            sortBy: "date"
            reverse: true
        document:
            pattern: "{public,draft}/documents/*.html"
            sortBy: "date"
            reverse: true

    tagsPlugin:
        handle: "category"
        path: "categories/:tag.html"
        layout: "category.jade"
        sortBy: "date"
        reverse: true
        skipMetadata: false

    layoutsPlugin:
        engine: "jade"
        directory: "src/templates"
        default: "test.jade"

    htmlMinifierPlugin:
        collapseBooleanAttributes: true
        collapseWhitespace: true
        removeAttributeQuotes: false
        removeComments: false
        removeEmptyAttributes: false
        removeRedundantAttributes: true
