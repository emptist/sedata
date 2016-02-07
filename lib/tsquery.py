#-*- coding:UTF-8 -*-

import json
import tushare as ts

def query(message):
    data = json.dumps(message)
    funcname = message['func']
    if message.get('args'):
        args = message['args']
        func = "ts.{funcname}( {args} )".format(funcname=funcname,args=args)
        data = (eval(func)).to_json()
    else:
        data = ts.__getattribute__(funcname).to_json()
    return data
