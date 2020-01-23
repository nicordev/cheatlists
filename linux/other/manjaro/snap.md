# Snapcraft

[site](https://snapcraft.io/)

## Installation pour Manjaro

1. `sudo pacman -S snapd`
1. `sudo systemctl enable --now snapd.socket`
1. `sudo ln -s /var/lib/snapd/snap /snap`
1. `sudo systemctl start --now snapd.socket`

> Erreurs
> - *error: too early for operation, device not yet seeded or device model not acknowledged*
>    - Exécuter `sudo ln -s /var/lib/snapd/snap /snap`