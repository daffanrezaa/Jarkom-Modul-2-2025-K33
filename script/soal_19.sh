#di tirion
nano /etc/bind/K33.com

#bagian paling bawah file, dan tambahkan satu baris baru untuk CNAME havens.
#setiap perubahan selalu rubah nomor serial
havens      IN      CNAME   www

# restart bind
service bind9 restart

#Verifikasi Resolusi DNS
#di erlond
dig havens.K33.com

#Verifikasi Rute Aplikasi
curl http://havens.K33.com/

#Verifikasi Resolusi DNS
#di elwing
dig havens.K33.com

#Verifikasi Rute Aplikasi
curl http://havens.K33.com/