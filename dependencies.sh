sudo apt-get install -y usbguard
sudo usbguard generate-policy > rules.conf
sudo install -m 0600 -o root -g root rules.conf /etc/usbguard/rules.conf
sudo systemctl restart usbguard