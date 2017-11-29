# -*- mode: ruby -*-
# vi: set ft=ruby :

# README
#
# Getting Started:
# 1. vagrant plugin install vagrant-hostmanager
# 2. vagrant up
# 3. vagrant ssh
#
# This should put you at the control host
#  with access, by name, to other vms
Vagrant.configure(2) do |config|
  config.hostmanager.enabled = true

  config.vm.box = "ubuntu/xenial64"

  config.vm.define "puppet", primary: true do |h|
    h.vm.network "private_network", ip: "192.168.135.10"
    h.vm.hostname = "puppet"
    h.vm.provision :shell, :inline => <<'EOF'
if [ ! -f "/home/ubuntu/.ssh/id_rsa" ]; then
  ssh-keygen -t rsa -N "" -f /home/ubuntu/.ssh/id_rsa
fi
cp /home/ubuntu/.ssh/id_rsa.pub /vagrant/control.pub

cat << 'SSHEOF' > /home/ubuntu/.ssh/config
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
SSHEOF

chown -R ubuntu:ubuntu /home/ubuntu/.ssh/
EOF
  end

  config.vm.define "lb01" do |h|
    h.vm.network "private_network", ip: "192.168.135.101"
    h.vm.provision :shell, inline: 'cat /vagrant/control.pub >> /home/ubuntu/.ssh/authorized_keys'
    h.vm.hostname = "lb01"
  end

  config.vm.define "app01" do |h|
    h.vm.network "private_network", ip: "192.168.135.111"
    h.vm.provision :shell, inline: 'cat /vagrant/control.pub >> /home/ubuntu/.ssh/authorized_keys'
    h.vm.hostname = "app01"
  end

  config.vm.define "app02" do |h|
    h.vm.network "private_network", ip: "192.168.135.112"
    h.vm.provision :shell, inline: 'cat /vagrant/control.pub >> /home/ubuntu/.ssh/authorized_keys'
    h.vm.hostname = "app02"
  end

  config.vm.define "db01" do |h|
    h.vm.network "private_network", ip: "192.168.135.121"
    h.vm.provision :shell, inline: 'cat /vagrant/control.pub >> /home/ubuntu/.ssh/authorized_keys'
    h.vm.hostname = "db01"
  end
end
