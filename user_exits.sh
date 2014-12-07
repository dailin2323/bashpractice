#!/bin/bash

function user_exits()
{
	id $1
	if [ $? -eq 0 ]
	then
		uid=$(grep "^$1" /etc/passwd | cut -d: -f 3)
		shell=$(grep "^$1" /etc/passwd | cut -d: -f 7)
		echo "the information of root:"
		echo "shell:$shell"
		echo "UID:$uid"
	else
		echo "this user is not exits"
	fi
}

while (true)
do
	read -p "pls input name:" username
	if [ "$username" == "q"  -o "$username" == "Q" ]
	then
		exit
	else
		user_exits $username
	fi
done
