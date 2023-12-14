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

proxy_cache_path /var/cache/preston levels=1:2 keys_zone=STATIC:10m max_size=64g inactive=13w use_temp_path=off;

server {

    server_name repo.jhpoelen.nl deeplinker.bio linker.bio;

    root /var/lib/preston/archives;
    index index.html;

    merge_slashes off;

    proxy_buffering on;
    # see https://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_max_temp_file_size
    proxy_max_temp_file_size 0;

    proxy_read_timeout 1h;

    location ~ "/\.well-known/genid/" {
        limit_except GET {
          deny all;
        }
	return 302 https://www.w3.org/TR/rdf11-concepts/#section-skolemization;
    }

    # possibly a sha256 hash in hex notation
    location ~ "(hash://sha256/){0,1}([0-9a-f]{64})" {
        limit_except GET OPTIONS {
           deny all;
         }

        add_header 'Access-Control-Allow-Origin' '*' always;
        add_header 'Access-Control-Allow-Methods' 'GET, OPTIONS' always;
        add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range' always;
        add_header 'Access-Control-Expose-Headers' 'Content-Length,Content-Range' always;

        rewrite "(.*)(hash://sha256/){0,1}([0-9a-f]{64})([.][a-zA-Z0-9]+){0,1}(.*)$" $1$2$3$5 break; 
        proxy_pass http://localhost:8082;
        proxy_cache STATIC;
	proxy_cache_valid 200 5y;
        add_header 'X-Proxy-Cache' $upstream_cache_status;
    }
    
    # possibly a sha1 hash in hex notation
    location ~ "(hash://sha1/){0,1}([0-9a-f]{40})" {
        limit_except GET OPTIONS {
           deny all;
        }

        add_header 'Access-Control-Allow-Origin' '*' always;
        add_header 'Access-Control-Allow-Methods' 'GET, OPTIONS' always;
        add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range' always;
        add_header 'Access-Control-Expose-Headers' 'Content-Length,Content-Range' always;

        rewrite "(.*)(hash://sha1/){0,1}([0-9a-f]{40})([.][a-zA-Z0-9]+){0,1}(.*)$" $1$2$3$5 break; 
        proxy_pass http://localhost:8083;
        proxy_cache STATIC;
        proxy_cache_valid 200 5y;
        add_header 'X-Proxy-Cache' $upstream_cache_status;
    }

    # possibly a md5 hash in hex notation
    location ~ "(hash://md5/){0,1}([0-9a-f]{32})" {
        limit_except GET OPTIONS {
           deny all;
        }

        add_header 'Access-Control-Allow-Origin' '*' always;
        add_header 'Access-Control-Allow-Methods' 'GET, OPTIONS' always;
        add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range' always;
        add_header 'Access-Control-Expose-Headers' 'Content-Length,Content-Range' always;

        rewrite "(.*)(hash://md5/){0,1}([0-9a-f]{32})([.][a-zA-Z0-9]+){0,1}(.*)$" $1$2$3$5 break; 
        proxy_pass http://localhost:8081;
        proxy_cache STATIC;
        proxy_cache_valid 200 5y;
        add_header 'X-Proxy-Cache' $upstream_cache_status;
    }

    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/deeplinker.bio/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/deeplinker.bio/privkey.pem; # managed by Certbot
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
