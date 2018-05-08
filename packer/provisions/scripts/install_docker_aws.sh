#!/usr/bin/env bash
#
# Supply the location of the provisions directory, otherwise will use tmp/provisions

if [ $# -eq 0 ]
    then
        RESOURCES='tmp/provisions/resources'
        echo 'no argument supplied, using directory /tmp/provisions'
    else
        RESOURCES=$1'/resources'
fi

RESOURCES=$1'/resources'
DOCKER_CONFIG='/root/.docker/config.json'

#Install config file
set +e
sudo mkdir -m 0755 /root/.docker
set -e
sudo cp ${RESOURCES}${DOCKER_CONFIG} ${DOCKER_CONFIG}
sudo chmod 440 ${DOCKER_CONFIG}

#Install Docker
sudo yum install -y docker-io
if [ $? -gt 0 ];
  then
    echo "***Failed to install docker-io"
    exit 1
fi

sudo cp ${RESOURCES}/etc/sysconfig/docker /etc/sysconfig/docker

#Add certs and proxy here is necessary

sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /bin/docker-compose-1.21.0
sudo chmod 0755 /bin/docker-compose-1.21.0

set +e
sudo ln -s /bin/docker-compose-1.21.0 /bin/docker-compose
set -e

sudo service docker start

