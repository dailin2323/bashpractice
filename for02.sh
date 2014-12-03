#!/bin/bash
#****************************************************
#         Author: dudu   471906904@qq.com
#  Last modified: 2014-12-03 16:56
#       Filename: for02.sh
#    Description:
#              (1) 创建"/tmp/test-当前时间"目录；
#               (2) 添加10用户tuser1,.., tuser10;
#              (3) 在"/tmp/test-当前时间"目录中，创建10空文件f1,...,f10；
#               (4) 修改f1的属主为tuser1；依次类推； 
#****************************************************

dir=/tmp/test-$(date +%Y-%m-%d-%H-%M-%S)
mkdir $dir  
for i in `seq 1 10`
do
	id tuser${i} >> /dev/null
	[  $? -ne 0 ] && useradd tuser${i} 
	[ ! -f $dir ] && touch ${dir}/f${i}
done
id tuser1 &&  ls ${dir}/f1 && [ `chown tuser1 ${dir}/f1` ] 
