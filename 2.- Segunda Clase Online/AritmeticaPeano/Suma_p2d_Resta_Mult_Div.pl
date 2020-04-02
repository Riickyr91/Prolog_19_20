%-------------------------------------------
%
% Ordenación en Burbuja 
% suma(?N1, ?N2, ?R)
% 
% cierto si R unifica con la suma de N1 y N2 en 
% aritmética de Peano
%
% 1. P(n0)
% 2. P(n-1) -> P(n), Para n > n0
%    P(N) :- N2 is N-1, P(N2)
%
%-------------------------------------------

suma(0,N2,N2).
suma(s(N1),N2,s(R)) :- suma(N1,N2,R).

%-------------------------------------------
%
% Parse de Peano a Decimal
% p2d(+P, -D).
% 
% cierto si D unifica con el decimal equivalente a 
% numero P en aritmética de Peano.
%
%-------------------------------------------

p2d(0,0).
p2d(s(N), R2) :- p2d(N, R), R2 is R + 1.

%-------------------------------------------
%
% Resta
% resta( ?N1, ?N2, ?R). 
% 
% es cierto si unifica con la resta de N1 menos N2
% en aritmética de peano.
%
%-------------------------------------------

resta( N1, 0, N1).
resta( N1, s(N2), R) :- resta( N1, N2, s(R)).

%-------------------------------------------
%
% Multiplicacion
% mult( ?N1, ?N2, ?R). 
% 
% es cierto si R unifica con la suma múltiple de 
% N1, N2 veces
% 4 * 2 = 4 + 4 = 8 = 2 + 2 + 2 + 2.
%
%-------------------------------------------

% Ponemos _, porque cualuier cosa multiplicada por 0 es 0
mult( _, 0, 0).
mult(N1, s(N2), R2) :- mult(N1 , N2, R), suma(N1, R, R2).

%-------------------------------------------
%
% Peano Div
% peano_div( ?N1, ?N2, ?R, ?Resto). 
% 
% es cierto si R unifica con el numero de 
% veces que puede restarse N2 a N1.
% Resto unificará con el resto de la division entera.
%
% peano_div( s(s(s(0))), (s(s(0))), R, Resto ).
% R = s(0) 
% Resto = s(0)
%-------------------------------------------

peano_div( N1, N2, 0, N1) :-
    menor( N1, N2).

peano_div( N1, N2, s(R), Resto) :- 
    resta( N1, N2, N12),
    peano_div( N12, N2, R, Resto).

%-------------------------------------------
%
% Menor
% menor(?N1, ?N2). 
% 
% es cierto si N1 es menor que N2 en
% aritmetica de peano
%
%-------------------------------------------

menor( 0, s(_)).

menor( s(N1), s(N2)) :-
    menor( N1, N2).