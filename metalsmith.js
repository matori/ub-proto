"use strict";

require("coffee-script/register");

var metalsmith = require("./metalsmith/build");
metalsmith(__dirname);
