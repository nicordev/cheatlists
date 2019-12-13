# MariaDB

## Installation

* Manjaro
    1. `pacman -S mariadb` installe MariaDB
    1. `sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql` ou `/usr/bin/mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql` pour mettre en place les tables si cela n'a pas été fait automatiquement
    1. `systemctl start mysqld` démarre le service
    1. `systemctl enable mysqld` lance le service au démarrage du système
    1. Ajouter un mot de passe à l'utilisateur `root`