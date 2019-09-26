# Docker

## Installation

* [Doc officielle](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* [Linux Mint](https://linuxhint.com/install_docker_linux_mint/)
* Ajouter l'utilisateur au groupe `docker` pour éviter d'utiliser `sudo` à tout va en exécutant :
    * `sudo usermod -aG docker nomUtilisateur`

## Utilisation

* [Doc officielle](/home/nicolas/Documents/Manuels/Manuels)
* `docker --version` Afficher la version
* `docker info` Afficher des infos
* `docker run hello-world` Tester que docker fonctionne
* `docker image ls` Lister les images présentes sur l'ordinateur
* `docker container ls --all` Lister les conteneurs

## List Docker CLI commands

docker
docker container --help

## Display Docker version and info

docker --version
docker version
docker info

## Execute Docker image

docker run hello-world

## List Docker images

docker image ls

## List Docker containers (running, all, all in quiet mode)

docker container ls
docker container ls --all
docker container ls -aq

## Création d'une image

* Créer les fichiers suivants dans un nouveau dossier :
    * `Dockerfile`
    * `requirements.txt`
    * `fichierDeCodeAExecuter`
* Exécuter `docker build --tag=nomdutag .` pour créer l'image (`--tag` peut être remplacé par `-t`)
