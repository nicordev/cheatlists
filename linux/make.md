# make

- `make ` + `tab` + `tab` affiche les commandes possible du `Makefile`

## Makefile

> [Tuto GrafikArt](https://www.youtube.com/watch?v=2VV9FAQWHdw)

### But

Lance des commandes pour créer des fichiers ou dossiers.

Ces commandes sont exécutés que si les fichiers ou dossiers auxquelles elles font référence n'existent pas ou ne sont pas à jour.

On peut aussi utiliser le `Makefile` pour créer des alias de commandes.

### Syntaxe

```bash
.SILENT: # Empêche les commandes exécutées via make d'apparaître dans le terminal.
.PHONY: nomCommandeMake # Regroupe les noms de commande qui ne sont pas en rapport avec un fichier ou un dossier.

.DEFAULT_GOAL := help
NOM_PARAMETRE='valeurParamètre'
NOM_PARAMETRE:='valeurParamètre' # Ici := permet de prendre en compte des sous-variables potentielles de 'valeurParamètre'
NOM_PARAMETRE_PAR_DEFAUT?='valeurParamètreParDéfaut'

nomFichierOuDossierCible: nomDépendance1 nomDépendance2
    nomCommandeAExécuter $(NOM_PARAMETRE)

nomCommandeMake: nomDépendance1 nomDépendance2 ## Description nomCommandeMake affichée par `help`

help:
    @grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
```

- On utilise des tabulations et non des espaces.
- Dans `.PHONY` on écrit les noms des commandes du Makefile qui ne correspondent pas à des fichiers ou dossiers du répertoire du Makefile.
- On peut déclarer des variables de 3 façons :
    - ```bash
        NOM_PARAMETRE='valeurParamètre' # Classique.
        NOM_PARAMETRE:='valeurParamètre' # Interprète directement les sous-variables potentielles.
        NOM_PARAMETRE?='valeurParamètre' # Utilise 'valeurParamètre' si NOM_PARAMETRE n'est pas déjà défini.
        ```
- On peut redéfinir les variables utilisées lors de l'exécution d'une commande :
    ```bash
    make nomCommandeMake NOM_PARAMETRE='nouvelleValeur'
    ```

Exemple :

```bash
.PHONY: install test server help cache-clear

.DEFAULT_GOAL = help
PORT?=8000
HOST=localhost
PHP=php
CURRENT_DIRECTORY=$(shell pwd)

ifdef VERSION
    PHP=docker run -it --rm --name phpcli -p $(PORT):$(PORT) -v $(CURRENT_DIR):/cheminVers/nomRépertoireApplicationCôtéConteneurDocker -w /cheminVers/nomRépertoireApplicationCôtéConteneurDocker php:$(VERSION)-cli php
    HOST=0.0.0.0
endif

OK_COLOR=\033[0;32
NO_COLOR=\033[m

vendor: composer.json
    composer install

composer.lock: composer.json
    composer update

install: vendor composer.lock

help:
    @grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

test: install ## Lance les tests unitaires et s'arrête à la première erreur.
    $(PHP) ./vendor/bin/phpunit --stop-on-failure

server: install ## Lance le serveur interne de php.
    echo -e "Lancement du serveur sur http://$(HOST):$(PORT)"
    php -S localhost:$(PORT) -t public/ -d display_errors=1

cache-clear:
    @rm -rf ./tmp # @ masque la commande exécutée dans la console.
```