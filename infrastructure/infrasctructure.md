# Infrastructure

- Single tenant (ou multi-instance) : 
    
    Client 1 - 1 Environnement

    Un client a son serveur et sa base de données.

    Tenant == locataire. Chaque locataire a sa maison.

- Multi tenant : 

    Client * - 1 Environnement

    Une infrastructure commune à tous les clients.

    Tenant == locataire. Chaque locataire a son appartement dans un immeuble.
    
- Architecture monolithique : 

    une seule application qui fait tout.

- Architecture microservices : 
    
    plusieurs applications spécifiques qui communiquent entre elles.

- API Gateway :
    
    1. Réceptionne une requête venant d'une application.
    1. Envoie cette requête sur les différents services concernées par la requête.
    1. Récupère la réponse des services.
    1. Retourne la réponse.
