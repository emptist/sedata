#-*- coding:UTF-8 -*-
'''
https://github.com/extrabacon/python-shell/issues/18
http://stackoverflow.com/questions/18849112/stream-child-process-output-in-flowing-mode
'''
import sys,json
import tsquery as ts

line=' '
while line:
    try:
        line = sys.stdin.readline()

        try:
            # 結束時,由於line不是正常的資料,會發生錯誤,似乎不需要處理
            message = json.loads(line)
        except Exception as e:
            pass #print(line)

        if message.get('func'):
            print(ts.query(message))

        ''' 可增加券商接口模塊,仿照tsquery.py,將 SmallSocket...py 搬過來
        elif message.get('command'):

            print()
        '''

        # 用python -u 來執行,故不需要手工flush()
        # sys.stdout.flush()
    except Exception as e:
        raise e
