comprimido([], []).
comprimido([H|T], R) :- 
    aux_simple(H, T, R).
comprimido([H|T],[c(H,K)|R]) :- 
    aux_comp(H, T, K, R).

% aux_simple(+H,+T,-R).
aux_simple(H, [], [H]).
aux_simple(H, [H|T], [H|R]) :- 
    aux_simple(H, T, R).
aux_simple(H1, [H2|T2], [H1|T3]) :- 
    H1 \= H2, 
    comprimido([H2|T2],T3).

% aux_comp(+H,+T,-K,-R).
aux_comp(_,[],1,[]).
aux_comp(H,[H|T],K,R) :- 
    aux_comp(H, T, K1, R), 
    K is K1+1.
aux_comp(H1,[H2|T],1,R) :- 
    H1\=H2, 
    comprimido([H2|T],R).

% solo es reversible en L1 si L2 no contiene elementos de la forma c(_,_), dado que aux_comp no es reversible en K.

