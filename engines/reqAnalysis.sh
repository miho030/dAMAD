#!/bin/bash

:<<'END'
* Author  : github.com/miho030
* version : 0.0.2.1
* purpose : listing directory(daily malware sample directory), request malware analysis to cuckoo.service
END

# global variable
#test="./tmpMalSector/2023-04-18/"
vecMalFileDir=$1


# AMA.reqAnalyz-func-req
send_mal_to_cuckoo ()
{
	for file in "$vecMalFileDir"*
	do
		if [ -d $file ]; then
			echo "[`date +%Y-%m-%d` `date +%T`]  [dAMAS.reqAnalysis-INFO] '$file' is directory."
		elif [ -f $file ]; then
			cuckoo submit --package exe --timeout 60 -o route=internet --machine cuckoo1 --platform windows $file
		fi
	done
}

# interface
echo ""
echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [dAMAS.reqAnalysis-INFO] Initiate dAMAS.reqAnalysis engine protocol."
echo ""
echo " * * * "
echo ""
echo "#=================================================#"
echo "#              - dAMAS.reqAnalysis -              #"
echo "#  ---------------------------------------------  #"
echo "#    - github.com/miho030    - version: v0.0.2.1  #"
echo "#=================================================#"
echo ""
echo " * * *"
echo ""
echo "-----------------------------------------------------------------------"

# AMA.reqAnalysis
send_mal_to_cuckoo


echo ""
echo ""
echo "+------------ 'Send daily malware to cuckoo' completed  ---------------+"
echo ""