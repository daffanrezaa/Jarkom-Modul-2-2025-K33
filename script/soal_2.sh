# di Eonwe 
apt update && apt install iptables
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.80.0.0/16