# MongoDB

## Intallation

[Ubuntu](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/)
[Manjaro](https://www.vultr.com/docs/how-to-install-mongodb-4-0-on-arch-linux)
[Manjaro Wiki](https://wiki.archlinux.org/index.php/MongoDB)
[Windows](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-windows/#run-mongodb-from-cmd)

### Extension MongoDB pour PHP

* Avec [PECL](https://www.php.net/manual/fr/mongodb.installation.pecl.php)
    1. `sudo pecl install mongodb` télécharge et compile l'extension
    2. Ajouter `extension=mongodb.so` au fichier `php.ini`

## Utilisation du serveur MongoDB

* `sudo service mongod start` démarre MongoDB
* `sudo service mongod status` affiche le status
* `sudo service mongod stop` arrête MongoDB
* `sudo service mongod restart` redémarre MongoDB

## Utilisation du shell pour communiquer avec le serveur

* `mongo` lance le shell
* `db` affiche la base de données sélectionnée
* `use nomBDDIci` sélectionne une base de données (existante ou non)
* `db.nomCollection.insertOne( { x: 1 } );` si la base de données sélectionnée n'existe pas, créé la base de données et ajoute la collection `nomCollection` avec un document `{ x: 1 }`