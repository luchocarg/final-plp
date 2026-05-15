comprimido([], []).

comprimido([H|T], Salida) :-
    obtener_bloque_simple(H, T, Bloque, Resto),
    append(Bloque, T2, Salida),
    comprimido(Resto, T2).

comprimido([H|T], [c(H, K)|T2]) :-
    comprimido(H, T, K, Resto),
    comprimido(Resto, T2).

comprimido(H, [H|T], K, Resto) :- 
    comprimido(H, T, K1, Resto), 
    K is K1 + 1.
comprimido(H, [X|T], 1, [X|T]) :- H \= X.
comprimido(_, [], 1, []).

obtener_bloque_simple(H, [H|T], [H|RestoBloque], Resto) :-
    obtener_bloque_simple(H, T, RestoBloque, Resto).
obtener_bloque_simple(H, [X|T], [H], [X|T]) :- H \= X.
obtener_bloque_simple(H, [], [H], []).