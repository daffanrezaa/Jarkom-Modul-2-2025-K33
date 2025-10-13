# di vingilot
apt update && apt install nginx php8.4-fpm -y

# buat direktori
mkdir -p /var/www/app.K33.com/html

# Buat file beranda (index.php)
echo "<?php echo '<h1>Vingilot Berlayar!</h1><p>Ini adalah halaman utama dinamis yang disajikan oleh PHP.</p><p>Kunjungi <a href=\"/about\">halaman tentang kami</a>.</p>'; ?>" > /var/www/app/index.php

# Buat file about.php
echo '<h1>Tentang Kapal Vingilot</h1><p>Tanggal server saat ini adalah: <?php echo date("Y-m-d H:i:s"); ?></p>' > /var/www/app.K33.com/about.php

# file konfigurasi nginx
nano /etc/nginx/sites-available/app.K33.com
server {
    listen 80;
    server_name app.K33.com;
    root /var/www/app.K33.com/html;
    index index.php;

    # Aturan rewrite untuk menghilangkan .php dari /about
    # Jika ada request untuk /about, Nginx akan secara internal mengambil /about.php
    rewrite ^/about$ /about.php last;

    location / {
        try_files $uri $uri/ =404;
    }

    # Blok ini memberitahu Nginx untuk meneruskan semua file
    # yang berakhiran .php ke socket PHP-FPM untuk diproses
    location ~ .php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }
}

# aktifkan konfigurasi situs
ln -s /etc/nginx/sites-available/app.K33.com /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default 

# restart nginx dan php
nginx -t
service php8.4-fpm restart
service nginx restart

# tes webpage
curl http://app.k33.com/
curl http://app.k33.com/about.php
curl http://app.k33.com/about