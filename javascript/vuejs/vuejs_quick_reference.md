## Quick reference

- `v-text` alias `{{  }}` modifie le contenu d'une balise :
    
    Syntaxe `v-text="nomPropriété"` ou `{{ nomPropriété }}`

    ```html
    <h1>{{ nomPropriété1 }}</h1>
    <p>{{ nomPropriété2 }}</p>
    ```

- `v-bind:` alias `:` lie un attribut HTML à une propriété :
    
    Syntaxe `v-bind:nom_attribut="nomPropriété"` ou `:nom_attribut`

    ```html
    <img :src="imageUrl">
    ```
- `v-on:` alias `@` lie une méthode à un évènement :
    
    Syntaxe `v-on:nom_événement="nomMéthode()"` ou `@nom_événement`

    > Les parenthèses sont facultative, mais nécessaires si on veut passer des arguments à la méthode.
    
    ```html
    <button @click="nomMéthodeAExécuter()">Add to cart</button>
    ```

    Evénements :
    - `@keyup.nomTouche` déclenché quand la touche `nomTouche` vient d'être relâchée.

        Touche | Nom
        ------ | ---
        `esc` | Echap
- `v-for` boucle pour générer une liste d'éléments HTML :
    Syntaxe `v-for="nomElément in nomEléments" :key="nomElément.key"`

    `:key="nomElément.key"` permet d'améliorer les performances
- `v-if` ajoute des éléments au DOM si la condition est remplie :
    Syntaxe `v-if="condition"`

    ```html
    <div v-if="selectedHero">...</div>
    ```
- `v-show` masque un élément du DOM via CSS `display: none` si la condition n'est pas remplie :
    Syntaxe `v-show="condition"`

    ```html
    <div v-show="selectedHero">...</div>
    ```
- Component lifecycle hooks :
    1. `beforeCreate`
    1. `created` DOM not available
    1. `beforeMounted`
    1. `mounted` DOM available
    1. `beforeUpdate`
    1. `updated` data changes
    1. `beforeDestroy`
    1. `destroyed` component destroyed

    Exemple :
    ```js
    export default {
        name: 'Heroes',
        data() {
            return {
                heroes: [],
                selectedHero: undefined,
                message: ''
            }
        },
        computed: {
            fullName() {
                return `${this.selectedHero.firstName} ${this.selectedHero.lastName}`;
            }
        },
        created () {
            this.loadHeroes();
        },
        methods: {
            async getHeroes() {
                return new Promise(resolve => {
                    setTimeout(() => resolve(ourHeroes), 1500);
                });
            },
            async loadHeroes() {
                this.heroes = [];
                this.message = 'Getting the heroes. Please be patient.';
                this.heroes = await this.getHeroes();
                this.message = '';
            }
        },
    };
    ```
- Watchers :

    Exécute du code suite à un changement d'une donnée.

    Un watcher doit porter le même nom que la donnée qu'il surveille.

    Idéal pour les opérations asynchrones.

    Exemple :
    ```js
    watch: {
        nomDonnéeRéférence(newValue, oldValue) {
            // ...
        },
        nomAutreDonnéeRéférence {
            immediate: true, // Défaut false. Si true, handler sera exécuté dès le début même si aucun changement ne s'est produit.
            handler(newValue, oldValue) {
                // ...
            }
        },
        'nomDonnéeRéférence.nomSousDonnéeRéférence'(newValue, oldValue) {
            // ...
        },
    }
    ```
- Filters :

    Filtres comme dans twig. Peuvent être propre à un composant ou globaux.

    On définit un filtre global avant de définir l'instance de Vue :
    ```js
    import Vue from 'vue';

    Vue.filter('nomFiltreGlobal', function (valeur) {
        // ...
        return quelquechose;
    })
    ```

    Exemple :
    - script :
        ```js
        filters: {
            nomFiltre1(valeur) {
                // ...
                return quelquechose;
            },
            // ...
        }
    - template :
        ```html
        {{ nomPropriété | nomFiltre1 | nomFiltre2(nomArgument) }}
        ```
- Composants enfants :
    
    Dans le fichier d'un composant parent `nomComposant.vue` :
    ```js
    import ComposantEnfant1 from '@/components/nom-fichier-composant-enfant1-sans-extension';

    export default {
        name: 'nomComposant',
        data() {},
        components: {
            ComposantEnfant1,
            ComposantEnfant2,
            ComposantEnfant3
        }
    }
    ```

    Pour passer des valeurs à un composant enfant :
    ```html
    <NomComposant v-bind:nom-attribut-enfant1="nomAttributParent" />
    ```

    ```js
    export default {
        name: 'nomComposantEnfant',
        props: {
            nomAttributEnfant1: {
                type: Object,
                default: () => {},
                required: true,
            },
            nomAttributEnfant2: {
                type: Number,
                default: 1987,
                validator: function (value) {
                    return ['apple', 'peach', 'cherry'].indexOf(value) !== -1;
                },
                required: false,
            }
        },
        data() {}
    }
    ```

## VSCode snippets

- `vbase` créé un template de composant.
