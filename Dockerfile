FROM ubuntu:18.04

# Update
RUN apt update

# Install java
RUN apt install -y openjdk-8-jre-headless

# Install required utilities
RUN apt install -y curl xz-utils git openssh-client

# Install cypress dependencies
# https://docs.cypress.io/guides/guides/continuous-integration.html#Dependencies
RUN apt install -y libgtk2.0-0 libgtk-3-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb

# Install Node.js
RUN mkdir -p /usr/local/lib/nodejs
RUN curl -sSL "https://nodejs.org/dist/v12.16.1/node-v12.16.1-linux-x64.tar.xz" --output node-v12.16.1-linux-x64.tar.xz
RUN tar -xJvf node-v12.16.1-linux-x64.tar.xz -C /usr/local/lib/nodejs
ENV PATH "$PATH:/usr/local/lib/nodejs/node-v12.16.1-linux-x64/bin"
