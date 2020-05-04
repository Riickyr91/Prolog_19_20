/*


    Onceava Clase Online


*/

%-------------------------------------------
%
%      comprime( +Lista, -R)
%       es cierto si R unifica con una lista de la 
%       siguiente forma:
%
%       comprime([1,1,1,2,2,2,3,4,4],R)
%       R = [(1,3), (2,3), (3,1), (4,2)]
%           
%-------------------------------------------

comprime([], []).

comprime([E], [(E,1)]).

comprime([C,C|Resto], [(C,N)|R]) :-
    comprime([C|Resto], [(C,N2)|R]),
    N is N2 + 1.

comprime([C1,C2|Resto],[(C1,1)|R]) :-
     C1 \= C2,
     comprime([C2|Resto],R).

%-------------------------------------------
%
%      comprime2( +Lista, -R)
%
%-------------------------------------------

comprime2([], []).

comprime2([E], [E]).

comprime2([C,C|Resto], [(C,2)|R] ):-
  comprime([C|Resto], [C|R]).
  
comprime2([C,C|Resto], [(C,N2)|R] ):-
  comprime([C|Resto], [(C,N)|R]),
  N2 is N + 1.

comprime2([C1, C2|Resto], [C1|R]):-
   C1 \= C2,
   comprime([C2|Resto], R).
      

%-------------------------------------------
%
%   elimina_cada_n(Lista, N, R)
%      es cierto si R unifica con una lista
%      que contiene los elementos de Lista
%      eliminando los valores que ocupan
%      posiciones que son múltiplos de N.
%   
%   elimina_cada_n([1,2,3,4,5,6,7], 3, R)
%   R=[1,2,4,5,7]
%
%   elimina_cada_n([9,1,5,3,4,7,8,9], 3, R)
%   R=[9,1,3,4,8,9]
%   
%-------------------------------------------

elimina_cada_n(Lista, N, Lista):-
    length(Lista, L), L < N.

elimina_cada_n( Lista, N, R2):-
    length(Lista, L), L >= N,
    N2 is N - 1,
    length(L1, N2),
    append( L1, [_|L2], Lista),
    elimina_cada_n(L2, N, R),
    append(L1, R, R2).

%-------------------------------------------
%
%   bin2gen( +ArbolBinario, -ArbolGenerico)
%      es cierto si Arbol generico unifica 
%     con un arbol generico equivalente al arbol
%     binario ArbolBinario.
%
%  bin2gen(a(1, nil, nil), R)
%  R = a(1,[]).
%
%  bin2gen(a(1, a(2, nil, nil), a(3nil, nil)), R)
%  R=a(1,[a(2,[]), a(3,[])]).
%
%-------------------------------------------

bin2gen(a(E, nil, nil), a(E, [])).

bin2gen(a(E, HI, HD), a(E, [RI,RD])):-
  HI \= nil,
  HD \= nil, 
  bin2gen(HI, RI),
  bin2gen(HD, RD).

bin2gen(a(E, nil, HD), a(E, [RD])):-
  HD \= nil, 
  bin2gen(HD, RD).

bin2gen(a(E, HI, nil), a(E, [RI])):-
  HI \= nil,
  bin2gen(HI, RI).

% Ejemplo de Arbol binario
arbol1(a(9, a(5, a(3,nil,nil), a(7,nil,nil)), a(12, a(10,nil,nil), a(15,nil,nil)))).