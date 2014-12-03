#!/bin/bash
#****************************************************
#         Author: dudu   471906904@qq.com
#  Last modified: 2014-12-03 18:20
#       Filename: for03.sh
#    Description:计算一百以内所有的正整数之和，奇数之和，偶数之和 
#****************************************************
declare i sum=0
declare i even=0
declare i odd=0
for i in {1..100} 
do
      sum=$((${sum}+${i}))
      if [ $(($i%2)) -eq 0 ] 
      then	
      	even=$((${even}+${i}))
      else
	odd=$((${odd}+${i}))
      fi


done
echo "一百以内的整数和为${sum}"
echo "一百以内的奇数和为${odd}"
echo "一百以内的偶数和为${even}"
