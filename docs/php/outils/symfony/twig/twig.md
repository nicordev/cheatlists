# Twig

# Installation

* `composer require "twig/twig:^2.0"`

## Utilisation

### Routes

* `{{ path(nomRoute, {nomParametre: valeurParametre}) }}` va afficher l'url de la route avec les paramètres

### Formulaires

* Côté contrôleur :
    * On créé une classe `MyFormType` qui hérite de `AbstractType`
    * On utilise cette classe dans notre contrôleur :
        ```php
        $form = $this->createForm(MyFormType::class);
        return $this->render('path/to/myView.html.twig', ["formNameInTemplate" => $form->createView()]);
        ```
* Côté vue :
    * `{{ form(formNameInTemplate) }}` va afficher le formulaire

## Extensions

On peut créer nos propres filtres, fonctions, macros...

[Doc Symfony](https://symfony.com/doc/current/templating/twig_extension.html)