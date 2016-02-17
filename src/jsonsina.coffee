# https://github.com/HarrisonXi/AStock/blob/master/%E5%8E%86%E5%8F%B2%E6%95%B0%E6%8D%AEAPI.md
request = require 'request'
{recode,restring} = require 'secode'

### param:
      market: 默認 hs--滬深
      symbol: 代碼
      year: 年份
      type: day,week,month
###
history = (param, callback)->
  scale =
    m05: 5
    m15: 15
    m30: 30
    m60: 60
    day: 60*4
    week: 60*4*5
    #month: 60*4*20 # 似乎沒有月線

  c = recode param.symbol, 1
  host = "http://money.finance.sina.com.cn/quotes_service/api/json_v2.php"
  url = "#{host}/CN_MarketData.getKLineData?symbol=#{c}&scale=#{scale[param.type]}&datalen=#{param.len}"
  options =
    url: url
    json: true
    #encoding:null

  request.get options, (err, res, data)->
    unless err?
      #text = iconv.decode(data, 'GBK')
      callback err,data

module.exports = history
