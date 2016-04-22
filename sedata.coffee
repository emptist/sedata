sinaticks = require("./src/ticks")
sinaforex = require("./src/forex")
sinahists = require("./src/jsonsina")
histd = require("./src/csv163")
hist = require("./src/json126")
qsa = require("./src/htsc")

module.exports =
  forex: sinaforex
  ticks: sinaticks
  hists: sinahists
  histd: histd
  histdwm: hist
  qsa: qsa
