import Data.List (sort)

data ABBComp a = Nil | Comp [a] | Nodo a (ABBComp a) (ABBComp a)

foldABBComp :: b -> ([a] -> b) -> (a -> b -> b -> b) -> ABBComp a -> b
foldABBComp cNil cComp cNodo abbcomp = case abbcomp of
    Nil        -> cNil
    Comp xs    -> cComp xs
    Nodo x i d -> cNodo x (rec i) (rec d)
    where rec = foldABBComp cNil cComp cNodo

mapABBComp :: (a -> b) -> ABBComp a -> ABBComp b
mapABBComp f = foldABBComp Nil (\xs -> Comp (map f xs)) (\x i d -> Nodo (f x) i d)

recABBComp :: b -> ([a] -> b) -> (a -> ABBComp a -> ABBComp a -> b -> b -> b) -> ABBComp a -> b
recABBComp cNil cComp cNodo abbcomp = case abbcomp of
    Nil        -> cNil
    Comp xs    -> cComp xs
    Nodo x i d -> cNodo x i d (rec i) (rec d)
   where rec = recABBComp cNil cComp cNodo

ordenado :: Ord a => ABBComp a -> Bool
ordenado = 
	recABBComp 	True 
				(\xs -> sort xs == xs) 
				(\x i d iRec dRec -> (ordABBComp (x>) i)&&(ordABBComp (x<) d)&&iRec&&dRec)
    where ordABBComp f = foldABBComp True (\xs -> all f xs) (\x i d -> (f x)&&i&&d

iguales :: (ABBComp a, ABBComp a) -> Bool
iguales (a1,a2) = recABBComp () () () a1