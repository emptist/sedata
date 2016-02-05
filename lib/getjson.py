#-*- coding:UTF-8 -*-

import sys
import tsquery as ts

for line in sys.stdin:
    data = ts.query(line)
    print(data)
