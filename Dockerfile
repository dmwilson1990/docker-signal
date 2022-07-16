#
# Signal Dockerfile
#
# https://github.com/dmwilson1990/docker-signal
#

# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-20.04

# Define working directory.
WORKDIR /tmp

#Install Updates
RUN apt-get update && apt-get -y upgrade

# Install signal.
RUN \
add-pkg wget gnupg libx11-xcb1 libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0 libgbm1 && \
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg && \
mv signal-desktop-keyring.gpg /usr/share/keyrings/ && \
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | \
tee -a /etc/apt/sources.list.d/signal-xenial.list && \
add-pkg signal-desktop=5.50.1

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Signal-Logo.svg/600px-Signal-Logo.svg.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Copy the start script.
COPY startapp.sh /startapp.sh

# Set the name of the application.
ENV APP_NAME="Signal"

# Expose ports.
EXPOSE 5800
