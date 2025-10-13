#di vingilot
nano /etc/nginx/nginx.conf

#tambahkan akses log format baru di atas access_log
http {
    log_format proxy_format '$http_x_real_ip - $remote_user [$time_local] "$request" '
                            '$status $body_bytes_sent "$http_referer" '
                            '"$http_user_agent"';
}

#cari baris access_log di nano /etc/nginx/sites-available/default dan rubah di bawah ini
access_log /var/log/nginx/access.log proxy_format;

# restart nginx
nginx -t
service nginx restart

#cek verifikasi cth: elwing
curl http://www.K33.com/app/

#periksa di vigilot
cat /var/log/nginx/access.log
#atau bisa  juga
tail -n 1 /var/log/nginx/access.log

