# This is a dummy Dockerfile.
# See https://github.com/jlesage/docker-baseimage-gui to get the content of the
# Dockerfile used to generate this image.

# Pull base image.
FROM dmwilson1990/docker-baseimage-gui-cac:debian-10

# Install signal.
RUN \
add-pkg wget gnupg libx11-xcb1 libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0 libgbm1 && \
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg && \
mv signal-desktop-keyring.gpg /usr/share/keyrings/ && \
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | \
tee -a /etc/apt/sources.list.d/signal-xenial.list && \
add-pkg signal-desktop

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://upload.wikimedia.org/wikipedia/commons/8/8d/Signal-Logo.svg && \
    APP_ICON_DESC='{"masterPicture":"/opt/novnc/images/icons/master_icon.png","iconsPath":"/images/icons ","design":{"ios":{"pictureAspect":"noChange","assets":{"ios6AndPriorIcons":false,"ios7AndLaterIcons":false,"precomposedIcons":false,"declareOnlyDefaultIcon":true}},"desktopBrowser":{"design":"raw"},"windows":{"pictureAspect":"noChange","backgroundColor":"#da532c","onConflict":"override","assets":{"windows80Ie10Tile":false,"windows10Ie11EdgeTiles":{"small":false,"medium":true,"big":false,"rectangle":false}}},"androidChrome":{"pictureAspect":"noChange","themeColor":"#ffffff","manifest":{"display":"standalone","orientation":"notSet","onConflict":"override","declared":true},"assets":{"legacyIcon":false,"lowResolutionIcons":false}},"safariPinnedTab":{"pictureAspect":"blackAndWhite","threshold":71.875,"themeColor":"#5bbad5"}},"settings":{"scalingAlgorithm":"Mitchell","errorOnImageTooSmall":false,"readmeFile":false,"htmlCodeFile":false,"usePathAsIs":false},"versioning":{"paramName":"v","paramValue":"ICON_VERSION"}}' && \
    install_app_icon.sh "$APP_ICON_URL" "$APP_ICON_DESC"

# Copy the start script.
COPY startapp.sh /startapp.sh

# Set the name of the application.
ENV APP_NAME="Signal"

# Expose ports.
EXPOSE 5800
