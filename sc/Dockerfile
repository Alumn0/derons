FROM debian:12-slim

# Avoid prompts from apt
ARG DEBIAN_FRONTEND=noninteractive

# Install the necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    jq \
    pigz \
    xxd \
    coreutils \
    php-cli \
    curl \
    ca-certificates \
    dnsutils \
    && rm -rf /var/lib/apt/lists/*

# Download and install msgpack2json
RUN curl -LO https://github.com/ludocode/msgpack-tools/releases/download/v0.6/msgpack-tools-0.6-x86_64.deb && \
    dpkg -i msgpack-tools-0.6-x86_64.deb && \
    rm msgpack-tools-0.6-x86_64.deb

# Copy the CLI wrapper script and test cases into the container
COPY cli /app/cli
COPY testing /app/testing

# Set the working directory
WORKDIR /app/cli

# Ensure the scripts are executable
RUN chmod +x /app/cli/*.sh ; \
    chmod +x /app/testing/*.sh

# Default to display smart contract status
CMD ["/app/cli/getScStatus_testnet.sh"]