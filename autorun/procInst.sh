#!/bin/bash

:<<"END"
* Author  : github.com/miho030
* version : 0.0.0.1
* purpose : 1) Create Internal Network for Malware behavior analysis engine
END

# log variables
cd ..
dAMADRoot=$(pwd)
logDir="$dAMADRoot/log/debugLog/"
logFileName="[$(date +%Y-%m-%d)]_dAMAD-reportEngine.log"
logFileDir="$logDir$logFileName"

echo "Initiate Malware Behavior Analysis engine's Internal Network adapter."
nohup cuckoo -d process instance1 > "$logFileDir" 2>&1 &
echo "[SUCCESS] Now Sandbox is in a IntraNET :)"
