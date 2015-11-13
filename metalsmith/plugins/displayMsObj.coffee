"use strict"

util = require "util"

module.exports = ->
    ->
        console.log util.inspect arguments, false, null, true
