/*
sedata - sedata.js
 Copyright(c) 2016 Jigme Ko <jigme1968@gmail.com>
 MIT Licensed
 */
var sinadata,tsdata;
sinadata = require('./lib/sinadata');
tsdata = require('./lib/tsdata');
module.exports = {
  ticks: sinadata.ticks,
  tsdata: tsdata
};