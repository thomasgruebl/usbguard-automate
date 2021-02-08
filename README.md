# usbguard-automate

**Dependencies**
---

```
Install usbguard: sudo ./dependencies.sh

```

**Usage**
---

```
Usage: sudo ./automate_usbguard.sh [OPTIONS]

  Automate and secure USBguard.
  Developed by Thomas Grübl -> (Github: thomasgruebl)

Arguments:
  [1]  -tmp  Add the tmp flag to add USB devices temporarily (default is permanently)
```

**Description**
---

usbguard is an open-source tool that allows users to generate USB device policies tailoired to the device ID, name, serial number and hashes.

**Background**
---

####Automation####

When plugging in a new USB device, usbguard requires you to either (1) add the device temporarily using the *allow-device* option or (2) permanently by using the
*append-rule* option or the *-p* flag with *allow-device*.
This process involves looking up the device ID for every new USB device and adding the new ID subsequently - this can get quite annoying over time.

By using this script you just need to plug in the device, run the script and enter your user password.

####Security####

In theory, an attacker with physical access to the unlocked machine could modify the /etc/usbguard/rules.conf file 
since the default permissions are set to -rw------- (read and write access for the user class).

Hence, after installing usbguard, the /etc/usbguard/rules.conf file permissions are automatically set to 000 and are only changed back 
while writing to the file in the *add_permanently* function in *automate_usbguard.sh*.
