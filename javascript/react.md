# ReactJS

From freeCodeCamp

## JSX

* On peut mettre du code HTML dans nos variables. Ce code sera compilé en JS par le transpileur babel.

    > Un transpileur compile le code source dans un autre langage

    ```javascript
    const JSX = (
        <div>
            <h1>TODO</h1>
            <p>Go shopping to buy:</p>
            <ul>
            <li>Bananas</li>
            <li>Strawberries</li>
            <li>Raspberry</li>
            </ul>
        </div>
    );
    ```
* Les attributs HTML s'écrivent en camelCase
* L'attribut `class` devient `className`
    ```js
	const JSX = (
        <div className="myDiv">
            <h1>Add a class to this div</h1>
        </div>
    );
    ```
* Les balises simples doivent s'écrire avec un `/`: `<br />`
* On peut écrire des balises doubles vides comme des balises simples: `<div />`
* On affiche du code JSX via la méthode `ReactDOM.render()` en lui passant le JSX et l'élément du DOM qui devra contenir le code:
    ```js
    const JSX = (
        <div>
            <h1>TODO</h1>
            <p>Go shopping to buy:</p>
            <ul>
            <li>Bananas</li>
            <li>Strawberries</li>
            <li>Raspberry</li>
            </ul>
        </div>
    );
    ReactDOM.render(JSX, document.getElementById('my-awesome-element'));
    ```
* On exécute du code JavaScript entre *{}*: `<p>The current date is: {Date()}</p>`

## Components

* Les composants React sont *stateless*, ils recoivent des données et les affichent, mais ne peut pas les modifier
* Il existe 2 façons de créer un composant:
    * Via une fonction JS qui va retourner soit du JSX, soit `null`. Son nom est en PascalCase.
        ```js
        const MyComponent = function () {
            return <div>Hello world!</div>;
        }
        ```
    * Via une classe héritant de `React.Component`
        ```js
        class MyComponent extends React.Component {
            constructor(props) {
                super(props); // Call the parent constructor
            }
            render() {
                return <div>
                    <h1>Hello React!</h1>
                </div>;
            }
        };
        ```
* On peut imbriquer des composants en utilisant des balises custom contenant le nom du composant à imbriquer:
    ```js
    const ChildComponent = () => {
        return (
            <div>
                <p>I am the child</p>
            </div>
        );
    };

    class ParentComponent extends React.Component {
        constructor(props) {
            super(props);
        }
        render() {
            return (
                <div>
                    <h1>I am the parent</h1>
                    <ChildComponent /> // Le composant enfant va être placé ici
                </div>
            );
        }
    };
    ```
* On peut afficher le code d'un composant via la méthode `ReactDOM.render()` en lui passant le `<composant />` et l'élément du DOM cible:
    ```js
    class TypesOfFood extends React.Component {
    constructor(props) {
        super(props);
    }
    render() {
        return (
        <div>
            <h1>Types of Food:</h1>
            <Fruits />
            <Vegetables />
        </div>
        );
    }
    };

    ReactDOM.render(<TypesOfFood />, document.getElementById('my-awesome-element'));
    ```
* Passage de paramètres, ici l'attribut `date` de l'objet `props` est passé via `<CurrentDate date={Date()} />`:
    ```js
    const CurrentDate = props => {
        return (
            <div>
                <p>The current date is: {props.date}</p>
            </div>
        );
    };

    class Calendar extends React.Component {

        constructor(props) {
            super(props);
        }

        render() {
            return (
            <div>
                <h3>What date is it?</h3>
                <CurrentDate date={Date()} />
            </div>
            );
        }
    }
    ```
* Valeurs par défaut des `props`:
    ```js
    const ShoppingCart = (props) => {
        return (
            <div>
            <h1>Shopping Cart Component</h1>
            </div>
        )
    };
    // Set default props
    ShoppingCart.defaultProps = {
        items: 0
    };
    ```
* Restriction du type des `props`:
    ```js
    const Items = props => {
        return <h1>Current Quantity of Items in Cart: {props.quantity}</h1>;
    };

    // Set the required type of quantity props attribute to number only
    Items.propTypes = {
        quantity: PropTypes.number.isRequired
    };
    ```