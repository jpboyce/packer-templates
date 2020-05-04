#!/bin/bash -eux

# Check if packer type is the right type, if not, exit
echo "Checking Packer Builder Type..."
if [ "$PACKER_BUILDER_TYPE" != "virtualbox-iso" ]; then
  echo "Builder type is not VirtualBox, exiting!"
  exit 0
fi

# Enable EPEL repository
echo "Enabling the EPEL repository..."
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Install YUM utils so we get config-manager
echo "Installing YUM utils..."
sudo yum -y install yum-utils

# Run an update first
#echo "Running a YUM Update..."
#sudo yum -y update

# Install prerequisite items
echo "Installing prerequisite items via YUM..."
sudo yum -y install perl gcc dkms kernel-devel kernel-headers make bzip2
echo "Enable CR Repo"
sudo yum-config-manager --enable cr -y
#echo "Installing kernel-devel"
#sudo yum -y install kernel-devel-`uname -r`

# Add KERN_DIR environment variable
echo "Setting KERN_DIR environment variable..."
KERN_DIR=/usr/src/kernels/`uname -r`/build
export KERN_DIR

# Reboot System
sudo reboot
sleep 60
