# CURL

[doc](https://curl.haxx.se/docs/manual.html)

## Paramètres

- `-s --silent` hide the progress bar
- `-o, --output <file>` write output in a file
- `-w, --write-out <format>` write information about the request

    Get status code:

    ```bash
    curl --write-out '%{http_code}'
    curl -w '%{http_code}'
    ```

## Requêtes GET

* `curl http://mon.super.site`

## Requêtes POST

* [stack](https://superuser.com/questions/149329/what-is-the-curl-command-line-syntax-to-do-a-post-request)
    * `curl --data "param1=value1&param2=value2" https://example.com/resource.cgi`
    * `curl --data "param1=value1" --data "param2=value2" https://example.com/resource.cgi` avec des champs spécifiés individuellement
    * `curl --form "fileupload=@my-file.txt" https://example.com/resource.cgi` mutlipart