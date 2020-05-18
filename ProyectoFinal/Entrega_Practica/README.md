# Entrega Práctica
# Algoritmo de Búsqueda de A Estrella
### Curso 19/20
### Representación del Conocimiento
### Por Ricardo Manuel Ruiz Díaz

## Introducción
En esta memoria, vamos a describir el algoritmo de búsqueda A Estrella escrito en prolog y programado por _**Jorge Carlos Valverde Rebaza**_ . 

El Algoritmo de búsqueda A estrella, es una algoritmo para buscar el camino entre un origen y un fin gracias a una heurística ( o pista ), teniendo la peculiaridad que ese camino es el de menor coste de todos los posibles. 
(Ejemplo con imágenes en el PDF)

A continuación mostramos el enlace del código:
-   https://github.com/Riickyr91/Representacion-del-Conocimiento-19-20/blob/master/ProyectoFinal/Entrega_Practica/Codigo/A_Estrella.pl

Debemos indicar que la filosofía utilizada para explicar el código y realizar algunas modificaciones es la inducción explicada por @jcarpio.

Para visualizar tutoriales de _Prolog_ podeis visitar el canal de Youtube siguiente:
-   https://www.youtube.com/user/josecarpioc


## Descripción del Código
Primero, debemos de señalar, que el grafo lo tenemos insertado en el código de la siguiente forma:
-	indice_ciudad(NumeroNodo, Nombre).
-	transiciones(NumeroNodoInicial, NumeroNodoFinal, Distancia).
-	Heurística en línea recta(NumeroNodoInicial, NumeroNodoFinal, Distancia).

A partir de aquí, vamos a explicar todas las funciones utilizadas en la implementación de dicho algoritmo:


**Encontrar Camino**

La primera función que nos encontramos sería la principal con el siguiente predicado  _**encontrarCamino(+Origen, +Destino, -Solucion)**_ , donde Solucion es una lista de nodos por los que pasa con el coste concatenado en la última posicion de la lista. 

```
Es cierto cuando existe una lista de nodos que empiece en origen y termine en destino.
```

**Busca Heurística**

En este caso, el predicado es _**buscaHeuristica(+Caminos, -Solucion , +Destino )**_
Esta función, es la más importante ya que es la que se encarga de escoger el próximo camino, eliminar ( pasar a visitados ) los nodos que ya no nos sirve. También extiende los caminos, es decir, añade a la lista de caminos los caminos nuevos que se abren al “posicionarse” en el nuevo nodo.
Además, se encarga de ir concatenando los caminos seleccionados.

```
es cierto cuando existe una lista de Transiciones que te lleva desde Camininos iniciales, hasta Destino. 
```

**Escoger Próximo**

Utiliza el siguiente predicado _**escogerProximo(+Caminos, -Proximo , +Destino)**_. Obtiene todos los caminos recorridos hasta el momento y realiza las comparaciones. Solo se detiene cuando se encuentra el menor camino (menor Coste).

```
Es cierto cuando existe existe un camino hacia el proximo en dirección al destino con el menor coste.
```

**Extender Siguiente Camino**

Este predicado, cuenta con la cabecera _**extenderSiguienteCamino(+Prox, -NuevosCaminos)**_ , según el nodo Prox que tengamos, realiza las comprobaciones necesarias ( existe movimiento, no está en la lista de camino, … ) para poder añadir los siguientes caminos a la lista.

```
Es cierto si NuevosCaminos unifica con la lista de los caminos que parten desde Prox.
```

**Actualizar Costes Caminos**

Esta función, cuenta con el predicado _**actualizarCostesCaminos(+ListaCaminos, -NuevosCaminos)**_, que según la lista de caminos que llevamos, va actualizando los pesos ( distancia ) de los nuevos caminos.

```
Es cierto si NuevosCaminos unifica con la lista de los caminos con los pesos actualizados.
```

**Verifica Movimientos**

Cuenta con el predicado _**verificarMovimiento(+Origen, +Destino, -Distancia)**_ y revisa si el movimiento a realizar de ciudad origen a ciudad destino con la distancia expresada existe.

```
Es cierto cuando existe una transición desde origen a destino con una distancia o viceversa.
```

**Invierte Camino**

La única función de este método es invertir una lista y tiene cuenta con _**invertirCamino(+Lista1 ,-Lista2)**_ como predicado.

```
Es cierto cuando Lista2 unifica con Lista1 invertida.
```

**Concatena Caminos**

En este caso, la función que realiza es la de concatenar a una lista un nodo visitado nuevo y el predicado es _**concatenarCaminos(+ListaInt,+Nodo,-NuevaLista)**_.

```
Es cierto cuando nueva lista es la concatenación de ListaInt y el nuevo nodo Nodo
```

**Borra Caminos**

Cuenta con el predicado _**removerCamino(+Prox, +Caminos, -CaminosRestantes)**_ y esta función, borra los caminos innecesarios que tengamos en nuestra lista de abiertos.

```
Es cierto cuando existe una lista CaminosRestantes que unifica con los posibles caminos válidos para llegar hasta el destino.
```

**ImprimerCamino**

En este caso, esta función va imprimiendo todas las ciudades de izquierda a derecha de la lista, y cuando sólo queda un elemento en la lista, sabemos que es el coste y cambia el formate del write para sacar por pantalla el coste.


## Nuevas Funciones
Para el correcto funcionamiento del algoritmo, hemos tenido que utilizar las siguientes funciones no dadas en las clases de teoría:
-	!: llamado negación como fracaso, es la negación de la clausula anterior a la exclamación, pero tiene la particularidad de que con este modo se libera la restricción sintáctica de que las regals tengan que ser cláusulas de Horn.
-	not(): es la negación de lo que tenga entre parentesis.
-	member(): es cierto si el primer elemento de la función es mienbro del segundo elemento del parámetro, utilizado para saber si un nodo o camino estaba en la lista.

## Bibliografía
Hay que destacar que el código de la práctica lo hemos sacado de la siguiente URL, siendo el propietario de él Jorge Carlos Valverde Rebaza:
-	http://jc-info.blogspot.com/2012/04/star-algorithm-prolog-code.html

Definición del algoritmo de búsqueda A Estrella:
-	https://es.wikipedia.org/wiki/Algoritmo_de_b%C3%BAsqueda_A*

Explicación negación como fracaso / not:
-	http://dit.upm.es/~gfer/ssii/rcsi/rcsisu85.html

Explicación member:
-	https://www.swi-prolog.org/pldoc/man?predicate=member/2
