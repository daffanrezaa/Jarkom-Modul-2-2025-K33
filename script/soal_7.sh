# version 3
# di Tirion, tambahin di /etc/bind/K33.com

nano /etc/bind/K33.com

# memastikan A record dan Canonical NAME record baru
www       IN    CNAME   sirion.K33.com.
static    IN    CNAME   lindon.K33.com.
app       IN    CNAME   vingilot.K33.com.

# restart bind
service bind9 restart

# tes dari Erarendil
# www cname ke sirion -> ke IP 10.80.3.2
dig www.K33.com

# tes alias static (IP Lindon)
ping -c 2 static.K33.com

# tes alias app (IP Vingilot)
ping -c 2 app.K33.com


# tes dari Cirdan
# tes alias www (menujukkan alias dan IP)
host www.K33.com

# tes alias static (menujukkan alias dan IP)
host static.K33.com

# tes alias app (menujukkan alias dan IP)
host app.K33.com

