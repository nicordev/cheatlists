# GitHub

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