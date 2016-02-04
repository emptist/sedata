sedata
=======

[![NPM version][npm-image]][npm-url]
[![npm download][download-image]][download-url]

[npm-image]: https://img.shields.io/npm/v/sedata.svg?style=flat-square
[npm-url]: https://npmjs.org/package/sedata
[download-image]: https://img.shields.io/npm/dm/sedata.svg?style=flat-square
[download-url]: https://npmjs.org/package/sedata

Manipulating security codes, for China market only for now.


## Install

```bash
$ npm install sedata
```

## Usage


```js
var sedata = require('sedata');

sedata.ticks('159915,600663',function(object){
  console.log(object.sz159915.ask1)
});
```

also see comments in source code

## License

[MIT](LICENSE.txt)
