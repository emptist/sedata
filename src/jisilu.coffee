request = require "requestretry"

class JisiluData
  constructor:()->

  # 分级A的接口
  funda_url: "http://www.jisilu.cn/data/sfnew/funda_list/?___t="

  # 分级B的接口
  fundb_url: "http://www.jisilu.cn/data/sfnew/fundb_list/?___t="

  # 母基接口
  fundm_url: "https://www.jisilu.cn/data/sfnew/fundm_list/?___t="

  # 分级套利的接口
  fundarb_url: "http://www.jisilu.cn/data/sfnew/arbitrage_vip_list/?___t="

  # 集思录登录接口
  jsl_login_url: "https://www.jisilu.cn/account/ajax/login_process/"

  # 集思录 ETF 接口
  etf_index_url: "https://www.jisilu.cn/jisiludata/etf.php?___t="
  # 黄金 ETF
  etf_gold_url: "https://www.jisilu.cn/jisiludata/etf.php?qtype=pmetf&___t="
  etf_money_url: "https://www.jisilu.cn/data/money_fund/list/?___t="

  now: -> (new Date()).getTime()

  get: (urlname, callback)->
    url = @["#{urlname}_url"]
    options =
      url: "#{url}#{@now()}"
      json: true

    request options, (err,res, body)->
      callback(err, body) # unless err?
      #jj = (each for each in body.rows when each.id is "150152")
      #console.log jj[0].cell

  getSymbols: (category, callback)->
    @get category, (err, body)->
      if err?
        callback err,null
        return
         
      cell = switch category
        when 'fundm' then "base_fund_id"
        else "#{category}_id"
      callback null, (each.cell[cell] for each in body.rows)


module.exports = JisiluData
###
(new JisiluData()).getSymbols 'fundb', (symbols)->
  console.log symbols
###
