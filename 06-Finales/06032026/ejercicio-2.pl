progenitor(diego,dalma).
progenitor(diego,gianinna).
progenitor(diego,dalma).
progenitor(tota,diego).
progenitor(chitoro,ana).
progenitor(ana,daniel).

pareja(gianinna,osvaldo).
pareja(chitoro,tota).
pareja(diego,claudia).
pareja(ana,pedro).

pareja(X,Y) :- pareja(Y,X).

ancestro(A, X) :- progenitor(A, X).
ancestro(A, X) :- progenitor(A, Y), ancestro(Y, X).

% a descendientes(+P, -L).

descendientes(P, [H|T]) :- 
    ancestro(P, H), 
    not(member(H,T)),
    descendientes(P,T). 