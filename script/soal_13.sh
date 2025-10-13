# buka sirion
nano /etc/nginx/sites-available/sirion.K33.com

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

# restart nginx
nginx -t
service nginx restart

#verifikasi klien lain misal elwing
curl  http://sirion.K33.com/static/

# tes via ip
curl http://10.80.3.2/app/

# tes via nama resmi
curl http://www.K33.com/app/