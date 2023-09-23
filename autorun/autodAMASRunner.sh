#!/bin/bash

:<<"END"
* Author  : github.com/miho030
* version : 0.3.7.1
* purpose : 1) Setup VBoxManagers host only net adapter
	    2) Run cuckoo service
	    3) create log directory and write all logs
END

# log variables
cd ..
dAMADRoot=$(pwd)
cd ./autorun
logDir="$daMADRoot/log/debugLog/"
logFileName="[$(date +%Y-%m-%d)]_dAMAS-debug.log"
logFileDir="$logDir$logFileName"

cuckooRooter="$dAMADRoot/autorun/cuckooRooter.sh"


echo ""
echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Initiate dAMAS autorun engine protocol."
echo ""
echo " * * * "
echo ""
echo "#=================================================#"
echo "#             - dAMAS.AutodAMASRunner -            #"
echo "#  ---------------------------------------------  #"
echo "#    - github.com/miho030    - version: v0.3.7.1  #"
echo "#=================================================#"
echo ""
echo ""
echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Initiate hostonly.VBoxManager."
VBoxManage hostonlyif ipconfig vboxnet0 --ip 192.168.56.1 --netmask 255.255.255.0
echo ""

echo "-----------------------------------------------------------------------"
if [ ! -e "$logDir" ]; then
	echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Creating new debug log directory.."
	mkdir "$logDir"
	if [ $(echo $?) == 0 ]; then
		echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Success to create debug log directory"
	else
		echo ""
		echo "[`date +%Y-%m-%d` `date +%T`]  [ERROR] Failed to create debug log directory"
		echo "   -> check the log directory permission, ~/dAMAS/log/"
		echo "   -> 'autoAMARunner exit by mkdir issue with permission error" || exit 1
		echo ""
	fi
else
	echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] debug log directory checked."
	
	if [ ! -e "$logFileDir" ]; then
		echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Creating daily debug log file.."
		touch "$logFileDir"
	else
		echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] daily debug lof file checked."
	fi
fi

echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Initiate cuckoo.rooter & debug mode."

echo ""
echo " -> execute cuckoo.rooter service...wait.."
nohup $cuckooRooter >> "$curPwd/log/rooter.log" &
sleep 10

check=`ps -ef | grep 'rooter' | wc | awk '{print $1}'`
if [ $check -gt 1 ]; then
	echo "[STATUS] cuckoo.rooter is running."
	nohup cuckoo -d > "$logFileDir" 2>&1 &
else
	nohup $cuckooRooter >> "$curPwd/log/rooter.log" &
	sleep 5
	if [ "$check" -gt 1 ]; then
		nohup cuckoo -d > "$logFileDir" 2>&1 &
	else
		echo "[`date +%Y-%m-%d` `date +%T`]  [ERROR] Failed to initiate cuckoo.rooter." | exit 1
	fi
fi
nohup cuckoo -d > "$logFileDir" 2>&1 &


echo ""
echo "[`date +%Y-%m-%d` `date +%T`]  ===> dAMAS.autoAMARunner process done."
echo "-----------------------------------------------------------------------"
echo ""
echo ""
