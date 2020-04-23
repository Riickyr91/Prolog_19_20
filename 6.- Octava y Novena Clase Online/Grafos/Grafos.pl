/*


    Novena Clase Online


*/

%-------------------------------------------
%
%   Problemas de estado
%       - Ajedrez
%       - 9 reinas
%       - Jarras
%
%           |       |                  
%           |       |       |     |
%           |       |       |     |
%           ---------       -------
%               G5             G3
%
%       1.- Definir el estado
%           estado( ... )
%           Ejemplos:
%               - Ajedrez
%                   Para indicar el estado de una partida, necesitariamos
%                   una matriz de 8 por 8 para indicar lo que hay en cada 
%                   posicion ( en prolog es una lista de listas)
%                   estado([[t,c,a,k,q,a,c,y], 
%                           [p,p,p,p,p,p,p,p],
%                           [x,x,x,x,x,x,x,x],
%                           ... ]).
%
%               - Jarras
%                   Representa un instante del problema de las jarras. G5,
%                   indica el numero de galones en la garrafa de 5 galones
%                   y G3 indica el numero de galones en la garrafa de 3.
%                   estado( X, X).
%
%       2.- Estados inicial y final
%           Ejemplo:
%               - Jarras 
%                   estado inicial = estado(0,0).
%                   estado final = estado(4, ).
%
%       3.- Definir los movimientos
%           Ejemplo:
%               - Jarras
%                   1 - Llenar G5
%                   2 - Llenar G3
%                   3 - Vaciar G5    
%                   4 - Vaciar G3
%                   5 - Pasar contenido de G3 a G5
%                   6 - Pasar contenido de G5 a G3
%
%           Predicado de los movimientos
%               mov( Nombre, EstadoAntes, EstadoDespues).    
%           
%-------------------------------------------

% Movimientos

% Llenar G5
mov( llenarG5, estado(_, G3), estado(5, G3)).

% Llenar G3
mov( llenarG3, estado( G5, _), estado( G5, 3)).

% Vaciar G5
mov( vaciarG5, estado( _, G3), estado( 0, G3)).

% Vaciar G3
mov( vaciarG3, estado( G5, _), estado( G5, 0)).

% Pasar contenido de G3 a G5
mov( pasarG3G5, estado( G5, G3), estado( T, 0)) :-
    T is G5 + G3, 
    T =< 5.

mov( pasarG3G5, estado( G5, G3), estado( 5, R3)) :-
    T is G5 + G3,
    T > 5,
    R3 is T - 5.
    
% Pasar contenido de G5 a G3
mov( pasarG5G3, estado( G5, G3), estado( 0, T)) :-
    T is G5 + G3, 
    T =< 3.

mov( pasarG5G3, estado( G5, G3), estado( R5, 3)) :-
    T is G5 + G3,
    T > 3,
    R5 is T - 3.
