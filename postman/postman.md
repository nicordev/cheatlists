# Postman

## Pre-request scripts

Variables:
```js
pm.variables.set('product_id', 10022)
console.log(pm.variables.get('product_id'))
```

Basic authentication:

```js
// Fill your email and password
const email = "";
const password = "";

// Encode email:password using base64
const base64Credentials = btoa(`${email}:${password}`);

// Send request to fetch API token
pm.sendRequest({
    url: pm.collectionVariables.get("host url variable name here") + "/authenticate.json",
    method: 'GET',
    header: {
        'Accept': 'application/json',
        'Authorization': `Basic ${base64Credentials}`
    },
}, function (err, res) {
    console.log(res.json());
    pm.collectionVariables.set("token variable name here", res.json().api_token);
});
```

Login:

```js
// Fill your username and password
const username = "";
const password = "";

const loginUrl = pm.collectionVariables.get("host url variable name here") + '/api/login_check';
const bodyContent = {
    username,
    password
};

// Send request to fetch API token
pm.sendRequest({
    url: loginUrl,
    method: 'POST',
    header: {
        'Content-Type': 'application/json',
    },
    body: {
      mode: 'raw',
      raw: JSON.stringify(bodyContent)
    }
}, function (error, response) {
    if (error) {
        console.error(error);
        return 
    }

    pm.collectionVariables.set("token variable name here", response.json().tokenKeyHere);
});
```

## Test scripts

```js
function getResponseBody() {
    return pm.response.json()
}
```