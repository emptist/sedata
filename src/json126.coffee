request = require 'request'
{recode,restring} = require 'secode'


### param:
      market: 默認 hs--滬深
      code: 代碼
      year: 年份
      type: day,week,month
###
history = (param, callback)->
  c = recode param.code, 6
  url = "http://img1.money.126.net/data/#{param.market}/kline/#{param.type}/history/#{param.year}/#{c}.json"
  options =
    url: url
    json: true
    #encoding:null

  request.get options, (err, res, data)->
    unless err?
      #text = iconv.decode(data, 'GBK')
      callback err,data

###
history {market:'hs',code:'159915',year:'2016',type:'week'}, (err,json)->
  console.log json unless err?
###
module.exports = history
