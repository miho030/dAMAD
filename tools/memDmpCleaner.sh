#!/bin/bash

find $USER/.cuckoo/storage/analyses -name "memory.dmp" -type f -exec rm -rf {} \;
