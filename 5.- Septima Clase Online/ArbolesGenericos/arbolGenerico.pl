/*


    Septima Clase Online


*/

%-------------------------------------------
%
% Arboles Genericos
%           1
%         / | \
%        3  4  5
% 
% El arbol mas pequeño : n0 (a(E, [])) -> No hay arbol nulo.
% 
% Como se representa un arbol generico:
%
% a(E, ListaHijos);
% ListaHijos es una lista de arboles
%
% a(1, [a(2, []), a(3, []), a(4. [])])
%
%
%           1
%         / | \
%        2  3  4
%      / | \   |
%     5  6  7  8
%-------------------------------------------

arbol1(a(1, [a(3, []), a(4, []), a(5, [])])).

arbol2(a(1), [a(2, [a(5, []), a(6, []), a(7, [])]), a(3, []), a(4, [a(8, [])])]).

arbol2(
   a(1, [ a(2, [a(5, []), a(6, []), a(7, [])]), a(3, []), a(4, [a(8, [])])])
).

%-------------------------------------------
%
% pertenece(E, Arbol)
%   es cierto si el elemento E pertenece al 
%   arbol generico Arbol.
%
% Caso mas sencillo que elemento este en la raiz y me da igual lo que haya en la ListaHijos
%
%-------------------------------------------

% Predicado para arboles

pertenece(E, a(E, _)). 

pertenece(E, a(Et, ListaHijos)) :-
    E \= Et,
    pertenece(E, ListaHijos).

% Predicado para listas de arboles

pertenece(E, [Cab|_]) :-
    pertenece(E, Cab).

pertenece(E, [_|Resto]) :-
    pertenece(E, Resto).


%-------------------------------------------
%
% cuenta_nodos( +Arbol, -N)
%   es cierto si N unifica con el numero de nodos del 
%   arbol generico Arbol.
%
%-------------------------------------------

% Predicado para arboles

/*En este caso no hay recursividad ya que no se llama a si mismo para 
contar los arboles, llama a cuenta lista de un arbol, y luego la cabeza
es un arbol, y llama a cuenta nodos arbol, por lo que el caso base no 
es necesario*/
% cuenta_nodos(a(_, []), 1).

cuenta_nodos(a(_, ListaHijos), R2) :-
    cuenta_nodos(ListaHijos, R),
    R2 is R + 1.

% Predicado para lista de arboles

cuenta_nodos([], 0).

cuenta_nodos([Cab|Resto],  R3) :-
    cuenta_nodos(Cab, R1),
    cuenta_nodos(Resto, R2), 
    R3 is R1 + R2.

% Para verlo mejor cambiamos nombres a los predicados:

cuentaNodosArboles(a(_, ListaHijos), R2) :-
    cuenta_nodos(ListaHijos, R),
    R2 is R + 1.

cuentaNodosListaArboles([], 0).

cuentaNodosListaArboles([Cab|Resto],  R3) :-
    cuentaNodosArboles(Cab, R1),
    cuentaNodosListaArboles(Resto, R2), 
    R3 is R1 + R2.

%-------------------------------------------
%
% hojas( +Arbol, -ListaHojas)
%   es cierto si ListaHojas unifica con la lista
%   de las etiquetas de las hojas del arbol Arbol.
%
%-------------------------------------------

% Predicado para arboles

hojas( a(E, []), [E]). %Es una hoja

hojas( a(_, ListaHijos), R) :- %No es una hoja
    ListaHijos \= [],
    hojas(ListaHijos, R).

% Predicado para lista de arboles

hojas([], []).

hojas([Cab|Resto], R3) :-
    hojas(Cab, R1), % Llama a hojas del arbol
    hojas(Resto, R2),
    append(R1, R2, R3).
    
%-------------------------------------------
%
% crea( +Lista, -Arbol)
%   es cierto si Lista unifica con un arbol generico que 
%   contiene todos los elementos de Lista.
%
%-------------------------------------------

% Arbol de una rama cada nodo

crea([], []).

crea([E], a(E, [])).

crea([Cab|Resto], a(Cab, [R])) :-
    crea(Resto, R).
    
% Arbol plano

creaArbol([Cab|Resto], a(Cab, R)) :-
    creaListaArboles(Resto, R).

creaListaArboles([], []).
creaListaArboles([Cab|Resto], [a(Cab, []) | R]):-
    creaListaArboles(Resto, R).

%-------------------------------------------
%
% anchura(+Arbol, -Lista)
%   es cierto si Lista unifica con una lista que contiene
%   el recorrido en anchura del arbol A.
%
%-------------------------------------------

% Predicado para arboles

anchura(a( E, _), [E]).

anchura(a( _, ListaHijos), R) :-
    anchura(ListaHijos, R).

% Predicado para lista de arboles

anchura( [], []).

anchura( ListaArboles, R):-
    bajarNivel(ListaArboles, R2),
    anchura(R2, R).

anchura(ListaArboles, R) :- 
    etiquetas(ListaArboles, R).

%-------------------------------------------
%
% bajarNivel( +ListaArboles, -ListaR)
%
%-------------------------------------------

bajarNivel([], []).

bajarNivel([a(_,L)|Resto], R2):-
    Resto \= [];
    bajarNivel(Resto, R),
    append(L, R, R2).

%-------------------------------------------
%
% etiquetas(+ListaArboles, -ListaEtiquetas)
%
%-------------------------------------------

etiquetas( [], []).

etiquetas( [a(E ,_)|Resto], [E|R]) :-
    etiquetas(Resto, R).