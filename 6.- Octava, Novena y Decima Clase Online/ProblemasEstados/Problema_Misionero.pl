/*


    Decima Clase Online


*/

%-------------------------------------------
%
%   Problemas de estado
%       - Ejemplo Misionero y Canivales
%
%           |       |                  
%           |       |   M M M    
%           |      _|   C C C              
%
%       1.- Definir el estado
%           estado( ... )
%           
%           estado(Num_mi_Izqu, Num_can_izq, Pos_barca)
%
%       2.- Estados inicial y final
%
%              estado inicial = estado(0,0, derecha).
%              estado final = estado(3, 3, _).
%
%       3.- Definir estados validos
%
%       4.- Limitar las diferentes opciones de pasar
%
%       5.- Definir los movimientos
%                      
%-------------------------------------------

% Estados validos

valido(estado( 1, 1, _)).
valido(estado( 3, 0, _)).
valido(estado( 3, 1, _)).
valido(estado( 3, 2, _)).
valido(estado( 3, 3, _)).
valido(estado( 2, 2, _)).
valido(estado( 0, 0, _)).
valido(estado( 0, 1, _)).
valido(estado( 0, 2, _)).
valido(estado( 0, 3, _)).

% Opciones validas para pasar

pasar(1, 0, izq).
pasar(1, 0, dch).
pasar(0, 1, izq).
pasar(0, 1, dch).
pasar(2, 0, izq).
pasar(2, 0, dch).
pasar(0, 2, izq).
pasar(0, 2, dch).
pasar(1, 1, izq).
pasar(1, 1, dch).

% Movimientos

mov( pasar(M, C, dch), estado( MIzq, CIzq, izq), estado( MIzq2, CIzq2, dch)) :-
    MIzq2 is MIzq - M,
    CIzq2 is CIzq - C,
    valido(estado(MIzq2, CIzq2, dch)).

mov( pasar(M, C, izq), estado( MIzq, CIzq, dch), estado( MIzq2, CIzq2, izq)) :-
    MIzq2 is MIzq + M,
    CIzq2 is CIzq + C,
    valido(estado(MIzq2, CIzq2, izq)).

%-------------------------------------------
%
% Camino a la solucion
%   camino(+EstadoInicial, +EstadoFinal, +Visitados, -R).
%       es cierto si R unifica con una lista de movimientos
%       para pasar del EstadoInicial al estadoFinal, sin repetir
%       los estados de la lista de estados visitados.
%
%   Inicial -> Mov -> EstadoTMP -> Mov -> ...               Final.
%                                        --------------------->
%   EstadoTMP esta un paso mas cerca del final que el Inicial, construiremos
%   la inducción desde ahi.
%
%-------------------------------------------

camino(Ini, Ini, _, [] ).

camino(Ini, Fin, Visitados, [pasar(M, C, Barca)|Camino]):-
    pasar(M, C, Barca), 
    mov(pasar(M, C, Barca), Ini, Tmp), 
    \+ member( Tmp, Visitados),
    camino(Tmp, Fin, [Tmp|Visitados], Camino).