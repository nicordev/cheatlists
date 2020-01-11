# Doctrine ORM

## Utilisation

* Migrations
    * `php bin/console doctrine:migrations:diff` créé un fichier de migration par rapport à l'état de la base de données utilisée.
    * `php bin/console doctrine:migrations:migrate` exécute les fichiers de migrations.
* Relation ManyToMany
    * [doc](https://www.doctrine-project.org/projects/doctrine-orm/en/2.6/reference/association-mapping.html#owning-and-inverse-side-on-a-manytomany-association)
        > For Many-To-Many associations you can chose which entity is the owning and which the inverse side. There is a very simple semantic rule to decide which side is more suitable to be the owning side from a developers perspective. You only have to ask yourself which entity is responsible for the connection management, and pick that as the owning side.
    * Exemple :
        * L'entité `Tag` possède un ou plusieurs `TwitList` et inversement
        * Pour pouvoir ajouter des `Tag` aux `TwitList` :
            * la propriété `tags` de `TwitList` doit avoir l'annotation suivante : `@ORM\ManyToMany(targetEntity="App\Entity\Tag", inversedBy="twitlists")`
                ```php
                namespace App\Entity;

                use Doctrine\ORM\Mapping as ORM;
                
                class TwitList
                {
                    // ...

                    /**
                    * @ORM\ManyToMany(targetEntity="App\Entity\Tag", inversedBy="twitLists")
                    */
                    private $tags;
                    
                    // ...
                }
                ```
            * la propriété `twitLists` de `Tag` doit avoir l'annotation suivante : `@ORM\ManyToMany(targetEntity="App\Entity\TwitList", mappedBy="tags")`
                ```php
                namespace App\Entity;

                use Doctrine\ORM\Mapping as ORM;

                class Tag
                {
                    // ...

                    /**
                    * @ORM\ManyToMany(targetEntity="App\Entity\TwitList", mappedBy="tags")
                    */
                    private $twitLists;

                    // ...
                }
                ```