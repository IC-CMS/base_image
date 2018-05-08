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

sudo docker pull hashicorp/consul-template
sudo cp ${RESOURCES}/consul/ctconfig.hcl /var/lib
sudo echo "#!/usr/bin/env bash" > myscript.sh
#Add ca trust to docker command if necessary
sudo echo "alias consul-template='sudo docker run -it \
           --network='host' \
           -v '\$\(pwd\)':/app \
           -w /app \
           -v /var/lib/ctconfig.hcl:/var/lib/ctconfig.hcl \
           hashicorp/consul-template \
           -config 'var/lib/ctconfig.hcl''" >> myscript.sh
sudo mv myscript.sh /etc/profile.d
sudo chmod 644 /etc/profile.d/myscript.sh
bash -l
source /etc/profile