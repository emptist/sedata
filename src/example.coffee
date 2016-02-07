{ticks,tsdata} = require '../sedata'

tsdata {func: 'get_hist_data',args: "'300388',ktype='W'"}, (pys,res)->
  console.log(res)

tsdata {func: 'get_hist_data',args: "'159915',ktype='M'"}, (pys,res)->
  console.log(res)

tsdata {func: 'get_h_data',args: "'300388'"}, (pys,res)->
  console.log(res)
  # use this to end conversation
  pys.done()


codes = "900901,000002sz,600603sh,200429,159915"
ticks codes, (obj)->
  {買,名稱,賣5} = obj.sz159915
  console.log('here:',買,名稱,賣5)
