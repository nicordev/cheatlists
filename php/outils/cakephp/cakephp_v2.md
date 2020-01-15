# Cake PHP - v2

## Blog tutorial

* [doc](https://book.cakephp.org/2/en/tutorials-and-examples/blog/blog.html)

## Installation

* [Repo GitHub](https://github.com/cakephp/cakephp/tags)
* `git clone -b 2.x git://github.com/cakephp/cakephp.git` clone une version 2 de cakePHP.

## Configuration

* Base de données
    1. Copier le fichier `/app/Config/database.php.default` et le renommer en `/app/Config/database.php`
    2. Modifier l'attribut `$default` avec les identifiants de la base de données utilisée :
        ```php
        public $default = array(
            'datasource' => 'Database/Mysql',
            'persistent' => false,
            'host' => 'localhost',
            'port' => '',
            'login' => 'cakeBlog',
            'password' => 'c4k3-rUl3Z',
            'database' => 'cake_blog_tutorial',
            'schema' => '',
            'prefix' => '',
            'encoding' => 'utf8'
        );
        ```
* Sécurité
    * Modifier `/app/Config/core.php` pour :
        * `Configure::write('Security.salt', 'mon-super-sel');` pour choisir un sel.
        * `Configure::write('Security.cipherSeed', 'nombreDeLaGraine');` pour choisir une graine pour encrypter/décrypter des strings.

## Utilisation

* Debug
    * `pr()` ou `debug()`.
* Fonctionnement de base
    * Modèle `/app/Model/` :
        * [doc](https://book.cakephp.org/2/en/models.html)
        * Les entités doivent hériter de `AppModel`.
        * Le nom d'une entité doit correspondre au nom du contrôleur et de la table associée.
        * Les attributs de l'entité sont créés à la volée en fonction de la table.
        * Un genre de repository est créé automatiquement.
        * Exemple :
            * Entité : `/app/Model/Post.php`
                ```php
                class Post extends AppModel {
                }
                ```
            * Contrôleur : `/app/Controller/PostsController`
            * Table : `posts`
        * > **Attention** Si on oublie de créer une classe ou qu'elle est mal nommée, CakePHP va créer une entité dynamiquement.
    * Contrôleurs `/app/Controller/` :
        * [doc](https://book.cakephp.org/2/en/controllers.html)
        * Fonctionnement de base :
            * Le nom du contrôleur et le nom de la méthode correspond à l'url.
            * Les entités peuvent être récupérer par le repository via `$this->NomEntité->find()`.
            * Les entités sont passées à la vue via `$this->set()`.
            * Exemple :
                * URL : `/posts/index`
                * Contrôleur :
                    ```php
                    class PostsController extends AppController {
                        public $helpers = array('Html', 'Form');

                        public function index() {
                            $posts = $this->Post->find('all');
                            $this->set('posts', $posts);
                        }
                    }
                    ```
        * Accéder à la requête
            * `$this->request` accède à l'objet `CakeRequest`
            * `$this->request->is('POST')` vérifie le verbe HTTP utilisé.
            * `$this->request->data` accède au contenu d'une requête POST.
    * Vues `/app/View/` :
        * Une vue doit être placée dans un sous-dossier portant le même nom que le contrôleur.
        * Le nom d'une vue doit correspondre à la méthode qui l'appelle.
        * L'extension d'une vue est `.ctp`.
        * Des helpers sont disponible dans la vue via l'objet `$this->Html`. [doc](https://book.cakephp.org/2/en/views/helpers.html)
        * Exemple :
            * Contrôleur et méthode : `/app/Controller/PostsController::index`
            * Vue : `/app/View/Posts/index.ctp`
                ```php
                <h1>Blog posts</h1>
                <table>
                    <tr>
                        <th>Id</th>
                        <th>Title</th>
                        <th>Created</th>
                    </tr>

                    <!-- Here is where we loop through our $posts array, printing out post info -->

                    <?php foreach ($posts as $post): ?>
                        <tr>
                            <td><?php echo $post['Post']['id']; ?></td>
                            <td>
                                <?php echo $this->Html->link($post['Post']['title'],
                                    array(
                                        'controller' => 'posts', 
                                        'action' => 'view', 
                                        $post['Post']['id'])
                                    ); ?>
                            </td>
                            <td><?php echo $post['Post']['created']; ?></td>
                        </tr>
                    <?php endforeach; ?>
                    <?php unset($post); ?>
                </table>
                ```
* Ajout d'une entité et **règles de validation**
    * Model :
        * Mettre les **règles de validation** dans un attribut `public $validate` :
            ```php
            class Post extends AppModel 
            {
                public $validate = array(
                    'title' => array(
                        'rule' => 'notBlank'
                    ),
                    'body' => array(
                        'rule' => 'notBlank'
                    )
                );
            }
            ```
    * Contrôleur : 
        * Créer une méthode `add` :
            ```php
            // /app/Controller/PostsController

            class PostsController extends AppController
            {
                // Flash correspond au composant chargé de gérer les messages flash.
                public $helpers = array('Html', 'Form', 'Flash');
                public $components = array('Flash');

                // ...

                public function add() 
                {
                    if ($this->request->is('post')) { // On vérifie que la requête est en POST
                        $this->Post->create(); // Prépare le model à recevoir une nouvelle entité.

                        if ($this->Post->save($this->request->data)) { // Vérifie que le formulaire est valide puis enregistre l'entité.
                            $this->Flash->success(__('Your post has been saved.'));
                            return $this->redirect(array('action' => 'index'));
                        }

                        $this->Flash->error(__('Unable to add your post.'));
                    }
                }
            }
            ```
    * Vue :
        * Créer un formulaire avec `$this->Form()` :
            ```php
            <!-- File: /app/View/Posts/add.ctp -->

            <h1>Add Post</h1>
            <?php
            echo $this->Form->create('Post');
            echo $this->Form->input('title');
            echo $this->Form->input('body', array('rows' => '3'));
            echo $this->Form->end('Save Post');
            ?>
            ```
* Modification d'une entité
    * Contrôleur :
        * Comme pour l'ajout mais en sélectionnant l'entité existante :
            ```php
            public function edit($id = null)
            {
                if (!$id) {
                    throw new NotFoundException(__('Invalid post'));
                }

                $post = $this->Post->findById($id);

                if (!$post) {
                    throw new NotFoundException(__('Invalid post'));
                }

                if ($this->request->is(array('post', 'put'))) {
                    $this->Post->id = $id; // On indique quelle est l'entité à modifier
                    if ($this->Post->save($this->request->data)) {
                        $this->Flash->success(__('Your post has been updated.'));
                        return $this->redirect(array('action' => 'index'));
                    }
                    $this->Flash->error(__('Unable to update your post.'));
                }

                if (!$this->request->data) { // La requête ne contient pas de données, donc on utilise l'entité existante pour pré-remplir le formulaire de la vue.
                    $this->request->data = $post;
                }
            }
            ```
    * Vue :
        * On ajoute un champs `hidden` au formulaire pour l'id de l'entité :
            ``` php
            <!-- File: /app/View/Posts/edit.ctp -->

            <h1>Edit Post</h1>
            <?php
            echo $this->Form->create('Post');
            echo $this->Form->input('title');
            echo $this->Form->input('body', array('rows' => '3'));
            
            // Champs caché pour l'id de l'entité à modifier
            echo $this->Form->input('id', array('type' => 'hidden')); 
            
            echo $this->Form->end('Save Post');
            ?>
            ```
        * On utilise `$this->Html->link()` pour générer un lien vers notre page d'édition :
            ```php
            <?php
            echo $this->Html->link(
                'Edit', array('action' => 'edit', $post['Post']['id'])
            );
            ?>
            ```
* Suppression d'une entité
    * Contrôleur :
        * On évite la méthode `GET` :
            ```php
            public function delete($id)
            {
                if ($this->request->is('get')) {
                    throw new MethodNotAllowedException();
                }

                if ($this->Post->delete($id)) {
                    $this->Flash->success(
                        __('The post with id: %s has been deleted.', h($id)) // La fonction __() sert à la traduction du texte et h() est synonyme de htmlspecialchars().
                    );
                } else {
                    $this->Flash->error(
                        __('The post with id: %s could not be deleted.', h($id))
                    );
                }

                return $this->redirect(array('action' => 'index'));
            }
            ```
    * Vue :
        * Lien avec confirmation JavaScript :
            ```php
            <?php
            echo $this->Form->postLink(
                'Delete',
                array('action' => 'delete', $post['Post']['id']),
                array('confirm' => 'Are you sure?')
            );
            ?>
            ```
* Routing :
    * [doc](https://book.cakephp.org/2/en/development/routing.html#routes-configuration)
    * Routes `/app/Config/routes.php` :
        * `Router::connect('/uriDésirée', array('controller' => 'nomController', 'action' => 'nomMéthode'));` lie la méthode `nomMéthode` du contrôleur `nomController` à l'uri `/uriDésirée`.
