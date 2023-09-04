#!/usr/bin/expect

# purpose : automatic network disk connector based on samba
# author  : github.com/miho030
# version : v0.0.0.1


spawn bash -c "sudo mount -t cifs -o user=aoi,vers=2.0 //192.168.0.14/MalwareSector /home/cuckoo/Desktop/AMA/malwareSector/";
expect -re "password"
sleep 1
send "sudo패스워드\r"

expect -re "MalwareSector:"
sleep 1
send "sudo패스워드\r"

interact
