// Generated by CoffeeScript 1.10.0
var csv2json, iconv, quotes, request;

request = require('request');

iconv = require('iconv-lite');

csv2json = require('./csvjson').csv2json;

quotes = function(param, callback) {
  var fields, headers, host, id, options, url;
  host = 'http://quotes.money.163.com/service/chddata.html?code=';
  fields = 'TOPEN;HIGH;LOW;TCLOSE;LCLOSE;CHG;PCHG;TURNOVER;VOTURNOVER;VATURNOVER;TCAP;MCAP';
  headers = 'DATE;CODE;NAME;' + fields;
  id = (param.ids.split(','))[0];
  url = host + (id + "&start=" + param.start + "&end=" + param.end + "&fields=" + fields);
  options = {
    url: url,
    json: false,
    encoding: null
  };
  return request.get(options, function(err, res, data) {
    var cnt, csvlines, csvrows, date, i, len, r, row, rows, text;
    if (err == null) {
      text = iconv.decode(data, 'GBK');
      cnt = text;
      csvlines = cnt.split("\n");
      csvrows = (csvlines.slice(1, csvlines.length)).reverse();
      rows = [];
      for (i = 0, len = csvrows.length; i < len; i++) {
        r = csvrows[i];
        if (r.length !== 0) {
          row = r.split(',');
          date = [(new Date(row[0])).getTime()];
          res = row.map(Number);
          if (!((res[3] === 0) || (res[4] === 0) || (res[5] === 0) || res[6] === 0)) {
            rows.push(date.concat(res.slice(3, 7), res.slice(11, 12)));
          }
        }
      }
      return callback(cnt);
    }
  });
};

module.exports = quotes;

//# sourceMappingURL=history.js.map