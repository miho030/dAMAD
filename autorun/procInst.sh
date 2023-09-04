#!/bin/bash

:<<"END"
* Author  : github.com/miho030
* version : 0.0.0.1
* purpose : 1) 
            2) 
            3) 
END

# log variables
curPwd=$(pwd)
logDir="$curPwd/log/debugLog/"
logFileName="[$(date +%Y-%m-%d)]_AMA-reportEngine.log"
logFileDir="$logDir$logFileName"

nohup cuckoo -d process instance1 > "$logFileDir" 2>&1 &
