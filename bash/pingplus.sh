#!/bin/bash

while true; do

MODEM="PT Telekomunikasi Selular Indonesia"
ISP=$(curl -s http://ip-api.com/line/?fields=isp -m 5)
STATUS=$(cat /root/libernet/log/status.log)

if [ "${STATUS}" = "2" ]; then

echo ""
if [ "${ISP}" = "${MODEM}" ] || [ "${ISP}" = "" ]; then
	echo "Ping Fail - ${ISP}"
	echo $(date) && sleep 5

	# Restart Libernet
	/root/libernet/bin/service.sh -ds
	/root/libernet/bin/service.sh -sl
else
	echo "Ping Done - ${ISP}"
	echo $(date)
fi

fi

sleep 5
done
