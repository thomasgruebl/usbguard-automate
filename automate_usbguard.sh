#!/bin/bash

sudo chmod 600 testrules.conf

id=$(sudo lsusb | grep -oP '(?<=ID )[^ ]*')
id=($id)

name=$(sudo lsusb | sed 's/.*://' | cut -c6-)
readarray -t name <<<"$name"

for i in "${!id[@]}"
do
        if ! grep -q "allow id ${id[$i]}" /etc/usbguard/rules.conf; then
                # matching both ID and name (doesn't always work)
                # sudo echo "allow id ${id[$i]} serial '' name ${name[$i]} via port '1-2'" >> /etc/usbguard/rules.conf
                # matching ID only
                sudo echo "allow id ${id[$i]}" >> /etc/usbguard/rules.conf
        fi
done

echo "reject via-port '1-2'" >> testrules.conf

sudo systemctl restart usbguard 

sudo chmod 400 testrules.conf



#echo 'allow id $foo \n' >> /etc/usbguard/rules.conf

#"allow $id serial "" name $name via-port "1-2"
#reject via-port "1-2""

#maybe chmod /etc/usbguard/rules.conf in order to authenticate then chmod back

#e.g.

#chmod 777 /etc/usbguard/rules.conf

#chmod 000 /etc/usbguard/rules.conf

