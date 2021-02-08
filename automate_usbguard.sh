#!/bin/bash

# read all IDs from detected USB devices into array using lsusb
id=$(sudo lsusb | grep -oP '(?<=ID )[^ ]*')
id=($id)

# read all names into array
name=$(sudo lsusb | sed 's/.*://' | cut -c6-)
readarray -t name <<<"$name"

# detect any blocked devices using usbguard list-devices
blocked=$(sudo usbguard list-devices | grep -o -P '.{0,4}block' | grep -o '^[^:]*')
blocked=($blocked)

# if "-tmp" flag is set this function will temporarily add the blocked device
add_temporarily() {
	if [ -z "$blocked" ]; then
		echo "No blocked devices found."
		exit
	fi

	for i in "${!blocked[@]}"
	do
		sudo usbguard allow-device ${blocked[$i]}
		echo "Added device ${blocked[$i]} temporarily!"
	done
}

# if "-tmp" flag is not set, this function will permanently add the blocked device
add_permanently() {
	sudo chmod 600 /etc/usbguard/rules.conf

	for i in "${!id[@]}"
	do
		if ! grep -q "allow id ${id[$i]}" /etc/usbguard/rules.conf; then
			# matching both ID and name (doesn't always work)
			# sudo echo "allow id ${id[$i]} serial '' name ${name[$i]}" >> /etc/usbguard/rules.conf
			# matching ID only
			sudo echo "allow id ${id[$i]}" >> /etc/usbguard/rules.conf
			echo "Added device ${id[$i]} permanently on all ports!"
		fi
	done

	sudo systemctl restart usbguard 

	sudo chmod 400 /etc/usbguard/rules.conf
}

case "$1" in
	-tmp)
		add_temporarily
		;;

	*)
		add_permanently
		;;
esac
