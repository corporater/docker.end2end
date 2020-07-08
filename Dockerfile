FROM ubuntu:18.04

# Update
RUN apt update

# Install java
RUN apt install -y openjdk-8-jre-headless

# Install required utilities
RUN apt install -y curl xz-utils git openssh-client wget

# Install cypress dependencies
# https://docs.cypress.io/guides/guides/continuous-integration.html#Dependencies
RUN apt install -y libgtk2.0-0 libgtk-3-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb

# Install Node.js
RUN mkdir -p /usr/local/lib/nodejs
RUN curl -sSL "https://nodejs.org/dist/v12.16.1/node-v12.16.1-linux-x64.tar.xz" --output node-v12.16.1-linux-x64.tar.xz
RUN tar -xJvf node-v12.16.1-linux-x64.tar.xz -C /usr/local/lib/nodejs
ENV PATH "$PATH:/usr/local/lib/nodejs/node-v12.16.1-linux-x64/bin"

# Install Chromebrowser, taken from https://hub.docker.com/r/cypress/browsers/dockerfile
RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt update && \
  apt install -y dbus-x11 google-chrome-stable && \
  rm -rf /var/lib/apt/lists/*

# "fake" dbus address to prevent errors
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
