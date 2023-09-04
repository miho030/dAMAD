#!/bin/bash
: << "END"

ex) ./unzipper.sh /tmp/sector/2023-03-13.zip /tmp/sector/

* author  : github.com/miho030
* version : 0.2.3.7
* purpose : 1) unzip archived daily malware file
	    2) *.ZIP format password auto-entry algorithm
	    3) delete *.ZIP file after unzip process

END

# global variable
strArchivePwd="infected"

archivedMalFileDir=$1
strTargetDir=$2


# interface
echo ""
echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [dAMAS.unzipper-INFO] Initiate dAMAS.unziper engine protocol."
echo ""
echo " * * * "
echo ""
echo "#=================================================#"
echo "#               - dAMAS.AutoUnzipper -            #"
echo "#  ---------------------------------------------  #"
echo "#    - github.com/miho030    - version: v0.2.3.7  #"
echo "#=================================================#"
echo ""
echo " * * *"
echo ""
echo "-----------------------------------------------------------------------"

# AMA.unzipper_func-delArchive
del_malware_archiveFile ()
{
	if [ ! -e "$archivedMalFileDir" ]; then
		echo "[`date +%Y-%m-%d` `date +%T`]  [AMA.unziper-INFO] All temp file cleaned."
	else
		rm -rf "$archivedMalFileDir"
		echo "[`date +%Y-%m-%d` `date +%T`]  [AMA.unziper-INFO] Successfully clean malware archive file."
	fi
}

# AMA.unzipper_func-unzip
unzip_malware_archiveFile ()
{
        # unzip process
        echo "[SUCCESS] Completed preparing environment with no errors."
        echo "  * Starting unzip process.."
        echo ""
        unzip -P "$strArchivePwd" -d "$strTargetDir" "$archivedMalFileDir"
        echo ""
	echo " * * *"
	echo ""
	del_malware_archiveFile
	echo "+-------------------  Unzip process completed  ------------------------+"
	echo ""
	echo ""
}

# AMA.unzipper_func.makeStorage
if [ ! -e "$archivedMalFileDir" ]; then
	echo "[ERROR] Load daily malware archive failure!"
        exit 1
	
else
	echo "[AMA.unzipper-INFO] Successfully loaded daily malware archive file."
	echo "[AMA.unzipper-INFO] Initiate upzip process.."	
	sleep 1
	unzip_malware_archiveFile
fi


echo ""
echo ""
echo "+------------ 'unzip archived malware file process' completed  ---------------+"
echo ""