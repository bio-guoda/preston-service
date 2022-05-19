##
# You should look at the following URL's in order to grasp a solid understanding
# of Nginx configuration files in order to fully unleash the power of Nginx.
# https://www.nginx.com/resources/wiki/start/
# https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/
# https://wiki.debian.org/Nginx/DirectoryStructure
#
# In most cases, administrators will remove this file from sites-enabled/ and
# leave it as reference inside of sites-available where it will continue to be
# updated by the nginx packaging team.
#
# This file will automatically load configuration files provided by other
# applications, such as Drupal or Wordpress. These applications will be made
# available underneath a path with that package name, such as /drupal8.
#
# Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
##

# Virtual Host configuration for example.com
#
# You can move that to a different file under sites-available/ and symlink that
# to sites-enabled/ to enable it.
#
server {

	server_name repo.jhpoelen.nl;

	root /var/lib/preston/archives;
	index index.html;

	location / {
		try_files /gbif-idigbio-biocase/data/$uri /ala/data/$uri /obis/data/$uri /bhl/data/$uri /dataone/data/$uri =404;
	}

        location ~ "/\.well-known/genid/" {
		return 302 https://www.w3.org/TR/rdf11-concepts/#section-skolemization;
	}

	location ~ ".*([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{58}).*" {
            	try_files /gbif-idigbio-biocase/data/$1/$2/$1$2$3 /ala/data/$1/$2/$1$2$3 /obis/data/$1/$2/$1$2$3 /bhl/data/$1/$2/$1$2$3 /dataone/data/$1/$2/$1$2$3 =404;
        }

    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/repo.jhpoelen.nl/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/repo.jhpoelen.nl/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}

server {
    if ($host = repo.jhpoelen.nl) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


	listen 80;
	listen [::]:80;

	server_name repo.jhpoelen.nl;
    return 404; # managed by Certbot


}
