% long(+L,-N)

long([], 0).
long([_|T], N) :- 
    long(T, N1), 
    N is N1 + 1.

