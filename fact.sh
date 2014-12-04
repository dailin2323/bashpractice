#!/bin/bash
#****************************************************
#         Author: dudu   471906904@qq.com
#  Last modified: 2014-12-03 22:00
#       Filename: fact.sh
#    Description:阶乘 
#****************************************************
function fact()
{
	if [ $1 -eq 0 -o $1 -eq 1 ]
	then
		echo 1
	else
		echo $[ $1* $(fact  $[$1-1] ]
	fi
}

fact 5
