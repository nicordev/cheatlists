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

Visualization using JsonPath:
- [documentation](https://www.postman.com/postman/workspace/postman-team-collections/documentation/1794236-eab3402a-73ab-4b3d-99c9-62a4bf180e5a)

```js
let template = `
<html>
<head>
    <script src="https://cdn.jsdelivr.net/npm/jsonpath@1.0.2/jsonpath.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.min.js"></script>
</head>
<body>
    <div>
      <div>
        <input id="filter" style="width:450px;" type="text" placeholder="Example query: $..name.first">
      </div>
      <div>
        <button id="resetButton" style="background-color:red;color:white;">Reset</button>
        <input id="showErrors" type="checkbox" value="1"/>
        <span class="item-text" style="font-family:courier;">Show Evaluation Errors</span>
      </div>
      <div id="errors" style="font-family:courier;color:red;display:none;"></div>
      <div>
        <p id="content" style="font-family:courier;color:green;font-size:18px;"></p>
      </div>
    </div>
</body>
</html>

<script>
pm.getData( (error, value) => {
    const extractedData = jsonpath.query(value, '$');

    $(function() {
        $('#filter').keyup(function() {
            try {
                let filteredData = jsonpath.query(extractedData, $(this).val());
                $("#content, #errors").empty();
                $("#content").append("<pre><code>" + JSON.stringify(filteredData, null, 4) + "</code></pre>");
            } catch (err) {
                console.info(err);
                $("#errors").empty();
                $("#errors").append("<pre><code>" + err + "</code></pre>");
            }
        });
    });

    $( "#resetButton" ).click(function() {
        $("#content, #errors").empty();
        $("#filter").val('');
        $("#content").append("<pre><code>" + JSON.stringify(extractedData, null, 4) + "</code></pre>");
    })
})

$(function() {
  $("#showErrors").on("click",function() {
    $("#errors").toggle(this.checked);
  });
});
</script>`

pm.visualizer.set(template, pm.response.json())
```