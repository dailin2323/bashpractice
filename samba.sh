#!/bin/bash
#****************************************************
#         Author: dudu   471906904@qq.com
#  Last modified: 2014-12-24 21:25
#       Filename: samba.sh
#    Description: 
#****************************************************

[ -d /data ] || mkdir /data

stat=$(rpm -q samba)
[ $stat eq 1 ] && yum -y install samba
