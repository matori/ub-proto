"use strict"

util = require "util"

module.exports = ->
    ->
        console.log util.inspect arguments[0], false, 1, true
