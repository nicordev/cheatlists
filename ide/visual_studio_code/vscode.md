# Visual studio code

## Installation

- [VSCodium](https://vscodium.com/)
    1. `wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -`
    1. `echo 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list`
    1. `sudo apt update && sudo apt install codium`
* [vscode pour Ubuntu](https://linuxize.com/post/how-to-install-visual-studio-code-on-ubuntu-18-04/)
    1. First, update the packages index and install the dependencies by typing:
        ```
        sudo apt update
        sudo apt install software-properties-common apt-transport-https wget
        ```
    2. Next, import the Microsoft GPG key using the following wget command:
        ```
        wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
        ```
        And enable the Visual Studio Code repository by typing:
        ```
        sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
        ```
    3. Once the apt repository is enabled, install the latest version of Visual Studio Code with:
        ```
        sudo apt update
        sudo apt install code
        ```

## Extension

- Installer une extension manuellement :
    1. Chercher l'extension sur le [marketplace](https://marketplace.visualstudio.com/VSCode).
    1. Cliquer sur *Resources > Download extension* dans le panneau de droite.
    1. Dans le menu extension de VSCodium : *... > Install from VSIX*

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