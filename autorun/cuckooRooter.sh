#!/usr/bin/expect

# purpose : automatic cuckoo rooter executer with auto-type-password
# author  : github.com/miho030
# version : v0.0.0.1 

# execute cuckoo with root account.
spawn bash -c "nohup cuckoo -d rooter --sudo --group cuckoo >> ./log/rooter.log";
expect -re "password"
sleep 1
send "sudo패스워드\r"
interact
