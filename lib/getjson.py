import sys,json,io
# import io
import tushare as ts

# http://stackoverflow.com/questions/16549332/python-3-how-to-specify-stdin-encoding
# input_stream = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8')
for line in sys.stdin:
    message = json.loads(line)

    if message.get('func'):
        funcname = message['func']
        if message.get('args'):
            args = message['args']
            func = "ts.{funcname}( {args} )".format(funcname=funcname,args=args)
            data = (eval(func)).to_json()
        else:
            data = ts.__getattribute__(funcname).to_json()
        print(data)
    else:
        sys.stderr.write(json.dumps(message))
