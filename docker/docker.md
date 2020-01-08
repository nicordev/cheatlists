# Docker

## Installation

* [Doc officielle](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
    * Pour Ubuntu 19.10 :

* [Linux Mint](https://linuxhint.com/install_docker_linux_mint/)
* Ajouter l'utilisateur au groupe `docker` pour éviter d'utiliser `sudo` à tout va en exécutant :
    * `sudo usermod -aG docker nomUtilisateur`

## Utilisation

* Général
    * `docker --version` ou `docker -v` affiche la version.
    * `docker info` affiche des infos.
    * `docker` affiche les commandes disponibles.
    * `docker nomCommande --help` affiche l'aide d'une commande.
    * `docker run hello-world` teste que docker fonctionne.
* Images Docker
    * > **Note perso** Une image Docker sert de base pour créer des conteneurs.
    * `docker search nomImage` cherche une ou plusieurs images sur le Docker hub. Equivaut à la barre de recherche du site web du [Docker hub](https://hub.docker.com/).
    * `docker image ls` lister les images présentes sur l'ordinateur.
        * `docker image ls -a` affiche toutes les images présentes sur l'ordinateur.
    * `docker pull nomImage` récupère une image du Docker hub.
    * `docker images` ou `docker image ls` affiche les images disponibles localement (ajouter `-a` pour tout afficher).
    * Création d'une image
        1. Créer les fichiers suivants dans un nouveau dossier :
            * `Dockerfile`
            * `requirements.txt`
            * `fichierDeCodeAExecuter`
        2. Exécuter `docker build --tag=nomdutag .` pour créer l'image (`--tag` peut être remplacé par `-t`)
    * `docker rmi nomImage:tagImage` ou `docker rmi imageId` supprime une image
* Conteneurs Docker
    * > **Note perso** Un conteneur exécute le programme contenu dans l'image de base.
    * `docker container ls` ou `docker ps` liste les conteneurs actifs.
        * `--all` ou `-a` liste tous les conteneurs.
        * `docker container ls -aq` liste les conteneurs en *quiet mode*.
    * `docker run -d -p numéroPortLocal:numéroPortConteneur nomImage` lance un conteneur à partir d'une image et affiche l'identifiant du conteneur `idConteneur` :
        * `-d` détache le conteneur du shell.
        * `-p numéroPortLocal:numéroPortConteneur` sélectionne un port où `numéroPortConteneur` correspond au port utilisé par le conteneur et `numéroPortLocal` correspond au port que l'on utilisera pour accéder à l'application du conteneur.
        * Exemple : Lancement d'un serveur nginx via un conteneur et accessible via l'url *http://127.0.0.1:8080*
            * `docker run -d -p 8080:80 nginx` lance le serveur où :
                * `-d` détache le conteneur du processus principal de la console.
                * `-p 8080:80` transfère le trafic du port 8080 vers le port 80 du conteneur.
    * `docker exec -ti idConteneur bash` lance un shell bash pour agir directement sur le conteneur.
    * `docker stop idConteneur` arrête le conteneur.
    * `docker rm idConteneur` ou `docker container rm nomConteneur` détruit le conteneur (pourra être reconstruit avec la commande `docker run`).
* Faire le ménage
    * `docker system prune` supprime les données suivantes :
        * l'ensemble des conteneurs Docker qui ne sont pas en status running ;
        * l'ensemble des réseaux créés par Docker qui ne sont pas utilisés par au moins un conteneur ;
        * l'ensemble des images Docker non utilisées ;
        * l'ensemble des caches utilisés pour la création d'images Docker.

## Créer un Dockerfile

> **Note perso** Un Dockerfile permet de construire une image Docker.

1. Créer un fichier `Dockerfile` à la racine du projet contenant les instructions suivantes :
    * `FROM nomImageDeBase` défini l'image à utiliser comme base.
    * `RUM commandesLinux` exécute des commandes. Mieux vaut regrouper les commandes avec `&&` pour limiter le nombre d'instructions `RUN` et ainsi limiter le nombre de *layers* et la taille de l'image.
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
2. `docker tag nomImage:tagImage nomUtilisateurDockerHub/nomRepository:tagImage` ou `docker tag idImage nomUtilisateurDockerHub/nomRepository:tagImage` créé un lien entre l'image créée en local et l'image à envoyer sur le Docker Hub.
3. Se connecter avec la commande `docker login`.
4. `docker push nomUtilisateur/nomRepository:tagImage` envoi l'image locale vers le repository. `:tagImage` est par défaut `:latest`.

## Docker compose

* [Installation](https://docs.docker.com/compose/install/)
    * `sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose && sudo chmod +x /usr/bin/docker-compose` installe Docker compose sur Linux.

* Fichier `docker-compose.yaml` :
    * Fichier à créer qui contiendra le descriptif des conteneurs à générer.
    * Contenu du fichier :
        ```yaml
        version: 'numéroVersionFormatFichierDockerCompose'
        services:
            nomServiceA:
                image: nomImage:tagImage
                volumes:
                    - /dossier/sur_ordinateur_hôte:/chemin/dossier_des_données_à_persister # Garde les données du dossier du conteneur sur la machine hôte
                    - db_data:/chemin/dossier_des_données_à_persister # Garde les données du dossier du conteneur sur la machine hôte sans spécifier l'emplacement exact
                restart: always # Redémarre le conteneur en cas d'erreur
                environment:
                    NOM_VARIABLE_ENVIRONNEMENT: valeurVariableEnvironnement
            nomServiceB:
                depends_on: # Les dépendances entre conteneurs
                    - nomServiceA # Le service A sera lancé avant le B
                ports:
                    - numéroPortHôte:NuméroPortConteneur # Expose un port de la machine hôte vers le conteneur et ainsi le rendre accessible depuis l'extérieur. Par exemple 8000:80 signifie que le port 8000 de la machine hôte permettera d'utiliser le port 80 du conteneur.
        volumes:
            db_data: {} # TODO je ne sais pas à quoi ça sert
        ```
    * [Exemple](https://openclassrooms.com/fr/courses/2035766-optimisez-votre-deploiement-en-creant-des-conteneurs-avec-docker/6211677-creez-un-fichier-docker-compose-pour-orchestrer-vos-conteneurs) :
        ```yaml
        version: "3"
        services:
            db:
                image: mysql:5.7
                volumes:
                    - db_data:/var/lib/mysql
                restart: always
                environment:
                    MYSQL_ROOT_PASSWORD: somewordpress
                    MYSQL_DATABASE: wordpress
                    MYSQL_USER: wordpress
                    MYSQL_PASSWORD: wordpress
            wordpress:
                depends_on:
                    - db
                image: wordpress:latest
                ports:
                    - "8000:80"
                restart: always
                environment:
                    WORDPRESS_DB_HOST: db:3306
                    WORDPRESS_DB_USER: wordpress
                    WORDPRESS_DB_PASSWORD: wordpress
                    WORDPRESS_DB_NAME: wordpress
        volumes:
            db_data: {}
        ```
* Utilisation
    * `docker-compose --version` affiche la version.
    * `docker-compose config` vérifie la syntaxe du fichier `docker-compose.yml`.
    * `docker-compose pull` récupère les images nommées dans le fichier `docker-compose.yaml`.
    * `docker-compose up` lance la création des conteneurs définis dans le fichier `docker-compose.yaml`.
        * `docker-compose up -d` exécute les conteneurs en tâche de fond.
    * `docker-compose stop` arrête les conteneurs actifs.
    * `docker-compose down` détruit les conteneurs.
    * `docker-compose ps` affiche la liste des conteurs actifs.
    * `docker-compose logs -f --tail 5` affiche les 5 dernières lignes des logs des conteneurs.
