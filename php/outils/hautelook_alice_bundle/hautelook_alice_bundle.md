# Hautelook Alice Bundle

- [GitHub](https://github.com/hautelook/AliceBundle)

## Debug

```php
Fidry\AliceDataFixtures\Loader\PersisterLoader::load
Hautelook\AliceBundle\Loader\DoctrineOrmLoader::loadFixtures
```

## Syntaxe

```yaml
# fixtures/dev/myFixtures.yaml
App\Entity\Dummy:
    fruit_{1..10}:
        id: <current()>
        name: <name()>
        related_fruit: '@related_fruit*'
        another_related_fruit: '@related_fruit{1..10}'
```

Paramètres et templates :

```yaml
# fixtures/parameters.yaml
parameters:
    my_parameter: '%env(ENV_PARAMETER_NAME_HERE)%'
```

```yaml
App\Entity\ParameterSet:
    my_template (template):
        name: 'my_template<current()>'
        description: '<sentence()>'
        createdAt: '<dateTimeBetween("-1 year", "-1 day")>'
        updatedAt: '<dateTimeBetween($createdAt, "now")>'

    my_entity (extends my_template):
        name: '<{my_parameter}>'
        fruit: '@fruit{1..10}'

    my_other_entity{1..10} (extends my_template):
        fruit: '@fruit{1..10}'
```