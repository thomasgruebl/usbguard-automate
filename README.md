# usbguard-automate

**Dependencies**
---

```
Install USBguard: sudo ./dependencies.sh

```

**Usage**
---

```
Usage: sudo ./automate_usbguard.sh [OPTIONS]

  Automate and secure USBguard.
  Developed by Thomas Grübl -> (Github: thomasgruebl)

Arguments:
  [1]  -tmp  (Add the tmp flag to add USB devices temporarily (default is permanently)
```

In theory, an attacker with physical access to the unlocked machine could modify the /etc/usbguard/rules.conf file 
since the default permissions are set to -rw------- (read and write access for the user class).
