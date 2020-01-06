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

## Images Docker

* `docker pull nomImage` récupère une image du Docker HUB
* `docker images -a` affiche les images disponibles localement
* Création d'une image
    1. Créer les fichiers suivants dans un nouveau dossier :
        * `Dockerfile`
        * `requirements.txt`
        * `fichierDeCodeAExecuter`
    2. Exécuter `docker build --tag=nomdutag .` pour créer l'image (`--tag` peut être remplacé par `-t`)

## Utilisation d'un conteneur

> Exemple : Lancement d'un serveur nginx via un conteneur

* `docker run -d -p 8080:80 nginx` lance le serveur où :
    * `-d` détache le conteneur du processus principal de la console.
    * `-p 8080:80` transfère le trafic du port 8080 vers le port 80 du conteneur.
* `docker exec -ti ID_RETOURNÉ_LORS_DU_DOCKER_RUN bash` lance un shell bash pour agir directement sur le conteneur.
* `docker stop ID_RETOURNÉ_LORS_DU_DOCKER_RUN` arrête le conteneur
* `docker rm ID_RETOURNÉ_LORS_DU_DOCKER_RUN` détruit le conteneur (pourra être reconstruit avec la commande `docker run`)
* `docker ps` affiche la liste des conteneurs actifs

## Faire le ménage

* `docker system prune` supprime les données suivantes :
    * l'ensemble des conteneurs Docker qui ne sont pas en status running ;
    * l'ensemble des réseaux créés par Docker qui ne sont pas utilisés par au moins un conteneur ;
    * l'ensemble des images Docker non utilisées ;
    * l'ensemble des caches utilisés pour la création d'images Docker.

## Créer un Dockerfile

1. Créer un fichier `Dockerfile` à la racine du projet contenant les instructions suivantes :
    * `FROM nomImageDeBase` défini l'image à utiliser comme base.
    * `RUM commandesLinux` exécute des commandes. Mieux vaut regrouper les commandes avec `&&` pour limiter le nombre d'instructions `RUN` et ainsi limiter la taille de l'image.
    * `ADD dossierContenantLesSources dossierDeDestinationDansLImage` copie ou télécharge des fichiers dans l'image.
    * `WORKDIR nomDossierDansLImage` modifie le répertoire courant utilisé dans  l'image.
    * *Optionel* `EXPOSE numéroDuPort` indique le port sur lequel l'application écoute.
    * *Optionel* `VOLUME nomDossierAPartager` indique quel répertoire partager avec le host.
    * `CMD commandeAExecuterAuDémarrage` indique quelle commande exécuter au démarrage du conteneur.
    * Exemple :
        ```
        FROM debian:9

        RUN apt-get update -yq \
        && apt-get install curl gnupg -yq \
        && curl -sL https://deb.nodesource.com/setup_10.x | bash \
        && apt-get install nodejs -yq \
        && apt-get clean -y

        ADD . /app/
        WORKDIR /app
        RUN npm install

        EXPOSE 2368
        VOLUME /app/logs

        CMD npm run start
        ``` 
2. Créer un fichier `.dockerignore` contenant par exemple :
    ```
    .git
    node_modules
    ```
3. `docker build -t nomImageACréer nomDossierOùSeTrouveLeDockerfile` créé l'image Docker correspondant au projet. `-t` permet de donner un nom à l'image. Exemple : `docker build -t maSuperAppli .` dans le cas où l'on est dans le dossier du `Dockerfile`.
4. `docker run -d -p 2368:2368 nomImageCréée` lance le conteneur sur le port 2368.

## Partager des images sur le docker hub

1. Créer un repository sur le site [hub.docker.com](https://hub.docker.com)
2. `docker tag nomImage:latest nomUtilisateurDockerHub/nomRepository:latest`