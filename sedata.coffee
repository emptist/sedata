sinaticks = require("./src/ticks")
sinaforex = require("./src/forex")
sinahists = require("./src/jsonsina")
histd = require("./src/csv163")
hist = require("./src/json126")
module.exports =
  forex: sinaforex
  ticks: sinaticks
  hists: sinahists
  histd: histd
  histdwm: hist
