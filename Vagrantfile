# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "ubuntu-01"
  config.vm.hostname = "ubuntu-01"
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "ubuntu-20-04"
    vb.memory = "3072"
    vb.cpus = 1
  end
  config.vm.network "private_network", ip: "192.168.10.50"
  config.vm.synced_folder "./jenkins", "/home/vagrant/jenkins"
  config.vm.provision 'shell', path: 'scripts/docker.sh', privileged: true
  config.vm.provision 'shell', path: 'scripts/k3s.sh', privileged: true
  config.vm.provision 'shell', path: 'scripts/jenkins.sh', privileged: false
end
