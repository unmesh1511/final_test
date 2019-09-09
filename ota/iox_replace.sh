#!/bin/bash

SL_INTERFACES=$(ls -A /sys/class/net | grep sl)

upgrade_ip()
{
    IP=$1
    IP_HEX=$(printf '%.2X%.2X%.2X%.2X\n' `echo $IP | sed -e 's/\./ /g'`)
	NEXT_IP_HEX=$(printf %.8X `echo $(( 0x$IP_HEX + 1 ))`)
    NEXT_IP=$(printf '%d.%d.%d.%d\n' `echo $NEXT_IP_HEX | sed -r 's/(..)/0x\1 /g'`)
    echo "$NEXT_IP"
}

get_iox_info()
{
	APOLLO_SL_IP=$(ifconfig ${1} | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
	echo ${APOLLO_SL_IP}
	IOX_IP=$(upgrade_ip ${APOLLO_SL_IP})
	echo ${IOX_IP}
	
}


get_iox_mac()
{
	(sleep 2; echo "iox_mac | head -n2"; sleep 5; echo "exit") | telnet ${1} 2>/dev/null
}

echo ""
echo "Collecting INSTALL ID's.............."

for interface in ${SL_INTERFACES[@]};
do
	IOX_INFO=$(get_iox_info ${interface})
	IOX_IP=$(echo ${IOX_INFO} | awk '{print $2}')
	info=$(get_iox_mac ${IOX_IP})
	ID=$(echo ${info} | awk '{print $23}')
	INSTALL_ID+=(${interface}:${ID})
done



while true
do
	rand1=$[$RANDOM % ${#INSTALL_ID[@]}]
	rand2=$[$RANDOM % ${#INSTALL_ID[@]}]
	if [[ ${rand1} -ne ${rand2} ]];
	then
		break
	fi
done

IOX1_INSTALL_ID=$(echo ${INSTALL_ID[$rand1]} | awk -F ":" '{print $2}')
IOX1_SL_INTERFACE=$(echo ${INSTALL_ID[$rand1]} | awk -F ":" '{print $1}')
IOX2_INSTALL_ID=$(echo ${INSTALL_ID[$rand2]} | awk -F ":" '{print $2}')
IOX2_SL_INERFACE=$(echo ${INSTALL_ID[$rand2]} | awk -F ":" '{print $1}')

#both connected then replace abr

get_lim_log()
{
	mosquitto_pub -t apollo/0/./rq/=lim/f/config -m '{"list": null}'
	cat /var/log/supervisor/lim.log > lim.log
}

test1()
{
	get_lim_log
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX1_INSTALL_ID} -m '{"replace": "'${IOX2_INSTALL_ID}'"}'
	#check logs
}

#1st connected then replace then connected 2nd arb

test2()
{
	get_lim_log
	sudo ifconfig ${IOX2_SL_INTERFACE} down
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX1_INSTALL_ID} -m '{"replace": "'${IOX2_INSTALL_ID}'"}'
	sudo ifconfig ${IOX2_SL_INTERFACE} up
}

#both connected then replace bar

test3()
{
	get_lim_log
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX2_INSTALL_ID} -m '{"replace": "'${IOX1_INSTALL_ID}'"}'
}

#2nd connected then replace then connected 1st bra

test4()
{
	get_lim_log
	sudo ifconfig ${IOX1_SL_INTERFACE} down
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX2_INSTALL_ID} -m '{"replace": "'${IOX1_INSTALL_ID}'"}'
	sudo ifconfig ${IOX1_SL_INTERFACE} up
}

#replace then connect both rab

test5()
{
	get_lim_log
	sudo ifconfig ${IOX1_SL_INTERFACE} down
	sudo ifconfig ${IOX2_SL_INTERFACE} down
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX1_INSTALL_ID} -m '{"replace": "'${IOX2_INSTALL_ID}'"}'
	sudo ifconfig ${IOX1_SL_INTERFACE} up
	sudo ifconfig ${IOX2_SL_INTERFACE} up
}

#replace then connect both rba

test6()
{
	get_lim_log
	sudo ifconfig ${IOX1_SL_INTERFACE} down
	sudo ifconfig ${IOX2_SL_INTERFACE} down
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX2_INSTALL_ID} -m '{"replace": "'${IOX1_INSTALL_ID}'"}'
	sudo ifconfig ${IOX1_SL_INTERFACE} up
	sudo ifconfig ${IOX2_SL_INTERFACE} up
}
