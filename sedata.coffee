sinaticks = require("./src/ticks")
sinaforex = require("./src/forex")
{yahooforex, convertyahoo} = require("./src/yahooforex")
sinahists = require("./src/jsonsina")
histd = require("./src/csv163")
hist = require("./src/json126")
qsa = require("./src/htsc")
qsort = require("./src/sortsina")
JisiluData = require('./src/jisilu')

module.exports =
  forext: sinaforex
  yahooforex: yahooforex
  convertyahoo:convertyahoo
  ticks: sinaticks
  hists: sinahists
  histd: histd
  histdwm: hist
  qsa: qsa
  qsort: qsort
  JisiluData:JisiluData
