#!/bin/bash

echo "PingPlus Started!" && n=1
while true; do

MODEM="PT Telekomunikasi Selular Indonesia"
ISP=$(curl -s -m 10 http://ip-api.com/line/?fields=isp)
STATUS=$(cat /root/libernet/log/status.log)

if [ "${STATUS}" = "2" ]; then

	echo ""
	if [ "${ISP}" = "${MODEM}" ]; then

		echo "Ping Fail - ${ISP}"
		echo $(date) && sleep 5

		# Restart Libernet
		/root/libernet/bin/service.sh -ds
		/root/libernet/bin/service.sh -sl

	elif [ "${ISP}" = "" ]; then

		echo "Ping Null ${n} .."
		echo $(date) && sleep 5
		
		if [ "${n}" = "5" ]; then
		
			# Restart Hilink & Libernet
			ifdown hilink && sleep 1
			/root/libernet/bin/service.sh -ds
			ifup hilink && sleep 3
			/root/libernet/bin/service.sh -sl

		fi
		n=$((n + 1))

	else

		echo "Ping Done - ${ISP}"
		echo $(date)
		n=1

	fi
fi
sleep 10
done
