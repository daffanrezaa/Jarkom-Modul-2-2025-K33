# version 3
# tambahkan di /etc/bind/K33.com
# naikin nomor serial di tanggal yang statis
nano /etc/bind/K33.com

# tambahin di line paling bawah
eonwe     IN    A       10.80.3.1
tirion    IN    CNAME   ns1.K33.com.
valmar    IN    CNAME   ns2.K33.com.

# restart bind9
service bind9 restart

# di mana aja -> misal Elwing
dig @valmar.K33.com K33.com SOA
# perhatikan nomor serialnya

# di Tirion
dig @tirion.K33.com K33.com SOA
# perhatikan nomor serialnya