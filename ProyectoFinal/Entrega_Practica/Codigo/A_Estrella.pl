%-------------------------------------------
%
%       Algorithm A *
%
%-------------------------------------------

% Ciudades / Nodos del Mapa
%       El primer parámetro la numeración del nodo y el segundo el nombre.

indice_ciudad(1,'Oradea').
indice_ciudad(2,'Zerind').
indice_ciudad(3,'Sibiu').
indice_ciudad(4,'Arad').
indice_ciudad(5,'Timisoara').
indice_ciudad(6,'Lugoj').
indice_ciudad(7,'Mehadia').
indice_ciudad(8,'Dobreta').
indice_ciudad(9,'Fagaras').
indice_ciudad(10,'Rimnicuvilcea').
indice_ciudad(11,'Pitesti').
indice_ciudad(12,'Craiova').
indice_ciudad(13,'Bucharest').
indice_ciudad(14,'Giurgiu').
indice_ciudad(15,'Urziceni').
indice_ciudad(16,'Hirsova').
indice_ciudad(17,'Eforie').
indice_ciudad(18,'Vaslui').
indice_ciudad(19,'Iasi').
indice_ciudad(20,'Neamt').

% Transiciones entre Nodos
%       El primer parámetro es el nodo de origen, el segundo el nodo de destino
%       y el tercero es la distancia entre ellos.

grafo(1,2,71).
grafo(1,3,151).
grafo(2,4,75).
grafo(4,5,118).
grafo(4,3,140).
grafo(5,6,111).
grafo(6,7,70).
grafo(7,8,75).
grafo(3,9,99).
grafo(3,10,80).
grafo(10,11,97).
grafo(10,12,146).
grafo(12,8,120).
grafo(9,13,211).
grafo(11,12,138).
grafo(11,13,101).
grafo(13,14,90).
grafo(13,15,85).
grafo(15,16,98).
grafo(16,17,86).
grafo(15,18,142).
grafo(18,19,92).
grafo(19,20,87).

% Heurística
%        Valores de la distancia en linea recta hasta BUCHAREST

hsld(4,13,366).
hsld(13,13,0).
hsld(12,13,160).
hsld(8,13,242).
hsld(17,13,161).
hsld(9,13,176).
hsld(14,13,77).
hsld(16,13,151).
hsld(19,13,226).
hsld(6,13,244).
hsld(7,13,241).
hsld(20,13,234).
hsld(1,13,380).
hsld(11,13,100).
hsld(10,13,193).
hsld(3,13,253).
hsld(5,13,329).
hsld(15,13,80).
hsld(18,13,199).
hsld(2,13,374).

%-------------------------------------------------------------------------------------
%
%       obtener_hsld(+Origen, +Destino, -Distancia),
%               es cierto cuando existe una heurística ( distancia ) cuando cumpla
%               con la ciudad de origen y destino
%
%-------------------------------------------------------------------------------------

obtener_hsld(Origen, Destino, Distancia):-
 hsld(Origen, Destino, Distancia).

obtener_hsld(Origen, Destino, Distancia):-
 !,hsld(Destino, Origen, Distancia).


%-------------------------------------------------------------------------------------
%
%       encontrarCamino(+Origen, +Destino, -Solucion),
%               es cierto cuando existe una lista de nodos que empiece en origen
%               y termine en destino.
%
%-------------------------------------------------------------------------------------

encontrarCamino(_,_):-
 write('Este Camino no existe.').

encontrarCamino(Origen, Destino, Camino):-
 indice_ciudad(C1,Origen),
 indice_ciudad(C2,Destino),
 buscaHeuristica([[0,C1]],CaminoInvertido,C2),
 invertirCamino(CaminoInvertido, Camino).

%-------------------------------------------------------------------------------------
%
%       buscaHeuristica(+Caminos, -Solucion , +Destino ),
%               es cierto cuando existe una lista de Transiciones que te lleva
%               desde Camininos iniciales, hasta Destino. 
%
%-------------------------------------------------------------------------------------

buscaHeuristica(Caminos, [Coste,Destino|Camino], Destino):-
 member([Coste,Destino|Camino],Caminos),
 escogerProximo(Caminos, [Coste1|_], Destino),
 Coste1 == Coste.

buscaHeuristica(Caminos, Solucion, Destino):-
 escogerProximo(Caminos, Prox, Destino),
 removerCamino(Prox, Caminos, CaminosRestantes),
 extenderSiguienteCamino(Prox, NuevosCaminos),
 concatenarCaminos(CaminosRestantes, NuevosCaminos, ListaCompleta),
 buscaHeuristica(ListaCompleta, Solucion, Destino).

%-------------------------------------------------------------------------------------
%
%       escogerProximo(+Caminos, -Proximo , +Destino),
%               es cierto cuando existe un nodo proximo que te acerca al destino
%               a través de los caminos
%
%-------------------------------------------------------------------------------------

