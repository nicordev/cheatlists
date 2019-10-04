# Authentification

## Fonctionnement général d'une application Symfony

Toutes les requêtes sont redirigées vers le front controller, en l'occurence le fichier `public/index.php`, qui va :
1. Appeler le fichier `config/bootstrap.php` pour charger les variables d'environnement présentes dans le fichier `.env` situé à la racine du projet ou ses dérivés (`.env.local`, `.env.test`)
2. Instancier un objet `App\Kernel $kernel` en fonction de l'environnement choisi via `APP_ENV=nomEnvironnement` dans le fichier `.env` retenu (`.env.local` par exemple)
3. Instancier un objet `Symfony\Component\HttpFoundation\Request $request` contenant toutes les informations de la requête
4. Passer l'objet `$request` au `$kernel` pour construire un objet `Symfony\Component\HttpFoundation\Response $response`
5. Envoyer la réponse via `$response->send()` (contenant les instructions php `header` pour l'envoi des headers et `echo` pour le contenu de la réponse)
6. Exécuter les dernières opérations du `$kernel` avant sa fermeture

## Connexion

Un utilisateur peut être soit anonyme, soit authentifié.

Une classe implémentant `Symfony\Component\Security\Core\User\UserInterface` doit

Le fichier `security.yaml` contient les paramètres liés à l'authentification :
```yaml
security:
    encoders:
        App\Entity\User: bcrypt # Encodeur utilisé pour hacher les mots de passe

    providers:
        doctrine:
            entity:
                class: 'App\Entity\User' # Classe utilisé pour représenter un utilisateur. Elle doit implémenter l'interface Symfony\Component\Security\Core\User\UserInterface
                property: 'username' # Propriété utilisée pour identifier un utilisateur
        in_memory: { memory: null }

    firewalls:
        dev:
            pattern: ^/(_(profiler|wdt)|css|images|js)/
            security: false
        main:
            anonymous: ~
            pattern: ^/
            form_login:
                login_path: login # URI utilisée pour s'authentifier
                check_path: login_check # URI utilisée par le formulaire d'authentification
                always_use_default_target_path:  true
                default_target_path:  / # Une fois l'utilisateur authentifié, il sera redirigé sur cette URI
            logout: ~

    access_control: # Limite l'accès à certaines routes
        - { path: ^/login, roles: IS_AUTHENTICATED_ANONYMOUSLY } # Ici tout le monde peux accéder à cette URI
        - { path: ^/users, roles: ROLE_ADMIN } # Seul les utilisateurs authentifiés et ayant le rôle ROLE_ADMIN peuvent accéder aux URI commençant par /users
        - { path: ^/, roles: ROLE_USER } # Seuls les utilisateurs authentifiés peuvent accéder aux URI commençant par / (car tous les utilisateurs authentifiés ont le rôle ROLE_USER)

    role_hierarchy:
        ROLE_USER: ~ # Le rôle ROLE_USER n'a pas de rôle enfant (il est présent néanmoins ici pour pouvoir le lister dans le formulaire de création d'utilisateur)
        ROLE_ADMIN: ROLE_USER # Un utilisateur ayant le rôle ROLE_ADMIN possèdera automatiquement le ROLE_USER
```

Pour être authentifié, un utilisateur anonyme doit se rendre sur `/login`, entrer ses identifiants (nom d'utilisateur et mot de passe) et soumettre le formulaire.

Une requête `POST` sur `/login_check` contenant les identifiants est alors envoyée au serveur pour être traitée par le front controller.

Lorsque l'évènement `kernel.request` est lancé, le listener `Symfony\Component\Security\Http\Firewall\UsernamePasswordFormAuthenticationListener` du firewall `Symfony\Component\Security\Http\Firewall` va procéder à l'authentification proprement dite. Il va notamment :
1. Vérifier le token CSRF du formulaire s'il existe
2. Appeler son `Symfony\Component\Security\Core\Authentication\AuthenticationProviderManager` pour :
    1. Enregistrer le nom de l'utilisateur inscrit dans le formulaire dans la session (`$_SESSION`) avec la clé `_security.last_username`
    1. Récupérer l'utilisateur dans la base de données correspondant au nom d'utilisateur envoyé via le formulaire
    1. Vérifier que le compte n'est pas bloqué, désactivé ou expiré
    1. Vérifier que le mot de passe envoyé via le formulaire correspond à celui de l'utilisateur récupéré dans la base de données en utilisant l'encoder spécifié dans le fichier `security.yaml`
    1. Placer l'utilisateur récupéré dans un `Symfony\Component\Security\Core\Authentication\Token\UsernamePasswordToken $authenticatedToken`
    1. Lancer un événement `security.authentication.success` si tout s'est bien passé ou `security.authentication.failure` en cas de problème
3. Créer une réponse de redirection vers la page d'acceuil (URI `/` précisé dans le fichier `security.yaml`) si l'authentification a réussi.

Les informations de l'utilisateur authentifié sont ensuite placées dans un token en JSON appelé *security token*. Ce token est stocké dans la session avec la clé `_security_nomDuFireWallUtilisé` par le `Symfony\Component\Security\Http\Firewall\ContextListener` lorsque l'événement `kernel.response` est lancé.

Une nouvelle requête est alors traitée pour accéder à la page d'accueil. Les données de l'utilisateur connecté sont alors extraites du token stocké dans la session.

## Connecté

Une fois l'utilisateur connecté, il peut accéder aux routes accessibles par son rôle grâce au token stocké dans la session. Une fois la session détruite, il devra s'authentifier de nouveau pour accéder au contenu protégé.

## Déconnexion

Lorsque l'utilisateur connecté clique sur le iien "Se déconnecter", une requête est envoyée avec l'URI `/logout`.

Au moment du lancement de l'événement `kernel.request`, le listener `Symfony\Component\Security\Http\Firewall\LogoutListener` du firewall va déconnecter l'utilisateur en supprimant la session et en créant une nouvelle via un appel à la fonction php `session_regenerate_id()`.

Une redirection est alors lancée vers la page d'accueil. Comme l'utilisateur est déconnecté, il est ensuite redirigé vers la page de connexion.

