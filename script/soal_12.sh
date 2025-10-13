# Di Sirion
apt install -y apache2-utils

#buat password
htpasswd -c /etc/nginx/.htpasswd eldeargod

nano /etc/nginx/sites-available/sirion.K33.com

#Tambahkan  di bawah server name
    server {
    listen 80;
    server_name sirion.K33.com www.K33.com;

    #Tambahkan bagian ini saja yang baru
    location /admin/ {
        # Pesan yang akan muncul di jendela login
        auth_basic "Area Terbatas - Masukkan Kredensial Penjaga";

        # Menunjuk ke file password yang kita buat tadi
        auth_basic_user_file /etc/nginx/.htpasswd;

        # Jika login berhasil, teruskan ke Vingilot (sebagai contoh)
        proxy_pass http://10.80.3.6/; # IP Vingilot
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

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

# restart nginx
nginx -t
service nginx restart

#Tes tanpa password
curl  http://www.K33.com/admin/

#Tes dengan password
curl -u eldeargod:messigoat http://www.K33.com/admin/

