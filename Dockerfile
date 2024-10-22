# Utilise la dernière version officielle de Go pour compiler Caddy
FROM golang:1.23 AS builder

# Installe les dépendances nécessaires pour Caddy
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential

# Télécharge et compile Caddy avec les modules supplémentaires
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
RUN xcaddy build \
    --with github.com/caddyserver/transform-encoder \
    --with github.com/mholt/caddy-webdav

# Étape finale
FROM alpine:latest

# Installe Tailscale
RUN apk add --no-cache tailscale

# Crée un utilisateur non privilégié
RUN addgroup -S caddy && adduser -S caddy -G caddy

# Copie Caddy compilé depuis l'étape de construction
COPY --from=builder /go/bin/caddy /usr/local/bin/caddy

# Crée un dossier pour les fichiers de configuration
RUN mkdir /etc/caddy

# Crée le Caddyfile directement dans le Dockerfile
RUN echo 'example.com {\n    root * /usr/share/caddy\n    file_server\n    encode gzip\n}' > /etc/caddy/Caddyfile

# Change le propriétaire des fichiers
RUN chown -R caddy:caddy /etc/caddy /usr/local/bin/caddy

# Expose le port 80 et 443
EXPOSE 80 443

# Passe à l'utilisateur non privilégié
USER caddy

# Démarre Caddy et Tailscale
CMD ["sh", "-c", "tailscaled & tailscale up --accept-routes --authkey ${TAILSCALE_AUTH_KEY} --hostname ${TAILSCALE_HOSTNAME} && caddy run --config /etc/caddy/Caddyfile"]
