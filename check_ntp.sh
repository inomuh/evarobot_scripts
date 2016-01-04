#!/bin/bash
limit=100
ntp_server=192.168.10.60
sizeofip=${#ntp_server}
echo $sizeofip
#offsets=$(ntpq -nc peers | tail -n +3 | cut -c 62-66 | tr -d '-')
#server_ip=$(ntpq -nc peers | tail -n +3 | cut -c 2-13 | tr -d '-')
loop=1
while [ $loop == 1 ]; do
	i=0
	k=0
	j=0
	offsets=$(ntpq -nc peers | tail -n +3 | cut -c 62-66 | tr -d '-')
	server_ip=$(ntpq -nc peers | tail -n +3 | cut -c 2-14 | tr -d '-')
	refid=$(ntpq -nc peers | tail -n +3 | cut -c 18-25 | tr -d '-')
	for server_ip in ${server_ip}; do
		if [ "$server_ip" == "$ntp_server" ]; then
			echo $server_ip
			break
		fi
		let i=i+1
	done
        for refid in ${refid}; do
                if [ "$refid" == "LOCAL(0)" ]; then
                        echo $refid
                        break
                fi
                let j=j+1
        done
	
        for offset in ${offsets}; do
#            echo $offset
            if [ $offset -gt $limit ] || [ $k -ne $i ]; then
                echo "waiting sync"
            else
		if [ $i == $j ]; then
			#echo $offset
	                echo "ntp sync is OK"
			echo $i
			echo $k
			echo $j
			loop=0
	                break
		fi
            fi
	    let k=k+1
        done
	if [ $loop == 1 ]; then
	        sleep 10
	fi
done
# EOF
