FROM caddy:2.8.4-builder-alpine AS builder

RUN xcaddy build v2.8.4 \
    --github.com/caddyserver/transform-encoder \
    --github.com/mholt/caddy-webdav \
    --github.com/tailscale/caddy-tailscale
    
FROM caddy:2.8.4-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
