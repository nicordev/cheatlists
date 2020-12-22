# Bash

> Bourne Again SHell

Ressources externes :
- [Closures](https://gist.github.com/forestbaker/63960a80536dff501f2d)

## Utilisation

Exemples présents là : `/usr/share/doc/util-linux/examples`.

Ecrire un script bash :
1. Créer un fichier avec ou sans l'extension `.sh`.
2. A la première ligne du fichier, écrire où se trouve l'exécutable du shell dans un commentaire (appelé shebang) : `#! /bin/bash`.

    Le shebang peut aussi pointer vers d'autres programmes et contenir des paramètres.
    
    Exemple avec sed :

    ```bash
    #! /usr/bin/sed -f

    # Un peu de code sed :
    3,5d
    ```

3. Ecrire le reste des commandes désirées.

    Exemple :

    ```bash
    #!/bin/bash

    # Ceci est un commentaire.
    echo 'Hello world!' # echo est une commande, tout comme pwd, ls, cat...

    # Paramètres du script :
    $@ # Contient tous les paramètres passés au script
    $0 # Contient le nom du fichier du script avec le chemin complet. Utiliser $(basename $0) pour retirer le chemin.
    $1 # Contient le premier paramètre
    $# # Contient le nombre de paramètres passés au script

    nomFonction() {
        variableGlobale='valeur'
        local variableLocale='valeur'
    }

    greetSomeone() {
        echo "Hello $1" # L'argument "World" est récupéré avec le paramètre $1
    }

    greetSomeone "World" # L'argument "World" est passé à la fonction greetSomeone
    ```

Exécuter un script bash :
* Soit en utilisant le chemin relatif ou absolu vers l'emplacement du fichier :
    * `cheminVersMonScript/nomScript.sh nomParamètre1 nomParamètre2` exécute le script.
* Soit comme une commande :
    1. `echo $PATH` affiche les dossiers contenant les commandes.
    2. Copier ou déplacer le fichier du script dans l'un des dossiers affiché.
    3. Exécuter directement `nomScript.sh` n'importe où. La classe !
- En utilisant le même shell que le terminal actuel :
    
    ```bash
    . nomScript.sh
    ```
    
    ou

    ```bash
    source nomScript.sh
    ```

Debug d'un script :
- Lancer le script précédé de `bash -x` :

    ```bash
    bash -x nomScript.sh
    ```

- Ecrire directement dans le script :
    
    - Activer le debug :

        ```bash
        # du code...
        set -vx
        # suite du code...
        ```

    - Désactiver le debug :

        ```bash
        # du code...
        set +vx
        # suite du code...
        ```

Paramètres d'un script ou d'une fonction :
* `$@` contient les arguments passés à une fonction.
* `$#` contient le nombre de paramètres passés au script.
* `$0` contient le nom du script.
* `$1`, `$2`, [...] `$9` contient la valeur d'un des 9 premiers paramètres.
* `shift` décale les variables `$1` à `$9` d'un paramètre (exemple : `$1` contient maintenant le 2ème paramètre).
* `$?` contient le code retourné par la dernière commande exécutée.

Variables :
* `nomVariable=valeurVariable` affecte une valeur à une variable. Attention à ne pas mettre d'espace autour du signe `=`.
* `$nomVariable` permet d'accéder à la valeur de la variable.

Chaînes de caractères :
* `'Hello $nom!'` les simples quotes `''` stockent la chaîne telle quelle. Ici : `Hello $nom!`.
* `'Hello $nom!'` les doubles quotes `""` stockent la chaîne avec les valeurs des variables qu'elle contient. Ici : `Hello Bob!`.
* ``nomCommande`` les backticks `` ` `` exécutent la commande.

Tableaux :
* `nomTableau=('valeur0' 'valeur1' 'valeur2')` définit un tableau.
* `tableau[index]='valeur'` affecte une valeur à une case, quelque soit la valeur de l'index.
* `${tableau[index]}` accède à la valeur d'une case d'un tableau.

Arrêter un script :

```bash
exit nombreOptionel
```

- `nombreOptionel` : 0 indique que tout c'est bien passé, n'importe quel entier indique une erreur. Par défaut 0

Afficher le contenu d'une variable :

```bash
echo $nomVariable1$nomVariable2`
```

* Chaque nom de variable doit être précédée du symbole `$`.
* `echo ${tableau[*]}` affiche toutes les valeurs d'un tableau.
* `-e` active les retours à la ligne avec le caractère `\n` (même dans des simples quotes). Exemple : `echo -e 'Hello\nworld!'`

Récupérer une saisie au clavier :

```bash
read nomVariable1 nomVariable2
```

* `read -p 'Entrez une valeur puis une autre : ' nomVariable1 nomVariable2` affiche un message avant de demander la saisie (prompt).
* `-n nombreCaractèresMax nomVariable` limite le nombre de caractère maximum à stocker. Exemple : `read -p 'Entrez une valeur (5 caractères max) : ' -n 5 nomVariable`.
* `-t nombreSecondes` limite le temps autorisé pour la saisie. Exemple : `read -p 'Entrez le code de désamorçage de la bombe (vous avez 5 secondes) : ' -t 5 code`.
* `-s nomVariable` masque les caractères entrés. Exemple : `read -p 'Entrez votre mot de passe : ' -s pass`.

Effectuer des calculs sur des entiers :

```bash
let "expression"
```

* Exemples :

    ```bash
    let "a = 5 * 3" # echo $a affiche 15
    let "a = 4 ** 2" # echo $a affiche 16 (4 au carré)
    let "a = 8 / 2" # echo $a affiche 4
    let "a = 10 / 3" # echo $a affiche 3 (la partie flottante est enlevée)
    let "a = 10 % 3" # echo $a affiche 1
    ```

Variables d'environnement :
* Variables utilisables depuis n'importe quel programme (variables globales).
* `env` affiche les variables d'environnement (leur nom et leur valeur). Exemples :
    * `SHELL` le shell en cours d'utilisation.
    * `PATH` la liste des répertoires contenant des programmes pouvant être lancé en entrant le nom de leur fichier directement dans la console.
    * `EDITOR` le nom de l'éditeur de texte par défaut.
    * `HOME` l'emplacement du dossier `home`.
    * `PWD` l'emplacement du dossier courant.
    * `OLDPWD` l'emplacement du dossier dans lequel on était avant.
* `export NOM_VARIABLE` transforme une variable existante en variable d'environnement.

Conditions :
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

    - Regex :
        
        Utiliser `=~` et `[[]]` :

        ```bash
        Email=me@example.com
        
        if [[ "$Email" =~ [a-z]+@[a-z]{2,}\.(com|net|org) ]]
        then
            echo "Valid email!"
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

* Fichiers et dossiers :

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

* AND `&&` OR `||` :

    ```bash
    #!/bin/bash

    if [ $# -ge 1 ] && [ $1 = 'koala' ]; then
        echo 'Quel bel animal !'
    fi

    if [ $1 = 'fraise' ] || [ $1 = 'framboise' ]; then
        echo 'Vive les fruits rouges !'
    fi
    ```

* NOT `!` :

    ```bash
    #!/bin/bash

    if [ ! -e $1 ]; then
        echo "Le fichier ou dossier $1 n'existe pas."
    fi
    ```

* Switch :

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

- Select :
    
    ```bash
    select v in data_list
    do
        statement1
        Statement2
        Statement3
    done
    ```

Fonctions :

- Paramètres :

    - `$#` nombre de paramètres passés à la fonction (ou au script si appelé en dehors d'une fonction).
    - `$@` regroupe tous les paramètres dans un tableau.
    - `$*` concatène tous les paramètres dans une string.
    - `$?` contient la dernière valeur de retour générée par une fonction ou une commande.
    - `$_` contient le dernier paramètre passé à la dernière fonction ou à défaut le nom de la fonction.
    - `$0` nom du script.
    - `$1` contient la valeur du premier paramètre passé à la fonction.
    - `shift` retire un paramètre dans l'ordre croissant (d'abord le 1er, puis le 2ème, etc...)

    Trucs chelou :

    - `$!` Gives the process ID of the last job placed into the background.
    - `$$` Expands to the process ID of the shell or invoking shell in case of subshell.
    - `$-` List special parameters set for bash.

- Exemples

    ```bash
    #!/bin/bash

    sayHelloTo() {
        echo "Hello $1!"
    }

    # Scope

    sayHelloTo "Bob"

    localVariableDemo() {
        local nameAsLocalVariable="Sarah"
        nameAsGlobalVariable="Jean"

        sayHelloTo $nameAsLocalVariable
        sayHelloTo $nameAsGlobalVariable
        sayHelloTo $anotherNameAsGlobalVariable
    }

    anotherNameAsGlobalVariable="Jim"

    localVariableDemo
    sayHelloTo $nameAsLocalVariable # $nameAsLocalVariable is now empty because called outside of its scope.
    ```

    Booléens :

    ```bash
    #!/bin/bash

    filter=$1

    isPhpFile() {
        [[ "$filter" =~ .+\.php ]]
    }

    if isPhpFile; then
        echo "It's a php file!"
    fi
    ```

Boucles

- for ... in ...

    ```bash
    # Boucle qui affiche tous les fichiers commençant par 'zog' du répertoire courant et de ses sous-répertoires.
    for filePath in */zog*; do
        echo $filePath
    done
    ```

- while

    Boucle sur les arguments :

    ```bash
    shiftArguments() {
        while [ ! -z $1 ]; do
            echo "Remaining arguments: $#"
            echo "Shifting $1"
            shift
        done
        echo "Remaining arguments: $#"
    }

    shiftArguments bob sarah jim
    ```
