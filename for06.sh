#!/bin/bash
#****************************************************
#         Author: dudu   471906904@qq.com
#  Last modified: 2014-12-03 21:57
#       Filename: for06.sh
#    Description: 
#1、提示用户输入一个可执行命令；
#2、获取这个命令所依赖的所有库文件(使用ldd命令)；
#3、复制命令至/mnt/sysroot/对应的目录中
#4、复制各库文件至/mnt/sysroot/对应的目录中；
#****************************************************
                target=/mnt/sysroot

                [ -d $target ] || mkdir $target

                preCmd() {
                    if which $1 &> /dev/null; then
                                cmdpath=$(which --skip-alias $1)
                                return 0
                    else
                                echo "No such command."
                                return 1
                    fi
                }

                cmdCopy() {
                    cmddir=$(dirname $cmdpath)
                    [ -d $target/$cmddir ] || mkdir -p $target/$cmddir
                    [ -f $target/$cmdpath ] || cp $1 $target/$cmddir
                    return 0
                }

                libCopy() {
                    for lib in $(ldd $1 | grep -E -o "/[^[:space:]]+"); do
                                libdir=$(dirname $lib)
                                [ -d $target/$libdir ] || mkdir -p $target/$libdir
                                [ -f $target/$lib ] || cp $lib $target/$libdir
                    done
                    return 0
                }

                main() {
                    while true; do
                        read -p "Plz enter a command(quit for quiting): " cmd
                        [ "$cmd" == 'quit' ] && break
                        preCmd $cmd
                        if [ $? -eq 0 ]; then
                                        cmdCopy $cmdpath
                            libCopy $cmdpath
                        fi
                    done
                }

                main
