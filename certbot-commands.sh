##Step -2


##Run the staging command for issuing a new certificate:##

sudo docker run -it --rm \
-v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /docker/letsencrypt-docker-nginx/src/letsencrypt/letsencrypt-site:/data/letsencrypt \
-v "/docker-volumes/var/log/letsencrypt:/var/log/letsencrypt" \
certbot/certbot \
certonly --webroot \
--register-unsafely-without-email --agree-tos \
--webroot-path=/data/letsencrypt \
--staging \
-d example.com -d www.example.com


# Map 4 volumes from the server to the Certbot Docker Container:
# =>  The Let's Encrypt Folder where the certificates will be saved
# =>  Lib folder
# =>  Map our html and other pages in our site folder to the data folder that let's encrypt will use for challenges , 
#     i.e wordpress voulume path
# =>  Map a logging path for possible troubleshooting if needed


#--------------------------------------------------------------------------------------------------------------------------------

#You can also get some additional information about certificates for your domain by running the Certbot certificates command:

sudo docker run --rm -it --name certbot \
-v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /docker/letsencrypt-docker-nginx/src/letsencrypt/letsencrypt-site:/data/letsencrypt \
certbot/certbot \
--staging \
certificates

#--------------------------------------------------------------------------------------------------------------------------------
# First, clean up staging artifacts:

sudo rm -rf /docker-volumes/

#--------------------------------------------------------------------------------------------------------------------------------

# And then request a production certificate: (note that it's a good idea to supply your email address so 
# that Let's Encrypt can send expiry notifications)

sudo docker run -it --rm \
-v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /docker/letsencrypt-docker-nginx/src/letsencrypt/letsencrypt-site:/data/letsencrypt \
-v "/docker-volumes/var/log/letsencrypt:/var/log/letsencrypt" \
certbot/certbot \
certonly --webroot \
--email youremail@domain.com --agree-tos --no-eff-email \
--webroot-path=/data/letsencrypt \
-d example.com -d www.example.com