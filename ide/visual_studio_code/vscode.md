# Visual studio code

## Installation

* [Ubuntu](https://linuxize.com/post/how-to-install-visual-studio-code-on-ubuntu-18-04/)
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

## Utilisation

* `code nomDossier` ouvre Visual Studio Code.

## Configuration

* Sauvegarde automatique `File > Preferences > Settings > Files: Auto Save > after delay`
* Raccourcis clavier `File > Preferences > Keyboard Shortcuts` :
    * `View: Toggle Integrated Terminal` affiche ou masque le terminal