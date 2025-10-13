# di elrond
apt update && apt install -y apache2-utils

# uji endpoint statis (/static)
ab -n 500 -c 10 http://www.K33.com/static/

# uji endpoint dinamis (/app)
ab -n 500 -c 10 http://www.K33.com/app/

