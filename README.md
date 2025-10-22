## Anggota Kelompok
| No | Nama                       | NRP         | Pembagian Tugas  |
|----|----------------------------|-------------|------------------|
| 1  | Aditya Reza Daffansyah     | 5027241034  | 1 - 10           | 
| 2  | I Gede Bagus Saka Sinatrya |	5027241088  | 11 - 20          | 

# Laporan Resmi Praktikum Jarkom

## Walkthrough Pengerjaan Praktikum Jarkom Modul 2
## Daftar Isi

- [Anggota Kelompok](#anggota-kelompok)
- [Daftar Isi](#daftar-isi)
- [Soal 1](#soal-1)
- [Soal 2](#soal-2)
- [Soal 3](#soal-3)
- [Soal 4](#soal-4)
- [Soal 5](#soal-5)
- [Soal 6](#soal-6)
- [Soal 7](#soal-7)
- [Soal 8](#soal-8)
- [Soal 9](#soal-9)
- [Soal 10](#soal-10)
- [Soal 11](#soal-11)
- [Soal 12](#soal-12)
- [Soal 13](#soal-13)
- [Soal 14](#soal-14)
- [Soal 15](#soal-15)
- [Soal 16](#soal-16)
- [Soal 17](#soal-17)
- [Soal 18](#soal-18)
- [Soal 19](#soal-19)
- [Soal 20](#soal-20)

### Soal 1
Di tepi Beleriand yang porak-poranda, Eonwe merentangkan tiga jalur: Barat untuk Earendil dan Elwing, Timur untuk Círdan, Elrond, Maglor, serta pelabuhan DMZ bagi Sirion, Tirion, Valmar, Lindon, Vingilot. Tetapkan alamat dan default gateway tiap tokoh sesuai glosarium yang sudah diberikan.

- Buat topologi lengkap sesuai permintaan soal, set address dan default gateway tiap client 

```
----- Config Eonwe (10.80.1.1) -----
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
```
```
----- Config Earendil (10.80.1.2) -----
auto eth0
iface eth0 inet static
    address 10.80.1.2
    netmask 255.255.255.0
    gateway 10.80.1.1
```
```    
----- Config Elwing (10.80.1.3) -----
auto eth0
iface eth0 inet static
    address 10.80.1.3
    netmask 255.255.255.0
    gateway 10.80.1.1
```
```
----- Config Cirdan (10.80.2.2) -----
auto eth0
iface eth0 inet static
    address 10.80.2.2
    netmask 255.255.255.0
    gateway 10.80.2.1
```
```
----- Config Elrond (10.80.2.3) -----
auto eth0
iface eth0 inet static
    address 10.80.2.3
    netmask 255.255.255.0
    gateway 10.80.2.1
```
```
----- Config Maglor (10.80.2.4) -----
auto eth0
iface eth0 inet static
    address 10.80.2.4
    netmask 255.255.255.0
    gateway 10.80.2.1
```
```
----- Config Sirion (10.80.3.2) -----
auto eth0
iface eth0 inet static
    address 10.80.3.2
    netmask 255.255.255.0
    gateway 10.80.3.1
```
```
----- Config Tirion (10.80.3.3) -----
auto eth0
iface eth0 inet static
    address 10.80.3.3
    netmask 255.255.255.0
    gateway 10.80.3.1
```
```
----- Config Valmar (10.80.3.4) -----
auto eth0
iface eth0 inet static
    address 10.80.3.4
    netmask 255.255.255.0
    gateway 10.80.3.1
```
```
----- Config Lindon (10.80.3.5) -----
auto eth0
iface eth0 inet static
    address 10.80.3.5
    netmask 255.255.255.0
    gateway 10.80.3.1
```
```
----- Config Vingilot (10.80.3.6) -----
auto eth0
iface eth0 inet static
    address 10.80.3.6
    netmask 255.255.255.0
    gateway 10.80.3.1
```
![topologi](/assets/topologi_modul2_jarkom.png)

### Soal 2
### Soal 3
### Soal 4
### Soal 5
### Soal 6
### Soal 7
### Soal 8
### Soal 9
### Soal 10
### Soal 11
Di muara sungai, Sirion berdiri sebagai reverse proxy. Terapkan path-based routing: /static → Lindon dan /app → Vingilot, sambil meneruskan header Host dan X-Real-IP ke backend. Pastikan Sirion menerima www.<xxxx>.com (kanonik) dan sirion.<xxxx>.com, dan bahwa konten pada /static dan /app di-serve melalui backend yang tepat.

Pertama kita bisa masuk ke Sirion menggunakan IP ataupun langsung melalui console, kemudian dapat melakukan update dan install terlebih dahulu dengan command seperti di bawah ini
```bash
apt update && apt install -y nginx
```

Setelah itu kita dapat masuk ke sript `nano /etc/nginx/sites-available/sirion.K33.com`, pada script tersebut kita dapat menambahkan kode seperti di bawah ini. Atau jika ingin kode tetap ada dan tidak perlu memasukkan secara manual bisa menambahkan di root `/root/.bashrc`.
```bash
cat <<EOF > /etc/nginx/sites-available/sirion.K33.com
server {
    listen 80;
    server_name sirion.K33.com www.K33.com;

    # default vingilot
    location / {
        proxy_pass http://10.80.3.6; # <-- IP Vingilot

        # Meneruskan header penting ke backend
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # /static -> arahkan ke Lindon
    location /static/ {
        proxy_pass http://10.80.3.5/;       # IP Lindon
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # /app -> arahkan ke Vingilot
    location /app/ {
        proxy_pass http://10.80.3.6/;       # IP Vingilot
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

}
EOF
```

Selanjutnya kita dapat melakukan konfigurasi terlebih dahulu
```bash
ln -s /etc/nginx/sites-available/sirion.K33.com /etc/nginx/sites-enabled/
```

Setelah itu kita melakukan restart pada nginx
```bash
nginx -t
```
```bash
service nginx restart
```

Nah langkah yang terakhir kita melakukan test verifikasi dari klien lain (selain sirion)
- Tes ke path /static/
```bash
curl http://www.K33.com/static/
```
- Tes ke path /app/
```bash
curl  http://www.K33.com/app/
```
Berikut hasilnya
![TesPath](assets/11_cek_elwing.png)

Kemudian kita lakukan juga test dari Sirion langsung 
```bash
curl http://sirion.K33.com/static/
```
```bash
curl http://sirion.K33.com/app/
```
Berikut hasilnya
![TesSirion](assets/11_cek_sirion.png)

### Soal 12
Ada kamar kecil di balik gerbang yakni /admin. Lindungi path tersebut di Sirion menggunakan Basic Auth, akses tanpa kredensial harus ditolak dan akses dengan kredensial yang benar harus diizinkan.

Pertama kita masuk ke Sirion terlebih dahulu dan melakukan install
```bash
apt install -y apache2-utils
```

Selanjutnya kita bisa membuat password sesuai keinginan kita 
```bash
htpasswd -c /etc/nginx/.htpasswd eldeargod
```

Setelah itu kita masuk kemabli ke `nano /etc/nginx/sites-available/sirion.K33.com` dan masukkan kode di bawah ini setelah `server_name`
```bash
 location /admin/ {
    # Pesan yang akan muncul di jendela login
    auth_basic "Area Terbatas - Masukkan Kredensial Penjaga";

    # Menunjuk ke file password yang kita buat tadi
    auth_basic_user_file /etc/nginx/.htpasswd;

    # Jika login berhasil, teruskan ke Vingilot 
    proxy_pass http://10.80.3.6/; # IP Vingilot
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
}
```

Setelah memasukkan kode tersebut kita dapat melakukan restart terlebih dahulu
```bash
nginx -t
```
```bash
service nginx restart
```
![setup12](assets/12_setup_sirion.png)

Kemudian kita bisa mencoba tes masuk tanpa password
```bash
curl  http://www.K33.com/admin/
```

Dan yang terakhir kita tes masuk dengan password
```bash
curl -u eldeargod:messigoat http://www.K33.com/admin/
```

Berikut hasilnya
![cekPass](assets/12_cekpass.png)

### Soal 13
“Panggil aku dengan nama,” ujar Sirion kepada mereka yang datang hanya menyebut angka. Kanonisasikan endpoint, akses melalui IP address Sirion maupun `sirion.<xxxx>.com` harus redirect 301 ke `www.<xxxx>.com` sebagai hostname kanonik.

Pertama kita bisa masuk ke Sirion dan buka script `nano /etc/nginx/sites-available/sirion.K33.com` dan kita tambahkan kode berikut 
```bash
# Tambahkan panggilan tidak resmi
server {
    listen 80;
    server_name sirion.K33.com 10.80.3.2;
    return 301 http://www.K33.com$request_uri;
}

#panggilan resmi
server {
    listen 80;
    server_name www.K33.com;

    location /admin/ {
        auth_basic "Area Terbatas - Masukkan Kredensial Penjaga";
        auth_basic_user_file /etc/nginx/.htpasswd;
        proxy_pass http://10.80.3.6/; # IP Vingilot
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location / {
        proxy_pass http://10.80.3.6; # IP Vingilot
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /static/ {
        proxy_pass http://10.80.3.5/; # IP Lindon
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /app/ {
        proxy_pass http://10.80.3.6/; # IP Vingilot
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

Setelah itu kita bisa melakukan restart pada nginx dan selanjutnya kita bisa mencoba verifikasi menggunakan klien lain
```bash
curl  http://sirion.K33.com/static/
```
Selain itu kita juga melakukan test dengan nama IP dan nama resminya
```bash
# tes via ip
curl http://10.80.3.2/app/

# tes via nama resmi
curl http://www.K33.com/app/
```

Berikut hasilnya
![hasil13](assets/13_hasilcek.png)

### Soal 14
Di Vingilot, catatan kedatangan harus jujur. Pastikan access log aplikasi di Vingilot mencatat IP address klien asli saat lalu lintas melewati Sirion (bukan IP Sirion).

Pertama kita bisa masuk ke Vingilot dan buka script `nano /etc/nginx/nginx.conf` untuk menambahkan akses log format baru dengan kode di bawah ini
```bash
#tambahkan akses log format baru di atas access_log
http {
    log_format proxy_format '$http_x_real_ip - $remote_user [$time_local] "$request" '
                            '$status $body_bytes_sent "$http_referer" '
                            '"$http_user_agent"';
}
```

Kemudian kita buka `nano /etc/nginx/sites-available/default` dan cari baris access_log dan rubah menggunakan kode di bawah ini
```bash
access_log /var/log/nginx/access.log proxy_format;
```

Selanjutnya kita dapat melakukan restart pada nginx dan kemudian kita dapat melakukan verifikasi menggunakan klien lain serta verifikasi melalui Vingilot juga
```bash
#cek verifikasi kilen lain
curl http://www.K33.com/app/

#periksa di vigilot
cat /var/log/nginx/access.log
#atau bisa  juga
tail -n 1 /var/log/nginx/access.log
```

Berikut hasilnya
![log14](assets/14_hasil.png)

### Soal 15
Pelabuhan diuji gelombang kecil, salah satu klien yakni Elrond menjadi penguji dan menggunakan ApacheBench (ab) untuk membombardir `http://www.<xxxx>.com/app/` dan `http://www.<xxxx>.com/static/` melalui hostname kanonik. Untuk setiap endpoint lakukan 500 request dengan concurrency 10, dan rangkum hasil dalam tabel ringkas.

Pertama kita bisa membuka Elrond dan melakukan install
```bash
apt update && apt install -y apache2-utils
```

Selanjutnya kita dapat melakukan uji endpoint statis dan dinamis 
```bash
# uji endpoint statis (/static)
ab -n 500 -c 10 http://www.K33.com/static/

# uji endpoint dinamis (/app)
ab -n 500 -c 10 http://www.K33.com/app/
```

Hasil uji dinamis
![dinamis](assets/15_uji_dinamis_elrond.png)

Hasil uji statis 
![statis](assets/15_uji_statis_elrond.png)

### Soal 16
Badai mengubah garis pantai. Ubah A record lindon.<xxxx>.com ke alamat baru (ubah IP paling belakangnya saja agar mudah), naikkan SOA serial di Tirion (ns1) dan pastikan Valmar (ns2) tersinkron, karena static.<xxxx>.com adalah CNAME → lindon.<xxxx>.com, seluruh akses ke static.<xxxx>.com mengikuti alamat baru, tetapkan TTL = 30 detik untuk record yang relevan dan verifikasi tiga momen yakni sebelum perubahan (mengembalikan alamat lama), sesaat setelah perubahan namun sebelum TTL kedaluwarsa (masih alamat lama karena cache), dan setelah TTL kedaluwarsa (beralih ke alamat baru).

Pertama buka Tirion dan buka `nano /etc/bind/K33.com` kemudian tambahkan kode ini
```bash
#rubah record lindon dan tambahkan ttl 30
lindon      30      IN      A       10.80.3.5
```

Kemudian kita dapat melakukan restart pada bind. Dan kemudian sebelum perubahan kita bisa mengecek terlebih dahulu alamat staticnya menggunakan klien lain.
```bash
#Sebelum perubahan
#Gunakan dig untuk menanyakan alamat static.K33.com. dig akan menunjukkan TTL.
dig static.K33.com
```

Kemudian saat perbuhan kita melakukan edit pada ipnya
```bash
#saat perubahan
#di lindon
# Hapus alamat IP lama
ip addr del 10.80.3.5/24 dev eth0
# Tambahkan alamat IP baru
ip addr add 10.80.3.55/24 dev eth0
```

Kemudian buka lagi Tirion dan buka `nano /etc/bind/K33.com` dan ubah ip lindon ke yang baru \
```bash
#Ubah IP lindon ke yang baru:
lindon      30      IN      A       10.80.3.55
```

Setelah itu lakukan restart dan langsung pindah ke klien lain untuk mengecek perubahan sebelum 30 detik
```bash
dig static.K33.com
```
Kemudian bisa jalankan lagi jika di rasa sudah melewati 30 detik dan yang terakhir lakukan verifikasi di valmar 
```bash
dig @localhost lindon.K33.com
```

### Soal 17
Andaikata bumi bergetar dan semua tertidur sejenak, mereka harus bangkit sendiri. Pastikan layanan inti bind9 di ns1/ns2, nginx di Sirion/Lindon, dan PHP-FPM di Vingilot autostart saat reboot, lalu verifikasi layanan kembali menjawab sesuai fungsinya.

### Soal 18
Sang musuh memiliki banyak nama. Tambahkan `melkor.<xxxx>.com` sebagai record TXT berisi “Morgoth (Melkor)” dan tambahkan `morgoth.<xxxx>.com` sebagai `CNAME → melkor.<xxxx>.com`, verifikasi query TXT terhadap melkor dan bahwa query ke morgoth mengikuti aliasnya.

Pertama kita masuk ke Tirion dan buka script `nano /etc/bind/K33.com`, kemudian kita tambahkan kode di bawah ini
```bash
melkor      IN      TXT     "Morgoth (Melkor)"
morgoth     IN      CNAME   melkor
```

Setelah itu kita bisa melakukan restart pada bind dan setelah itu kita bisa melakukan verifikasi dengan klien lain
```bash
#verifikasi txt di erlond
dig melkor.K33.com TXT

#verifikasi morgoth di elrond
dig morgoth.K33.com
```

Hasil dari verifikasi morgoth
![morgoth](assets/18_cekmorgoth.png)

Hasil dari verifikasi txt
![txt](assets/18_cektxt.png)

### Soal 19
Pelabuhan diperluas bagi para pelaut. Tambahkan havens.<xxxx>.com sebagai CNAME → www.<xxxx>.com, lalu akses layanan melalui hostname tersebut dari dua klien berbeda untuk memastikan resolusi dan rute aplikasi berfungsi.

Pertama kita masuk ke Tirion dan buka script `nano /etc/bind/K33.com` dan kita tambahkan CNAME dengan kode di bawah ini
```bash
havens      IN      CNAME   www`
```

Setelah itu kita bisa melakukan restart pada bind dan melakukan verifikasi dengan dua klien yang berbeda
```bash
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
```

Berikut hasilnya di elrond
![curl](assets/19_curlHavens.png)
![dig](assets/19_digHavens.png)

### Soal 20
Kisah ditutup di beranda Sirion. Sediakan halaman depan bertajuk “War of Wrath: Lindon bertahan” yang memuat tautan ke /app dan /static. Pastikan seluruh klien membuka beranda dan menelusuri kedua tautan tersebut menggunakan hostname (mis. www.<xxxx>.com), bukan IP address.

Pertama kita masuk ke Sirion dan buka script `nano /etc/nginx/sites-available/sirion.K33.com` untuk melakukan modifikasi konfigurasi nginx dan kita tambahkan kode di bawah ini
```bash
# Tambahkan pada BLOK 2: UNTUK PANGGILAN RESMI (KANONIK)
server {
    listen 80;
    server_name www.K33.com;

    # --- (BARU) HALAMAN DEPAN KHUSUS UNTUK SOAL 20 ---
    # Tanda '=' memastikan ini hanya cocok untuk halaman root (homepage)
    location = / {
        # Mengembalikan kode 200 (OK) dan konten HTML
        return 200 '
        <html>
            <head>
                <title>War of Wrath</title>
            </head>
            <body style="font-family: sans-serif; background-color: #f4f4f4; padding: 2em;">
                <h1>War of Wrath: Lindon bertahan</h1>
                <p>Kisah-kisah dari Beleriand dapat diakses melalui tautan berikut:</p>
                <ul>
                    <li><a href="/static/">Telusuri Arsip Statis di Lindon</a></li>
                    <li><a href="/app/">Dengarkan Kisah Dinamis dari Vingilot</a></li>
                </ul>
            </body>
        </html>';
        # Memberitahu browser bahwa ini adalah konten HTML
        add_header Content-Type text/html;
    }
```

Kemudian kita bisa melakukan restart pada nginx dan melakukan verifikasi dengan klien lain
```bash
# Verifikasi dari kilen lain cth:erlond
curl http://www.K33.com/

# tes halaman lain 
curl http://www.K33.com/static/
curl http://www.K33.com/app/
```


