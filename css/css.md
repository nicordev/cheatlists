# CSS

## Sélecteurs

[`:not()` Qui ne correspond pas à... (une classe par exemple)](https://developer.mozilla.org/en-US/docs/Web/CSS/:not)
```css
.myClass:not(.myOtherClass) {}
```

## background

[`background-image`](https://developer.mozilla.org/fr/docs/Web/CSS/background-image) :
```css
background-image: linear-gradient(rgba(0, 0, 255, 0.5), rgba(255, 255, 0, 0.5)), 
                  url("../../media/examples/lizard.png");
```

[`background-size`](https://developer.mozilla.org/fr/docs/Web/CSS/background-size) :
```css
background-size: contain;
background-size: cover;
background-size: 200px 100px;
```

[`background-repeat`](https://developer.mozilla.org/fr/docs/Web/CSS/background-repeat) :
```css
background-repeat: no-repeat;
```

[`background-position`](https://developer.mozilla.org/fr/docs/Web/CSS/background-position) :
```css
background-position: center;
background-position: bottom 50px right 100px;
```

## filter

Noir et blanc :
```css
filter: grayscale(100%);
```

## Variables

[MDN](https://developer.mozilla.org/fr/docs/Web/CSS/Using_CSS_custom_properties)

* Déclaration d'une variable
    ```css
    element {
        --main-bg-color: brown;
    }
    ```
* Utilisation de la variable
    ```css
    element {
        background-color: var(--main-bg-color);
    }
    ```

## Shapes

[MDN](https://developer.mozilla.org/fr/docs/Web/CSS/shape-outside)

```css
.myClass {
    shape-outside: circle(50%);
    shape-outside: ellipse(130px 140px at 20% 20%);
    shape-outside: url(/media/examples/round-balloon.png);
    shape-outside: polygon(50% 0, 100% 50%, 50% 100%, 0 50%);
}

.myClass {
    /* Valeurs avec un mot-clé */
    shape-outside: none;
    shape-outside: margin-box;
    shape-outside: content-box;
    shape-outside: border-box;
    shape-outside: padding-box;

    /* Valeurs utilisant une fonction */
    shape-outside: circle();
    shape-outside: ellipse();
    shape-outside: inset(10px 10px 10px 10px);
    shape-outside: polygon(10px 10px, 20px 20px, 30px 30px);
    shape-outside: linear-gradient(45deg, rgba(255,255,255,0) 150px, red 150px);

    /* Valeur de type <url> */
    shape-outside: url(image.png);

    /* Valeur de type <gradient> */
    shape-outside: linear-gradient(45deg, rgba(255, 255, 255, 0) 150px, red 150px);

    /* Valeurs globales */
    shape-outside: initial;
    shape-outside: inherit;
    shape-outside: unset;
}
```

## Animations

* Simple: utiliser `transition-property` et `transition-duration`
    ```css
    .logo {
        transition-property: text-shadow;
        transition-duration: 100ms;
    }

    .logo:hover {
        text-shadow: azure -2px 2px 2px;
    }
    ```
* Evolué: utiliser les propriétés `animation` et `@keyframes`
    ```css
    #square2 {
        transition-property: background-color, width, height;
        transition-duration: 250ms;
    }

    #square2:hover {
        animation-name: masuperanimation;
        animation-duration: 2s;
        animation-delay: 0.4ms;
        animation-timing-function: ease; /* ease linear ease-in ease-out ease-in-out  cubic-bezier(val1, val2, val3, val4) step-start step-end steps(X) */
        animation-iteration-count: infinite;
        animation-direction: alternate; /* alternate reverse normal */
        animation-fill-mode: none; /* none forwards backwards */
    }

    @keyframes masuperanimation {
        0% {
            transform: translateX(0px);
        }

        50% {
            transform: translateX(150px);
        }

        100% {
            transform: translateX(150px) rotate(30deg);
        }
    }
    ```
