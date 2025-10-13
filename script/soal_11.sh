# di sirion
apt update && apt install -y nginx

# Tambahkan sript

nano /etc/nginx/sites-available/sirion.K33.com
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


#konfigurasi
ln -s /etc/nginx/sites-available/sirion.K33.com /etc/nginx/sites-enabled/

# restart nginx
nginx -t
service nginx restart


# Verifikasi akses klien lain
# Tes ke path /static/
curl http://www.K33.com/static/

# Tes ke path /app/
curl  http://www.K33.com/app/

# Tes langsung ke Sirion
curl http://sirion.K33.com/static/
curl http://sirion.K33.com/app/