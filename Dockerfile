# Étape de construction
FROM caddy:2.8.4-builder-alpine AS builder

# Installer xcaddy
RUN go install --x github.com/caddyserver/xcaddy/cmd/xcaddy@latest

RUN xcaddy build v2.8.4 \
    --github.com/caddyserver/transform-encoder \
    --github.com/mholt/caddy-webdav \
    --github.com/tailscale/caddy-tailscale
    
# Étape finale
FROM caddy:2.8.4-alpine

# Créer un répertoire pour les fichiers de Caddy
RUN mkdir -p /etc/caddy /data /config 

# Copier l'exécutable Caddy personnalisé depuis l'étape de construction
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Exposer les ports non privilégiés
EXPOSE 80
EXPOSE 443

# Commande pour démarrer Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
