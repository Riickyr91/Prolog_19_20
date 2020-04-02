/*

comprime(+Lista, R) 

comprime([1,1,1,2,2,3,3,3], R).
R = [(1,3), (2,2), (3,3)]

*/

comprime([], ).

comprime([Cab|Resto], R2) :- num_elem(Resto,R), R2 is Cab.