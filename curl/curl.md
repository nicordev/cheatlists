# CURL

## Requêtes POST

* [stack](https://superuser.com/questions/149329/what-is-the-curl-command-line-syntax-to-do-a-post-request)
    * `curl --data "param1=value1&param2=value2" https://example.com/resource.cgi`
    * `curl --data "param1=value1" --data "param2=value2" https://example.com/resource.cgi` avec des champs spécifiés individuellement
    * `curl --form "fileupload=@my-file.txt" https://example.com/resource.cgi` mutlipart