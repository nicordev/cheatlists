# Bash

> Bourne Again SHell

## Utilisation

* Créer un script bash
    1. Créer un fichier avec ou sans l'extension `.sh`.
    2. A la première ligne du fichier, écrire où se trouve l'exécutable du shell dans un commentaire : `#!/bin/bash`.
    3. Ecrire le reste des commandes désirées. Exemple :
        ```bash
        #!/bin/bash

        # Ceci est un commentaire.
        echo 'Hello world!' # Et echo une commande, tout comme pwd, ls, cat...
        ```
* Exécuter un script bash
    * Soit en utilisant le chemin relatif ou absolu vers l'emplacement du fichier :
        * `cheminVersMonScript/nomScript.sh nomParamètre1 nomParamètre2` exécute le script.
    * Soit comme une commande :
        1. `echo $PATH` affiche les dossiers contenant les commandes.
        2. Copier ou déplacer le fichier du script dans l'un des dossiers affiché.
        3. Exécuter directement `nomScript.sh` n'importe où. La classe !
* Variables :
    * `nomVariable=valeurVariable` affecte une valeur à une variable. Attention à ne pas mettre d'espace autour du signe `=`.
* Quotes :
    * `'Hello $nom!'` les simples quotes `''` stockent la chaîne telle quelle. Ici : `Hello $nom!`.
    * `'Hello $nom!'` les doubles quotes `""` stockent la chaîne avec les valeurs des variables qu'elle contient. Ici : `Hello Bob!`.
    * ``nomCommande`` les backticks `` ` `` exécutent la commande.
* `echo $nomVariable1$nomVariable2` affiche des variables. 
    * Chaque nom de variable doit être précédée du symbole `$`.
    * `-e` active les retours à la ligne avec le caractère `\n` (même dans des simples quotes). Exemple : `echo -e 'Hello\nworld!'`
* `read nomVariable1 nomVariable2` demande la saisie de valeurs pour des variables.
    * `read -p 'Entrez une valeur puis une autre : ' nomVariable1 nomVariable2` affiche un message avant de demander la saisie (prompt).
    * `-n nombreCaractèresMax nomVariable` limite le nombre de caractère maximum à stocker. Exemple : `read -p 'Entrez une valeur (5 caractères max) : ' -n 5 nomVariable`.
    * `-t nombreSecondes` limite le temps autorisé pour la saisie. Exemple : `read -p 'Entrez le code de désamorçage de la bombe (vous avez 5 secondes) : ' -t 5 code`.
    * `-s nomVariable` masque les caractères entrés. Exemple : `read -p 'Entrez votre mot de passe : ' -s pass`.
* `let "expression"` effectue des calculs sur des entiers. Exemples :
    ```bash
    let "a = 5 * 3" # echo $a affiche 15
    let "a = 4 ** 2" # echo $a affiche 16 (4 au carré)
    let "a = 8 / 2" # echo $a affiche 4
    let "a = 10 / 3" # echo $a affiche 3 (la partie flottante est enlevée)
    let "a = 10 % 3" # echo $a affiche 1
    ```
* Variables d'environnement :
    * Variables utilisables depuis n'importe quel programme (variables globales).
    * `env` affiche les variables d'environnement (leur nom et leur valeur). Exemples :
        * `SHELL` le shell en cours d'utilisation.
        * `PATH` la liste des répertoires contenant des programmes pouvant être lancé en entrant le nom de leur fichier directement dans la console.
        * `EDITOR` le nom de l'éditeur de texte par défaut.
        * `HOME` l'emplacement du dossier `home`.
        * `PWD` l'emplacement du dossier courant.
        * `OLDPWD` l'emplacement du dossier dans lequel on était avant.
