# FOS Rest Bundle

## QueryParams

* Dans `fos_rest.yaml`
    ```yaml
    fos_rest:
        param_fetcher_listener: force
    ```

## API dans un site web en /api/*

* Dans `fos_rest.yaml`
    ```yaml
    format_listener:
        rules:
            - { path: ^/api, priorities: [json], fallback_format: json }
            - { path: ^/, priorities: [html], fallback_format: html }
    ```