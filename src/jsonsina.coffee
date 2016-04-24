# https://github.com/HarrisonXi/AStock/blob/master/%E5%8E%86%E5%8F%B2%E6%95%B0%E6%8D%AEAPI.md
#https://www.npmjs.com/package/requestretry

{recode,restring} = require 'secode'
request = require 'requestretry'
myRetryStrategy = require './myretry'


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
  #host = "http://vip.stock.finance.sina.com.cn/quotes_service/api/json_v2.php"
  c = recode param.symbol, 1
  t = scale[param.type]
  l = param.len ? 0
  url = "#{host}/CN_MarketData.getKLineData?symbol=#{c}&scale=#{t}&datalen=#{l}"


  options =
    url: url
    json: false
    forever:true
    timeout: 7000
    maxAttempts: 9  #// (default) try 5 times
    retryDelay: 1000  #// (default) wait for 5s before trying again
    retryStrategy: myRetryStrategy

  request options, (error, res, string)->

    retry = (err)->
      console.error "#{c} jsonsina.coffee >> history 將重試: ", err
      history(param, callback)

    if error?
      return retry(error)
    else
      arr = null
      try
        arr = eval string
      catch error
        return retry(error)

      if arr?.length > 0 # 必須這樣寫,不能簡化為: for each in arr?
        for each in arr
          each.day = new Date each.day
          each.open = Number each.open
          each.low = Number each.low
          each.high = Number each.high
          each.close = Number each.close
          each.volume = Number each.volume
          #console.log each
      else
        return retry('數據長度為 0')
        
      if res?.attempts > 1
        console.log(param.symbol,'數據請求次數: ', res.attempts)

      callback null, arr



module.exports = history

#在下行前面加或去一個#就可以測試,測試完記得加回去
###
history {symbol:'900915',type:'day'},(err, arr)->
  console.log err, arr?[arr.length-1]
###
