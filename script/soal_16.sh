# di tirion
nano /etc/bind/K33.com

#rubah record lindon dan tambahkan ttl 30
#rubah nomor serial untuk menandakan perubahan
lindon      30      IN      A       10.80.3.5

# restart bind9
service bind9 restart

#Sebelum perubahan
#buka elrond
#Gunakan dig untuk menanyakan alamat static.K33.com. dig akan menunjukkan TTL.
dig static.K33.com

#saat perubahan
#di lindon
# Hapus alamat IP lama
ip addr del 10.80.3.5/24 dev eth0
# Tambahkan alamat IP baru
ip addr add 10.80.3.55/24 dev eth0

#di konsol tirion
nano /etc/bind/K33.com

#Ubah IP lindon ke yang baru:
lindon      30      IN      A       10.80.3.55
#naikkan nomor serial 

# restart bind9
service bind9 restart

# di elrond
# Selama belum lewat 30 detik sejak dig pertama, jalankan lagi: (kadaluarsa jika lebih dari waktu itu)
dig static.K33.com

#verifikasi valmar
dig @localhost lindon.K33.com

