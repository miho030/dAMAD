#!/bin/bash

: << "END" 
* author  : github.com/miho030
* version : 0.1.9.4
* purpose : 1) verify malware archive file(malware collect server), 
	    2) download archived daily malware sample from malware collect server. 
END


# global variable
reqFile=$1
archiveTmpDir=$2

# interface
echo ""
echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [AMA.reqNewMalFile-INFO] Initiate dAMAS.reqNewMalFile engine protocol."
echo ""
echo " * * * "
echo ""
echo "#=================================================#"
echo "#             - dAMAS.reqNewMalFile -             #"
echo "#  ---------------------------------------------  #"
echo "#    - github.com/miho030    - version: v0.1.9.4  #"
echo "#=================================================#"
echo ""
echo " * * *"
echo ""
echo "-----------------------------------------------------------------------"

# AMA.reqNewMal main
if [ -e "$reqFile" ]; then
	echo "[`date +%Y-%m-%d` `date +%T`]  [AMA.reqNewMal-INFO] Successfully checked target malware archive file."
	cp -R "$reqFile" "$archiveTmpDir"
else
	echo "[`date +%Y-%m-%d` `date +%T`]  [AMA.reqNewMal-ERROR] Temp malware sector not founded."
	echo "   -> Try re-execute this script, 'reqNewMalFiles.sh'."
	exit 1
fi


echo ""
echo ""
echo "+------------ 'Request daily malware archive file' completed  ---------------+"
echo ""