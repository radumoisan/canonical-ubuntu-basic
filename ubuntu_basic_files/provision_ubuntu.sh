#!/bin/bash

export LANGUAGE=en_US.UTF-8
export LC_ALL=C

echo "Installing updates"
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils libvirt-daemon-system pv qemu-utils sshpass virtinst

sudo usermod -aG kvm ubuntu
sudo usermod -aG libvirt ubuntu

echo "Configuring KVM network"
sudo virsh net-destroy default
sudo virsh net-undefine default
sudo virsh net-define /home/ubuntu/cloud.xml
sudo virsh net-start cloud
sudo virsh net-autostart cloud

echo "Downloading Ubuntu image"
sudo wget --timeout 10 -O /var/lib/libvirt/images/ubuntu_noble_lab.tgz  https://storage.googleapis.com/maas-images-eu/ubuntu_noble_lab.tgz  2>&1
echo "Extracting Ubuntu image"
sudo pv /var/lib/libvirt/images/ubuntu_noble_lab.tgz  | sudo tar xzf - -C /var/lib/libvirt/images
echo "Copying Ubuntu xml file"
sudo cp /home/ubuntu/ubuntu.xml /etc/libvirt/qemu/
echo "Defining Ubuntu machine"
sudo virsh define /home/ubuntu/ubuntu.xml
echo "Attaching extra disks to the Ubuntu VM"
sudo qemu-img create -f raw /var/lib/libvirt/images/ubuntu-disk1.raw 10G
sudo qemu-img create -f raw /var/lib/libvirt/images/ubuntu-disk2.raw 10G
#virsh attach-disk ubuntu --source /var/lib/libvirt/images/ubuntu-disk1.raw --target vdb --config
#virsh attach-disk ubuntu --source /var/lib/libvirt/images/ubuntu-disk2.raw --target vdc --config
echo "Starting the LAB VM"
sudo virsh start ubuntu
sudo virsh autostart ubuntu

#/usr/bin/sshpass -p 'canonical_lab' ssh -t -t -o StrictHostKeyChecking=no ubuntu@192.168.100.4 "sudo hostnamectl set-hostname ubuntu"

echo "Ubuntu VM created successfully!"
