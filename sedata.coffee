sinaticks = require("./src/ticks")
sinaforex = require("./src/forex")
sinahists = require("./src/jsonsina")
histd = require("./src/csv163")
hist = require("./src/json126")
qsa = require("./src/htsc")
qsort = require("./src/sortsina")
JisiluData = require('./src/jisilu')

module.exports =
  forex: sinaforex
  ticks: sinaticks
  hists: sinahists
  histd: histd
  histdwm: hist
  qsa: qsa
  qsort: qsort
  JisiluData:JisiluData
