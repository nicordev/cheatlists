# Git et GitHUB

## Git

### Liste des commandes utiles de la console git bash

* `pwd` Donne le répertoire courant
* `ls` Donne la liste des fichiers et répertoires dans le dossier courant
* `ls -l` Affiche une liste des fichiers et répertoires du dossier courant
* `ls -a` Donne des infos supplémentaires
* `cd nomRépertoire` Permet de se placer dans un répertoire
* `cd ..` Permet d'aller au répertoire parent
* `cd ~` Revient au répertoire principal
* `touch nomFichier` Permet de créer un fichier
* `mkdir nomRépertoire` Permet de créer un dossier
* `car nomFichier` Affiche le contenu d'un fichier
* `clear` Efface la console
* `ctl + shift + inser` Permet de coller du texte dans la console

### Configuration

* `git config --list` Liste les paramètres
* `git config --global user.name "Nom utilisateur"` Configure le nom de l'utilisateur de manière globale
* `git config --global user.email email.utilisateur@domain.com` Configure l'email de l'utilisateur de manière globale
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

* Fichier `.gitignore` Fichier à créer à la racine du projet. Il doit contenir les noms des fichiers à ignorer (par exemple des fichiers contenant des mots de passe).  
    * Exemple de contenu du fichier `.gitignore` :
        ```
            nomDossierAExclure/
            nomDossier/monFichierA.exclure
            nomFichierA.exclure
        ```

### Utilisation

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
    * `git branch -m nouveauNomDeLaBrancheActive` Renomme la branche active
* `git merge nomDeLaBrancheAFusionner` Permet de fusionner la branche indiquée dans la branche active
    * Par exemple pour ajouter dans une branche A les mises à jour que vous avez faites dans une autre branche B, on se place dans la branche A avant d'exécuter la commande `git merge brancheB`
* `git blame nomDuFichier` Liste toutes les modifications qui ont été faites sur le fichier ligne par ligne. À chaque modification est associé le début du sha du commit correspondant.
* `git show debutCommitSHA` Affiche les détails du commit recherché en saisissant le début de son sha.
* `git stash` met de côté les modifications en cours qui n'ont pas fait l'objet d'un commit pour pouvoir faire d'autres modifications, par exemple lorsque quelqu'un nous demande de régler un bug qui n'a rien à voir avec ce sur quoi on travaille actuellement. On stash notre travail, on règle le bug, on commit les modifications apportées pour régler le bug et on revient sur notre travail avec `git stash pop` ou `git stash apply`.
    * `git stash apply` applique les modifications.
    * `git stash pop` applique les modifications et les efface du stash.

#### Merge

1. Coder sa branche et faire ses commits
2. `git push origin nomBranche` envoie la branche sur GitHub
3. GitHub exécute `git merge nomBranche` pour fusionner la branche `nomBranche` dans la branche master, en créant un commit de merge pour gérer les conflits

Nos commits sont intégrés à l'historique de la branche master de manière chronologique.

#### Rebase

1. Coder sa branche et faire ses commits
2. `git pull --rebase origin master` récupère les commits de la master manquants et place nos commits à la suite, modifiant l'historique chronologique
3. `git push force-with-lease` envoie notre branche sans faire de merge

Nos commits deviennent les plus récents.

## GitHub

* Récupérer un repository
    *   Taper le nom du repository désiré dans la barre de recherche
    *   Cliquer sur Clone or download
    *   Copier le lien
    *   Exécuter `git clone https://lienCopiéSurGitHub` dans le dossier devant recevoir le repository
* Créer un repository
    *   Cliquer sur le + situé à gauche de l'avatar puis sur new repository
    *   Renseigner le nom, la description et ajouter une licence
    *   Au passage on peut initialiser le repository avec un fichier README.md pour pouvoir immédiatement le cloner sur notre ordi. Inutile si on a déjà un repository sur l'ordi.
* Connecter un repository local avec un repository GitHub
    *   Ouvrir une console dans le repository local
    *   Exécuter `git remote add origin https://github.com/nomUtilisateur/nomProjet`
* Envoyer le code du repository local vers GitHub
    *   Ouvrir une console dans le repository local
    *   Faire un commit des modifications apportées au code
    *   Utiliser la commande `git push origin master` ou, si on travaille sur une branche, `git push origin nomDeLaBranche`
* Récupérer des modifs depuis GitHub vers le repository local
    *   Ouvrir une console dans le repository local
    *   Exécuter `git pull origin master`
* Faire une pull request pour contribuer à un projet open source
    1.  Lire les consignes de contribution dans le _README.md_ du projet
    2.  Sur le repository auquel on veut contribuer, faire un _Fork_ en cliquant sur le bouton _Fork_ du repository
    3.  Cloner le repository sur notre ordi via un `git clone`
    4.  Créer une nouvelle branche dans le repository cloné avec `git checkout -b nomDeLaNouvelleBranche`
    5.  Faire les modifications et faire un commit
    6.  Envoyer les modifications sur GitHUB avec un `git push origin nomDeLaNouvelleBranche`
    7.  Aller sur le repository GitHUB cloné et cliquer sur _Compare & pull-request_
    8.  Rédiger un joli message expliquant le pourquoi du comment et c'est parti !
* touche T : Faire une recherche



