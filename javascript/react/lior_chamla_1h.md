# REACT : 1H POUR COMPRENDRE LA LIBRAIRIE !

[Vidéo YouTube](https://www.youtube.com/watch?v=no82oluCZag)

## Composant

* Structure :
    * Composant
        * Etat (données)
        * Comportements (exemple ajouter, supprimer)
        * Rendu (affichage)
* Dès que l'état change, le rendu s'actualise
* Les comportements modifient l'état

### Gérer `this`

* En utilisant `bind`
    ```js
    class App extends React.Component {
        
        handleClick() {
            console.log(this); // Ici this sera bien l'objet App
        }

        render() {
            // On bind l'objet App pour la méthode handleClick
            return <button onClick={this.handleClick.bind(this)}>Click me!</button>
        }
    }
    ```
* En utilisant une fonction fléchée contenant la méthode
    ```js
    class App extends React.Component {
        
        handleClick() {
            console.log(this); // Ici this sera bien l'objet App
        }

        render() {
            // On bind l'objet App pour la méthode handleClick
            return <button onClick={() => this.handleclick()}>Click me!</button>
        }
    }
    ```
* En utilisant une fonction fléchée en guise de méthode
    ```js
    class App extends React.Component {
        
        handleClick = () => {
            console.log(this); // Ici this sera bien l'objet App
        }

        render() {
            // On bind l'objet App pour la méthode handleClick
            return <button onClick={this.handleclick}>Click me!</button>
        }
    }
    ```

### Modifier l'état d'un composant

* **Ne jamais modifier l'état directement**
* On utilise `this.setState` à la place :
    ```js
    class App extends React.Component {

        state = {
            counter: 0
        }
        
        handleClick = () => {
            this.setState({ counter: this.state.counter + 1 });
            console.log(this.state.counter);
        }

        render() {
            return <button onClick={this.handleclick}>Click me! {this.state.counter}</button>
        }
    }
    ```