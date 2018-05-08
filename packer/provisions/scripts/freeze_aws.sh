#!/usr/bin/env bash
#

#ALLOWED_USERS="root|bin|deamon|adm|lp|sync|shutdown|halt|mail|operator|games|nobody|systemd-bus-proxy|systemd-network|sshd|dbus|ntp|postfix|tss|avahi-autoipd|newuser|polkitd"

#echo "****** Stopping/Disabling crond ******"
#sudo service crond stop
#sudo chkconfig crond off

#echo "****** Removing Users ******"
#set +e
#for user in `sudo cat /etc/passwd | grep -oP "(\w+(-\w+)*)(?=:x)" | egrep -v $ALLOWED_USERS`;
#    do
#        sudo pkill -u ${user};
#        sudo userdel -f  -r ${user};
#        echo ** removed ${user} **;
#done
#set -e