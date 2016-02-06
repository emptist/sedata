###
 Copyright(c) 2016- Jigme Ko <jigme1968@gmail.com>
 MIT Licensed
###

{restring,recode} = require 'secode'
request = require 'request'
iconv = require 'iconv-lite'

hqstr2obj = (code,tickstr,obj)->
  c = recode(code,0)
  #tickstr = eval("hq_str_#{code}")
  tick = "#{c},#{tickstr}".split(',')
  # 共有34項,最後一項不知何用
  obj[code] =
    code:tick[0]
    name:tick[1]
    open: Number(tick[2])
    close: Number(tick[3])
    latest: Number(tick[4])
    high: Number(tick[5])
    low: Number(tick[6])
    bid: Number(tick[7]) # 買入報價
    ask: Number(tick[8]) # 賣出要價
    volume: Number(tick[9])
    amount: Number(tick[10])
    bid1v: Number(tick[11])
    bid1: Number(tick[12])
    bid2v: Number(tick[13])
    bid2: Number(tick[14])
    bid3v: Number(tick[15])
    bid3: Number(tick[16])
    bid4v: Number(tick[17])
    bid4: Number(tick[18])
    bid5v: Number(tick[19])
    bid5: Number(tick[20])
    ask1v: Number(tick[21])
    ask1: Number(tick[22])
    ask2v: Number(tick[23])
    ask2: Number(tick[24])
    ask3v: Number(tick[25])
    ask3: Number(tick[26])
    ask4v: Number(tick[27])
    ask4: Number(tick[28])
    ask5v: Number(tick[29])
    ask5: Number(tick[30])
  obj[code].time = new Date tick[31..32].join(' ')# (tick[32..33].join(' '))
  obj[code].ref = tick[33]
  obj[code].market = code[..1]
  return obj

sinaticks = (string, callback)->

  # reformat the codes in string argument

  codes = restring(string, 'sina')
  obj = {}
  options =
    url:"http://hq.sinajs.cn/list=#{codes}"
    json: false
    encoding:null

  request options, (err, res, data)->
    text=iconv.decode(data, 'GBK')

    # TODO: 替換掉 eval
    eval(text)
    for code in codes.split(',')
      tickstr = eval("hq_str_#{code}")
      hqstr2obj(code,tickstr,obj)

    callback obj

module.exports =
  ticks: sinaticks
