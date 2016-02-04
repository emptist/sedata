###
sedata - sedata.js
 Copyright(c) 2016 Jigme Ko <jigme1968@gmail.com>
 MIT Licensed
###
###
Usage

in coffeescript:
  {ticks} = require 'sedata'
  codes = "900901,000002sz,600603sh,200429,159915"
  ticks codes, (obj)->
    {sh900901,sz159915,sh600603} = obj
    console.log('here:',sh600603.market,sz159915.ask5)

###

{restring,recode} = require 'secode'
request = require 'request'
iconv = require 'iconv-lite'
# or we can use encoding module
# encoding = require 'encoding'

sinaticks = (string, callback)->

  # reformat the codes in string argument

  codes = restring(string, 'sina')
  obj = {}
  options =
    url:"http://hq.sinajs.cn/list=#{codes}"
    json: false
    encoding:null

  request options, (err, res, data)->
    #text=(encoding.convert data, 'utf8', 'GBK').toString()
    text=iconv.decode(data, 'GBK')

    # TODO: 替換掉 eval
    eval(text)

    hqstr2obj = (code)->
      c = recode(code,0)
      tickstr = eval("hq_str_#{code}")
      tick = "#{c},#{tickstr}".split(',')
      # 共有34項,最後一項不知何用
      obj[code] =
        code:tick[0]
        name:tick[1]
        open: Number(tick[2])
        close: Number(tick[3])
        now: Number(tick[4])
        high: Number(tick[5])
        low: Number(tick[6])
        buy: Number(tick[7])
        sell: Number(tick[8])
        turnover: Number(tick[9])
        volume: Number(tick[10])
        bid1_volume: Number(tick[11])
        bid1: Number(tick[12])
        bid2_volume: Number(tick[13])
        bid2: Number(tick[14])
        bid3_volume: Number(tick[15])
        bid3: Number(tick[16])
        bid4_volume: Number(tick[17])
        bid4: Number(tick[18])
        bid5_volume: Number(tick[19])
        bid5: Number(tick[20])
        ask1_volume: Number(tick[21])
        ask1: Number(tick[22])
        ask2_volume: Number(tick[23])
        ask2: Number(tick[24])
        ask3_volume: Number(tick[25])
        ask3: Number(tick[26])
        ask4_volume: Number(tick[27])
        ask4: Number(tick[28])
        ask5_volume: Number(tick[29])
        ask5: Number(tick[30])
      obj[code].time = new Date tick[31..32].join(' ')# (tick[32..33].join(' '))
      obj[code].ref = tick[33]
      obj[code].market = code[..1]

    for code in codes.split(',')
      hqstr2obj(code)
    callback obj

module.exports =
  ticks: sinaticks
