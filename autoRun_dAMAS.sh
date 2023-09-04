#!/bin/bash

: << "END" 
* author  : github.com/miho030
* version : 0.1.0.2
* purpose : running cuckoo sandbox daemon using dAMAS each sutable state
END


chkRooter=`ps -ef | grep 'rooter' | wc | awk '{print $1}'`
if [ "$chkRooter" -gt 1 ]; then
	echo "[SUCCESS] cuckoo.rooter deamon is already running."
else
	echo "[INFO] Initiate dAMAS.autodAMASRunner."
	sh ./autorun/autodAMASRunner.sh
	echo "[SUCCESS] now cuckoo.rooter daemon is running statement."
fi
sleep 5

chkCuckoo=`ps -ef | grep 'cuckoo -d' | wc | awk '{print $1}'`
if [ "$chkCuckoo" -gt 1 ]; then
	echo "[SUCCESS] cuckoo.debug daemon is already running."
else
	echo "cuckoo -d failed."
	echo "[ALERT] initiate emergency debug process."
	nohup cuckoo -d >> ./log/emergency-debug.log
	echo "[SUCCESS] now cuckoo.debug daemon is running statement."
fi
sleep 5

chkWeb=`ps -ef | grep 'runserver' | wc | awk '{print $1}'`
if [ "$chkWeb" -gt 1 ]; then
	echo "[SUCCESS] cuckoo.web daemon is already running."
else
	echo "[INFO] Initiate dAMAS.autoWebRunner."
	sh ./autorun/autoWebRunner.sh
	echo "[SUCCESS] now cuckoo.web daemon is running statement."
fi

chkproc=`ps -ef | grep 'instance1' | wc | awk '{print $1}'`
if [ "$chkproc" -gt 1 ]; then
	echo "[SUCESS] cuckoo report instance checked."
else
	echo "[INFO] Initiate dAMAS.procInst."
	sh ./autorun/procInst.sh
	echo "[SUCCESS] now cuckoo.report instance is running statement."
fi


echo ""
echo ""
sh ./tools/procCheck.sh
