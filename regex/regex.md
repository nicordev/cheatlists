# Regex

[Regex](https://regex101.com/)

* `?=`, `?!`, `?:`
    * The difference between ?= and ?! is that the former requires the given expression to match and the latter requires it to not match. For example a(?=b) will match the "a" in "ab", but not the "a" in "ac". Whereas a(?!b) will match the "a" in "ac", but not the "a" in "ab".

        The difference between ?: and ?= is that ?= excludes the expression from the entire match while ?: just doesn't create a capturing group. So for example a(?:b) will match the "ab" in "abc", while a(?=b) will only match the "a" in "abc". a(b) would match the "ab" in "abc" and create a capture containing the "b".

        `?:`  is for non capturing group
        `?=`  is for positive look ahead
        `?!`  is for negative look ahead
        `?<=` is for positive look behind
        `?<!` is for negative look behind
    * Exemple: `^application\/(?:.+\+)?json$`

## PCRE

Mot de passe :

- 8 caractères minimum
- 1 caractère spécial
- 1 caractère en majuscule
- 1 caractère en minuscule
- 1 chiffre

```
^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z1-9]).{8,}$
^\S*(?=\S{8,})(?=\S*[a-z])(?=\S*[A-Z])(?=\S*[\d])(?=\S*[\W])\S*$
```