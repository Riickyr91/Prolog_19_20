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