# WIM

## Lancer VIM

* Exécuter `vim` ou `vi`

## Quitter VIM

* Appuyer sur `Echap` pour être sûr d'être en mode normal
* Quitter
    * Taper `:q` puis `Entrée`
* Quitter sans enregistrer
    * `:q!`
* Enregistrer et quitter
    * `:wq`

## Lancer le tutoriel

* Exécuter `vimtutor`

## Principe

* Opérateur, mouvement et quantificateur
    * exemple : `d2w` qui efface 2 mots entiers à partir du curseur
        * `d` : l'opérateur (ici effacer)
        * `2` : le quantificateur
        * `w` : le mouvement (ici le mot entier)
    * Taper un nombre avant un mouvement le répète autant de fois.
        * exemple : `2w` déplace le curseur de 2 mots

## Navigation

* Déplacement du curseur en mode normal
    * Déplacement par caractère
        * Touches fléchées
        * Touches hjkl
        * `0` place le curseur au début de la ligne
    * Déplacement par mot
        * `w` place le curseur en début de mot
        * `e` place le curseur en fin de mot
        * On peut se déplacer de plusieurs mots à la fois en ajoutant un nombre devant la lettre
            * exemple : `4w` déplace de 4 mots
    * Déplacement par ligne
        * `1` déplace d'une ligne vers le bas
        * `2` déplace de 2 lignes vers le bas
        * `3` déplace de 3 lignes vers le bas
        * ...

## Edition de texte

* On ouvre un fichier avec la commande `vim nomDuFichier`
* On accède au mode normal avec la touche `Echap`
* Effacer le caractère en cours
    * `x`
* Insérer du texte
    * Appuyer sur `i`
    * Taper le texte désiré
    * Appuyer sur `Echap` pour revenir en mode normal
* Ajouter du texte à la fin de la ligne en cours
    * Appuyer sur `A`
    * Taper le texte désiré
    * Appuyer sur `Echap` pour revenir en mode normal
* Effacer un mot
    * Se placer sur la première lettre du mot en mode normal
    * Taper `dw` ou `de`
        * `dw` efface jusqu'au début du prochain mot
        * `de` efface jusqu'à la fin du mot courant
* Effacer du curseur jusqu'à la fin de la ligne
    * `d$`
* Effacer du curseur jusqu'au début de la ligne
    * `d0`
* Effacer une ligne complète
    * `dd`

## Enregistrer

* `:w` en mode normal

## Annuler et refaire

* Annuler la dernière commande
    * `u`
* Annuler toutes les modifications apportées à la ligne courante
    * `U`
* Refaire la dernière commande
    * `ctl + r`

## Rechercher

* En mode normal
    * `/texteARechercher` cherche vers le bas.
    * `?texteARechercher` cherche vers le haut.
    * `n` va vers la prochaine occurence.
    * `N` va vers la précédente occurence.
    * `%` quand le curseur est sur une parenthèse pour aller à la parenthèse correspondante ({[]}).

## Rechercher et remplacer

* `:s/texteARemplacer/texteDeRemplacement/g` change toutes les occurences du texte dans la ligne courante (on peut omettre `/g` pour ne remplacer que la première occurence).
* `#,#s/texteARemplacer/texteDeRemplacement/g` change toutes les occurences du texte entre 2 lignes (remplacer les `#` par des numéros de ligne).
* `%s/texteARemplacer/texteDeRemplacement/g` change toutes les occurences du texte dans tout le fichier.
* `%s/texteARemplacer/texteDeRemplacement/gc` change toutes les occurences du texte dans tout le fichier avec demande de confirmation pour chaque remplacement.