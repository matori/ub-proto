"use strict"

module.exports =

    src: "src/_contents"
    ignore: ["resources", "**/.gitkeep"]
    clean: false
    build: "build"

    metadataFiles: [
        "../_data/site.yml"
    ]

    publishPlugin:
        draftDir: "draft"
        publicDir: "public"
        publishKey: "public"

    formatDatePlugin: [
        key: "date"
        newKey: "fmtDate"
        format: "YYYY-MM-DD"
        locale: undefined
    ,
        key: "modified"
        newKey: "fmtModified"
        format: "YYYY-MM-DD"
        locale: undefined
    ]

    lastBuildPlugin:
        format: "YYYY MM DD"
        locale: "ja"

    permalinksPlugin: [
        {matchFilter: "{public,draft}/articles/*.html", pattern: "articles/:slug"}
        {matchFilter: "{public,draft}/documents/*.html", pattern: "documents/:slug"}
        {matchFilter: "public/pages/*.html", pattern: ":slug"}
        {matchFilter: "public/pages/*/*.html", pattern: ":parent/:slug"}
        {matchFilter: "categories/**/*.html", pattern: ""}
    ]

    feedPlugin:
        destination: "feed/index.xml"
        data:
            layout: "feed.jade"

# hostname は metadata から取ってるくるので指定しないでください
    sitemapPlugin:
        filter: [
            "**/*.html"
            "!**/page/**/*.html"
            "!**/category/**/*.html"
        ]
        hostname: ""
        dest: "sitemap.xml"
        changefreq: null
        priority: null
        dropIndex: true
        lastmodKey: "fmtModified.iso8601"
        data:
            layout: "sitemap.jade"

    collectionsPlugin:
        articles:
            pattern: "{public,draft}/articles/*.html"
            sortBy: "date"
            reverse: true
        documents:
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
