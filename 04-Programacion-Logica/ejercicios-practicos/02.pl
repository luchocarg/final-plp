genNat(0).
genNat(N) :- genNat(M), N is M+1.

par(X, Y) :- genNat(X), between(0,X,S), Y is X-S.

coprimos(X,Y) :- 
    par(X,Y), 
    X > 0, Y > 0,
    1 is gcd(X,Y).

% no es reversible en X, dado que el generador natural hara recursion infinita dado que nunca instancia M.
% es reversible en Y dado que between es S reversible, y se calcula Y con ambos instanciados X y S.

% corteMasParejo(+L,-L1,-L2)

corteMasParejo(L, L1, L2) :- 
    unCorte(L,L1,L2,D),
    not((unCorte(L,_,_,M), M < D)).

unCorte(L, L1, L2, D) :-
    append(L1,L2,L), 
    sumlist(L1,S1), 
    sumlist(L2,S2),
    S3 is S1-S2,
    D is abs(S3).    

% proximoPrimo(+N,-P)

esPrimo(P) :- not((between(2,P,X), P > X, M is gcd(X,P), M > 1)).

proximoPrimo(N, P) :- 
    L is 2*N,
    between(N,L,P),
    esPrimo(P),
    P \= N,
    not((between(N, P, M), M > N, M < P, esPrimo(M))).

% perimetro(?T,?P)

esTriangulo(tri(A,B,C)) :-
    A < B+C,
    B < A+C,
    C < A+B.

triangulo(tri(A,B,C)) :-
    genNat(S1),
    between(0, S1, A), S2 is S1-A,
    between(0, S2, B), C is S2-B,
    esTriangulo(tri(A,B,C)).

sumTri(tri(A,B,C), S) :- S1 is A+B, S is S1+C. 

perimetro(tri(A, B, C), P) :-
    nonvar(P),
    between(0, P, A), S2 is P-A,
    between(0, S2, B), C is S2-B,
    esTriangulo(tri(A, B, C)).

perimetro(T, P) :-
    var(P),
    var(T),
    triangulo(T),
    sumTri(T, P).

perimetro(T, P) :-
    nonvar(T),
    var(P),
    esTriangulo(T),
    sumTri(T, P).