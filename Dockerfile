# Étape de construction
FROM caddy:2.8.4-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddyserver/transform-encoder \
    --with github.com/mholt/caddy-webdav \
    --with github.com/tailscale/caddy-tailscale
    
# Étape finale
FROM caddy:2.8.4-alpine

# Copier l'exécutable Caddy personnalisé depuis l'étape de construction
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
