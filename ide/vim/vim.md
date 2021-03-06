# VIM

## Installation

* `sudo apt-get install vim-gtk` installe vim et son GUI. Permet au passage d'utiliser le clipboard.
    
## Configuration

* Pour l'instance de vim en cours *(en mode normal)* :
    * `:set NomOption?` affiche l'état de l'option `NomOption`;
    * `:set NomOption` active l'option `NomOption`.
        * `:set NomOption=valeurOption` affecte la valeur `valeurOption` à l'option `NomOption`.
    * `:set noNomOption` désactive l'option `NomOption`.
* `~/.vimrc` fichier de configuration de VIM
    * Récupérer la version d'exemple `/etc/vim/vimrc` :
        ```bash
        cp /etc/vim/vimrc  ~/.vimrc
        ```
    * Quelques options pratiques :
        ```
        set mouse=a		" Enable mouse usage (all modes)
        set number      " Show line numbers
        set showcmd		" Show (partial) command in status line.
        set showmatch		" Show matching brackets.
        set background=dark " Dark background
        "set ignorecase		" Do case insensitive matching
        "set smartcase		" Do smart case matching
        "set incsearch		" Incremental search
        "set autowrite		" Automatically save before commands like :next and :make
        "set hidden		" Hide buffers when they are abandoned
        ```
    * Indentation
        ```
        filetype plugin indent on
        " show existing tab with 4 spaces width
        set tabstop=4
        " when indenting with '>', use 4 spaces width
        set shiftwidth=4
        " On pressing tab, insert 4 spaces
        set expandtab
        ```
        ou
        ```
        set expandtab       "Use softtabstop spaces instead of tab characters for indentation
        set shiftwidth=4    "Indent by 4 spaces when using >>, <<, == etc.
        set softtabstop=4   "Indent by 4 spaces when pressing <TAB>

        set autoindent      "Keep indentation from previous line
        set smartindent     "Automatically inserts indentation in some cases
        set cindent         "Like smartindent, but stricter and more customisable
        ```

## Utilisation

* Lancer vim
    * `vi` ou `vim` lance vim dans le terminal.
    * `gvim` lance le GUI de vim.
    * `vimtutor` lance le tutoriel
    * `vi nomFichier` ou `vim nomFichier` ouvre un fichier avec vim.
* Changer de mode
    * `Echap` mode normal
        * `:` mode commande
            * `:!` mode commande externe (exemple `ls`)
    * `i` mode insertion
    * `a` mode ajout
* Mode normal :
    * `opérateurQuantificateurMouvement` exécute la commande de l'`opérateur` sur le `Mouvement` un certain nombre de fois (correspondant au `Quantificateur`). Exemples :
        * `2w` déplace le curseur de 2 mots. Ici l'`opérateur` est vide, le `Quantificateur` est `2` et le `Mouvement` est `w`.
        * `d2w` efface 2 mots entiers à partir du curseur :
            * `d` : l'opérateur (ici effacer).
            * `2` : le quantificateur.
            * `w` : le mouvement (ici le mot entier).
    * Mouvements :
        * `OpérateurOpérateur` applique l'opérateur sur la ligne entière. Exemple : `yy` pour copier la ligne.
        * `0` va au début de la ligne.
        * `$` va à la fin de la ligne.
        * `h` va à gauche.
        * `j` va en bas.
        * `k` va en haut.
        * `l` va à droite.
        * `gg` va à la première ligne du fichier.
        * `G` va à la dernière ligne du fichier.
            * `1987G` va à la ligne numéro 1987.
* Enregistrer le fichier *(en mode normal)*
    * `:w` enregistre le fichier.
        * `:w nomFichier` enregistrer sous un nom particulier.
* Quitter vim *(en mode normal)*
    * `:q` quitte vim si aucun changement n'a été fait.
    * `:q!` quitte sans enregistrer.
    * `:wq` enregistre et quitte vim.
    * `:x` ou `ZZ` enregistre seulement si des modifications ont été faites.
