# di Tirion tambahkan alamat untuk setiap host
nano /etc/bind/K33.com 

# ubah version jadi 2
# tambahkan hostname server dan client di line terakhir
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

# restart bind9
service bind9 restart

# di Elwing tes ping
ping cirdan
ping cirdan.K33.com
ping elrond.K33.com
