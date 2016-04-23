sedata
=======

[![NPM version][npm-image]][npm-url]
[![npm download][download-image]][download-url]

[npm-image]: https://img.shields.io/npm/v/sedata.svg?style=flat-square
[npm-url]: https://npmjs.org/package/sedata
[download-image]: https://img.shields.io/npm/dm/sedata.svg?style=flat-square
[download-url]: https://npmjs.org/package/sedata

For China market only for now.


## Install

```bash
$ npm install sedata
```

## Usage

ticks 從網上取得實時數據,速度取決於網絡狀況和數據源服務器.

去掉了js轉譯.

```coffeescript
{forex, ticks,hists,histd,histdwm} = require 'sedata'

# from sina:

symbols = "900901,000002sz,600603sh,200429,159915"

#實時
ticks symbols, (obj)->
  {買,名稱,賣5} = obj.sz159915
  console.log('here:',買,名稱,賣5)

# 5,15,30,60,day,week
hists {symbol:'900951',type:'week'},(err,json)->
  console.log json

# forex
forex 'usdcnh', (data)->
  console.log data

# from 163.com:

# daily
date = new Date()
end = date.year * 1000 + date.hour * 100 + date.day
histd {symbol: '000001', start:20080801, end:end}, (data)->
  console.log data

# daily, week, month, 分年度取
histdwm {market:'hs',symbol:'159915',year:'2016',type:'week'}, (err,json)->
  console.log json unless err?

```

See also example

## Data Sources
新浪數據值得研究 重點在chrome中看network/XHR
http://vip.stock.finance.sina.com.cn/mkt/#stock_hs_amount
http://vip.stock.finance.sina.com.cn/quotes_service/api/json_v2.php/Market_Center.getHQNodes

https://github.com/HarrisonXi/AStock/blob/master/%E5%8E%86%E5%8F%B2%E6%95%B0%E6%8D%AEAPI.md

http://blog.sina.com.cn/s/blog_7ed3ed3d0101gphj.html
http://www.wstock.net/wstock/5min.htm

## todos
Redo request when request for data failed after hitting a time out.
Well, npm has some packages for this:
https://github.com/geoffreak/request-enhanced
https://github.com/FGRibreau/node-request-retry
https://www.npmjs.com/package/retry-request
https://www.npmjs.com/package/then-request


## License

[MIT](LICENSE.txt)
