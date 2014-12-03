#!/bin/bash
#****************************************************
#         Author: dudu   471906904@qq.com
#  Last modified: 2014-12-03 18:56
#       Filename: for04.sh
#    Description:显示当前系统所有默认shell为bash的用户的总数；并统计此些用户ID之和；
#****************************************************
declare -i sum=0
for i in $(grep "bash$" /etc/passwd| cut -d: -f3)
do
	sum+=${i}
done
echo ${sum}