* Annuler et refaire
    * `u` annule la dernière commande.
    * `U` annule toutes les modifications apportées à la ligne du curseur.
    * `ctl + r` refait la dernière commande.
* Navigation *(en mode normal)*
    * Déplacement du curseur en mode normal
        * Déplacement par caractère
            * Touches fléchées
            * Touches hjkl
            * `0` place le curseur au début de la ligne
            * `$` place le curseur à la fin de la ligne
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
* Edition de texte
    * Ajout *(en mode normal)*
        * `i` passe en mode *insertion* pour ajouter du texte au niveau du curseur.
        * `A` passe en mode *ajout* pour ajouter du texte à la fin de la ligne du curseur.
    * Copier / coller depuis le clipboard système *(en mode normal)*
        * `"+y` + `mouvement` copie.
        * `"+p` + `mouvement` colle. `p` seul fonctionne aussi.
    * Indentation
        * *(en mode normal)*
            * `>` décale vers la droite.
            * `<` décale vers la gauche.
        * *(en mode insertion)*
            * `ctl + t` décale vers la droite (`t` pour `tab`).
            * `ctl + d` décale vers la gauche (`d` pour `de-tab`).
    * Effacement *(en mode normal)*
        * `x` efface le caractère sous le curseur.
        * `d4l` ou `d4 + flèche droite` efface 4 caractères à droite du curseur.
        * `d4h` ou `d4 + flèche gauche` efface 4 caractères à gauche du curseur.
        * `dw` efface du curseur jusqu'au début du prochain mot.
        * `de` efface du curseur jusqu'à la fin du mot courant.
        * `d$` efface du curseur jusqu'à la fin de la ligne.
        * `d0` efface du curseur jusqu'au début de la ligne.
        * `dd` efface toute la ligne du curseur.
        * `#dd` efface plusieurs lignes où `#` est le nombre de lignes.
        * `p` coller les dernières lignes effacées
    * Insertion
        * `:r nomFichier` insère un fichier à la position du curseur (l'autocomplétion avec `tab` fonctionne !).
* Rechercher *(en mode normal)*
    * `/texteARechercher` cherche vers le bas.
    * `?texteARechercher` cherche vers le haut.
    * `n` va vers la prochaine occurence.
    * `N` va vers la précédente occurence.
    * `%` quand le curseur est sur une parenthèse pour aller à la parenthèse correspondante *({[]})*.
* Rechercher et remplacer *(en mode normal)*
    * `:s/texteARemplacer/texteDeRemplacement/g` change toutes les occurences du texte dans la ligne courante (on peut omettre `/g` pour ne remplacer que la première occurence).
    * `#,#s/texteARemplacer/texteDeRemplacement/g` change toutes les occurences du texte entre 2 lignes (remplacer les `#` par des numéros de ligne).
    * `%s/texteARemplacer/texteDeRemplacement/g` change toutes les occurences du texte dans tout le fichier.
    * `%s/texteARemplacer/texteDeRemplacement/gc` change toutes les occurences du texte dans tout le fichier avec demande de confirmation pour chaque remplacement.
* Diviser l'écran
    * `:sp` divise l'écran horizontalement.
        * `:sp nomFichier` divise l'écran horizontalement et ouvre un fichier dans la partie haute.
    * `:vsp` divise l'écran verticalement.
        * `:vsp nomFichier` divise l'écran verticalement et ouvre un fichier dans la partie gauche.
    * `ctl` + `w` passe en mode action :
        * `w` change de viewport.
        * `h` ou `j` ou `k` ou `l` change de viewport selon la direction de la touche utilisée.
        * `+` agrandit le viewport actuel.
        * `-` réduit le viewport actuel.
        * `=` égalise les dimensions des viewports.
        * `r` ou `R` change la position des viewports.
        * `q` ferme le viewport actuel.
        
        