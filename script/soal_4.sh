# di Tirion (ns1 - Master DNS)
apt update && apt install bind9 -y

# jalankan command untuk menjalankan bind9
ln -s /etc/init.d/named /etc/init.d/bind9

# edit file untuk menambahkan forwarder dan izin transfer ke Valmar
nano /etc/bind/named.conf.options

# masukin ke /root/.bashrc
cat <<EOF > /etc/bind/named.conf.options
options {
        directory "/var/cache/bind";
        dnssec-validation auto; 

        listen-on-v6 { any; };

        forwarders {
                192.168.122.1; 
        };
        allow-query { any; };
};
EOF

# daftarkan K33.com di file
nano /etc/bind/named.conf.local

# masukin ke /root/.bashrc 
cat <<EOF > /etc/bind/named.conf.local
zone "K33.com" {
    type master;
    file "/etc/bind/K33.com";
    
    allow-transfer { 10.80.3.4; };
};
EOF


nano /etc/bind/K33.com
# jangan masukin ke /root/.bashrc
$TTL    604800
@       IN      SOA     ns1.K33.com. root.K33.com. (
                        2025101201
                              ; Serial (Gunakan YYYYMMDDNN)
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;

; Name Servers (NS Records)
@       IN      NS      ns1.K33.com.
@       IN      NS      ns2.K33.com.

; A Records
@       IN      A       10.80.3.2       ; K33.com -> Sirion
ns1     IN      A       10.80.3.3       ; ns1 -> Tirion
ns2     IN      A       10.80.3.4       ; ns2 -> Valmar
www     IN      A       10.80.3.2       ; www -> Sirion


# masukin ke /root/.bashrc
cat <<EOF > /etc/resolv.conf
search K33.com
nameserver 10.80.3.3
nameserver 10.80.3.4
nameserver 192.168.122.1
EOF

# restart service bind9
service bind9 restart

# di Valmar
apt update && apt install bind9 -y

# jalankan command untuk menjalankan bind9
ln -s /etc/init.d/named /etc/init.d/bind9

# edit local di Valmar
nano /etc/bind/named.conf.local

cat <<EOF > /etc/bind/named.conf.local
zone "K33.com" {
    type slave;
    file "K33.com";
    masters { 10.80.3.3; };
};
EOF

# masukin ke /root/.bashrc
cat <<EOF > /etc/resolv.conf
search K33.com
nameserver 10.80.3.3
nameserver 10.80.3.4
nameserver 192.168.122.1
EOF

# restart service bind9
service bind9 restart

# untuk pengecekan:
ping K33.com