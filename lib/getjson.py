#-*- coding:UTF-8 -*-

import sys
import tsquery as ts

for line in sys.stdin:
    try:
        data = ts.query(line)
        print(data)
    except Exception as e:
        raise e
