% concatenar(?L1,?L2,?L3).
concatenar([], L, L).
concatenar([H|T1], L, [H|T2]) :- 
    concatenar(T1, L, T2).

% ocurreAlMenosUnaVez(X, L).

ocurreAlMenosUnaVez(X, L) :- concatenar(_,[X|_],L).

% ocurreAlMenosDosVeces(X, L).

ocurreAlMenosDosVeces(X, L) :- 
    concatenar(_,[X|T],L), 
    concatenar(_,[X|_],T).

% ocurreExactamenteUnaVez(X, L).

ocurreExactamenteUnaVez(X,L) :- 
    ocurreAlMenosUnaVez(X,L), 
    not(ocurreAlMenosDosVeces(X,L)).