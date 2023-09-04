#!/bin/bash

# log variables
curPwd=$(pwd)
logDir="$curPwd/log/webLog/"
logFileName="[$(date +%Y-%m-%d)]_dAMAS-web.log"
logFileDir="$logDir$logFileName"


echo ""
echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Initiate dAMAS main engine protocol."
echo ""
echo " * * * "
echo ""
echo "#=================================================#"
echo "#             - dAMAS.AutoWebRunner -             #"
echo "#  ---------------------------------------------  #"
echo "#    - github.com/miho030    - version: v0.0.1.2  #"
echo "#=================================================#"
echo ""
echo "-----------------------------------------------------------------------"
if [ ! -e "$logDir" ]; then
	echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Creating new web log directory.."
        mkdir "$logDir"
        if [ $(echo $?) == 0 ]; then
                echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Success to create web log directory"
        else
                echo "[`date +%Y-%m-%d` `date +%T`]  [ERROR] Failed to create web log directory."
                echo "   -> check the log directory permission, ~/dAMAS/log/"
                echo "   -> 'autoWebRunner exit by mkdir issue with permission error"
                exit 1
        fi
else
	echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Web log directory checked."
	
	if [ ! -e "$logFileDir" ]; then
		echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Creating daily web log file.."
		touch "$logFileDir"

	else
		echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Complete checked web log file ==> $logFileName"
	fi					
fi

echo "-----------------------------------------------------------------------"
check=`ps -ef | grep 'runserver' | wc | awk '{print $1}'`
if [ ! $check -gt 1 ]; then
	echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Iinitate cuckoo Web Server"
        nohup cuckoo web runserver 0.0.0.0:25741 > "$logFileDir" 2>&1 &	
else
	echo "[INFO] Web interface is already running!"
	exit 0
fi 


echo ""
echo "[`date +%Y-%m-%d` `date +%T`]  ===> dAMAS.autoWebRunner process done."
echo "-----------------------------------------------------------------------"
echo ""
echo ""





