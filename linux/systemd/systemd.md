# systemd

> [Documentation Ubuntu](https://doc.ubuntu-fr.org/systemd)

- `systemd` pour system daemon.

- 1er programme lancé par le noyau (PID 1).

- Lance tous les programmes suivants en ordre jusqu'à obtenir un système opérationnel pour l'utilisateur, selon le mode déterminé (single user, multi-user, graphique). 

- Redémarre ou arrête l'ordinateur proprement. 

Un service ou daemon est un programme qui tourne en arrière plan et s'active sous certaines conditions.

Par exemple, le service hddtemp surveille la température de vos disques durs et déclenche une alerte si elle dépasse un certain seuil.

Les services sont situés dans le dossier `/etc/systemd/system/`.

Utilisation :
- Démarrer un service :

    ```bash
    systemctl start Nom_du_service.service
    ```

- Arrêter un service :

    ```bash
    systemctl stop Nom_du_service.service
    ```

- Activer un service :

    ```bash
    sudo systemctl enable Nom_du_service.service
    ```

- Désactiver un service :

    ```bash
    sudo systemctl disable Nom_du_service.service
    ```

- Voir l'état d'un service :

    ```bash
    systemctl status Nom_du_service.service
    ```

- Redémarrer un service :

    ```bash
    systemctl restart Nom_du_service.service
    ```

- Recharger un service :

    ```bash
    systemctl reload Nom_du_service.service
    ```

- Lister les services démarrés :

    ```bash
    systemctl list-unit-files '*service' | sort
    ```

- Lister les services lancés au démarrage :

    ```bash
    systemd-analyze blame
    ```