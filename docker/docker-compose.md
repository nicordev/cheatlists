# docker-compose

## Commandes docker-compose

- `docker-compose up` lance les conteneurs selon le fichier `docker-compose.yaml`.

## Installation

> [Installation](https://docs.docker.com/compose/install/)
    
```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose && sudo chmod +x /usr/bin/docker-compose
```

## Utilisation

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
                    - /dossier/sur_ordinateur_hôte2:/chemin/dossier_conteneur:ro # :ro pour read-only, empêche les modifications du dossier.
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
