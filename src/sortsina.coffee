# https://github.com/HarrisonXi/AStock/blob/master/%E5%8E%86%E5%8F%B2%E6%95%B0%E6%8D%AEAPI.md
request = require 'request'
iconv = require 'iconv-lite'

###
http://vip.stock.finance.sina.com.cn/quotes_service/api/json_v2.php/Market_Center.getHQNodeData?page=1&num=40&sort=amount&asc=0&node=hs_a&symbol=&_s_r_a=sort
http://vip.stock.finance.sina.com.cn/quotes_service/api/json_v2.php/Market_Center.getFundNetCount?page=1&num=5&sort=date&asc=0&node=open_fund

新浪行情數據的主要用語:
http://vip.stock.finance.sina.com.cn/quotes_service/api/json_v2.php/Market_Center.getHQNodes
param:
      market: 默認 hs--滬深
      symbol: 代碼
      year: 年份
      type: day,week,month
###
qsort = (param, callback)->


  host = "http://vip.stock.finance.sina.com.cn/quotes_service/api/json_v2.php"
  c = param.category ? 'sh_b'
  s = param.sort ? 'amount'
  l = param.len ? '40'
  url = "#{host}/Market_Center.getHQNodeData?page=1&num=#{l}&sort=#{s}&asc=0&node=#{c}&symbol=&_s_r_a=sort"
  options =
    url: url
    json: false
    encoding:null

  request.get options, (err, res, data)->
    if err?
      callback err, null

    else

      arr = null
      try
        arr = eval iconv.decode(data, 'GBK')
      catch error
        callback error, arr
        console.error 'sortsina.coffee >> qsort', error
        return

      callback err, arr



module.exports = qsort

### 在這行前面加或去一個#就可以測試,測試完記得加回去###
qsort {category:'sh_b'},(err, arr)->
  console.log arr
###
