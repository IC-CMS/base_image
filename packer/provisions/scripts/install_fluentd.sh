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
FLUENT_CONFIG='/etc/fluent/fluent-bit.conf'
DOCKER_DAEMON='/etc/docker/daemon.json'

#Move config for the Docker driver for Fluent
sudo cp -f ${RESOURCES}${DOCKER_DAEMON} ${DOCKER_DAEMON}
sudo cp -f ${RESOURCES}${FLUENT_CONFIG} ${FLUENT_CONFIG}

#This is a new instance. Should never be a fluentd running
#sudo docker stop fluentd || true && sudo docker rm fluentd || true

sudo docker run -d \
    --name fluentd \
    -p 24224:24224 \
    --log-driver none \
    --cpus=".1" \
    --restart always \
    -v ${FLUENT_CONFIG}:${FLUENT_CONFIG}:ro \
    -v /var/log/:/tmp/log/ \
    fluent/fluent-bit:0.12.11 /fluent-bit/bin/fluent-bit \
    -c /etc/fluent/fluent-bit.conf
