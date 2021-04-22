# Vue.js

## Apprendre

* [doc](https://vuejs.org/v2/guide/)
* [tutos](https://www.vuemastery.com/courses/intro-to-vue-js/vue-instance)

## Installation

* [doc](https://vuejs.org/v2/guide/installation.html)
* Via un CDN :
    * `<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>` version développement
    * `<script src="https://cdn.jsdelivr.net/npm/vue"></script>` version production
* Via NPM :
    * `npm install vue`
* Via vue CLI :
    * `npm install -g @vue/cli`
    * `vue --version` affiche la version installée.
    * `vue create nomProjet -d` créé un nouveau projet vue.js. `-d` rempli les options par défaut automatiquement.
    * `cd nomProjet`
    * `yarn serve` lance le projet.

## Utilisation

* Convertir le camelCase en `nom-propriété` dans les noms d'attribut HTML. Exemple :
    * JS :
        ```js
        Vue.component('product', {
            props: {
                productDetails: { type: Array },
                // ...
            },
            // ...
        });
        ```
    * HTML :
        ```html
        <product v-bind:product-details="socksDetails"></product>
        ```
* `Vue` instance :
    * Côté HTML :
        ```html
        <div id="nomIdBaliseHtml">
            <h1>{{ nomVariable1 }}</h1>
            <p>{{ nomVariable2 }}</p>
        </div>
        ```
        On pourrait aussi utiliser `v-text="nomVariable1"` mais c'est moins courant.
    * Côté JS :
        ```js
        var app = new Vue({
            el: '#nomIdBaliseHtml', // Attribut id de la balise HTML ciblée.
            data: {
                nomVariable1: 'Socks',
                nomVariable2: 'Nice green socks!'
            }
        });
        ```
        ou
        ```js
        var app = new Vue({
            el: '#nomIdBaliseHtml', // Attribut id de la balise HTML ciblée.
            data() {
                return {
                    nomVariable1: 'Socks',
                    nomVariable2: 'Nice green socks!'
                };
            }
        });
        ```
* `v-bind:nomattribut="expression"` ou juste `:nomattribut="expression"` lie un attribut HTML à une expression :
    * Côté HTML :
        ```html
        <img :src="imageUrl" alt="socks!">
        ```
    * Côté js :
        ```js
        var app = new Vue({
            el: '#app',
            data: {
                imageUrl: '../assets/vmSocks-green-onWhite.jpg'
            }
        });
        ```
    * `:alt`
    * `:href`
    * `:title`
    * `:class`
    * `:style`
    * `:disabled`
* `v-on:nomévènement` ou `@nomévènement` ajoute un event listener :
    * HTML :
        ```html
        <button v-on:click="nomMéthodeAExécuter">Add to cart</button>
        ```
    * JS :
        ```js
        var app = new Vue({
            el: '#app',
            data: {
                cart: 0
            },
            methods: {
                nomMéthodeAExécuter() {
                    this.cart++;
                }
            }
        });
        ```
* Modifier les classes CSS d'une balise HTML :
    * HTML :
        ```html
        <div :class="{ nomClasse: nomVariableBooléenne }">ZogZog</div>
        ```
    * JS :
        ```js
        var app = new Vue({
            el: '#app',
            data: {
                nomVariableBooléenne: true
            }
        });
        ```
* Modifier le style d'une balise HTML :
    * HTML :
        ```html
        <div :style="[nomObjetStyle1, nomObjetStyle2]">
        <div :style="nomObjetStyle3">
        ```
    * JS :
        ```js
        var app = new Vue({
            el: '#app',
            data: {
                nomObjetStyle1: {
                    nomPropriétéCSS: 'valeur'
                },
                nomObjetStyle2: {
                    'box-shadow': '5px 5px 5px 0px #656565',
                    'border-radius': '5px'
                },
                nomObjetStyle3: {
                    secondaryColor: 'grey',
                    padding: '1rem',
                    margin: '1rem'
                }
            }
        });
        ```
* Propriétés calculées (computed properties) :
    * Calculées 1 fois puis mis en cache jusqu'à ce qu'une des propriétés servant au calcul est modifiée.
    * HTML :
        ```html
        <h1>{{ title }}</h1>
        ```
    * JS :
        ```js
        var app = new Vue({
            el: '#app',
            data: {
                brand: 'Vue Zog Master',
                product: 'Socks'
            },
            computed: {
                title() {
                    return `${this.brand} ${this.product}`;
                }
            }
        });
        ```
* Composants (components) :
    * HTML :
        ```html
        <product message="Hello!"></product>
        ```
    * JS :
        ```js
        Vue.component('product', {
            props: {
                message: {
                    type: String,
                    required: true,
                    default: 'Hi!'
                } // Ou juste [message] si on n'a pas besoin de validation.
            },
            template: `<div>
                <h1>Product</h1>
                <p>{{ message }}</p>
            </div>`,
            data() {
                return {
                    // ...
                }
            }
        });
        ```
* `v-model="nomPropriété"` permet de lié un attribut HTML à une propriété JS dans les 2 sens : modifier la propriété modifiera l'attribut et inversement. Exemple d'un composant :
    * JS :
        ```js
        Vue.component('nom-composant', {
            template: `<input type="text" v-model="nomPropriété">`,
            data() {
                return {
                    nomPropriété: null
                }
            }
        });
        ```
    * HTML :
        ```html
        <nom-composant></nom-composant>
        ```
* Formulaires :
    * Exemple d'un composant :
        * HTML :
            ```html
            <div id="note-app">
                <notepad></notepad>
            </div>
            ```
        * JS :
            ```js
            Vue.component('notepad', {
                template: `
                    <div class="notepad">
                        <ul>
                            <li v-for="note in notes">
                                <p>{{ note.title }}</p>
                            </li>
                        </ul>

                        <form class="note-form" @submit.prevent="onSubmit">
                            <input type="text" id="note-title" v-model="title">
                            <button type="submit">Submit</button>
                        </form>
                    </div>
                `,
                data() {
                    return {
                        notes: [],
                        title: null
                    };
                },
                methods: {
                    onSubmit() {
                        let note = {
                            title: this.title
                        };
                        this.notes.push(note);
                        this.title = null;
                    }
                }
            });

            var app = new Vue({
                el: '#note-app'
            });
            ```
    * Dans un sous-composant :
        * Appeler une méthode lors de l'évènement `submit`.
        * Emettre un évènement custom pour modifier le composant parent.
* Style :
    * `scoped` indique que la balise `style` s'applique uniquement au composant où elle se trouve. En son absence, elle s'appliquera partout.

        Ici en prime on importe un fichier `scss` :
        ```html
        <style lang="scss" scoped>
            @import '@/design/index.scss';
        </style>
        ```

## Erreurs

- `[Vue warn]: Invalid prop: type check failed for prop "error". Expected Object, got Error`: j'utilise une variable qui n'existe pas.