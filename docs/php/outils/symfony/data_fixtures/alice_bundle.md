# Hautelook Alice Bundle

Génère des fausses données.

## Environment specific fixtures

[doc](https://github.com/hautelook/AliceBundle/blob/master/doc/advanced-usage.md#environment-specific-fixtures)

1. Put your fixtures files in separate folders which names correspond to the right environment into the `fixtures/` folder like that:

    ```
    .
    └── fixtures/
        ├── environmentless-fixture1.yml
        ├── ...
        ├── environmentNameHere
        |   ├── prod-fixture1.yml
        |   ├── ...
        └─── dev
                ├── dev-fixture1.yml
                └── ...
    ```

2. Execute `php bin/console hautelook:fixtures:load --env=environmentNameHere` to load only the fixtures located in the `environmentNameHere/` folder

## Générer des mots de passe encodés

* Créer un encoder de ce genre :
    ```php
    <?php
    
    namespace App\Helper;

    class PasswordEncoder
    {
        private static $encoder;
        /**
        * @var User
        */
        private static $user;

        public function __construct(EncoderFactoryInterface $encoderFactory)
        {
            self::$user = new User();
            self::$encoder = $encoderFactory->getEncoder(self::$user);
        }

        public static function hashPassword(string $password)
        {
            return self::$encoder->encodePassword($password, self::$user->getSalt());
        }
    }
    ```
* Configurer le service permettant d'encoder les mots de passe dans `services.yaml`
    ```yaml
    services:
        App\Helper\PasswordEncoder:
            tags: [ { name: nelmio_alice.faker.provider } ]
    ```
* Utiliser la méthode statique servant à encoder les mots de passe du service d'encodage
    ```yaml
    App\Entity\User:
        user_{1..10}:
            username: <name()>
            password: '<hashPassword("pwd")>'
    ```
