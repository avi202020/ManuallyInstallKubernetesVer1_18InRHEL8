#!/bin/bash
set -e
IFNAME=$1
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts
sudo setenforce 0 && sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
sudo yum install -y wget net-tools

# Update /etc/hosts about other hosts
sudo cat >> /etc/hosts <<EOF
192.168.15.10  kubernetes-rhel8-master
192.168.15.11  kubernetes-rhel8-nodeone
192.168.15.12  kubernetes-rhel8-nodetwo
EOF
