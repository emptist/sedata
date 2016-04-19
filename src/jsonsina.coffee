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
  if param.symbol.length < 5
    return callback '代碼不對',null

  scale =
    m05: 5
    m15: 15
    m30: 30
    m60: 60
    day: 60*4
    week: 60*4*5
    #month: 60*4*20 # 似乎沒有月線

  host = "http://money.finance.sina.com.cn/quotes_service/api/json_v2.php"
  c = recode param.symbol, 1
  t = scale[param.type]
  l = param.len ? 0
  url = "#{host}/CN_MarketData.getKLineData?symbol=#{c}&scale=#{t}&datalen=#{l}"
  options =
    url: url
    json: false

  request.get options, (err, res, string)->
    if err?
      callback error, null

    else

      arr = null
      try
        arr = eval string
      catch error
        callback error, null

      for each in arr?
        each.day = new Date each.day
        each.open = Number each.open
        each.low = Number each.low
        each.high = Number each.high
        each.close = Number each.close
        each.volume = Number each.volume
        #console.log each

      callback err, arr



module.exports = history

### 在這行前面加或去一個#就可以測試,測試完記得加回去
history {symbol:'150152',type:'week'},(err, arr)->
  console.log arr
###
