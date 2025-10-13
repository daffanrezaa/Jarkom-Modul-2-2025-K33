# di Tirion
# deklarasi reverse zone
nano /etc/bind/named.conf.local

# tambahin baru di line paling akhir 
zone "3.80.10.in-addr.arpa" {
    type master;
    file "/etc/bind/db.10.80.3"; // Nama file untuk reverse zone
    allow-transfer { 10.80.3.4; }; // Izinkan Valmar menyalin
};

# buat file db.10.80.3 dengan pointer
nano /etc/bind/db.10.80.3

# tambahin baru
$TTL    604800
@       IN      SOA     ns1.K33.com. root.K33.com. (
                        2025101201      ; Serial (NAIKKAN NOMOR INI!)
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
; Name Servers
@       IN      NS      ns1.K33.com.
@       IN      NS      ns2.K33.com.

; PTR Records (IP -> Hostname) untuk segmen DMZ
2       IN      PTR     sirion.K33.com.     ; 10.80.3.2 -> sirion
5       IN      PTR     lindon.K33.com.     ; 10.80.3.5 -> lindon
6       IN      PTR     vingilot.K33.com.   ; 10.80.3.6 -> vingilot

# restart bind9
service bind9 restart

# di Valmar
# deklarasi zona slave
nano /etc/bind/named.conf.local

# tambahin zone baru
zone "3.80.10.in-addr.arpa" {
    type slave;
    file "db.10.80.3";
    masters { 10.80.3.3; };
};

# restart bind9
service bind9 restart


# testing -> flag aa (di salah satu client)
dig -x 10.80.3.2






