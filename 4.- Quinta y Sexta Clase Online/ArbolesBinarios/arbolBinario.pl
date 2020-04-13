/*


    Cuarta Clase Online


*/


%-------------------------------------------
%
% Arboles Binarios
%   Arbol vacio -> nil; 
%   a(Etiqueta, HijoIzquierda, HijoDerecha)
%
%   Ejemplos de representacion
% 
%       1
%     /   \
%   2       3
% 
%  a( 1, a(2, nil, nil), a(3, nil, nil)).
%
%          1
%       /     \
%     2        3
%    /  \     /  \
%   4    5   6    7
%
%  a(1, a(2, a(4, nil, nil), a(5, nil, nil)), a(3, a(6, nil, nil), a(7, nil, nil))).
% 
%          +
%       /     \
%     *        /
%    /  \     /  \
%   4    5   6    7
%
%-------------------------------------------

arbol1( a(1, a(2, nil, nil), a(3, nil, nil)) ).
arbol2(a(1, a(2, a(4,nil,nil), a(5,nil,nil)), a(3, a(6,nil,nil),a(7,nil,nil)))).
arbol3(a('+', a('*', a(4,nil,nil), a(5,nil,nil)), a('/', a(6,nil,nil),a(7,nil,nil)))).
arbol4(a(9, a(5, a(3,nil,nil), a(7,nil,nil)), a(12, a(10,nil,nil), a(15,nil,nil)))).

%-------------------------------------------
% 
% pertenece(-E, +Arbol).
% es cierto si la etiqueta E, pertenece al 
% arbol binario Arbol
%
% Clausulas de horn
%
% a-> b || c
% a-> b 
% a-> c
%-------------------------------------------

% pertenece( _, nil). -> este seria el caso base pero al ser falso no se pone.

pertenece( E, a(E, _, _)).

pertenece( E, a(Et, Hi, _)) :-
    E \= Et, % no unifica con la etiqueta
    pertenece(E, Hi).

pertenece( E, a(Et, _, Hd)) :-
    E \= Et, % no unifica con la etiqueta
    pertenece(E, Hd).

%-------------------------------------------
%
% hojas(Arbol, Lista)
% es cierto si Lista unifica con 
% una lista que contiene todas las hojas del
% árbol.
%
%-------------------------------------------

% Tengo que tener en cuenta todas las opciones
% 1. Los dos nulos
% 2. Dos arboles no nulos
% 3. HI nulo HD no nulo
% 4. HI no nulo HI nulo

hojas( nil, []).

hojas( a(E, nil, nil), [E]).

hojas( a( _, HD, HI), R) :-
    HI \= nil, HD \= nil,
    hojas( HI, RI),
    hojas( HD, RD),
    append( RI, RD, R).

hojas( a( _, nil, HD), RD) :-
    HD \= nil,
    hojas(HD, RD).

hojas( a( _, HI, nil), RI) :-
    HI \= nil,
    hojas(HI, RI).

%-------------------------------------------
%
% Recorridos 
%   preorden( Arbol, Lista)
%       raiz, hi, hd
%   es cierto si Lista unifica con el recorrido en preorden de Arbol
%
%-------------------------------------------

preorden( nil, []).

preorden( a(E, HI, HD), U) :-
    preorden( HI, RI),
    preorden( HD, RD),
    append( [E|RI], RD, U).

%-------------------------------------------
%
% Recorridos 
%   posorden
%       hi, hd, raiz
%   es cierto si Lista unifica con el recorrido en preorden de Arbol
%
%-------------------------------------------

posorden( nil, []).

posorden( a(E, HI, HD), U2) :-
    preorden( HI, RI),
    preorden( HD, RD),
    append(RI,RD, U),
    append( U, [E], U2).

%-------------------------------------------
%
% Recorridos
%   inorden
%       hi, raiz, hd 
%   es cierto si Lista unifica con el recorrido en preorden de Arbol
%
%-------------------------------------------

inorden( nil, []).

inorden( a(E, HI, HD), R) :-
    preorden( HI, RI),
    preorden( HD, RD),
    append(RI, [E|RD], R).

/*


    Quinta Clase Online


*/


%-------------------------------------------
%
% Buscar En arbol Binario de Busqueda
%   buscar_abb(E, ABB)
%    es cierto si el elemento E pertenece al árbol
%    binario de búsqueda ABB
%
%-------------------------------------------

buscar_abb(E, a(E, _, _)).

buscar_abb(E, a(Raiz, HI, _)):-
  E < Raiz,
  buscar_abb(E, HI).

buscar_abb(E, a(Raiz, _, HD)):-
  E > Raiz,
  buscar_abb(E, HD). 

%-------------------------------------------
%
% crea arbol
%   crea_arbol( +Lista, +Arbol)
%    es cierto si Arbol unifica con un árbol
%    binario que contiene los elementos de Lista.
%
%-------------------------------------------

crea_arbol( [], nil).

crea_arbol( [Cabeza|Resto], a(Cabeza, R, nil)) :-
    crea_arbol( Resto, R).

%-------------------------------------------
%
% Balanceado
%   balanceado( +Arbol)
%    es cierto si Arbol binario es balanceado,
%    Para todo nodo, la diferencia entre la altura del arbol derecho y
%    y del arbol izquierdo, es como maximo 1
%
%-------------------------------------------

balanceado(nil).

balanceado( a(_ , HI, HD)) :-
    altura(HD, AD),
    altura(HI, AI),
    R is AI - AD,
    X is abs(R),
    1 is max(1,X),
    balanceado(HI),
    balanceado(HD).
    
%-------------------------------------------
%
% Altura de un Arbol
%   altura( +Arbol, -R)
%    es cierto si R unifica con la altura del
%    arbol binario
%
%-------------------------------------------

altura(nil, 0).

altura(a(_, HI, HD), R2) :-
    altura(HI, RI),
    altura(HD, RD),
    R is max(RI, RD),
    R2 is R + 1.

%-------------------------------------------
%
% crea arbol balanceado
%   crea_balanceado( +Lista, -Arbol)
%    es cierto si Arbol unifica con un árbol
%    binario balanceado que contiene los elementos de Lista.
%
%-------------------------------------------

crea_balanceado( [], nil).

crea_balanceado( [Cabeza|Resto], a(Cabeza, R1, R2)) :-
    length(Resto, Len),
    Med is Len div 2,
    length( L1, Med), 
    append( L1, L2, Resto),
    crea_balanceado(L1, R1),
    crea_balanceado(L2, R2).

%-------------------------------------------
%
% crea arbol de busqueda binaria
%   crea_abb( +Lista, -Arbol)
%    es cierto si Arbol unifica con un árbol
%    binario de busqueda que contiene los elementos de Lista.
%
%-------------------------------------------

crea_abb( [], nil).

crea_abb( Lista, a(M, R1, R2)) :-
    length(Lista, Len),
    Med is Len div 2,
    length( L1, Med), 
    append( L1, [M|L2], Lista),
    crea_abb(L1, R1),
    crea_abb(L2, R2).