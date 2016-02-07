net = require 'net'
###
  ** Use tsdata instead! **

  先須手工運行 tsocket.py
  然後可照以下方法做
###
client = new net.Socket()

port = 5574
host = '127.0.0.1'

client.on 'data', (data)->
  jso = JSON.parse data.toString()
  console.log jso
  # 需要停止時:
  # client.destroy()

  ### 可以用此方法令 Python程序檢測到錯誤或約定指令而退出
    在地下運行的狀況下,這方法有必要.
    Python一端也可以只當做一個錯誤

  client.write JSON.stringify {fun:'end'}
  ###

client.on 'close', ->
  console.log 'socket closed'

client.connect port, host, (err, data)->
  #return client.destroy() if err
  console.log 'connected' unless err

client.write JSON.stringify {func:'get_hist_data',args:"'300388',ktype='M'"}


#module.exports = tsocket




### Python代碼備考
''' 數據不完整問題解決(須在client一側完成):
    http://www.binarytides.com/receive-full-data-with-the-recv-socket-function-in-python/
'''
def recv_timeout(the_socket,timeout=2):
    #make socket non blocking
    the_socket.setblocking(0)

    #total data partwise in an array
    total_data=[];
    data='';

    #beginning time
    begin=time.time()
    while 1:
        #if you got some data, then break after timeout
        if total_data and time.time()-begin > timeout:
            break

        #if you got no data at all, wait a little longer, twice the timeout
        elif time.time()-begin > timeout*2:
            break

        #recv something
        try:
            data = the_socket.recv(8192)
            if data:
                total_data.append(data)
                #change the beginning time for measurement
                begin = time.time()
            else:
                #sleep for sometime to indicate a gap
                time.sleep(0.1)
        except:
            pass

    #join all parts to make final string
    return ''.join(total_data)
###
