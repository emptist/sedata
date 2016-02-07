{ticks,tsdata} = require '../sedata'

tsdata {func:'get_hist_data', args:"'300388',ktype='W'"}, (res)->
  console.log res

codes = "900901,000002sz,600603sh,200429,159915"
ticks codes, (obj)->
  {買,名稱,賣5} = obj.sz159915
  console.log('here:',買,名稱,賣5)
