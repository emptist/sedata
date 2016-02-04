{ticks,tsdata} = require 'sedata'

codes = "900901,000002sz,600603sh,200429,159915"
ticks codes, (obj)->
  {buy,name,ask5} = obj.sz159915
  console.log('here:',buy,name,ask5)

tsdata {func:'get_hist_data', args:['300388']}, (res)->
  console.log res
