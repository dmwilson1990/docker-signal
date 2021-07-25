# This is a dummy Dockerfile.
# See https://github.com/jlesage/docker-baseimage-gui to get the content of the
# Dockerfile used to generate this image.

# Pull base image.
FROM dmwilson1990/baseimage-gui-cac:debian-10

# Install signal.
RUN \
add-pkg wget gnupg libx11-xcb1 libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0 libgbm1 && \
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg && \
mv signal-desktop-keyring.gpg /usr/share/keyrings/ && \
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | \
tee -a /etc/apt/sources.list.d/signal-xenial.list && \
add-pkg signal-desktop

# Copy the start script.
COPY startapp.sh /startapp.sh

# Set the name of the application.
ENV APP_NAME="Signal"

# Expose ports.
EXPOSE 5800
