# Étape de construction
FROM caddy:2.8.4-builder-alpine AS builder

# Installer xcaddy
RUN go install --x github.com/caddyserver/xcaddy/cmd/xcaddy@latest

RUN xcaddy build \
    --github.com/caddyserver/transform-encoder \
    --github.com/mholt/caddy-webdav \
    --github.com/tailscale/caddy-tailscale
    
# Étape finale
FROM caddy:2.8.4-alpine

# Copier l'exécutable Caddy personnalisé depuis l'étape de construction
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
