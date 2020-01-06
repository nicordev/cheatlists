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

## Configurer VIM

* `~/.vimrc` fichier de configuration de VIM
    * Indentation
        ```
        set expandtab       "Use softtabstop spaces instead of tab characters for indentation
        set shiftwidth=4    "Indent by 4 spaces when using >>, <<, == etc.
        set softtabstop=4   "Indent by 4 spaces when pressing <TAB>

        set autoindent      "Keep indentation from previous line
        set smartindent     "Automatically inserts indentation in some cases
        set cindent         "Like smartindent, but stricter and more customisable
        ```

## Lancer le tutoriel

* Exécuter `vimtutor`

## Ouvrir un fichier

* `vi nomFichier` ou `vim nomFichier`

## Changer de mode

* `Echap` mode normal
* `i` mode insertion
* `a` mode ajout

## Principe

* Opérateur, mouvement et quantificateur
    * exemple : `d2w` qui efface 2 mots entiers à partir du curseur
        * `d` : l'opérateur (ici effacer)
        * `2` : le quantificateur
        * `w` : le mouvement (ici le mot entier)
    * Taper un nombre avant un mouvement le répète autant de fois.
        * exemple : `2w` déplace le curseur de 2 mots

## Navigation

> En mode normal

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
* `G` va à la fin du fichier

## Edition de texte

> En mode normal

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
* Effacer plusieurs lignes
    * `#dd` où `#` est le nombre de lignes
* Coller les dernières lignes effacées
    * `p`

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

> En mode normal

* `/texteARechercher` cherche vers le bas.
* `?texteARechercher` cherche vers le haut.
* `n` va vers la prochaine occurence.
* `N` va vers la précédente occurence.
* `%` quand le curseur est sur une parenthèse pour aller à la parenthèse correspondante ({[]}).

## Rechercher et remplacer

> En mode normal

* `:s/texteARemplacer/texteDeRemplacement/g` change toutes les occurences du texte dans la ligne courante (on peut omettre `/g` pour ne remplacer que la première occurence).
* `#,#s/texteARemplacer/texteDeRemplacement/g` change toutes les occurences du texte entre 2 lignes (remplacer les `#` par des numéros de ligne).
* `%s/texteARemplacer/texteDeRemplacement/g` change toutes les occurences du texte dans tout le fichier.
* `%s/texteARemplacer/texteDeRemplacement/gc` change toutes les occurences du texte dans tout le fichier avec demande de confirmation pour chaque remplacement.
