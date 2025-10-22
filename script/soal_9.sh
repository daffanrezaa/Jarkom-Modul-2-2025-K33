# di Lindon
apt update && apt install nginx -y

# buat direktori
mkdir -p /var/www/static.K33.com/html/annals
echo '<h1>Personne ne naît grand cuisinier, on le devient en pratiquant.</h1>' > /var/www/static.K33.com/html/index.html

touch /var/www/static.K33.com/html/annals/jarkom_asik.txt
touch /var/www/static.K33.com/html/annals/jarkom_mengurangi_lifespan.txt

# konfigurasi untuk static.K33.com
nano /etc/nginx/sites-available/static.K33.com

server {
    # Nginx akan mendengarkan di port 80 (HTTP)
    listen 80;
    server_name static.K33.com;
    # Direktori utama tempat file-file situs berada
    root /var/www/static.K33.com/html;

    # File yang akan disajikan jika user mengakses direktori (misal /)
    index index.html;

    # Konfigurasi umum untuk menangani request
    location / {
        try_files \$uri \$uri/ =404;
    }

    # Konfigurasi KHUSUS untuk folder /annals/
    location /annals/ {
        # Aktifkan directory listing!
        autoindex on;
    }
}

# Buat link untuk mengaktifkan situs
ln -s /etc/nginx/sites-available/static.K33.com /etc/nginx/sites-enabled/static.K33.com

# (Opsional tapi direkomendasikan) Hapus link default agar tidak ada konflik
rm /etc/nginx/sites-enabled/default

# restart nginx
nginx -t
service nginx restart

# akses web di client lain
curl http://static.K33.com
curl http://static.K33.com/annals/

