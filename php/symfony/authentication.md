# Authentification

[Doc Security](https://symfony.com/doc/current/security.html)
[Doc Authentication](https://symfony.com/doc/current/components/security/authentication.html)
[Doc Login form](https://symfony.com/doc/current/security/form_login_setup.html)
[Doc Guard](https://symfony.com/doc/current/security/guard_authentication.html)

## Intallation

* `composer require symfony/security-bundle`

## Utilisation

* `php bin/console make:user` créé une classe implémentant l'UserInterface et tout le bazar associé

## Mots de passe

* `php bin/console security:encode-password` encode un mot de passe
* Injecter `Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface $passwordEncoder` dans le constructeur d'une classe pour pouvoir encoder un mot de passe :
    ```php
    $user = new User();
    $user->setPassword($this->passwordEncoder->encodePassword(
        $user,
        'the_new_password'
    ));
    ```