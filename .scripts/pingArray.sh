#/bin/bash
for ip in 192.168.0.{1..255}; do ping -t 1 -W 1 $ip > /dev/null && echo "${ip} is up";
done
