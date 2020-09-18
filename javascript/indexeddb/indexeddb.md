# IndexedDB

[Tuto MDN](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API/Using_IndexedDB)

On intéragit avec une base de données en créant une requête sous forme d'un objet JS :

```js
const requestOnDatabase = indexedDB.open(databaseName, databaseVersion);
```

Cette requête dispose de 3 événements : `onsuccess`, `onerror`, `onupgradeneeded` auxquels on peut attacher des callbacks :

```js
const requestOnDatabase = indexedDB.open(databaseName, databaseVersion);

requestOnDatabase.onsuccess = function (event) {
    console.log('Success creating/accessing IndexedDB database');
    const database = event.target.result;
};

requestOnDatabase.onerror = function (event) {
    console.error('Error from indexeddb');
}

requestOnDatabase.onupgradeneeded = function (event) {
    const database = event.target.result;
    const objectStore = database.createObjectStore('tableName', { keyPath: 'propertyNameUsedAsId' });
};
```


1. Open a database.
1. Create an object store in the database. 
1. Start a transaction and make a request to do some database operation, like adding or retrieving data.
1. Wait for the operation to complete by listening to the right kind of DOM event.
1. Do something with the results (which can be found on the request object).
