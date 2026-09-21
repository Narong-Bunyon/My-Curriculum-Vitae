# =============================================================
# Dockerfile for Narong Bunyon's Personal Portfolio Website
# =============================================================
# This uses Nginx (a fast, lightweight web server) to serve
# the static HTML/CSS/JS files.
#
# 🐳 HOW TO USE:
#
#   1. Build the image:
#      docker build -t my-portfolio .
#
#   2. Run the container:
#      docker run -d -p 8080:80 --name portfolio my-portfolio
#
#   3. Open in browser:
#      http://localhost:8080
#
#   4. Stop the container:
#      docker stop portfolio
#
#   5. Remove the container:
#      docker rm portfolio
#
# =============================================================

# --- Stage 1: Use the official Nginx Alpine image ---
# Alpine is a tiny Linux distro (~5MB), keeping the image small & fast
FROM nginx:alpine

# --- Add metadata labels ---
LABEL maintainer="Narong Bunyon <narongbunyon@email.com>"
LABEL description="Personal Portfolio Website - Narong Bunyon"
LABEL version="1.0"

# --- Remove the default Nginx welcome page ---
RUN rm -rf /usr/share/nginx/html/*

# --- Copy our custom Nginx config ---
COPY nginx.conf /etc/nginx/conf.d/default.conf

# --- Copy ALL website files into the Nginx serving directory ---
COPY . /usr/share/nginx/html

# --- Clean up files that don't belong in the final image ---
RUN rm -f /usr/share/nginx/html/Dockerfile \
          /usr/share/nginx/html/.dockerignore \
          /usr/share/nginx/html/nginx.conf \
          /usr/share/nginx/html/docker-compose.yml \
          /usr/share/nginx/html/README.md
RUN rm -rf /usr/share/nginx/html/.git \
           /usr/share/nginx/html/.idea

# --- Expose port 80 (standard HTTP port inside the container) ---
EXPOSE 80

# --- Start Nginx in the foreground (keeps the container alive) ---
CMD ["nginx", "-g", "daemon off;"]
