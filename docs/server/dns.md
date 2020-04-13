# Serveurs DNS

* [cours](https://openclassrooms.com/fr/courses/1243111-gerer-son-nom-de-domaine)

## Fonctionnement

* Adresses IP et noms de domaine :
    * Une adresse ip correspond à un nom d'hôte et sert à identifier un ordinateur.
* FQDN : Fully Qualified Domain Name, soit l'URL avec un point à la fin pour représenter la racine des noms de domaine (exemple *www.siteduzero.com.*).
* Niveaux de domaines visibles dans un FQDN de la droite vers la gauche (exemple *www.siteduzero.com.*) :
    * *.* (qui n'est pas affiché) 13 serveurs racine qui contiennent l'adresse des serveurs de premier niveau.
    * *com* top level domain (TLD), serveurs DNS chargés des domaines (com, fr, net...) qui connaissent les adresses des serveurs de second niveau.
    * *siteduzero* second niveau, serveurs DNS connaissant les équivalences nom de domaine / IP et les sous-domaines.
    * *www* sous-domaine.
* 127 niveaux de domaines possibles (aa.bb.cc.dd.ee.ff.[...].com).
* Chaque FAI (fournisseurs d'accès internet) propose un serveur DNS faisant l'intermédiaire entre les internautes et les véritables serveurs DNS en interrogeant ces derniers :
    1. L'utilisateur demande *www.siteduzero.com*.
    2. Le serveur DNS du FAI interroge le serveur DNS racine pour connaître l'ip du serveur DNS chargé du domaine *com*.
    3. Le serveur DNS du FAI interroge le serveur DNS de *com* pour connaître l'ip du serveur DNS chargé de *siteduzero*.
    4. Le serveur DNS du FAI interroge le serveur DNS de *siteduzero* pour connaître l'ip du serveur DNS chargé du sous-domaine *www*.
    5. Le serveur DNS du FAI renvoie l'ip du serveur DNS chargé du sous-domaine *www* à l'utilisateur et enregistre dans son cache la correspondance entre l'ip du serveur DNS chargé du sous-domaine et l'url *www.siteduzero.com*.
* Obtenir un nom de domaine auprès d'un *registrar*

