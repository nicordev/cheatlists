# Cookies en JavaScript

Ajouter/modifier un cookie :

```js
document.cookie = 'myCookieName=myCookieValue'
```

Supprimer un cookie :

```js
document.cookie = 'myCookieName=myCookieValue; expires=' + (new Date(0)).toUTCString()
```
