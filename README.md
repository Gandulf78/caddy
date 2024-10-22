# caddy-cloudflare-ip
Caddy docker image with the following modules :

    github.com/caddyserver/transform-encoder
    github.com/mholt/caddy-webdav
    github.com/tailscale/caddy-tailscale
    

The caddy image is built with non-root user. 

Add NET_BIND_SERVICE in your docker-compose.yml to use the privileged ports (80, 443) 

    docker push gandulf78/caddy:latest
