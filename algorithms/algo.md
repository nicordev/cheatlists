# Algorithmes

## Big O notation

- On prend le cas le plus défavorable pour évaluer un algorithme.
- O(n) Linéaire (ou proportionel) :
    - y = a * n + b
        - exemple Sweeper : on cherche une valeur dans un tableau de gauche à droite, le cas le plus défavorable est égal à la taille du tableau.
- O(log n) Logarithmique :
    - exemple Splitter (Binary Search) : si le tableau est trié, on regarde au milieu du tableau et on élimine la moitié qui ne correspond pas à la valeur cherchée puis on recommence avec ce qui reste.