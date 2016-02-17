var sinaticks = require("./lib/ticks");
var sinahists = require("./lib/jsonsina")
var histd = require("./lib/csv163");
var hist = require("./lib/json126")
module.exports = {
  ticks: sinaticks,
  hists: sinahists,
  histd: histd,
  histdwm: hist
};
