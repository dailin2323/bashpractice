#!/bin/bash
#****************************************************
#         Author: dudu   471906904@qq.com
#  Last modified: 2014-12-19 22:15
#       Filename: oneCommand.sh
#    Description: 
#****************************************************
#删除0字节的文件
find -type f -size 0 -exec rm -rf {} \;
