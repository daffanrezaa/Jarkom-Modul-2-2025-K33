#Modifikasi Konfigurasi Nginx di Sirion
nano /etc/nginx/sites-available/sirion.K33.com

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

# restart nginx
nginx -t
service nginx restart

# Verifikasi dari kilen lain cth:erlond
curl http://www.K33.com/

# tes halaman lain 
curl http://www.K33.com/static/
curl http://www.K33.com/app/