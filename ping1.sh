#!/bin/bash
#****************************************************
#         Author: dudu   471906904@qq.com
#  Last modified: 2014-12-05 12:33
#       Filename: ping.sh
#****************************************************
function ping_fun()
{
	for((i=250;i<=250;i++))
	do
		for j in {0..255}
		do
			ping -c1 -w1 172.16.$i.$j &> /dev/null
			if [ $? -eq 0 ]
			then
				echo -e "\033[32m 172.16.$i.$j is online \033[0m"  
				let online++
			else
				echo -e "\033[31m 172.16.$i.$j is offline\033[0m"
				let offline++
			fi
		done
	done
}

function fun_while()
{
	declare -i iwhile=250
	declare -i iwhile=0
	while [ $iwhile -lt 255 ]
	do
		while [ $jwhile -lt 255 ]
		do
			ping -c1 -w1 172.16.$iwhile.$jwhile &> /dev/null
			if [ $? -eq 0 ]
                        then
                                echo -e "\033[32m 172.16.$iwhile.$jwhile is online \033[0m"  
                                let while_onlie++
                        else
                                echo -e "\033[31m 172.16.$while.$jwhile is offline\033[0m"
                                let while_offline++
                        fi
			let $jwhile++
		done
		let $iwhile++
	done
}
trap 'echo "quit"; exit 1' SIGINT
ping_fun
echo "在线的是$online"
echo "没在线的$offline"
echo -e "\033[34m 172.16.$i.$j is offline\033[0m"
