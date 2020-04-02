%-------------------------------------------
%
% Ordenación por QuickSort 
% quicksort( +Lista, -R)
%
% es cierto si R unifica con una lista
% que contiene los elementos de Lista  
% ordenados de menor a mayor por el metodo
% de quicksort
%  
% O(n log n)
%
% [9,4,6,2,6,3,1,4,2]
%     pivote=4 -> O(n) 
% Menores o iguales		 Mayores
% [4,2,3,1,4,2]          [9,6,6]
%
% quicksort([4,2,3,1,4,2], R1)
% quicksort([9,6,6], R2)
%  
% R1=[1,2,2,3,4,4]
% R2=[6,6,9]
%  
% R=[1,2,2,3,4,4,6,6,9] 
%
% predicado nth0 -> devuelve el elemento en la posicion X de la lista P
%                  y el resto
% 
%-------------------------------------------

quicksort([], []).
 
quicksort(List, R) :-
        length(List, Len),
		Len > 0,
		X is random(Len),
		nth0(X, List, P, Rest), 
        divide(Rest, P, L, H),
        quicksort(L, RL),
        quicksort(H, RH),
        append(RL, [P|RH], R).
    
%-------------------------------------------
% divide(-List, -Pivot, +Less, +High)
%   es cierto si Less se unifica con una lista con
%   de los elementos que son menores o iguales que
%   pivot y High unifica con una lista de elementos de List
%   que son mas altos que pivot
% 
%    1. P(n0)
%    2. n > n0, P(n-1) -> P(n)
%       P(N) :- N2 is N-1, P(N2)
% 
%-------------------------------------------

divide([], _, [], []).

divide([Head|Tail], P, [Head|L], H):- divide(Tail, P, L, H),
   Head =< P.
   
divide([Head|Tail], P, L, [Head|H]):- divide(Tail, P, L, H),
   Head > P.







