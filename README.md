# caddy-cloudflare
Caddy docker image with the following modules :

github.com/caddy-dns/cloudflare

github.com/WeidiDeng/caddy-cloudflare-ip

github.com/caddyserver/transform-encoder

The caddy image is built with non-root user. 

Add the following in your docker-compose.yml to use the privileged ports (80, 443):
cap_add:
   - NET_BIND_SERVICE

docker push gandulf78/caddy-cloudflare-ip:2.8.0-rc.1-alpine
