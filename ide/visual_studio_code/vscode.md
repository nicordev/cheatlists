# Visual studio code

## Installation

[VSCodium](https://vscodium.com/)
1. ```bash
    wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
    ```

1. ```bash
    echo 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list
    ```

1. ```bash
    sudo apt update && sudo apt install codium
    ```

[vscode pour Ubuntu](https://linuxize.com/post/how-to-install-visual-studio-code-on-ubuntu-18-04/)

1. First, update the packages index and install the dependencies by typing:

    ```bash
    sudo apt update
    sudo apt install software-properties-common apt-transport-https wget
    ```

2. Next, import the Microsoft GPG key using the following wget command:

    ```bash
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    ```

    And enable the Visual Studio Code repository by typing:
    
    ```bash
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    ```

3. Once the apt repository is enabled, install the latest version of Visual Studio Code with:

    ```bash
    sudo apt update
    sudo apt install code
    ```

## Extension

Installer une extension manuellement :

1. Chercher l'extension sur le [marketplace](https://marketplace.visualstudio.com/VSCode).
1. Cliquer sur *Resources > Download extension* dans le panneau de droite.
1. Dans le menu extension de VSCodium : *... > Install from VSIX*

Installer une extension depuis un repository :

> [StackOverflow](https://stackoverflow.com/questions/50714638/install-extension-from-a-specific-repo-branch-on-github)

1. Install vsce:

    ```
    npm install -g vsce
    ```

1. Check out the GitHub repo/branch you want.

1. Depending on the project, you may need to install its dependencies (npm install or whatever package manager you use). Some can be packaged without dependencies.

1. Run the following in the root of the project (see the official docs for more detail about the process):

    ```js
    vsce package  # Generates a .vsix file
    code --install-extension my-extension-0.0.1.vsix
    ```


Pour Bash :
- [shellman](https://marketplace.visualstudio.com/items?itemName=Remisa.shellman)
    
    avec l'ebook qui va bien : https://github.com/yousefvand/shellman-ebook
- [Bash debug](https://github.com/rogalmic/vscode-bash-debug)

Pour PHP :
- [PHP Intelephense](https://github.com/bmewburn/vscode-intelephense)
- [PHP Debug](https://github.com/felixfbecker/vscode-php-debug)
- [PHP Namespace Resolver](https://github.com/MehediDracula/PHP-Namespace-Resolver)

Pour Docker :
- [Docker](https://github.com/microsoft/vscode-docker)

## Utilisation

* `code nomDossier` ouvre Visual Studio Code.
* Raccourcis clavier
    * `alt + click gauche` ajoute des curseurs (`ctl + click gauche` peut être sélectionné dans *Selection > Switch to Ctrl+Click for Multi-Cursor*).
    * `ctl + shift + flèche haut/bas` ajoute des curseurs.
    * `ctl + d` ajoute un curseur sur le prochain mot similaire à la sélection en cours et l'ajoute à la sélection.

## Configuration

* Sauvegarde automatique `File > Preferences > Settings > Files: Auto Save > after delay`
* Raccourcis clavier `File > Preferences > Keyboard Shortcuts` :
    * `View: Toggle Integrated Terminal` affiche ou masque le terminal (`ctl + ù`).
    * `openInTerminal` ouvre le fichier en cours dans un terminal.
    * `workbench.action.terminal.kill` arrête le terminal en cours.
* Modifier le fichier `settings.json` :
    * Entrer `settings.json` dans la barre de recherche et cliquer sur le lien.
    * Utiliser Emmet dans d'autres fichiers que html (ici `.vue`, `.js` et `.twig`) :
        ```json
        "emmet.includeLanguages": {
            "twig": "html",
            "vue": "html",
            "javascript":"javascriptreact"
        },
        "emmet.triggerExpansionOnTab": true
        ```

## Snippet

> [FreeCodeCamp](https://www.freecodecamp.org/news/definitive-guide-to-snippets-visual-studio-code/)