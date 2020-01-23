# Git

## Principe

Git gère les versions de vos travaux locaux à travers 3 zones locales majeures :
* le répertoire de travail (working directory/WD) ;
* l’index, ou stage (nous préférerons le second terme) ;
* le dépôt local (Git directory/repository).

> Working directory -> `git add` -> Stage -> `git commit` -> Repository -> `git push` -> Remote (GitHub, GitLab...)

Une nouvelle branche ne peut être créée que lorque la branche master existe. La branche master n'est créée qu'après avoir fait un premier commit.



## Configuration

* `git config --list` Liste les paramètres
* `git config --global user.name "Nom utilisateur"` Configure le nom de l'utilisateur de manière globale
* `git config --global user.email email.utilisateur@domain.com` Configure l'email de l'utilisateur de manière globale
* Fichier `.gitignore` Fichier à créer à la racine du projet. Il doit contenir les noms des fichiers à ignorer (par exemple des fichiers contenant des mots de passe).  
    * Exemple de contenu du fichier `.gitignore` :
        ```
            nomDossierAExclure/
            nomDossier/monFichierA.exclure
            nomFichierA.exclure
        ```
* Eviter que Git ne demande le nom d'utilisateur et le mot de passe tout le temps
    * Sources :
        * [site](https://stackoverflow.com/a/12240995)
        * [site](https://stackoverflow.com/a/14528360)
    * En passant en SSH avec `git remote set-url origin git@github.com:username/repo.git`
    * Ou en enregistrant les identifiants:
        1. `git config --global credential.helper store`
        2. `git config --global credential.helper cache`
        3. (Optionel) `git config --global credential.helper 'cache --timeout=600'` pour mettre une limite de temps
* Créer des alias pour aller plus vite (par exemple pouvoir faire `git st` au lieu de `git status`)
    *   Ouvrir le fichier de configuration de Git `.gitconfig` situé dans le répertoire personnel (`C:\Users\nomDeLUtilisateur` sous windows)
    *   Ajouter à la fin les alias
        ```
            [alias]
                ci = commit
                co = checkout
                st = status
                br = branch
        ```

## Outils

* [Commitzen](https://github.com/commitizen/cz-cli) Assistant de rédaction de messages de commit :
    * Installation
        1. `npm install -g commitizen`
        2. `npm install -g cz-conventional-changelog`
        3. `echo '{ "path": "cz-conventional-changelog" }' > ~/.czrc`
    * Utilisation
        * `git cz`
* [Commitlint](https://commitlint.js.org/#/) Empêche de générer de mauvais messages de commit :
    * Installation
        1. `npm install -g @commitlint/cli @commitlint/config-conventional` installe commitlint.
        2. `echo "module.exports = {extends: ['@commitlint/config-conventional']}" > ~/commitlint.config.js` créé un fichier de configuration.
        4. Tester :
            ```bash
            echo 'should fail' | commitlint
            echo "fix(server): send cors headers" | commitlint
            ```
* [Git hook](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
    1. Configuration de git :
        * `mkdir -p ~/.git/hooks`
        * `git config --global core.hooksPath ~/.git/hooks`
    2. Création du fichier de hook `commit-msg` :
        * `touch ~/.git/hooks/commit-msg`
        * `chmod a+x ~/.git/hooks/commit-msg`
        * Contenu du fichier `commit-msg` :
            ```bash
            #! /bin/bash

            # run any local commit-msg hook first
            if test -e ./.git/hooks/commit-msg
            then
                    sh ./.git/hooks/commit-msg
            fi

            commitlint < $1

            exit $status
            ```

## Utilisation

* `git init` Active le répertoire courant en repository git (ajoute un dossier caché .git au répertoire)
* `git status` Donne le statut du repository (fichiers indexés ou non pouvant faire l'objet d'un commit)
* `git log` Donne les différents commit du repository
* Touche "q" du clavier Permet de sortir du log
* `git add`
    * `git add nomDuFichierAIndexer` Ajoute un fichier à l'index de git pour pouvoir en faire un commit
    * `git add .` Indexe tous les fichiers du repository en vue d'un commit
* `git commit` Permet de créer un commit et ouvre l'éditeur pour inscrire la description du commit
    * `git commit -m "Entrez ici le résumé du commit" -m "Entrez ici la description détaillée du commit"` Permet de créer un commit et d'ajouter la description en même temps.
    * `git commit -a` Le -a permet de créer un commit avec les fichiers qui ont déjà été indexés une fois et sans avoir à les réindexer avec add
    * `git commit --amend` Modifie le dernier commit
* `git reset --hard` Annule les changements qui n'ont pas encore été commités
* `git checkout`
    * `git checkout SHADuCommit` Revenir à un commit précédent
    * `git checkout nomDeLaBranche` Se placer sur le dernier commit d'une branche
    * `git checkout -b nomDeLaNouvelleBranche` Créé une nouvelle branche et nous place dessus
        * `git checkout -b nomDeLaNouvelleBranche SHA_d_un_commit` Créé une nouvelle branche à partir d'un commit particulier et nous place dessus
* `git revert SHADuCommit` Créé un nouveau commit qui fait exactement l'inverse d
* `git branch` Affiche les différentes branches du repository
    * `git branch nomDeLaNouvelleBranche` Créé une nouvelle branche 
        * `git branch nomDeLaNouvelleBranche SHA_d_un_commit` Créé une nouvelle branche à partir d'un commit particulier
    * `git branch -d nomDeLaBrancheASupprimer` Supprime une branche
    * `git branch -D nomDeLaBrancheASupprimer` Supprime une branche et toutes les modifications non commitées
    * `git branch -m nouveauNomDeLaBrancheActive` Renomme la branche active
* `git merge nomDeLaBrancheAFusionner` Permet de fusionner la branche indiquée dans la branche active
    * Par exemple pour ajouter dans une branche A les mises à jour que vous avez faites dans une autre branche B, on se place dans la branche A avant d'exécuter la commande `git merge brancheB`
* `git blame nomDuFichier` Liste toutes les modifications qui ont été faites sur le fichier ligne par ligne. À chaque modification est associé le début du sha du commit correspondant.
* `git show debutCommitSHA` Affiche les détails du commit recherché en saisissant le début de son sha.
* `git stash` met de côté les modifications en cours qui n'ont pas fait l'objet d'un commit pour pouvoir faire d'autres modifications, par exemple lorsque quelqu'un nous demande de régler un bug qui n'a rien à voir avec ce sur quoi on travaille actuellement. On stash notre travail, on règle le bug, on commit les modifications apportées pour régler le bug et on revient sur notre travail avec `git stash pop` ou `git stash apply`.
    * `git stash list` affiche la liste des stash créés.
    * `git stash apply` applique les modifications situées dans le dernier stash créé.
    * `git stash apply stash@{0}` applique les modifications d'un stash particulier.
    * `git stash pop` applique les modifications et les efface du stash.

### Merge

1. Coder sa branche et faire ses commits
2. `git push origin nomBranche` envoie la branche sur GitHub
3. GitHub exécute `git merge nomBranche` pour fusionner la branche `nomBranche` dans la branche master, en créant un commit de merge pour gérer les conflits

Nos commits sont intégrés à l'historique de la branche master de manière chronologique.

### Rebase

1. Coder sa branche et faire ses commits
2. `git pull --rebase origin master` récupère les commits de la master manquants et place nos commits à la suite, modifiant l'historique chronologique
3. `git push force-with-lease` envoie notre branche sans faire de merge

> Nos commits deviennent les plus récents.

### git clone dans un répertoire non vide

1. `git clone urlRepo nomDossierProjet/nomDossierTemporaire` clone le projet dans un dossier temporaire à l'intérieur du dossier du projet.
2. `mv nomDossierProjet/nomDossierTemporaire/.git nomDossierProjet/` déplace le dossier caché `.git` dans le dossier du projet.
3. `rm -rf nomDossierProjet/nomDossierTemporaire` supprime le dossier temporaire et son contenu.
4. `git reset --hard HEAD` recréé les fichiers et dossiers du projet dans le dossier du projet (git pense qu'ils ont été supprimés et restaure le projet).