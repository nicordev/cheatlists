# Authentification

[Doc Security](https://symfony.com/doc/current/security.html)
[Doc Authentication](https://symfony.com/doc/current/components/security/authentication.html)
[Doc Login form](https://symfony.com/doc/current/security/form_login_setup.html)
[Doc Guard](https://symfony.com/doc/current/security/guard_authentication.html)

## Intallation

* `composer require symfony/security-bundle`

## Utilisation

* Créer un système d'authentification [doc](https://symfony.com/doc/current/security.html) :
    * `php bin/console make:user` créé une classe implémentant l'UserInterface et tout le bazar associé.
    * `php bin/console make:auth` créé un formulaire de login.
* Mots de passe :
    * `php bin/console security:encode-password` encode un mot de passe
    * Injecter `Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface $passwordEncoder` dans le constructeur d'une classe pour pouvoir encoder un mot de passe :
        ```php
        $user = new User();
        $user->setPassword($this->passwordEncoder->encodePassword(
            $user,
            'the_new_password'
        ));
        ```
* Vérifier les rôles d'un utilisateur :
    * Dans une classe via la méthode `isGranted` de `Symfony\Component\Security\Core\Authorization\AuthorizationCheckerInterface`.
    * Dans un template twig :
        ```twig
        {% if is_granted('ROLE_ADMIN') %}
            <a href="...">Delete</a>
        {% endif %}
        ```