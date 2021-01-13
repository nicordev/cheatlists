# Docker

## Commandes générales

- Afficher les infos d'un objet docker (image, container, network) au format JSON :

    > [Documentation](https://docs.docker.com/engine/reference/commandline/inspect/)

    ```bash
    docker inspect nomOuIdObjetDocker
    ```

    Formatter la sortie de la commande en utilisant un template *go* :
    
    ```bash
    docker inspect --format='{{template go ici}}' nomOuIdObjetDocker
    ```

- Construire une image :

    ```bash
    docker build -t nomImage cheminVers/DossierContenant/Dockerfile
    ```

    En spécifiant un dockerfile particulier :
    
    ```bash
    docker build -t nomImage -f nomFichierDockerfileSouhaité cheminVersLeDossierContenantLeDockerfile
    ```

- Créer un conteneur à partir d'une image :

    Lance un conteneur en arrière plan (avec `-d`) et nomme le conteneur :

    ```bash
    docker run -d --name nomConteneur nomImage
    ```

- Ouvrir un shell bash dans un contenur :

    ```bash
    docker exec -ti idOuNomConteneur bash
    ```

- Afficher les logs d'un conteneur :

    ```bash
    docker logs idOuNomConteneur
    ```

- Lister tous les conteneurs :

    ```bash
    docker ps -a
    ```

- Supprimer tous les éléments inutilisés :

    - Supprimer tous les conteneurs, les images et les networks :

        ```bash
        docker system prune --all
        ```

    - Supprimer aussi les volumes :

        ```bash
        docker system prune --volumes
        ```
      
    - Cibler certains éléments :

        ```bash
        docker system prune --filter label=nomLabel
        docker system prune --filter label=nomLabel=valeurLabel
        docker system prune --filter label!=nomLabel
        docker system prune --filter label!=nomLabel=valeurLabel
        docker system prune --filter until=timestamp
        ```

## Commandes relatives aux conteneurs :

> [Documentation](https://docs.docker.com/engine/reference/commandline/container/)

```bash
docker container nomCommande
```

- Créer une nouvelle image à partir d'un conteneur :

    ```bash
    docker container commit nomConteneur nomImageACréer
    ```

- Lister les conteneurs :

    ```bash
    docker container ls
    ```

- Supprimer des conteneurs :

    ```bash
    docker container rm
    ```

- Démarrer un conteneur :

    ```bash
    docker container start
    ```

- Arrêter un conteneur :

    ```bash
    docker container stop
    ```

- Supprimer les conteneurs arrêtés :

    ```bash
    docker container prune
    ```

- Détruire des conteneurs :

    ```bash
    docker container kill
    ```

- Exécuter une commande dans un conteneur actif :

    ```bash
    docker container exec nomCommande
    ```

- Créé un conteneur et lance une commande dedans :

    - Lance `create`, `start` et `exec` à la fois
    - Similaire à `docker run`

    ```bash
    docker container run nomImage nomCommande
    ```

- Copie de fichiers dans un conteneur :

    ```bash
    docker container cp cheminCôtéMachine/fichierOuDossier cheminCôtéConteneur/fichierOuDossier
    ```

## Commandes relatives aux images :

> [Documentation](https://docs.docker.com/engine/reference/commandline/image/)

```bash
docker image nomCommande
```

- Construire une image :

    ```bash
    docker image build
    ```

- Renommer une image ou créer un tag pour une image :

    ```bash
    docker image tag idImageOuCoupleNomImage:nomTag nouveauNomImage:nouveauTag
    ```

- Lister les images :

    ```bash
    docker image ls
    ```

- Supprimer les images inutilisées :

    ```bash
    docker image prune
    ```

- Récupérer une image d'un registry docker hub :

    ```bash
    docker image pull nomImage
    ```

- Envoyer une image vers un registry docker hub :

    ```bash
    docker image push nomImage
    ```

- Supprimer des images :

    ```bash
    docker image rm nomImage1 nomImage2
    ```

- Enregistrer des images dans une archive `.tar` :

    ```bash
    docker image save nomImage1 nomImage2
    ```

- Créer une image à partir d'une archive `.tar` :

    ```bash
    docker image import nomFichier.tar
    ```

## Commandes relatives aux network :

> [Documentation](https://docs.docker.com/engine/reference/commandline/network/)

```bash
docker network nomCommande
```

## Installation

* [Doc officielle](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
    * Pour Ubuntu 19.10 :

* [Linux Mint](https://linuxhint.com/install_docker_linux_mint/)
* Ajouter l'utilisateur au groupe `docker` pour éviter d'utiliser `sudo` à tout va en exécutant :
    * `sudo usermod -aG docker nomUtilisateur`

## Erreurs

- **Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?**
    - `sudo dockerd` relance le daemon.

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

## Créer une image avec un Dockerfile

> **Note perso** Un Dockerfile permet de construire une image Docker.

1. Créer un fichier `Dockerfile` à la racine du projet comme suit :
    * `FROM nomImageDeBase` défini l'image à utiliser comme base. On peut en mettre plusieurs :
        ```
        FROM composer
        FROM php:7.4-fpm-alpine
        COPY --from=composer /usr/bin/composer /usr/local/bin/composer
        ```
    * `RUM commandesLinux` exécute des commandes. Mieux vaut regrouper les commandes avec `&&` pour limiter le nombre d'instructions `RUN` et ainsi limiter le nombre de *layers* et la taille de l'image.
    * `ADD nomDossierHôte nomDossierImage` copie ou télécharge des fichiers de l'hôte (l'ordinateur qu'on utilise ou un serveur distant) dans l'image.
    * `COPY nomDossierHôte nomDossierImage` copie ou télécharge des fichiers de l'hôte (l'ordinateur qu'on utilise ou un serveur distant) dans l'image.
    * `WORKDIR nomDossierImage` modifie le répertoire courant utilisé dans  l'image.
    * *Optionel* `EXPOSE numéroPort` indique le port sur lequel l'application écoute.
    * *Optionel* `VOLUME nomDossierAPartager` indique quel répertoire partager avec le host. Les modifications apportées dans le host seront répercutées dans le dossier du conteneur.
    * `CMD commandeAExecuterAuDémarrage` indique quelle commande exécuter au démarrage du conteneur.
    * `ENTRYPOINT commandeAExecuterAuDémarrage` indique quelle commande exécuter au démarrage du conteneur.
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
    
    > Chaque instruction RUN, ADD etc. constitue une couche pour docker correspondant chacune à un step qu'on voit lors d'un build.
    
2. Créer un fichier `.dockerignore` pour limiter la taille de l'image

    Exemple :

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

## Récupérer l'IP d'un conteneur

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' containerIdHere
```