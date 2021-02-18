sudo apt-get install -y usbguard
usbguard generate-policy > rules.conf
install -m 0000 -o root -g root rules.conf /etc/usbguard/rules.conf
systemctl restart usbguard
