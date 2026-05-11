$ exists. A "ancestro"(A,"daniel") and "ancestro"(A, "giannina")$

Negado y a cnf:

${not"ancestro"(A,"daniel"), not"ancestro"(A, "giannina")}$

Con la base de conocimientos:

1. $"ancestro"(A, X), not"progenitor"(A, X) $

2. $"ancestro"(A, X), not"progenitor"(A, Y), not"ancestro"(Y, X) $
3. progenitor(diego,dalma)
4. progenitor(diego,gianinna)
5. progenitor(tota,diego)
6. progenitor(chitoro,ana)
7. progenitor(ana,daniel)
8. progenitor(chitoro,diego)

9. $not"ancestro"(A,"daniel"), not"ancestro"(A, "giannina")$

En particular con resolucion general esto se resuelve solo con

2 y 6:

10. $"ancestro"("chitoro",X), not"ancestro"("ana",X)$

8 y 6:

11. $"ancestro"("chitoro",X), not"ancestro"("diego",X)$

10 y 9:

12. $not"ancestro"("chitoro","gianinna")$

12 y 11:

13. $not"ancestro"("diego","gianinna")$

13 y 1:

14: $not"progenitor"("diego","gianinna")$

14 y 4:

15: $emptyset$ con $A:="chitoro"$