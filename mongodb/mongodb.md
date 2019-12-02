# MongoDB

## Intallation

[Ubuntu](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/)
[Windows](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-windows/#run-mongodb-from-cmd)

## Utilisation

* `sudo service mongod start` démarre MongoDB
* `sudo service mongod status` affiche le status
* `sudo service mongod stop` arrête MongoDB
* `sudo service mongod restart` redémarre MongoDB
* `mongo` lance le shell

## Shell

* `db` affiche la base de données sélectionnée
* `use nomBDDIci` sélectionne une base de données (existante ou non)
* `db.nomCollection.insertOne( { x: 1 } );` si la base de données sélectionnée n'existe pas, créé la base de données et ajoute la collection `nomCollection` avec un document `{ x: 1 }`