# VuePress

## Quick start

```bash
# install globally
yarn global add vuepress # OR npm install -g vuepress

# create the project folder
mkdir vuepress-starter && cd vuepress-starter

# create a markdown file
echo '# Hello VuePress' > README.md

# start writing
vuepress dev

# build
vuepress build
```

## Dans un projet existant

1. Exécuter les commandes suivantes :
    ```bash
    # install as a local dependency
    yarn add -D vuepress # OR npm install -D vuepress

    # create a docs directory
    mkdir docs
    # create a markdown file
    echo '# Hello VuePress' > docs/README.md
    ```
1. Modifier le fichier `package.json` :
    ``` json
    {
        "scripts": {
            "docs:dev": "vuepress dev docs",
            "docs:build": "vuepress build docs"
        }
    }

    ```
1. `yarn docs:dev # OR npm run docs:dev` démarre un serveur de développement.
1. `yarn docs:build # OR npm run docs:build` génère des fichiers statiques.

## Arborescence

. (Website folder)
├── docs (VuePress website root folder)
│   ├── .vuepress (Optional)
│   │   ├── components (Optional)
│   │   ├── theme (Optional)
│   │   │   └── Layout.vue
│   │   ├── public (Optional)
│   │   ├── styles (Optional)
│   │   │   ├── index.styl
│   │   │   └── palette.styl
│   │   ├── templates (Optional, Danger Zone)
│   │   │   ├── dev.html
│   │   │   └── ssr.html
│   │   ├── config.js (Optional)
│   │   └── enhanceApp.js (Optional)
│   │ 
│   ├── README.md (Ou index.md, accessible via /)
│   ├── nomDossier
│   │   └── README.md (ou index.md, accessible via /nomDossier)
│   │   └── nomFichier.md (ou index.md, accessible via /nomDossier/nomFichier.html)
│   └── nomFichier.md (accessible via /nomFichier.html)
│ 
└── package.json

## Configuration

> - [Doc générale](https://vuepress.vuejs.org/guide/basic-config.html#theme-configuration)
> - [Doc détaillée](https://vuepress.vuejs.org/config/#basic-config)

Créer un fichier de configuration en `.js`, `.yaml` ou `.toml` dnas le dossier `.vuepress/` :
- `.vuepress/config.js` :
    ```js
    module.exports = {
        title: 'Hello VuePress',
        description: 'Just playing around'
    }
    ```