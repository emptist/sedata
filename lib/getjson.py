import sys
import io
import tushare as ts
import json

# http://stackoverflow.com/questions/16549332/python-3-how-to-specify-stdin-encoding
# input_stream = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8')
for line in sys.stdin:
    message = json.loads(line)
    func = message['func']
    # TODO: handle args
    args = message['args'][0]

    if func:
        data = ts.__getattribute__(func)(args).to_json()
        print(data)
    else:
        print(json.dumps(message))
