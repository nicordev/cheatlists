# MariaDB

## Installation

* Manjaro
    1. `pacman -S mariadb` installe MariaDB.
    1. `sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql` ou `/usr/bin/mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql` pour mettre en place les tables si cela n'a pas été fait automatiquement.
    1. `systemctl start mysqld` démarre le service.
    1. `systemctl enable mysqld` lance le service au démarrage du système.
    1. `sudo mysql_secure_installation` ajoute un mot de passe à l'utilisateur `root`.
* Ubuntu
    1. `sudo apt-get install mariadb-server` installe la dernière version de MariaDB.
    2. `sudo mysql_secure_installation` lance l'utilitaire pour sécuriser MariaDB et sélectionner le mot de passe root.

## Utilisation

* `mysql -u root -p` permet de se connecter.
    * En cas d'erreur **ERROR 1698 (28000): Access denied for user 'root'@'localhost'** :
        1. `sudo mysql -u root -p` connecte l'utilisateur *root*.
        2. `GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'motDePasseDeRootIci';` règle le problème.

## Configuration

* `sudo mysql_secure_installation` configure les options, notamment le mot de passe root