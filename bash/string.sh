#! /bin/bash

fruits='Apple Strawberry Raspberry Cherry'

expr index "$fruits" 'Strawberry'

statement='Bash is Cool'

expr index "$statement" Cool

hello='Hello world!'
echo ${hello:0:2} # Hello
echo ${hello:5} # world!