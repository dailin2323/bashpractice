#!/bin/bash
#****************************************************
#         Author: dudu   471906904@qq.com
#  Last modified: 2014-12-04 14:34
#       Filename: zuoye1.sh
#    Description: 
#1、列出当前系统上的所有磁盘设备；
#2、让用户选择一个磁盘设备，并在选择后显示指定设备上的所有分区信息；
#3、询问用户是否擦除此磁盘上的所有现存分区后重新添加三个分区；
#    y或yes: 继续
#    n或no: 中止脚本
#    其它字符则提醒用户重新输入合法的字符
# 4、在用户选择是后执行相应的分区操作
#    创建三个分区
#    主分区1：512M，ext4
#    主分区2: 512M，swap
#    主分区3：2G，ext4
# 5、将创建的分区按如上说明分别格式为相应的文件系统；
# 6、将主分区1挂载至/mnt/boot目录，主分区3挂载至/mnt/sysroot目录；
#    扩展：在上述第3个步骤开始之后，先查看此设备上是否有分区被挂载，如果有，则先卸载之；
#****************************************************
#列出当前系统的所有磁盘设备?
all_disk=`fdisk -l|grep -o "^/dev/sd[[:alpha:]][[:digit:]]"`
echo $all_disk
read -p "pls choose one disk:" disk
function choose_disk()
{
	#如果为空，则让用户必须输入
	until  [  $disk -a -b $disk ]
	do
  		read -p "pls choose one disk:" disk
	done
}

#获取设备的所有分区
function get_part()
{
	part=`fdisk -l $1|grep "^$1*"|cut -d" " -f 1`
	echo ${part[*]}
}

#删除设备分区

 function del_disk()
 {
 fdisk $1<<EOF
         d
         $2
         w
         q
EOF
 
}

#创建设备新分区

function add_disk()
{
        fdisk $1<<EOF
        n
        p
        $2
         
        $3
        w
        q
EOF
}
choose_disk 
#如果不为空，则显示磁盘信息，否则提示重新选
fdisk -l $disk
#请输入命令，如果没有输入或者不是yes，y,n,no中的一个，知道正确为止。
read -p "eraser the $disk,if you agree,you can type yes or y,or else,type no or n :" choice
while  [ -z "$choice"  ]
do
	read -p "eraser the $disk,if you agree,you can type yes or y,or else,type no or n :" choice
done

while  [  "$choice" != "yes" -a "$choice" != "y" -a "$choice" != "no" -a  "$choice" != "n" ]
do
	echo "pls input right no"
	read -p "eraser the $disk,if you agree,you can type yes or y,or else,type no or n :" choice
done
[ $choice == "no" -o $choice == "n" ] && exit 
#查看该设备是否有分区挂载,如果有则卸载，并获取分区的数字，并删除分区
result=`get_part $disk`
arr_count=${#result[*]}
if [ ${arr_count} -gt 0 ]
then
	for((i=0;i<${arr_count};i++))
	do
		part_name=${result[$i]}
		umount part_name
		part_num=${part_name#*$disk}
		#调用函数删除某个分区
		del_disk $disk $part_num  >> /dev/null
	done
fi
#创建分区,这个地方需要判断下磁盘是否够3GB再创建分区，但是df出问题，需要查下再解决。
add_disk $disk 1 +512M
add_disk $disk 2 +512M
add_disk $disk 3 +2G
#创建完分区后需要用partprobe来重新读取分区表，保险期间，多读几次，脸上不掉肉
partprobe
partprobe
partprobe
if [ -b "${disk}1" -a -b "${disk}2" -a -b "${disk}3" ]
then
	mkfs -t ext4 ${disk}1
	mkfs -t swap ${disk}2
	mkfs -t etx4 ${disk}3
fi
#挂载分区
if [ -d /mnt/boot ]
then
	umount /mnt/boot
	mount /dev/sdb1 /mnt/boot
else
	mkdir /mnt/boot
	mount /dev/sdb1 /mnt/boot
fi

#挂载三分区
if [ -d /mnt/sysroot ]
then
	umount /mnt/sysroot
else
	mkdir /mnt/boot
fi
mount /dev/sdb3 /mnt/sysroot

