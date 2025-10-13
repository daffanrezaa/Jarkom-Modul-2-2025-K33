# di Tirion tambahkan alamat untuk setiap host
# version 1
nano /etc/bind/K33.com 

# /root/.bashrc
cat <<EOF > /etc/bind/K33.com
; -----  ADD HOSTNAME DI SINI -----
; Hostname Klien
earendil  IN    A       10.80.1.2
elwing    IN    A       10.80.1.3
cirdan    IN    A       10.80.2.2
elrond    IN    A       10.80.2.3
maglor    IN    A       10.80.2.4

; Hostname Server
sirion    IN    A       10.80.3.2
lindon    IN    A       10.80.3.5
vingilot  IN    A       10.80.3.6
EOF
# masukin ke line paling bawah /etc/bin/K33.com


# restart bind9
service bind9 restart

# di Elwing
cat <<EOF > /etc/resolv.conf
search K33.com
nameserver 10.80.3.3
nameserver 10.80.3.4
nameserver 192.168.122.1
EOF

# tes ping
ping cirdan
ping cirdan.K33.com
ping elrond.K33.com
