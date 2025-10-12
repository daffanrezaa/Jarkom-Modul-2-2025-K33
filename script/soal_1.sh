# Config Eonwe (10.80.1.1)
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 10.80.1.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 10.80.2.1
    netmask 255.255.255.0

auto eth3
iface eth3 inet static
    address 10.80.3.1
    netmask 255.255.255.0

# Config Earendil (10.80.1.2)
auto eth0
iface eth0 inet static
    address 10.80.1.2
    netmask 255.255.255.0
    gateway 10.80.1.1
    
# Config Elwing (10.80.1.3)
auto eth0
iface eth0 inet static
    address 10.80.1.3
    netmask 255.255.255.0
    gateway 10.80.1.1

# Config Cirdan (10.80.2.2)
auto eth0
iface eth0 inet static
    address 10.80.2.2
    netmask 255.255.255.0
    gateway 10.80.2.1

# Config Elrond (10.80.2.3)
auto eth0
iface eth0 inet static
    address 10.80.2.3
    netmask 255.255.255.0
    gateway 10.80.2.1

# Config Maglor (10.80.2.4)
auto eth0
iface eth0 inet static
    address 10.80.2.4
    netmask 255.255.255.0
    gateway 10.80.2.1

# Config Sirion (10.80.3.2)
auto eth0
iface eth0 inet static
    address 10.80.3.2
    netmask 255.255.255.0
    gateway 10.80.3.1

# Config Tirion (10.80.3.3)
auto eth0
iface eth0 inet static
    address 10.80.3.3
    netmask 255.255.255.0
    gateway 10.80.3.1

# Config Valmar (10.80.3.4)
auto eth0
iface eth0 inet static
    address 10.80.3.4
    netmask 255.255.255.0
    gateway 10.80.3.1

# Config Lindon (10.80.3.5)
auto eth0
iface eth0 inet static
    address 10.80.3.5
    netmask 255.255.255.0
    gateway 10.80.3.1

# Config Vingilot (10.80.3.6)
auto eth0
iface eth0 inet static
    address 10.80.3.6
    netmask 255.255.255.0
    gateway 10.80.3.1