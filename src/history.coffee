request = require 'request'
iconv = require 'iconv-lite'
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
      callback cnt #rows #url #csv2json (cnt), {delim: ',', textdelim:'\r', headers: headers.split(';')}


### usage:
###

stock = '1000001'#(t.find '.stocks').value
source = '163.com' # history

#Session.set 'id', stock
date = new Date()
end = date.year * 1000 + date.hour * 100 + date.day
quotes {ids: stock, start:20080801, end:end}, (data)->
  console.log data
  # dealing with the data here, for this case it's for a single stock
  #Session.set 'history', GetData.rows
  #renderChart()

module.exports = quotes
