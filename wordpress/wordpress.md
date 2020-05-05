# WordPress

## Installation 

1. Télécharger l'archive .zip à [wordpress.org](https://wordpress.org/download/).
1. Placer le contenu de l'archive dans le dossier du projet.
1. Créer une base de données MySQL.
1. Lancer un serveur PHP `php -S localhost:8000 -t nomDossierWordpress`.
1. Configurer WordPress :
    - Graphiquement en se rendant sur [localhost:8000](http://localhost:8000).
    - En créant un fichier `wp-config.php` en se basant sur `wp-config-sample.php`.

## Sécurité

- Ajouter un préfixe aux noms des tables

## Thème enfant

1. Créer un dossier `nomThèmeEnfant` dans `wp-content/themes`.
1. Copier les fichiers `functions.php` et `style.css` présents dans `wp-content/themes/nomThèmeParent` dans le dossier du thème enfant.
1. Modifier le bloc de commentaire du fichier `style.css` du thème enfant :
    ```css
    /*
    Theme Name: nomDossierThèmeEnfant
    Template: nomDossierThèmeParent
    ```
1. Remplacer le contenu du fichier `functions.php` du thème enfant par :
    ```php
    <?php
    add_action( 'wp_enqueue_scripts', 'theme_enqueue_styles' );

    function theme_enqueue_styles() {
        wp_enqueue_style( 'parent-style', get_template_directory_uri() . '/style.css' );
        wp_enqueue_style( 'child-style', get_stylesheet_uri(), ['parent-style'] );
    }
    ```
    pour charger le fichier CSS du thème enfant en plus de celui du thème parent.
1. Activer le thème enfant dans le tableau de bord de WordPress *Apparence > Thèmes*.

## Créer un thème

> [Documentation](https://developer.wordpress.org/themes/getting-started/)
> [Publier son thème sur le web](https://wordpress.org/themes/getting-started/)

Créer un dossier `nomThèmeMaison` dans `wp-content/themes` contenant au minimum 2 fichiers :
- `style.css` contenant :
    ```css
    /*
    Theme Name: nomThèmeMaison
    Author: nomAuteur
    Description: descriptionThèmeMaison
    Version: numéroVersion
    Tags: NomTag1, NomTag2, NomTag3
    */
    ```
- `index.php` contenant le skelette HTML. 
    > Bidouille : Le fichier CSS peut être chargé via :
    > ```php
    > <link href="<?php echo get_bloginfo('template_directory'); ?>/nomFichier.css" rel="stylesheet">
    > ```

Créer un fichier `functions.php` pour :
- Charger les fichiers JS et CSS :
    
    > [Documentation](https://developer.wordpress.org/themes/basics/including-css-javascript/)

    - Fichiers CSS :
        ```php
        wp_enqueue_style(string $nomFichierSansExtension, string $cheminFichier, array $autreFichiers = [], ?float $numéroVersion = null, ?string $media = null);
        // Exemple de code minimum :
        wp_enqueue_style('nomFichierSansExtension', get_template_directory_uri() . '/css/nomFichier.css');
        ```

    - Fichiers JS :
        ```php
        wp_enqueue_script(string $nomFichierSansExtension, string $cheminFichier, ?array $autreFichiers = false, ?float $numéroVersion = null, bool $inFooter);
        // Exemple de code minimum :
        wp_enqueue_style('style', get_stylesheet_uri());
        wp_enqueue_script( 'nomFichierSansExtension', get_template_directory_uri() . '/js/nomFichier.js', array ( 'jquery' ), 1.1, true);
        ```
    
    Regrouper le tout dans une action :
    ```php
    function add_theme_scripts() {
        wp_enqueue_style( 'style', get_stylesheet_uri() );
        
        wp_enqueue_style( 'slider', get_template_directory_uri() . '/css/slider.css', array(), '1.1', 'all');
        
        wp_enqueue_script( 'script', get_template_directory_uri() . '/js/script.js', array ( 'jquery' ), 1.1, true);
        
        if ( is_singular() && comments_open() && get_option( 'thread_comments' ) ) {
            wp_enqueue_script( 'comment-reply' );
        }
    }
    
    add_action( 'wp_enqueue_scripts', 'add_theme_scripts' );
    ```
