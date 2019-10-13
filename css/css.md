# CSS

## Variables

[MDN](https://developer.mozilla.org/fr/docs/Web/CSS/Using_CSS_custom_properties)

* Déclaration d'une variable
    ```css
    element {
        --main-bg-color: brown;
    }
    ```
* Utilisation de la variable
    ```css
    element {
        background-color: var(--main-bg-color);
    }
    ```
