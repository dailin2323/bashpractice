#!/bin/bash
#****************************************************
#         Author: dudu   471906904@qq.com
#  Last modified: 2014-12-05 14:36
#       Filename: vim_head.sh
#    Description: 
#	1、脚本使用格式：
#       mkscript.sh [-D|--description "script description"] [-A|--author "script author"] /path/to/somefile
#       2、如果文件事先不存在，则创建；且前几行内容如下所示：
        #!/bin/bash
        # Description: script description
        # Author: script author

# 3、如果事先存在，但不空，且第一行不是“#!/bin/bash”，则提示错误并退出；如果第一行是“#!/bin/ba，则使用vim打开脚本；把光标直接定位至最后一行
#        4、打开脚本后关闭时判断脚本是否有语法错误
#                如果有，提示输入y继续编辑，输入n放弃并退出；
#                如果没有，则给此文件以执行权限；        
#****************************************************
function usage()
{
	echo "usage:`basename $0` [-D|--description string]  [-A|--author script] file" 
}
[  $# != 0 ] && params=${!#}
echo $params
while test $# != 0 
do
	case "$1" in
		-D|--description)
			shift
			case "$1" in
				''|-A|--author)
					echo "丫填个注释先"
					
					exit
				;;
				*)
					[ -d $1 ] && echo "丫是个目录,爷要的是描述啊" && exit
					desc=$1
			esac
		;;
		-A|--author)
			shift
			author="$1"
		;; 
		*)
			echo "none"
		;;
	esac
	shift
done
echo "desc:${desc}"
echo "autor:${author}"
if [ -f $params ] 
then
	head_str=`head -1 $params`
	if [ "$head_str" == "#!/usr/bin" ]
	then
	    vim + $params
	    while true
	    do
		bash -n $params
		[ $? -eq 0 ] && exit
		case $command in
				y)
				vim + $params
				;;
				n)
				exit
				;;
				*)
				read -p "pls input y or n" command
				;;
		esac
	     done
	else
	   echo "sorry,the private file"
	   exit	
	fi
else
cat  << EOF >> $params
#!/usr/bin
#Descption:${desc}
#author:${author}
EOF
fi
