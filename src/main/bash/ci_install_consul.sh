#!/bin/bash

CONSUL_VER="1.7.2"
PLATFORM="amd64"
if [ "$(uname -m)" == aarch64 ]; then
  PLATFORM="arm64"
fi
CONSUL_ZIP="consul_${CONSUL_VER}_linux_${PLATFORM}.zip"
IGNORE_CERTS="${IGNORE_CERTS:-no}"

# cleanup
rm "consul_*"
rm "consul"
# install consul
if [[ "${IGNORE_CERTS}" == "no" ]] ; then
  echo "Downloading consul with certs verification"
  wget "https://releases.hashicorp.com/consul/${CONSUL_VER}/${CONSUL_ZIP}"
else
  echo "WARNING... Downloading consul WITHOUT certs verification"
  wget "https://releases.hashicorp.com/consul/${CONSUL_VER}/${CONSUL_ZIP}" --no-check-certificate
fi
unzip ${CONSUL_ZIP}
# check
./consul --version
