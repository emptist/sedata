var sinaticks = require("./lib/ticks");
var sinaforex = require("./lib/forex");
var sinahists = require("./lib/jsonsina")
var histd = require("./lib/csv163");
var hist = require("./lib/json126")
module.exports = {
  forex: sinaforex,
  ticks: sinaticks,
  hists: sinahists,
  histd: histd,
  histdwm: hist
};
