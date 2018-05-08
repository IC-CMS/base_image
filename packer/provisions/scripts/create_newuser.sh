#!/usr/bin/env bash
sudo /usr/sbin/adduser newuser -m
echo newuser:$1 | sudo /usr/sbin/chpasswd
sudo /usr/sbin/usermod -aG wheel newuser
sudo cp ../resources/etc/sudoers.d/newuser /etc/sudoers.d/newuser