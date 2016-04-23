###
 Copyright(c) 2016- Jigme Ko <jigme1968@gmail.com>
 MIT Licensed
###
# http://hq.sinajs.cn/rn=1457510432632list=fx_seurjpy,fx_sgbpjpy,fx_seurgbp,fx_seurchf,fx_shkdusd,fx_seuraud,fx_seurcad,fx_sgbpaud,fx_sgbpcad,fx_schfjpy,fx_sgbpchf,fx_scadjpy,fx_saudjpy,fx_seurnzd,fx_sgbpnzd
# http://hq.sinajs.cn/?_=0.04818517481908202&list=fx_susdcnh
# 改寫為外匯行情

request = require 'requestretry'
iconv = require 'iconv-lite'

hqstr2obj = (symbol,tickstr,obj)->
  c = symbol[4..] # usdcnh
  #tickstr = eval("hq_str_#{symbol}")
  tick = "#{c},#{tickstr}".split(',')
  # 共有34項,最後一項不知何用
  obj[symbol] =
    symbol:tick[0]
    現: Number(tick[2])
    未知: Number(tick[3])
    前: Number(tick[4])
    波幅: Number(tick[5])
    開: Number(tick[6])
    高: Number(tick[7]) # 賣入報價
    低: Number(tick[8]) # 賣出要價
    現: Number(tick[9])
    名稱: Number(tick[10])
    漲幅: Number(tick[11])
    未知: Number(tick[12])
    振幅: Number(tick[13])
    近高: Number(tick[15])
    近低: Number(tick[16])
  obj[symbol].時間 = new Date "#{tick[18]} #{tick[1]}"# (tick[32..33].join(' '))
  obj[symbol].備註 = tick[17]
  obj[symbol].報價 = tick[14]
  return obj

sinaticks = (string, callback)->

  # reformat the codes in string argument

  codes = ("fx_s#{each}" for each in string.split(',')).join(',')
  obj = {}
  options =
    url:"http://hq.sinajs.cn/list=#{codes}"
    json: false
    encoding:null

  request options, (err, res, data)->
    console.error  err if err
    unless err?
      text=iconv.decode(data, 'GBK')

      # TODO: 替換掉 eval
      eval(text)
      for symbol in codes.split(',')
        tickstr = eval("hq_str_#{symbol}")
        hqstr2obj(symbol,tickstr,obj)

      callback obj

module.exports = sinaticks
