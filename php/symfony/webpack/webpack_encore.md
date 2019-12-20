# Utiliser Webpack Encore

[Documentation](https://symfony.com/doc/current/frontend.html)

Prérequis :
* Installer [yarn](https://yarnpkg.com/fr/)

## Installation

Exécuter `composer require encore` puis `yarn install`

## Utilisation

Exécuter `yarn encore dev` pour compiler les *assets* (fichiers situés dans le dossier `assets/` situé à la racine du projet).

Exécuter `yarn encore dev --watch` pour recompiler automatiquement les fichiers si on fait des modifications.

## Configuration

Voir dans le fichier `webpack.config.js` situé à la racine du projet.
>Si vous avez exécuté `yarn encore dev --watch` alors il faudra l'arrêter et le relancer après vos modifications.
