# Vue.js

## Commandes

- `yarn install` installe les dépendances du projet.
- `yarn serve` lance un serveur de développement.
- `yarn dev`

## VSCode snippets

- `vbase` créé un template de composant.

## Attributs HTML

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

## Component lifecycle hooks :

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

## Watchers :

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

## Filters :

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

## Composants enfants :
    
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

Pour passer des valeurs à un composant enfant, on utilise `props` :

- Dans `nomComposantParent.vue` :
    ```html
    <NomComposant v-bind:nom-attribut-enfant1="nomAttributParent" />
    ```

- Dans `nomComposantEnfant.vue` :
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

Pour passer des valeurs d'un composant enfant à un composant parent, on utilise des événements :

- Dans `NomComposantParent.vue` :
    ```html
    <nomComposantEnfant
        @nomEvénement="nomMéthodeComposantParent"
    />
    ```

    ```js
    methods: {
        nomMéthodeComposantParent(nomAttribut) {
            // Ici le composant enfant passera nomPropriétéComposantEnfant dans nomAttribut.
        }
    }
    ```

- Dans `NomComposantEnfant.vue` :
    ```js
    methods: {
        nomMéthodeLançantEvénement() {
            this.$emit("nomEvénement", this.nomPropriétéComposantEnfant)
        }
    }
    ```

## Mixins

Permet de partager des fonctionnalités entre des composants.

Ressemble aux traits de PHP.

En cas de conflit avec les élements du composant :
- Les éléments déjà présents dans le composant ne seront pas remplacés par les mixins.
- S'il s'agit de watchers ou de licecycle hooks, alors les éléments du mixin seront exécutés avant ceux du composant.

Exemple :
- `nomFichierMixins.js` :
    ```js
    export const nomMix = {
        // Lifecycle hook
        created() {
            // ...
        },
        // Methods
        methods: {
            nomMéthode() {
                // ...
            }
        }
    }
    ```
- `NomComposant.vue` :
    ```js
    import { nomMix } from './cheminVers/nomFichierMixins.js'
    export default {
        // ...
        mixins: [nomMix],
        // ...
    }
    ```

## Variables d'environnement

Fichiers à la racine du site :
- `/.env` :
    ```
    NODE_ENV=production
    VUE_APP_API=www.zogzog.com/api
    ```
- `/.env.development` :
    ```
    NODE_ENV=development
    VUE_APP_API=api
    ```

Fichier de configuration :
- `/shared/config.js` :
    ```js
    export const API = process.env.VUE_APP_API;
    ```
- `/shared/index.js` :
    ```js
    export * from './config';
    ```

Fichier utilisant la constante `API` du fichier `/shared/config.js` :
- `/shared/data.js` :
    ```js
    import * as axios from 'axios';
    import { format } from 'date-fns';
    import { inputDateFormat } from './constants';
    import { API } from "./config";

    const getHeroes = async function() {
        const response = await axios.get(`${API}/heroes.json`);
        const heroes = response.data.map(hero => {
            hero.originDate = format(hero.originDate, inputDateFormat);
        
            return hero;
    });

    return heroes;
    }

    export const data = {
        getHeroes,
    };
    ```

## Router

Installation : 

1. `vue add router` ajoute le router.
1. Dans le fichier `main.js` :
    ```js
    import Vue from 'vue';
    import App from '@/app.vue';
    import router from './router';

    new Vue({
        router,
        render: h => h(App)
    }).$mount('#app');
    ```
1. Dans le fichier `router.js` :
    ```js
    Vue.use(Router);
    
    export default new Router({
        mode: 'history',
        base: process.env.BASE_URL,
        routes: [
            {
                path: '/',
                redirect: '/heroes'
            },
            {
                path: '/heroes',
                name: 'heroes',
                // component: Heroes // Eager loading: nécessite un import.
                component: () => import(/* webpackChunkName: "bundle-heroes" */ './views/heroes.vue'), // Lazy loading: webpack fait le job grâce au commentaire.
            },
            { 
                path: '/heroes/:id', 
                name: 'hero-detail', 
                component: HeroDetail,
                props: route => ({ id: parseInt(route.params.id) }), // On aurait pu mettre juste true, mais on aurait eu des erreurs quand l'utilisateur rafraîchit la page (l'id serait alors une string).
            },
            { 
                path: '*', 
                component: NotFound 
            }
        ]
    })
    ```
1. Dans le fichier `app.vue` :
    ```html
    <template>
        <router-link to="/heroes">Heroes</router-link>
        <router-link to="/about">About</router-link>
        <router-link 
            :to="{ name: 'hero-detail', params: { id: hero.id } }"
            tag="button"
            class="link card-footer-item"
            >
                <i class="fas fa-check"></i>
                <span>Select</span>
            </router-link>
        <router-view></router-view>
    </template>
    ```
1. Dans les méthodes d'un composant :
    ```js
    methods: {
        nomMéthode() {
            this.$router.push({ name: 'nomRoute' }); // Ici l'appel à la méthode nomMéthode va rediriger l'utilisateur vers 'nomRoute'.
        },
        async saveHero() {
            await dataService.updateHero(this.hero);
            this.$router.push({ name: 'heroes' });
        },
    },
    ```

## Vuex

Installation :
```bash
vue add vuex
```
- Modifie le fichier main.js :
    ```js
    import Vue from 'vue';
    import App from '@/app';
    import store from './store';

    new Vue({
    store,
    render: h => h(App)
    }).$mount('#app');
    ```
- Ajoute le fichier `src/store.js` :
    ```js
    import Vue from 'vue'
    import Vuex from 'vuex'

    Vue.use(Vuex)

    export default new Vuex.Store({
    state: {},
    mutations: {},
    actions: {},
    getters: {}
    })

    ```

Accéder à un paramètre du state dans un composant (4 façons) :
```js
import { mapState } from 'vuex';

//...

computed: {
    heroes() {
      return this.$store.state.heroes;
    },
  },
computed: {
    ...mapState({ heroes: state => state.heroes }),
  },
computed: {
    ...mapState({ heroes: 'heroes' }),
  },
computed: {
    ...mapState(['heroes']),
  },
```