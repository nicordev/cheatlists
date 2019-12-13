# PostgreSQL - Errors

## Avec Symfony 4

* **An exception occurred in driver: SQLSTATE[22023]: Invalid parameter value: 7 ERROR:  invalid value for parameter "client_encoding": "utf8mb4"**
    - 2 options :
        - Modifier le fichier *.env.local* en ajoutant `charset=UTF-8` à la fin de la variable `DATABASE_URL` :
            ```
            postgresql://db_user:db_password@127.0.0.1:5432/db_name?serverVersion=11&charset=UTF-8
            ```
        - Modifier le fichier de configuration *config/packages/api_platform.yaml* en remplaçant `utf8mb4` par `utf8`