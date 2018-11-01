#!/bin/bash -eux

    echo "==> Applying updates"
    # sudo yum -y update
    sudo yum update --security -y

    # reboot
    echo "Rebooting the machine..."
    sudo reboot
    sleep 60
