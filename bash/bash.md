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
* Paramètres d'un script :
    * `$#` contient le nombre de paramètres passés au script.
    * `$0` contient le nom du script.
    * `$1`, `$2`, [...] `$9` contient la valeur d'un des 9 premiers paramètres.
    * `shift` décale les variables `$1` à `$9` d'un paramètre (exemple : `$1` contient maintenant le 2ème paramètre).
* Variables :
    * `nomVariable=valeurVariable` affecte une valeur à une variable. Attention à ne pas mettre d'espace autour du signe `=`.
    * `$nomVariable` permet d'accéder à la valeur de la variable.
* Quotes :
    * `'Hello $nom!'` les simples quotes `''` stockent la chaîne telle quelle. Ici : `Hello $nom!`.
    * `'Hello $nom!'` les doubles quotes `""` stockent la chaîne avec les valeurs des variables qu'elle contient. Ici : `Hello Bob!`.
    * ``nomCommande`` les backticks `` ` `` exécutent la commande.
* Tableaux :
    * `nomTableau=('valeur0' 'valeur1' 'valeur2')` définit un tableau.
    * `tableau[index]='valeur'` affecte une valeur à une case, quelque soit la valeur de l'index.
    * `${tableau[index]}` accède à la valeur d'une case d'un tableau.
* `exit nombreOptionel` arrête un script.
* `echo $nomVariable1$nomVariable2` affiche des variables. 
    * Chaque nom de variable doit être précédée du symbole `$`.
    * `echo ${tableau[*]}` affiche toutes les valeurs d'un tableau.
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
    * `export NOM_VARIABLE` transforme une variable existante en variable d'environnement.
* Conditions :
    * Chaînes de caractères :
        ```bash
        #!/bin/bash

        if [ $1 = "Bruno" ]
        then
                echo "Salut Bruno !"
        elif [ $1 = "Michel" ]
        then
                echo "Bien le bonjour Michel"
        else
                echo "J'te connais pas, ouste !"
        fi
        ```
        * Tester si une chaîne est vide :
            ```bash
            #!/bin/bash

            if [ -z $1 ]
            then
                    echo "C'est vide."
            fi
            ```
        * Tester si une chaîne n'est pas vide :
            ```bash
            #!/bin/bash

            if [ -n $1 ]
            then
                    echo "C'est plein."
            fi
            ```
    * Nombres :
        ```bash
        #!/bin/bash

        if [ $1 -eq 20 ]
        then
            echo "20 est égal à $1.";
        fi

        if [ $1 -ne 20 ]
        then
            echo "$1 est différent de 20.";
        fi

        if [ $1 -lt 20 ]
        then
            echo "$1 est inférieur à 20.";
        fi

        if [ $1 -le 20 ]
        then
            echo "$1 est inférieur ou égal à 20.";
        fi

        if [ $1 -gt 20 ]
        then
            echo "$1 est supérieur à 20.";
        fi

        if [ $1 -ge 20 ]
        then
            echo "$1 est supérieur ou égal à 20.";
        fi
        ```
    * Fichiers et dossiers
        ```bash
        #!/bin/bash
        if [ -e $1 ]; then
            echo "$1 existe."
        fi

        if [ -d $1 ]; then
            echo "$1 est un répertoire."
        fi

        if [ -f $1 ]; then
            echo "$1 est un fichier."
        fi

        if [ -L $1 ]; then
            echo "$1 est un lien symbolique."
        fi

        if [ -r $1 ]; then
            echo "$1 est accessible en lecture."
        fi

        if [ -w $1 ]; then
            echo "$1 est accessible en écriture."
        fi

        if [ -x $1 ]; then
            echo "$1 est exécutable."
        fi

        if [ $1 -nt $2 ]
        then
            echo "$1 est plus récent que $2."
        fi

        if [ $1 -ot $2 ]
        then
            echo "$1 est plus ancien que $2."
        fi
        ```
    * AND `&&` OR `||`
        ```bash
        #!/bin/bash

        if [ $# -ge 1 ] && [ $1 = 'koala' ]; then
            echo 'Quel bel animal !'
        fi

        if [ $1 = 'fraise' ] || [ $1 = 'framboise' ]; then
            echo 'Vive les fruits rouges !'
        fi
        ```
    * NOT `!`
        ```bash
        #!/bin/bash

        if [ ! -e $1 ]; then
            echo "Le fichier ou dossier $1 n'existe pas."
        fi
        ```
    * Switch
        ```bash
        case $1 in
            "Bruno" | "Paul" | "Bob")
                echo "Salut Bob ou Paul ou Bruno !"
                ;;
            "Michel")
                echo "Bien le bonjour Michel"
                ;;
            "Jean")
                echo "Hé Jean, ça va ?"
                ;;
            *)
                echo "J'te connais pas, ouste !"
                ;;
        esac
        ```
* Fonctions
    ```bash
    #!/bin/bash
    
    sayHelloTo() {
        echo "Hello $1!"
    }

    sayHelloTo "Bob"
    ```