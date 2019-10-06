# Mon super manuel de git et de github

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

### Utilisation de git

* `git config --global user.name "nomDeLUtilisateur"` Configure le nom d'utilisateur de git
* `git config --global user.email "emailDeLUtilisateur"` Configure l'email de l'utilisateur de git
* `git init` Active le répertoire courant en repository git (ajoute un dossier caché .git au répertoire)
* `git status` Donne le statut du repository (fichiers indexés ou non pouvant faire l'objet d'un commit)
* `git log` Donne les différents commit du repository
* Touche "q" du clavier Permet de sortir du log
* `git add nomDuFichierAIndexer.extension` Ajoute un fichier à l'index de git pour pouvoir en faire un commit
* `git add .` Indexe tous les fichiers du repository en vue d'un commit
* `git commit -m "Entrez ici la description du commit"` Permet de créer un commit
* `git commit -a -m "Entrez ici la description du commit"` Le -a permet de créer un commit avec les fichiers qui ont déjà été indexés une fois et sans avoir à les réindexer avec add
* `git checkout SHADuCommit` Revenir à un commit précédent
* `git checkout master` Revenir au dernier commit
* `git revert SHADuCommit` Créé un nouveau commit qui fait exactement l'inverse du précédent (pour annuler le commit précédent)
* `git commit --amend -m "Votre nouveau message pour le dernier commit"` Modifie le message du dernier commit
* `git reset --hard` Annule les changements qui n'ont pas encore été commités
* `git branch` Affiche les différentes branches du repository
* `git branch nomDeLaNouvelleBranche` Créé une nouvelle branche
* `git branch -d nomDeLaBrancheASupprimer` Supprime une branche
* `git checkout nomDeLaBranche` Se placer sur une branche
* `git checkout -b nomDeLaNouvelleBranche` Créé une nouvelle branche et nous place dessus
* `git merge nomDeLaBrancheAFusionner` Permet de fusionner 2 branches  
    * Par exemple pour ajouter dans une branche A les mises à jour que vous avez faites dans une autre branche B, on se place dans la branche A avant d'exécuter la commande `git merge brancheB`
* `git blame nomDuFichier.sonExtension` Liste toutes les modifications qui ont été faites sur le fichier ligne par ligne. À chaque modification est associé le début du sha du commit correspondant.
* `git show debutCommitSHA` Affiche les détails du commit recherché en saisissant le début de son sha.
* Fichier _.gitignore_ Fichier à créer à la racine du projet. Il doit contenir les noms des fichiers à ignorer (par exemple des fichiers contenant des mots de passe).  
    * Exemple de contenu du fichier _.gitignore_ :
```
    nomDossierAExclure/
    nomDossier/monFichierA.exclure
    nomFichierA.exclure
```           

* `git stash` et `git stash pop` ou `git stash apply`
    * `git stash` met de côté les modifications en cours qui n'ont pas fait l'objet d'un commit pour pouvoir faire d'autres modifications, par exemple lorsque quelqu'un nous demande de régler un bug qui n'a rien à voir avec ce sur quoi on travaille actuellement. On stash notre travail, on règle le bug, on commit les modifications apportées pour régler le bug et on revient sur notre travail avec `git stash pop` ou `git stash apply`.
        * La différence entre `pop` et `apply` est que nos modifications sont effacées du stash lors d'un `pop`.

### Edition du fichier de configuration

* Ouvrir le fichier de configuration de Git
    *   Se placer dans le répertoire personnel `C:\Users\nomDeLUtilisateur`
    *   Ouvrir le fichier `.gitconfig`
* Créer des alias pour aller plus vite (par exemple pouvoir faire `git st` au lieu de `git status`)
    *   Ouvrir le fichier de configuration de Git
    *   Ajouter à la fin les alias
```
    [alias]
        ci = commit
        co = checkout
        st = status
        br = branch
```

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



