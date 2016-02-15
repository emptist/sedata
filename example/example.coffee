{ticks,histd} = require 'sedata'

codes = "900901,000002sz,600603sh,200429,159915"
ticks codes, (obj)->
  {買,名稱,賣5} = obj.sz159915
  console.log('here:',買,名稱,賣5)

### usage:
###

stock = '1000001'#(t.find '.stocks').value
source = '163.com' # history

#Session.set 'id', stock
date = new Date()
end = date.year * 1000 + date.hour * 100 + date.day
histd {ids: stock, start:20080801, end:end}, (data)->
  console.log data
  # dealing with the data here, for this case it's for a single stock
  #Session.set 'history', GetData.rows
  #renderChart()
