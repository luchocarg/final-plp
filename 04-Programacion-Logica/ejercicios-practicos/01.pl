% long(+L,-N)

long([], 0).
long([_|T], N) :- 
    long(T, N1), 
    N is N1 + 1.

% no es reversible
% long([H|T],1) -> long(T,N1) -> long(T1,N2) -> ...
% nunca llega al caso base

% sacar(+X,+XS,-YS)

sacar(_, [], []).
sacar(X, [X|T], R) :- sacar(X, T, R).
sacar(X, [H|T], [H|R]) :- X \= H, sacar(X, T, R).

% sinConsecRep(+XS,-YS)

sinConsecRep([], []).
sinConsecRep([H], [H]).
sinConsecRep([H,H|T],L) :- 
    sinConsecRep([H|T],L).
sinConsecRep([H1,H2|T],[H1|L]) :- H1\=H2, 
    sinConsecRep([H2|T],L).

% dado
% append([],L,L).
% append([X|L1],L2,[X|L3]) :- append(L1,L2,L3).

% prefijo(+L,?P)

prefijo(L,P) :- append(P,_,L).

% sufijo(+L,?S)
sufijo(L, S) :- append(_,S,L).

% sublista(+L,?SL)

% insertar(?X,+L,?LX)

% permutacion(+L,?P)

% capicua(?Lista)