# Hautelook Alice Bundle

Génère des fausses données.

## Environment specific fixtures

[doc](https://github.com/hautelook/AliceBundle/blob/master/doc/advanced-usage.md#environment-specific-fixtures)

1. Put your fixtures files in separate folders which names correspond to the right environment into the `fixtures/` folder like that:

    ```
    .
    └── fixtures/
        ├── environmentless-fixture1.yml
        ├── ...
        ├── environmentNameHere
        |   ├── prod-fixture1.yml
        |   ├── ...
        └─── dev
                ├── dev-fixture1.yml
                └── ...
    ```

2. Execute `php bin/console hautelook:fixtures:load --env=environmentNameHere` to load only the fixtures located in the `environmentNameHere/` folder