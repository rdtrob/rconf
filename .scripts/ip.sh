#!/bin/zsh
#/dev/null
for i in {1..254} ;do (ping -c 3 -W 1 192.168.200.$i -c 1 -w 2  > /dev/null && echo "192.168.200.$i" &) ;done
