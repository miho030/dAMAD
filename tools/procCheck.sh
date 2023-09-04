#!/bin/bash


echo ""
echo ""
echo "-----------------------------------------------------------------------"
echo ""
echo "[`date +%Y-%m-%s`]  [AMA.tools.ProcCheck] Initiated."
echo " * * *"
echo ""


echo "  [+] Check a process 'cuckoo.rooter'.."
chkRooter=`ps -ef | grep 'rooter' | wc | awk '{print $1}'`
if [ "$chkRooter" -gt 1 ]; then
	echo "     ==> [INFO] cuckoo.rooter is currently up."
else
	echo "     ==> [CRITICAL] cuckoo.rooter is currently down."
fi
echo ""


echo "  [+] Check a process 'cuckoo.main-debug'.."
chkCuckoo=`ps -ef | grep 'cuckoo' | wc | awk '{print $1}'`
if [ "$chkCuckoo" -gt 1 ]; then
	echo "     ==> [INFO] cuckoo.main-debug is currently up."
else
	echo "     ==> [CRITICAL] cuckoo.main-debug is currently  down."
fi
echo ""


echo "  [+] check a process 'cuckoo.web'.."
chkWeb=`ps -ef | grep 'runserver' | wc | awk '{print $1}'`
if [ "$chkWeb" -gt 1 ]; then
	echo "     ==> [INFO] cuckoo.web is currently up."
else
	echo "     ==> [CRITICAL] cuckoo.web is currently down"
fi


echo ""
echo " * * *"
echo "[`date +%Y-%m-%s`]  ==> Close process test task."
echo "-----------------------------------------------------------------------"
echo ""
echo ""
