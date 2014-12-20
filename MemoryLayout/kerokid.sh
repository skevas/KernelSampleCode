#!/bin/bash

KEROKID_PROC_FILE="/proc/kerokid/memory"

grep syscall ${KEROKID_PROC_FILE} | cut -d ' ' -f 3 | sed 's/\([a-f0-9]*\)/0x\1/' > syscalls 
grep module ${KEROKID_PROC_FILE} | cut -d ' ' -f 3,4 | sed 's/\([a-f0-9]*\) \([a-f0-9]*\)/0x\1 0x\2/g' > modules
