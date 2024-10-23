FROM debian:oldstable-slim

ENV FIREBIRD_VERSION=FirebirdSS-2.5.9.27139-0
ENV DEBIAN_FRONTEND=noninteractive

# Copying files into container
RUN mkdir -p /tmp/install
COPY FirebirdSS-2.5.9.27139-0.amd64.tar.gz /tmp/install/firebird.tar.gz
COPY setup.sql /tmp/install/setup.sql
COPY setup.sh /tmp/install/setup.sh
RUN chmod +x /tmp/install/setup.sh
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Run setup inside container
RUN /tmp/install/setup.sh

# Remove unnecessary files after setup
RUN rm -rf /tmp/install

# Volume for database files
RUN mkdir -p /data
RUN chmod 777 /data
VOLUME /data

# Network ports 
EXPOSE 3050/tcp 3051/tcp

# Execute on container's start
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
