"use strict"

moment = require "moment"

getDateTime = (customFormat, localeStr, dateStr) ->
    dateTime = moment dateStr
    result =
        rfc822: dateTime.format "ddd, DD MMM YYYY HH:mm:ss ZZ"
        iso8601: do dateTime.format
    dateTime.locale localeStr
    result.text = dateTime.format customFormat
    result

module.exports = getDateTime
