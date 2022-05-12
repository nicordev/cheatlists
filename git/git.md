# Git

## GUI

* [GitKraken](https://www.gitkraken.com/)
* [GitAhead](https://gitahead.github.io/gitahead.com/)
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

Utiliser un modèle de message pour les commits :
1. Créer un fichier .txt contenant le modèle :

    > [source](https://dev.to/timmybytes/keeping-git-commit-messages-consistent-with-a-custom-template-1jkm)

    Les lignes commençant par `#` sont juste des commentaires :

    ```


    # ----------------------------------------------------------
    # Header - type(target): Brief description
    # ----------------------------------------------------------
    #   * feat         A new feature
    #   * fix          A bug fix
    #   * docs         Changes to documentation only
    #   * style        Style/format changes (whitespace, etc.)
    #   * refactor     Changes not related to a bug or feature
    #   * perf         Changes that affects performance
    #   * test         Changes that add/modify/correct tests
    #   * build        Changes to build system (configs, etc.)
    #   * ci           Changes to CI pipeline/workflow
    # ----------------------------------------------------------


    # ----------------------------------------------------------
    # Body - More detailed description, if necessary
    # ----------------------------------------------------------
    #   * Motivation behind changes, more detail into how 
    # functionality might be affected, etc.
    # ----------------------------------------------------------


    # ----------------------------------------------------------
    # Footer - Associated issues, PRs, etc.
    # ----------------------------------------------------------
    #   * Ex: Resolves Issue #207, see PR #15, etc.
    # ----------------------------------------------------------
    ```

1. Sélectionner le modèle à utiliser pour les commits :

    ```bash
    git config --global commit.template path/to/your/file.txt
    ```

1. [hors service] Configurer l'éditeur de texte, ici vim, et commencer à la ligne 14 :

    ```bash
    git config --global core.editor=vim +14 -c 'startinsert'
    ```

Fichier `.gitignore` Fichier à créer à la racine du projet. Il doit contenir les noms des fichiers à ignorer (par exemple des fichiers contenant des mots de passe) : 
* Exemple de contenu du fichier `.gitignore` :

    ```
    nomDossierAExclure/
    nomDossier/monFichierA.exclure
    nomFichierA.exclure
    ```
- Pour éviter tout le contenu d'un dossier, placer dans le dossier un fichier `.gitignore` contenant :

    ```
    *
    ```

Ignorer des fichiers/dossiers globalement :
1. `git config --get core.excludesfile` voir où se situe le fichier global (par exemple `~/.gitignore_global`)
1. Ajouter les fichiers et dossiers à ignorer dans ce fichier comme dans un fichier `.gitignore` classique :

    ```
    .phpunit.result.cache
    .scannerwork/
    .idea/
    .vscode/

    please_nicor.sh
    .draft/
    ```
1. (optionel) `git config --global core.excludesFile 'nomFichier'` change le fichier global par `nomFichier`

Eviter que Git ne demande le nom d'utilisateur et le mot de passe tout le temps :
* Sources :
    * [site](https://stackoverflow.com/a/12240995)
    * [site](https://stackoverflow.com/a/14528360)
* En passant en SSH avec `git remote set-url origin git@github.com:username/repo.git`
* Ou en enregistrant les identifiants:
    1. `git config --global credential.helper store`
    2. `git config --global credential.helper cache`
    3. (Optionel) `git config --global credential.helper 'cache --timeout=600'` pour mettre une limite de temps

Créer des alias pour aller plus vite (par exemple pouvoir faire `git st` au lieu de `git status`)
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

* `git fetch origin` mets à jour le dépôt local avec le remote.
* `git init` Active le répertoire courant en repository git (ajoute un dossier caché .git au répertoire)
* `git status` Donne le statut du repository (fichiers indexés ou non pouvant faire l'objet d'un commit)
* `git log` Donne les différents commit du repository
    * `git log --oneline` affiche l'historique des commits avec une ligne par commit.
    * `git log --graph` affiche une ligne de couleur pour chaque branche.
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
* `git revert SHADuCommit` Créé un nouveau commit qui fait exactement l'inverse du commit indiqué.
* `git branch` Affiche les différentes branches du repository
    * `git branch nomDeLaNouvelleBranche` Créé une nouvelle branche 
        * `git branch nomDeLaNouvelleBranche SHA_d_un_commit` Créé une nouvelle branche à partir d'un commit particulier
    * `git branch -d nomDeLaBrancheASupprimer` Supprime une branche
    * `git branch -D nomDeLaBrancheASupprimer` Supprime une branche et toutes les modifications non commitées
    * `git branch -m nouveauNomDeLaBrancheActive` Renomme la branche active
* `git merge nomDeLaBrancheAFusionner` Permet de fusionner la branche indiquée dans la branche active
    * Par exemple pour ajouter dans une branche A les mises à jour que vous avez faites dans une autre branche B, on se place dans la branche A avant d'exécuter la commande `git merge brancheB`
    - `git merge --abort` abandonne le merge en cours.
* `git blame nomDuFichier` Liste toutes les modifications qui ont été faites sur le fichier ligne par ligne. À chaque modification est associé le début du sha du commit correspondant.
* `git show debutCommitSHA` Affiche les détails du commit recherché en saisissant le début de son sha.
* `git stash` met de côté les modifications en cours qui n'ont pas fait l'objet d'un commit pour pouvoir faire d'autres modifications, par exemple lorsque quelqu'un nous demande de régler un bug qui n'a rien à voir avec ce sur quoi on travaille actuellement. On stash notre travail, on règle le bug, on commit les modifications apportées pour régler le bug et on revient sur notre travail avec `git stash pop` ou `git stash apply`. [Documentation](https://www.git-scm.com/docs/git-stash) :
    * `git stash list` affiche la liste des stash créés.
    * `git stash apply` applique les modifications situées dans le dernier stash créé.
        * `git stash apply numéroDuStash` applique les modifications d'un stash particulier.
    * `git stash pop` applique les modifications et les efface du stash.
        * `git stash pop numéroDuStash` applique les modifications d'un stash particulier.
    * `git stash push [-m message] [cheminVers/fichierCible1 cheminVers/fichierCible2 ...]` permet d'ajouter un message à notre stash et de cibler les fichiers contenant les modifications à mettre de côté.

### Tag

- `git tag -d nomTag` supprime un tag en local
- Changer la version d'une branche (tag) :
    1. Se placer sur la branche désirée.
    1. `git tag nomTag` ajoute le tag `nomTag`.
    1. `git push --tags` envoi le nouveau tag sur le repository.
- `git fetch --tags` récupère tous les tags.

### Merge

1. Coder sa branche et faire ses commits
2. `git push origin nomBranche` envoie la branche sur GitHub
3. GitHub exécute `git merge nomBranche` pour fusionner la branche `nomBranche` dans la branche master, en créant un commit de merge pour gérer les conflits

Nos commits sont intégrés à l'historique de la branche master de manière chronologique.

### Rebase

* Annuler un rebase :
    1. `git reflog` affiche un historique montrant le dernier rebase.
    2. `git checkout shaDuDernierCommitAvantRebase` se place sur le dernier commit avant le rebase.
    3. `git reset --hard shaDuDernierCommitAvantRebase` annule le rebase.
* `git rebase nomBrancheARécupérer` insère les commits de `nomBrancheARécupérer` avant les commits de la branche active. Fonctionnement :
    1. revient au commit commun entre la branche courante et la branche à récupérer.
    2. applique les commits de la branche à récupérer.
    3. applique les commits de la branche courante.
* `git rebase nomDeMaBranche nomBrancheARécupérer` applique les commits de `nomBrancheARécupérer` dans `nomDeMaBranche` avant d'appliquer ceux de `nomDeMaBranche`.
* Rebase d'une branche venant d'un autre repository :
    1. `git remote add nomAutreRemote https://github.com/nomUtilisateur/nomRepository.git` créé un nouveau remote pointant vers le repository contenant la branche désirée.
    2. `git fetch nomAutreRemote` récupère les branches de l'autre repository.
    3. `git checkout nomBranche` se place sur la branche `nomBranche`.
    4. `git rebase nomAutreRemote\nomBrancheDésirée` applique les commits de notre branche à la suite de ceux de `nomBrancheDésirée`.
    5. `git push -f origin nomBranche` si on peine à pusher notre branche ayant subit le rebase.
* Méthode :
    1. Coder sa branche et faire ses commits.
    2. `git pull --rebase origin master` récupère les commits de la master manquants et place nos commits à la suite, modifiant l'historique chronologique.
    3. `git push force-with-lease` envoie notre branche sans faire de merge.

    > Nos commits deviennent les plus récents.

- `git rebase --onto nomNouvelleBrancheDeBase nomBrancheDeBaseDeLaBrancheAModifier nomBrancheAModifier` change la branche de base d'une branche et lance un rebase en évitant les commits de l'ancienne branche de base.

### git clone dans un répertoire non vide

1. `git clone urlRepo nomDossierProjet/nomDossierTemporaire` clone le projet dans un dossier temporaire à l'intérieur du dossier du projet.
2. `mv nomDossierProjet/nomDossierTemporaire/.git nomDossierProjet/` déplace le dossier caché `.git` dans le dossier du projet.
3. `rm -rf nomDossierProjet/nomDossierTemporaire` supprime le dossier temporaire et son contenu.
4. `git reset --hard HEAD` recréé les fichiers et dossiers du projet dans le dossier du projet (git pense qu'ils ont été supprimés et restaure le projet).

### Créer un remote distant

1. Dans le dossier où l'on veut créer notre remote distant :

    ```
    git init --bare
    ```
1. Dans le dossier de notre projet :

    ```
    git remote add nomRemote remoteInfo
    ```

    Où `remoteInfo` peut être :
    - en local : `nomUtilisateur@127.0.0.1:cheminRelatifAuRépertoireUtilisateur`
    - à distance : l'URL du remote

## squash commits

> [source](https://gitbetter.substack.com/p/how-to-squash-git-commits)

Pour squash les commits d'une branche au merge dans une autre branche :

```bash
git merge --squash target_branch_name
```

Pour regrouper (squash) les 3 derniers commits en un seul dans la branche actuelle :
1. ```bash
    git rebase -i HEAD~3
    git rebase --interactive HEAD~3
    ```
1. remplacer `pick` par `squash` pour les 2 plus anciens commits
1. enregistrer & quitter
1. entrer le message du commit restant
1. enregistrer & quitter

A creuser, à priori ça aide lorsque quelqu'un a force push:
```
git rebase --onto <new-branch-to-move-to> <last-change-that-should-NOT-move> <last-change-to-move>
```
