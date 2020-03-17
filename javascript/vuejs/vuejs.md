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

## Utilisation

* `Vue` instance :
    * Côté HTML :
        ```html
        <div id="nomIdBaliseHtml">
            <h1>{{ nomVariable1 }}</h1>
            <p>{{ nomVariable2 }}</p>
        </div>
        ```
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