#di tirion
nano /etc/bind/K33.com

#tambahkan paling bawah
#naikkan nomor seri setiap melakukan perubahan
melkor      IN      TXT     "Morgoth (Melkor)"
morgoth     IN      CNAME   melkor

# restart bind
service bind9 restart

#verifikasi txt di erlond
dig melkor.K33.com TXT

#verifikasi morgoth di elrond
dig morgoth.K33.com