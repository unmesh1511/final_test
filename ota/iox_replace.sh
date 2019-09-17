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

get_details()
{
	IOX_SL_INTERFACE=${1}
	IOX_INFO=$(get_iox_info ${IOX_SL_INTERFACE})
	IOX_IP=$(echo ${IOX_INFO} | awk '{print $2}')
	info=$(get_iox_mac ${IOX_IP})
	echo ${info}
}


echo -e "\nCollecting INSTALL ID's...\n"

for interface in ${SL_INTERFACES[@]};
do
	info=$(get_details ${interface})
	ID=$(echo ${info} | awk '{print $23}')
	INSTALL_ID+=(${interface}:${ID})
done


# randomly select any 2 of connected iox's
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
IOX2_SL_INTERFACE=$(echo ${INSTALL_ID[$rand2]} | awk -F ":" '{print $1}')

#both connected then replace abr

get_logical_id()
{
	INSTALL_ID=${1}
	cat lim.log | grep -o -P "${INSTALL_ID}.{0,20}" | cut -d ":" -f 2 | tr -d "'"	
}

parse_lim_log()
{
	tail -2 lim.log | head -1 > tmp 
	mv tmp lim.log
	echo -e "\n\t\tINSTALL_ID=${IOX1_INSTALL_ID} LOGICAL_ID=$(get_logical_id ${IOX1_INSTALL_ID})\n\t\tINSTALL_ID=${IOX2_INSTALL_ID} LOGICAL_ID=$(get_logical_id ${IOX2_INSTALL_ID})"
}

get_lim_log()
{
	mosquitto_pub -t apollo/0/./rq/=lim/f/config -m '{"list": null}'
	sleep 1
	cat /var/log/supervisor/lim.log > lim.log
	parse_lim_log
}

test1()
{
	echo "Before : "
	get_lim_log
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX1_INSTALL_ID} -m '{"replace": "'${IOX2_INSTALL_ID}'"}'
	echo -e "\nREPLACE : IOX (INSTALL_ID : ${IOX1_INSTALL_ID}) with IOX (INSTALL_ID : ${IOX2_INSTALL_ID})\n"
	sleep 120
	echo "After : "
	get_lim_log
}

#1st connected then replace then connected 2nd arb

test2()
{
	echo "Before : "
	get_lim_log
	temp=$(get_details ${IOX2_SL_INTERFACE})
	mac_id=$(echo ${temp} | awk '{print $23}')
	echo -e "\n*** PLEASE DETACH IOX WITH MAC_ID = ${mac_id} ***"
	sleep 10
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX1_INSTALL_ID} -m '{"replace": "'${IOX2_INSTALL_ID}'"}'
	echo -e "\nREPLACE : IOX (INSTALL_ID : ${IOX1_INSTALL_ID}) with IOX (INSTALL_ID : ${IOX2_INSTALL_ID})\n"
	sleep 2
	echo -e "*** PLEASE REATTACH IOX ***\n"
	sleep 120
	echo "After : "
	get_lim_log
}

#both connected then replace bar

test3()
{
	echo "Before : "
	get_lim_log
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX2_INSTALL_ID} -m '{"replace": "'${IOX1_INSTALL_ID}'"}'
	echo -e "\nREPLACE : IOX (INSTALL_ID : ${IOX2_INSTALL_ID}) with IOX (INSTALL_ID : ${IOX1_INSTALL_ID})\n"
	sleep 120
	echo "After : "
	get_lim_log
}

#2nd connected then replace then connected 1st bra

test4()
{
	echo "Before : "
	get_lim_log
	temp=$(get_details ${IOX1_SL_INTERFACE})
	mac_id=$(echo ${temp} | awk '{print $23}')
	echo -e "\n*** PLEASE DETACH IOX WITH MAC_ID = ${mac_id} ***"
	sleep 10
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX2_INSTALL_ID} -m '{"replace": "'${IOX1_INSTALL_ID}'"}'
	echo -e "\nREPLACE : IOX (INSTALL_ID : ${IOX2_INSTALL_ID}) with IOX (INSTALL_ID : ${IOX1_INSTALL_ID})\n"
	sleep 2
	echo "*** PLEASE REATTACH IOX ***\n"
	sleep 120
	echo "After : "
	get_lim_log
}

#replace then connect both rab

test5()
{
	echo "Before : "
	get_lim_log
	temp1=$(get_details ${IOX1_SL_INTERFACE})
	temp2=$(get_details ${IOX2_SL_INTERFACE})
	mac_id1=$(echo ${temp1} | awk '{print $23}')
	mac_id2=$(echo ${temp2} | awk '{print $23}')
	echo -e "\n*** PLEASE DETACH IOX WITH MAC_ID = ${mac_id1} and IOX WITH ${mac_id2} ***"
	sleep 10
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX1_INSTALL_ID} -m '{"replace": "'${IOX2_INSTALL_ID}'"}'
	echo -e "\nREPLACE : IOX (INSTALL_ID : ${IOX1_INSTALL_ID}) with IOX (INSTALL_ID : ${IOX2_INSTALL_ID})\n"
	sleep 2
	echo "*** PLEASE REATTACH IOX ***\n"
	sleep 120
	echo "After : "
	get_lim_log
}



#echo -e "\n***************** TEST_CASE 1 *****************\n"
#test1
echo -e "\n***************** TEST_CASE 2 *****************\n"
sleep 10
test2
