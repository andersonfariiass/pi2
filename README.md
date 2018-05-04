# Pojeto Integrador II
Repositório projeto integrador II

Neste repositorio conterá os arquivos e procedimentos necessários para subir um ambiente de desenvolvimento com Apache, PHP e MySQL em Docker e  Virtualizado.

Listagem de arquivos:
		
	Vagrantfile - Arquivo que automatiza o provisionamento da maquina virtual.
	config_inicial.sh - Shell Script que automatiza a instalação dos pacotes necessários, e algunas configurações da VM.
	start-service.sh - Shell script que automatiza o start do ambiente utilizando o docker-compose.

Procedimeto para configuração do ambiente
	
	Faça download e instalação do vagrant no site oficial https://www.vagrantup.com/downloads.html
	Faça download e instalação do VirtualBox
	Faça download deste projeto (git clone https://github.com/andersonfariiass/projeto_2.git)
	Dentro do diretório pi2/ crie um diretório chamado docker e dentro crie a seguinte estrutura de diretórios:
		mysql - Diretório onde será armazenado a base de dados do mysql
		www/html - Diretório onde será armazenado os arquivos da aplicação
	Dentro do diretório raiz (pi2) execute o comando - vagrant up
	Para acessar a vm digite o comando: vagrant ssh nome_da_vm

Executando os procedimentos acima,será criado no VirtualBox uma VM:
	
	docker_p2: 192.168.50.10

Para acessar a aplicação que foi utilizada para teste:
	
	Acesse o endereço http://192.168.50.10:8080 (este app executa um arquivo index.php que conecta ao banco, insere dados e exibi os dados na tela do browser).
	Usando o MySQL Workbench para acessar o banco:
		IP: 192.168.50.10
		user: docker
		senha: docker
		porta: 3306
