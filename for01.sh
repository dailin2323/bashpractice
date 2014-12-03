#!/bin/bash
#****************************************************
#         Author: dudu   471906904@qq.com
#  Last modified: 2014-12-03 16:23
#       Filename: for01.sh
#    Description:于/tmp/test目录中创建10个空文件f1,.., f10 
#****************************************************

#先查看是否有/tmp/test是否存在
 [ -d /tmp/test ] ||  mkdir /tmp/test
#也可写作 [ ! -d /tmp/test ] &&  mkdir /tmp/test
for  i in {1..10}
do
	[  -e "/tmp/test/f${i}" ] ||  touch /tmp/test/f${i} 
done
