#!/bin/bash -eux

# Install yumutils to get package-cleanup command
sudo yum -y install yum-utils



# Clean up old kernels and packages
sudo package-cleanup --oldkernels –-count=1 --verbose --assumeyes
sudo yum clean all

# Stopping logging services
sudo service rsyslog stop
sudo service auditd stop

# Cleanup logs
sudo logrotate -f /etc/logrotate.conf
sudo rm -f /var/log/*-???????? /var/log/*.gz
sudo rm -f /var/log/dmesg.old
sudo rm -rf /var/log/anaconda
sudo sh -c "cat /dev/null > /var/log/audit/audit.log"
sudo sh -c "cat /dev/null > /var/log/wtmp"
sudo sh -c "cat /dev/null > /var/log/lastlogg"
sudo sh -c "cat /dev/null > /var/log/grubby"
# sudo cat /dev/null > /var/log/audit/audit.log
# sudo cat /dev/null > /var/log/wtmp
# sudo cat /dev/null > /var/log/lastlog
# sudo cat /dev/null > /var/log/grubby

# Remove old hardware rules
sudo rm -f /etc/udev/rules.d/70*

# Remove UUID from ifcfg scripts
# sed –i”.bak” ‘/UUID/d’ /etc/sysconfig/network-scripts/ifcfg-eno16777984

# Clean tmp folders
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Remove SSH Host keys
sudo rm -f /etc/ssh/*key*

# Remove root's shell history
sudo rm -f ~root/.bash_history
unset HISTFILE

# Remove root's SSH history
sudo rm -rf ~root/.ssh/
history -c
# sudo sys-unconfig
