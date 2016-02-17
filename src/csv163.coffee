request = require 'request'
iconv = require 'iconv-lite'
{recode,restring} = require 'secode'

{csv2json} = require './csvjson'

quotes = (param, callback) ->
  host = 'http://quotes.money.163.com/service/chddata.html?code='
  # 日期，代碼，名稱，收盤，最高，最低，開盤，前收，漲跌，幅度，換手率，成交量，成交金額，總市值，流通市值
  fields = 'TOPEN;HIGH;LOW;TCLOSE;LCLOSE;CHG;PCHG;TURNOVER;VOTURNOVER;VATURNOVER;TCAP;MCAP'
  headers = 'DATE;CODE;NAME;' + fields
  id = (param.ids.split ',')[0]
  url = host + "#{id}&start=#{param.start}&end=#{param.end}&fields=#{fields}"
  options =
    url: url
    json: false
    encoding:null

  request.get options, (err, res, data)->
    unless err?
      text = iconv.decode(data, 'GBK')
      cnt = text #res.content#.toString 'utf8'
      csvlines = cnt.split "\n"
      csvrows = (csvlines.slice 1, csvlines.length).reverse()
      rows =  []
      for r in csvrows
        unless r.length is 0
          row = r.split ','
          date = [(new Date row[0]).getTime()]
          res = row.map(Number)
          unless (res[3] is 0) or (res[4] is 0) or (res[5] is 0) or res[6] is 0
            rows.push date.concat res[3..6], res[11..11]
      #console.log cnt
      callback csv2json (cnt), {delim: ',', textdelim:'\r', headers: headers.split(';')} #cnt #rows #url 


module.exports = quotes
###json版:
'http://img1.money.126.net/data/hs/kline/day/history/2016/1159915.json?callback=ne3fee324' -H 'DNT: 1'
http://api.money.126.net/data/feed/1159915?callback=ne238022ffc
http://img1.money.126.net/data/hs/kline/week/times/1159915.json?callback=ne2ddf44564
http://img1.money.126.net/data/hs/kline/week/history/2014/1159915.json?callback=neb4dd2a3
http://img1.money.126.net/data/hs/kline/week/history/2015/1159915.json?callback=ne2a87574d4
http://img1.money.126.net/data/hs/kline/week/history/2016/1159915.json?callback=ne4b98d328
###
