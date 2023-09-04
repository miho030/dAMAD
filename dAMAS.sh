#/bin/bash

:<<'END'
* Author  : github.com/miho030
* version : 0.1.9.0
* purpose : Request malware download, analysis, management of 
END


# local System setup
echo "+-------------------- start local system setup ----------------------"
echo ""
echo "[INFO] locale system setup.."
curPwd=$(pwd)
rootDir="$curPwd"
cd "$rootDir"
echo "cur pwd : $(pwd)"

# global variable
targetDate=$(date +%Y-%m-%d --date '1days ago')
reqFileName=$targetDate.zip

malSector="../malwareSector/"
realTarget="$malSector$reqFileName"
#testTarget="$malSector/2023-04-05.zip"

malStorage="./engines/tmpMalSector/"
malDir="$malStorage$targetDate/"
tmpTarget="$malDir$reqFileName"
rootMalDir="$rootDir/engines/tmpMalSector/$targetDate/"

# Initiate sub engines
mkSh=$(./engines/makeShelter.sh)
reqMal="./engines/reqNewMalFiles.sh $realTarget $malDir"
reqUnzip="./engines/unzipper.sh $tmpTarget $malDir"
reqAnalysis="./engines/reqAnalysis.sh $rootMalDir"


echo ""
echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Initiate dAMAS main engine protocol."
echo ""
echo " * * * "
echo ""
echo "    _         _                        _   _        __  __       _                             _                _                                                              _                 "
echo "   / \  _   _| |_ ___  _ __ ___   __ _| |_(_) ___  |  \/  | __ _| |_      ____ _ _ __ ___     / \   _ __   __ _| |_   _ _______   ___  ___ _ ____   _____ _ __   ___ _   _ ___| |_ ___ _ __ ___  "
echo "  / _ \| | | | __/ _ \| '_ ' _ \ / _' | __| |/ __| | |\/| |/ _' | \ \ /\ / / _' | '__/ _ \   / _ \ | '_ \ / _' | | | | |_  / _ \ / __|/ _ \ '__\ \ / / _ \ '__| / __| | | / __| __/ _ \ '_ ' _ \ "
echo " / ___ \ |_| | || (_) | | | | | | (_| | |_| | (__  | |  | | (_| | |\ V  V / (_| | | |  __/  / ___ \| | | | (_| | | |_| |/ /  __/ \__ \  __/ |   \ V /  __/ |    \__ \ |_| \__ \ ||  __/ | | | | |"
echo "/_/   \_\__,_|\__\___/|_| |_| |_|\__,_|\__|_|\___| |_|  |_|\__,_|_| \_/\_/ \__,_|_|  \___| /_/   \_\_| |_|\__,_|_|\__, /___\___| |___/\___|_|    \_/ \___|_|    |___/\__, |___/\__\___|_| |_| |_|"
echo "                                                                                                                  |___/                                              |___/                       "
echo ""
echo ""
echo ""
echo "  * dAMAS (daily Auto Malware Analyse System) version 0.0.1.2 "
echo "  * Author : github.com/miho030 "
echo "  * Copyright all reserved 2023 @ TEAM. BLUE"
echo ""
echo ""
echo " * * * "
echo ""
echo ""
echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Initiate dAMAS autoRun services.."
echo ""
chkWeb=`ps -ef | grep 'runserver' | wc | awk '{print $1}'`	
if [ "$chkWeb" -gt 1 ]; then
	echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Engine 'dAMAS.autoRun' already initiated. -> PASS this protocol.."
else
	echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Starting cuckoo service.."
	runS=$(./autoRun_dAMAS.sh)
	sleep 5
fi
echo ""



echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Initiate dAMAS.makeShelter.."
echo ""


if mountpoint -q "$malSector"; then
	echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Engine 'dAMAS.makeShelter' already initiated. -> PASS this protocol.."	
else
	$mkSh
	sleep 5
	echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Successfully initiate dAMAS.makeShelter."
fi
echo ""



echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Initiate dAMAS.reqNewMalFiles.."
echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Today's target file name : $reqFileName"
echo ""

make_malware_storage ()
{
        if [ ! -e "$malStorage" ]; then
                echo "[INFO] Creating malware storage directory.. (1/2)"
                mkdir "$malStorage"
        else
                echo "[INFO] Successfully checked environment for dAMAS.reqNewFiles (1/2)"
        fi
}

make_temp_storage ()
{
        if [ ! -e "$malDir" ]; then
                echo "[INFO] Creating temporary malware directory.. (2/2)"
                mkdir "$malDir"
        else
                echo "[INFO] Succesfully checked environment for dAMAS.reqNewFiles (2/2)"
        fi
}

req_new_mal ()
{
        echo ""
        sleep 1
        echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Requesting new daily malware files from collect server.."
        sh $reqMal
}

check_and_reqNewMal ()
{
if mountpoint -q "$malSector"; then
        echo "[INFO] Successfuly mounted malwareSector."

        if [ ! -e "$realTarget" ]; then
                echo "[INFO] Target malware archive file not founded."
        else
                make_malware_storage
                make_temp_storage
                req_new_mal
        fi
else
        echo "[`date +%Y-%m-%d` `date +%T`] [ERROR] Mount malware sector failure!"
        echo "   [+] Auto engine re-load protocol initiated." $mkSh
fi
}


if [ ! -e "$tmpTarget" ]; then
        check_and_reqNewMal
else
        echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] dAMAS.reqNewMal already initiated.  -> PASS this protocol"
fi



echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Initiate dAMAS.unzipper.."
echo ""

if [ ! -e "$malDir" ]; then
        echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Load temporary malware sector failure!"
        exit 1
else
        if [ ! -e "$tmpTarget" ]; then
                echo "[`date +%Y-%m-%d` `date +%T`]  [ERROR] Target daily malware file (temp-archive-file) not founded!"
                exit 1
        else
                echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Successfully loaded temporary malware sector. Initiate AMA.unzipper protocol.."
                sleep 1
                sh $reqUnzip
        fi
fi



echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Initiate dAMAS.reqAnalysis.."
echo ""

if [ ! -e "$rootMalDir" ]; then
	echo "[`date +%Y-%m-%d` `date +%T`]  [ERROR] Target daily malware file storage!"
	exit 1
else
	sh $reqAnalysis	
fi

echo "-----------------------------------------------------------------------"
echo "[`date +%Y-%m-%d` `date +%T`]  [INFO] Initiate dAMAS.makeReport.."
echo "[INFO] Not supported making report log stash in this version. comming soon.."
echo ""
