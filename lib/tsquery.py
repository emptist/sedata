#-*- coding:UTF-8 -*-

import json
import tushare as ts

def query(line):
    message = json.loads(line)

    data = json.dumps(message)
    if message.get('func'):
        funcname = message['func']
        if message.get('args'):
            args = message['args']
            func = "ts.{funcname}( {args} )".format(funcname=funcname,args=args)
            data = (eval(func)).to_json()
        else:
            data = ts.__getattribute__(funcname).to_json()
        return data
    else:
        raise NameError(data)
