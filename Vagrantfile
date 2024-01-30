# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  # Operative system
  BOX_IMAGE = "ubuntu/jammy64"

  # web settings
  VM_WEB_HOSTNAME = "web-m340"
  VM_WEB_NAME = "web.m340"
  VM_WEB_MEMORY = "1024"

  # db settings
  VM_DB_HOSTNAME = "db-m340"
  VM_DB_NAME = "db.m340"
  VM_DB_MEMORY = "1024"

  # web and db settings
  VM_GUI = true
  SSH_INSERT_KEY = false

  # Network settings
  BASE_INT_NETWORK = "10.10.20"
  BASE_HOST_ONLY_NETWORK = "192.168.56"
  WEB_NET = ".10"
  DB_NET = ".11"

  # Proxy settings
  PROXY_URL = "http://10.20.5.51:8888"
  NO_PROXY = "localhost,127.0.0.1"
  PROXY_ENABLE = false
  
  config.vm.define "web" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = VM_WEB_HOSTNAME
	subconfig.ssh.insert_key = SSH_INSERT_KEY
    
    if PROXY_ENABLE
	  if Vagrant.has_plugin?("vagrant-proxyconf")
        subconfig.proxy.http = PROXY_URL
        subconfig.proxy.https = PROXY_URL
        subconfig.proxy.no_proxy = NO_PROXY
	  else
	    puts "Plugin del proxy non installato. Installalo con 'vagrant plugin install vagrant-proxyconf'"
		exit
	  end
    end

    subconfig.vm.network "private_network", ip: BASE_INT_NETWORK + WEB_NET, virtualbox__intnet: true
    subconfig.vm.network "private_network", ip: BASE_HOST_ONLY_NETWORK + WEB_NET

    subconfig.vm.provider "virtualbox" do |vb|
      vb.name = VM_WEB_NAME
      vb.gui = VM_GUI
      vb.memory = VM_WEB_MEMORY
    end

    subconfig.vm.synced_folder "./site", "/var/www/html"
    config.vm.provision "shell", path: "scripts/install_apache_and_php.sh"
  end

  config.vm.define "db" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = VM_DB_HOSTNAME
	subconfig.ssh.insert_key = SSH_INSERT_KEY

    if PROXY_ENABLE
      if Vagrant.has_plugin?("vagrant-proxyconf")
        subconfig.proxy.http = PROXY_URL
        subconfig.proxy.https = PROXY_URL
        subconfig.proxy.no_proxy = NO_PROXY
	  else
	    puts "Plugin del proxy non installato. Installalo con 'vagrant plugin install vagrant-proxyconf'"
		exit
	  end
    end

    subconfig.vm.network "private_network", ip: BASE_INT_NETWORK + DB_NET, virtualbox__intnet: true

    subconfig.vm.provider "virtualbox" do |vb|
      vb.name = VM_DB_NAME
      vb.gui = VM_GUI
      vb.memory = VM_DB_MEMORY
    end

    config.vm.provision "shell", path: "scripts/install_mysql.sh"
  end
end