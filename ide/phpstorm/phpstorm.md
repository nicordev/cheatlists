# PhpStorm

## Pour n'importe quoi : Double shift > Actions

Afficher le menu View : `view`

## Obtenir un compte

Inscrit toi sur le site de supinfo, tu vas devenir discovery member, ça va te donner accès a une adresse @supinfo.com
Et tu vas pouvoir profiter de toute la suite intelliJ gratuitement, il faudra juste renouveler tous les ans, mais comme tu garde ton email @supinfo.com a vie, pas de soucis là dessus.
https://enrolment.supinfo.com/NewCandidate.aspx?lang=fr

## Utiliser cmder

* Faire une variable d'environnement pour le dossier de cmder, par exemple `CMDER_ROOT` qui pointe sur `C:\projects\cmder`
* Mettre `"cmd.exe" /k ""%CMDER_ROOT%\vendor\init.bat""` dans `Settings > Tools > Terminal : Shell path`

## Raccourcis clavier

* `ctl x2` ouvre un prompt qui sauvegarde les commandes saisies.
* `shift + Echap` ferme la fenêtre du bas (terminal, debug...).
* `alt + shift + click gauche + glisser la souris` ajoute des curseurs.
- `ctl + alt + enter` déroule un fichier xml

## Inspection du code

- Installer le plugin **Php Inspections (EA Extended)**
- *Settings > Editor > Inspections* pour choisir les règles à utiliser.
- *Code > Run inspection by name* pour lancer une règle en particulier.

## xdebug

- *Settings > Language & Frameworks > PHP > Servers* bidouiller le mapping jusqu'à ce que ça fonctionne.
- `ctl + shift + F8` affiche les points d'arrêts.

## behaviour

[original post](https://intellij-support.jetbrains.com/hc/en-us/community/posts/207074075/comments/360001817819)

For those who would want simple completion (no deletion) upon hitting tab - you need to change `Choose Lookup Item` and `Choose Lookup Item and Replace` in Settings | Keymap.