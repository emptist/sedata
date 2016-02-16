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


```coffeescript
{ticks,histd,hist} = require 'sedata'

codes = "900901,000002sz,600603sh,200429,159915"
ticks codes, (obj)->
  {買,名稱,賣5} = obj.sz159915
  console.log('here:',買,名稱,賣5)

stock = '1000001'
date = new Date()
end = date.year * 1000 + date.hour * 100 + date.day
histd {ids: stock, start:20080801, end:end}, (data)->
  console.log data

hist {market:'hs',code:'159915',year:'2016',type:'week'}, (err,json)->
  console.log json unless err?

```

See also example

## License

[MIT](LICENSE.txt)
