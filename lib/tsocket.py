#-*- coding:UTF-8 -*-

import socket
import tsquery as ts
from _thread import *

class SocketJSON(object):
    '''
    任意host,端口為5574,循環傾聽,接受到的訊息,執行func
    '''
    def __init__(self, host='',port=5574):
        self.host = host
        self.port = port
        self.sckt = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    def wait(self):
        try:
            self.sckt.bind((self.host, self.port))
        except socket.error as e:
            print('SocketJSON: socket.error')
            print(str(e))

        self.sckt.listen(5)
        print('Waiting for a connection.')


    def threaded_client(self, conn):
        while True:
            data = conn.recv(4096)
            if not data:
                break

            # process the command:
            command = data.decode('utf-8')
            try:
                # query tushare for data and sendback
                conn.sendall(str.encode(ts.query(command)))

            except Exception as e:
                print(str(e))
                #self.sckt.close()

        conn.close()


    def started(self):
        self.wait()

        while True:
            conn, addr = self.sckt.accept()
            print('connected to: '+addr[0]+':'+str(addr[1]))

            start_new_thread(self.threaded_client,(conn,)) # (conn, ) this is not a bug

def tsocket():
    SocketJSON(port=5574).started()

if __name__ == '__main__':
    tsocket()
