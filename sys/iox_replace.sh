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
	ID=$(echo ${info} | awk '{print $19}')
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


get_logical_id()
{
	temp1=$(get_details ${IOX1_SL_INTERFACE})
	LOGICAL_ID1=$(echo ${temp1} | awk '{print $24}')
	temp2=$(get_details ${IOX2_SL_INTERFACE})
	LOGICAL_ID2=$(echo ${temp2} | awk '{print $24}')

	echo -e "\n\t\tINSTALL_ID=${IOX1_INSTALL_ID} LOGICAL_ID=${LOGICAL_ID1}\n\t\tINSTALL_ID=${IOX2_INSTALL_ID} LOGICAL_ID=${LOGICAL_ID2}"
}


#both connected then replace abr

test1()
{
	echo "Before : "
	get_logical_id
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX1_INSTALL_ID} -m '{"replace": "'${IOX2_INSTALL_ID}'"}'
	echo -e "\nREPLACE : IOX (INSTALL_ID : ${IOX1_INSTALL_ID}) with IOX (INSTALL_ID : ${IOX2_INSTALL_ID})\n"
	sleep 120
	echo "After : "
	get_logical_id
}

#1st connected then replace then connected 2nd arb

test2()
{
    echo "Before : "
    get_logical_id
    temp=$(get_details ${IOX2_SL_INTERFACE})
    mac_id=$(echo ${temp} | awk '{print $14}')
    echo -e "\n*** PLEASE DETACH IOX WITH MAC_ID = ${mac_id} in 10s ***"
    sleep 10
    mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX1_INSTALL_ID} -m '{"replace": "'${IOX2_INSTALL_ID}'"}'
    echo -e "\nREPLACE : IOX (INSTALL_ID : ${IOX1_INSTALL_ID}) with IOX (INSTALL_ID : ${IOX2_INSTALL_ID})\n"
    sleep 2
    echo -e "*** PLEASE REATTACH IOX in 10s ***\n"
    sleep 120
    echo "After : "
    get_logical_id
}

#2nd connected then replace then connected 1st bra

test3()
{
	echo "Before : "
	get_logical_id
	temp=$(get_details ${IOX1_SL_INTERFACE})
	mac_id=$(echo ${temp} | awk '{print $14}')
	echo -e "\n*** PLEASE DETACH IOX WITH MAC_ID = ${mac_id} in 10s ***"
	sleep 10
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX2_INSTALL_ID} -m '{"replace": "'${IOX1_INSTALL_ID}'"}'
	echo -e "\nREPLACE : IOX (INSTALL_ID : ${IOX2_INSTALL_ID}) with IOX (INSTALL_ID : ${IOX1_INSTALL_ID})\n"
	sleep 2
	echo "*** PLEASE REATTACH IOX in 10s ***\n"
	sleep 120
	echo "After : "
	get_logical_id
}

#replace then connect both rab

test4()
{
	echo "Before : "
	get_logical_id
	temp1=$(get_details ${IOX1_SL_INTERFACE})
	temp2=$(get_details ${IOX2_SL_INTERFACE})
	mac_id1=$(echo ${temp1} | awk '{print $14}')
	mac_id2=$(echo ${temp2} | awk '{print $14}')
	echo -e "\n*** PLEASE DETACH IOX WITH MAC_ID = ${mac_id1} and IOX WITH ${mac_id2} in 10s ***"
	sleep 10
	mosquitto_pub -t apollo/0/./rq/=lim/i/${IOX1_INSTALL_ID} -m '{"replace": "'${IOX2_INSTALL_ID}'"}'
	echo -e "\nREPLACE : IOX (INSTALL_ID : ${IOX1_INSTALL_ID}) with IOX (INSTALL_ID : ${IOX2_INSTALL_ID})\n"
	sleep 2
	echo "*** PLEASE REATTACH IOX in 10s ***\n"
	sleep 120
	echo "After : "
	get_logical_id
}



#echo -e "\n***************** TEST_CASE 1 *****************\n"
#test1
echo -e "\n***************** TEST_CASE 2 *****************\n"
sleep 10
test2
#echo -e "\n***************** TEST_CASE 3 *****************\n"
#sleep 10
#test3
#echo -e "\n***************** TEST_CASE 4 *****************\n"
#sleep 10
#test4
