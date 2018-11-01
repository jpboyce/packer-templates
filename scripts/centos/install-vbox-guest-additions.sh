#!/bin/bash -eux

# Check if packer type is the right type, if not, exit
echo "Checking Packer Builder Type..."
if [ "$PACKER_BUILDER_TYPE" != "virtualbox-iso" ]; then
  echo "Builder type is not VirtualBox, exiting!"
  exit 0
fi

# Add KERN_DIR environment variable
echo "Setting KERN_DIR environment variable..."
KERN_DIR=/usr/src/kernels/`uname -r`/build
export KERN_DIR

# Install Guest Additions
echo "Starting Guest Additions installation..."
sudo mkdir /media/VirtualBoxGuestAdditions
sudo mount -o loop,ro /home/vagrant/VBoxGuestAdditions.iso /media/VirtualBoxGuestAdditions
sudo sh /media/VirtualBoxGuestAdditions/VBoxLinuxAdditions.run

# Reboot System
sudo reboot
sleep 60
