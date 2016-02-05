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

tsdata 是用於執行Python程序的,取得數據之後,就會退出Python,再次工作時再啟動Python,因此不是
連續交換信息的工具.適合用於下載歷史數據等不需要即時處理的任務.
tsock 通過socket與Python服務器保持聯絡,可以隨時申請取得數據.(尚未完成)
ticks 從網上取得實時數據,速度取決於網絡狀況和數據源服務器.

```coffeescript
{ticks,tsdata} = require 'sedata'

tsdata {func:'get_hist_data', args:"'300388',ktype='W'"}, (res)->
  console.log res

codes = "900901,000002sz,600603sh,200429,159915"
ticks codes, (obj)->
  {buy,name,ask5} = obj.sz159915
  console.log('here:',buy,name,ask5)
```

See also example.js

## License

[MIT](LICENSE.txt)
