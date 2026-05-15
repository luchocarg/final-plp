import Data.List (sort)
data ABBComp a = Nil | Comp [a] | Nodo a (ABBComp a) (ABBComp a) deriving Show

ej1 = Comp [0, 2, 14, 22]
ej2 = Nodo 2 (Nodo 0 Nil Nil) (Comp [14, 22])
ej3 = Nodo 14 (Nodo 2 (Nodo 0 Nil Nil) Nil) (Nodo 22 Nil Nil)

foldABBComp :: b -> ([a] -> b) -> (a -> b -> b -> b) -> ABBComp a -> b 
foldABBComp cNil cComp cNodo abb = case abb of
    Nil            -> cNil
    Comp xs        -> cComp xs
    Nodo r izq der -> cNodo r (foldABBComp cNil cComp cNodo izq) (foldABBComp cNil cComp cNodo der)

mapABBComp :: (a -> b) -> ABBComp a -> ABBComp b
mapABBComp f = foldABBComp Nil (\xs -> Comp (map f xs)) (\r izq der -> Nodo (f r) izq der)

recABBComp :: b -> ([a] -> b) -> (a -> (ABBComp a) -> (ABBComp a) -> b -> b -> b) -> ABBComp a -> b
recABBComp cNil cComp cNodo abb = case abb of
    Nil     -> cNil
    Comp xs -> cComp xs
    Nodo r izq der -> cNodo r izq der (rec izq) (rec der) 
    where rec = recABBComp cNil cComp cNodo

ordenado :: Ord a => ABBComp a -> Bool
ordenado = recABBComp True (\xs -> sort xs == xs) (\r izq der izqRec derRec ->izqRec&&derRec&&(elInvarianteValeParaEsteNodo r izq der))
	where 
		elInvarianteValeParaEsteNodo r izq der = (todoElSubarbolCumpleElInvariante (r>) izq)&&(todoElSubarbolCumpleElInvariante (r<) der)
		todoElSubarbolCumpleElInvariante f = foldABBComp True (\xs -> and (map f xs)) (\r izq der -> izq&&der&&(f r))


iguales :: Eq a => ABBComp a -> ABBComp a -> Bool
iguales a1 a2 = (inorder a1) == (inorder a2)
	where 
		inorder = foldABBComp [] id (\r i d -> i++[r]++d)
