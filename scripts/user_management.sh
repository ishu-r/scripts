#!/bin/bash


function create_user(){
	read -p "enter username:" username

	read -p "Enter password:" password

	sudo useradd -m $username -p password

	echo "user $username created successfully"

}

function delete_user(){
	read -p "enter user to be deleted " username

	sudo userdel -r $username

	echo "user $username deleted successfully"
}
function show_usages(){
	echo "Welcome to user management "
	echo "To create user use c as argument"
	echo "To delete user use d as argument"
}

case "$1" in
	c)
	echo "create user in progress"
	create_user
	;;
	d)
	echo "delete user in progress"
	delete_user
	;;
	*)
		show_usages
	;;


esac

