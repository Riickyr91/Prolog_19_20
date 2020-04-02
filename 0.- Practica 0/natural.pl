%-------------------------------------------
% natural(+Numero)
% es cierto si Numero es un numero natural
%-------------------------------------------

/* Comentarios :

    1) natural(1)

    2) natutal(n-1) -> natural(n) (como implicacion lógica, o regla logica)
    natural(N) :- N>1, N2 is N - 1, natural(N2).

    % a /\ b /\ c /\ -> d
    d :- a, b, c.
    
*/

natural(1).
natural(N) :-  N>1, N2 is N - 1, natural(N2).
