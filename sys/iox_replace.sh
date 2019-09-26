#!/bin/bash

source env_var.sh
source iox_info.sh

SL_INTERFACES=$(ls -A /sys/class/net | grep sl)

echo -e "\nCollecting INSTALL ID's...\n"

for interface in ${SL_INTERFACES[@]};
do
	info=$(get_details ${interface})
	ID=$(echo ${info} | awk '{print $20}')
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
	LOGICAL_ID1=$(echo ${temp1} | awk '{print $25}')
	temp2=$(get_details ${IOX2_SL_INTERFACE})
	LOGICAL_ID2=$(echo ${temp2} | awk '{print $25}')

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
