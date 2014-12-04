#!/bin/bash
#****************************************************
#         Author: dudu   471906904@qq.com
#  Last modified: 2014-12-04 11:17
#       Filename: random.sh
#    Description:生成十个随机数并进行排序 
#****************************************************
for i in {0..9}
do 
	rand[${i}]=$RANDOM
done
#echo ${#rand[@]}
echo ${rand[*]}
for ((i=0;i<9;i++))
do
	echo ${rand[i]}
	min_index=${i}
	for ((j=$(($i+1));j<10;j++))
	do
		if [ ${rand[j]} -lt ${rand[${min_index}]} ]
		then
			min_index=${j}
		fi
		if [ ${min_index} -ne ${i} ]
		then
			tmp=${rand[i]}
			rand[i]=${rand[${min_index}]}
			rand[${min_index}]=${tmp}
		fi
	done
	break
	echo ${rand[*]}
done

echo ${rand[@]}
