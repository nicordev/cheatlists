# Jekyll

[Site officiel](https://jekyllrb.com/)

## Quick start

1. Installer Ruby :
    ```bash
    sudo apt-get install ruby-full build-essential zlib1g-dev
    echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
    echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
    echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
    ```
1. Installer Jekyll :
    ```bash
    gem install jekyll bundler
    ```
1. Créer un site web :
    ```bash
    jekyll new nomSite
    cd nomSite
    bundle exec jekyll serve
    # => Now browse to http://localhost:4000
    ```

## Usage

Langage de templating : liquid

- Activé en ajoutant au minimum :

    ```
    ---
    ---
    ```

- On peut :
    - Mettre des variables entre les 2 lignes de `---`
    - Appliquer des filtres avec le `|`

    Exemple :

    ```html
    ---
    nomVariable: Valeur
    ---
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>{{ page.nomVariable }}</title>
        </head>
        <body>
            <h1>{{ "Hello World!" | downcase }}</h1>
        </body>
    </html>
    ```

Dossier `_layouts` :

1. Créer un fichier html dans le dossier `_layouts/` :

    ```html
    <!doctype html>
    <html>
        <head>
            <meta charset="utf-8">
            <title>{{ page.title }}</title>
        </head>
        <body>
            {{ content }}
        </body>
    </html>
    ```
1. A inclure dans un fichier html ou markdown en utilisant le bloc de code liquid :

    ```html
    ---
    layout: default
    title: Home
    ---
    <h1>{{ "Hello World!" | downcase }}</h1>
    ```

Dossier `_includes` :

1. Créer un fichier html ou markdown dans le dossier `_includes`.
1. Inclure ce fichier avec `{% include nomFichier.html %}`.

    Exemple :

    ```html
    <!-- _layouts/default.html -->
    <body>
        {% include navigation.html %}
        {{ content }}
    </body>
    ```

Dossier `assets` :

Contient les fichiers CSS, JS et images.
