#!/usr/bin/env bash

set -e

# system setup

apt-get update

apt-get install -qy --no-install-recommends \
    libatomic1 \
    libicu67 \
    libncurses5 \
    libtomcrypt1 \
    libtommath1 \
    netbase \
    procps

# firebird install

cd /tmp/install
tar --strip=1 -xf firebird.tar.gz
./install.sh -silent

# sysdba password change

cd /opt/firebird
source SYSDBA.password
export ISC_PASSWORD
bin/isql -user sysdba -pas $ISC_PASSWORD -i/tmp/install/setup.sql localhost:employee

# firebird config changes

sed -i 's/#\?RemoteAuxPort\s*=.*/RemoteAuxPort = 3051/' /opt/firebird/firebird.conf
echo "dbname = /data/dbname.fdb" >> /opt/firebird/aliases.conf

# cleanup

rm -rf /var/lib/apt/lists/*