escogerProximo([X],X,_):-
  !.

escogerProximo([[Custo1,Cidade1|Resto1],[Custo2,Cidade2|_]|Cola], MejorCamino, Destino):-
 obtener_hsld(Cidade1, Destino, Avaliacao1),
 obtener_hsld(Cidade2, Destino, Avaliacao2),
 Avaliacao1 +  Custo1 =< Avaliacao2 +  Custo2,
 escogerProximo([[Custo1,Cidade1|Resto1]|Cola], MejorCamino, Destino).

escogerProximo([[Custo1,Cidade1|_],[Custo2,Cidade2|Resto2]|Cola], MejorCamino, Destino):-
 obtener_hsld(Cidade1, Destino, Avaliacao1),
 obtener_hsld(Cidade2, Destino, Avaliacao2),
 Avaliacao1  + Custo1 > Avaliacao2 +  Custo2,
 escogerProximo([[Custo2,Cidade2|Resto2]|Cola], MejorCamino, Destino).

%-------------------------------------------------------------------------------------
%
%       extenderSiguienteCamino(+Prox, -NuevosCaminos),
%               Es cierto si NuevosCaminos unifica con la lista de los 
%               caminos que parten desde Prox.
%
%-------------------------------------------------------------------------------------

extenderSiguienteCamino([Custo,No|Caminho],NuevosCaminos):-
 findall([Custo,NovoNo,No|Caminho], (verificarMovimiento(No, NovoNo,_),not(member(NovoNo,Caminho))), ListaResultante),
 actualizarCostesCaminos(ListaResultante, NuevosCaminos).

%-------------------------------------------------------------------------------------
%
%       actualizarCostesCaminos(+ListaCaminos, -NuevosCaminos).
%               Actualiza el coste de los caminos y los añade en nuevos caminos.
%
%-------------------------------------------------------------------------------------

actualizarCostesCaminos([],[]):-!.
actualizarCostesCaminos([[Custo,NovoNo,No|Caminho]|Cola],[[NovoCusto,NovoNo,No|Caminho]|Cauda1]):-
 verificarMovimiento(No, NovoNo, Distancia),
 NovoCusto is Custo + Distancia,
 actualizarCostesCaminos(Cola,Cauda1).


%-------------------------------------------------------------------------------------
%
%       verificarMovimiento(+Origen, +Destino, -Distancia)
%               Es cierto cuando existe una transición desde origen a destino con una distancia
%               o viceversa
%
%-------------------------------------------------------------------------------------

verificarMovimiento(Origen, Destino, Distancia):-
 grafo(Origen, Destino, Distancia).

verificarMovimiento(Origen, Destino, Distancia):-
 grafo(Destino, Origen, Distancia).

%-------------------------------------------------------------------------------------
%s
%       invertirCamino(+Lista1 ,-Lista2)
%               Es cierto cuando Lista2 unifica con Lista1 invertida
%
%-------------------------------------------------------------------------------------

invertirCamino([X],[X]).

invertirCamino([X|Y],Lista):-
  invertirCamino(Y,ListaInt),
  concatenarCaminos(ListaInt,[X],Lista).

%-------------------------------------------------------------------------------------
%
%       concatenarCaminos(+ListaInt,+Nodo,-NuevaLista).
%               Es cierto cuando nueva lista es la concatenación de ListaInt y el nuevo
%               nodo Nodo
%
%-------------------------------------------------------------------------------------

concatenarCaminos([],L,L).

concatenarCaminos([X|Y],L,[X|Lista]):- 
 concatenarCaminos(Y,L,Lista).

%-------------------------------------------------------------------------------------
%
%       removerCamino(+Prox, +Caminos, -CaminosRestantes),
%           Es cierto cuando existe una lista CaminosRestantes que unifica 
%           con los posibles caminos válidos para llegar hasta el destino.
%-------------------------------------------------------------------------------------

removerCamino(X,[X|T],T):-!.

removerCamino(X,[Y|T],[Y|T2]):-
 removerCamino(X,T,T2).


%-------------------------------------------------------------------------------------
%
%       imprimeCamino(+Solucion),
%               es cierto si solución unifica con un lista de nodos, donde la última
%               posición de la lista es la distancia a recorrer.
%
%-------------------------------------------------------------------------------------

imprimeCamino([Coste]):-
 nl,
 write('La distancia total recorrida fue de: '),
 write(Coste),
 write(' kilometros.').


imprimeCamino([CiudadActual|Cola]):-
 indice_ciudad(CiudadActual, X),
 write(X),
 write(', '),
 imprimeCamino(Cola).


imprimirCamino([CiudadActual|Cola]):- write('Camino a recorrer: '),
 imprimeCamino([CiudadActual|Cola]).
