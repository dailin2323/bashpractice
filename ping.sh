#!/bin/bash
#****************************************************
#         Author: dudu   471906904@qq.com
#  Last modified: 2014-12-05 12:33
#       Filename: ping.sh
#    Description:写一个脚本，判定192.168.0.0网络内有哪些主机在线，在线的用绿色显示；不在线的用红色显示 
#****************************************************
function ping_fun()
{
	ip_name=$1
	head=${ip_name%%.*}
	if [ ${head} -ne 172 -a ${head} -ne 192 ]
	then
		echo "not private"
	else
		if [ ${head} -eq 172 ]
		then
			for((i=16;i<=16;i++))
			do
				for j in {0..255}
				do
					for k in `seq 0 255`
					do
						ping -c1 -w1 172.$i.$j.$k &> /dev/null
						if [ $? -eq 0 ]
						then
							echo -e "\033[32m 172.$i.$j.$k is online \033[0m"  
						else
							echo -e "\033[31m 172.$i.$j.$k is offline\033[0m"
						fi
					done
				done
			done
		else
			for((i=0;i<=255;i++))
			do
				for j in {0..255}
				do
					ping -c1 -w1 192.168.$i.$j &> /dev/null 
					if [ $? -eq 0 ]
                                                then
                                                   
     echo -e "\033[32m 192.168.$i.$j is online \033[0m"
                                                else
                                                        
                            echo -e "\033[31m 192.168.$i.$j is offline\033[0m"
                                       fi
				done
			done
		fi
	fi
	
}
trap 'echo "quit"; exit 1' SIGINT
ping_fun 172.16.0.0
