# Nuxt.js

## Installation

[Documentation](https://nuxtjs.org/guide/installation)

1. Créer un dossier pour le projet contenant un fichier `package.json` :
    
    ```bash
    mkdir <project-name>
    cd <project-name>
    touch package.json
    ```

    Contenu du fichier `package.json` initial :

    ```json
    {
        "name": "my-app",
        "scripts": {
            "dev": "nuxt",
            "build": "nuxt build",
            "start": "nuxt start",
            "generate": "nuxt generate"
        }
    }
    ```
1. Installer Nuxt :

    ```bash
    npm install --save nuxt
    ```
1. Créer un dossier `pages` :

    ```bash
    mkdir pages
    ```

    Dans ce dossier se trouveront les pages de l'application.
1. Créer un fichier `pages/index.vue` :

    ```vue
    <template>
        <h1>Hello world!</h1>
    </template>
    ```
1. Lancer l'application :

    ```bash
    npm run dev
    ```

Contenu du fichier `package.json` final :

```json
{
    "name": "my-app",
    "scripts": {
        "dev": "nuxt",
        "build": "nuxt build",
        "start": "nuxt start",
        "generate": "nuxt generate"
    },
    "dependencies": {
        "nuxt": "^2.13.3"
    }
}
```

## Modules

- nuxt/content

    Permet entre autre de gérer du contenu Markdown.

    ```bash
    npm install @nuxt/content
    ```

    `package.json` :

    ```json
    {
        "dependencies": {
            "@nuxt/content": "^1.4.1",
            "nuxt": "^2.13.3"
        }
    }
    ```

    Configuration :

    ```js
    export default {
        modules: [
            "@nuxt/content",
        ],
    };
    ```