# -*- mode: ruby -*-
# vi: set ft=ruby :


VAGRANTFILE_API_VERSION = "2"

[
  { :name => "vagrant-reload" },
  { :name => "vagrant-vbguest" },
].each do |plugin|

  if not Vagrant.has_plugin?(plugin[:name])
    raise "#{plugin[:name]} is required. Please run `vagrant plugin install #{plugin[:name]}`"
  end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	#config.vm.synced_folder "~/Documents/pi2/docker", "/home/vagrant/"

	# VM do Gerenciador do docker
	config.vm.define "docker" do |docker|

		# Hostname da VM
		docker.vm.hostname = "docker.localdomain"
		
		# Imagem que será utilizada para configurar a VM
		docker.vm.box = "ubuntu/xenial64"
		
		# Configuracao da Rede e IP
		docker.vm.network "private_network", ip: "192.168.50.10"
		
		# Executa script para a configuracao do ambiente
		docker.vm.provision "shell", inline: "/bin/bash /vagrant/config_inicial.sh docker_p2"

		# Mapeia pasta para a VM
		#docker.vm.synced_folder "~/Documents/testes/", "/home/vagrant"
		
		# Restart da VM para efetivar as atualizacoes dos pacotes instalados
		docker.vm.provision :reload		

		#Mapeia as portas do apache e mysql
		docker.vm.network "forwarded_port", guest: 8080, host: 8080
		docker.vm.network "forwarded_port", guest: 3306, host: 3306

		#Script que inicia o ambiente
		docker.vm.provision "shell", inline: "/bin/bash /vagrant/start-service.sh docker-compose"
				

		# Configuracoes passadas ao Provisionador, neste caso o VirtualBox
		docker.vm.provider "virtualbox" do |vbox|
		        
			# Desabilitar Tela
			vbox.gui = false
		
			# Nome da VM no VirtualBox
			vbox.name = "docker_p2"
			
			# Qtd de CPUs
			vbox.customize [ "modifyvm", :id, "--cpus", "1" ]
		        
			# Qtd de Memoria RAM
			vbox.customize [ "modifyvm", :id, "--memory", "512" ]
		end
	end
end
