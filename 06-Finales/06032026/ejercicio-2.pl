progenitor(diego,dalma).
progenitor(diego,gianinna).
progenitor(tota,diego).
progenitor(chitoro,ana).
progenitor(ana,daniel).

progenitor(chitoro,diego).

pareja(gianinna,osvaldo).
pareja(chitoro,tota).
pareja(diego,claudia).
pareja(ana,pedro).

pareja(X,Y) :- pareja(Y,X).

ancestro(A, X) :- progenitor(A, X).
ancestro(A, X) :- progenitor(A, Y), ancestro(Y, X).

% a descendientes(+P, -L).

descendientes(P, L) :- bagof(X, ancestro(P,X), L).

% ancestroComunMasCercano(+P1, +P2, -A).

ancestroComunMasCercano(P1, P2, A) :- 
    ancestro(A, P1), 
    ancestro(A, P2), 
    not((descendientes(A,L), ancestro(X,P1), ancestro(X,P2), X \= A, member(X,L))).

