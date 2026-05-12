import Data.List (union)
data AdjAB a = Raiz a [AB a] | Adj [AB a]
data AB a = Nil | Hoja a | Arb a (AB a) (AB a)

ej1 :: AdjAB Int
ej1 = Adj [Nil, Nil, Arb 3 Nil Nil, Hoja 6]

ej2 :: AdjAB Int
ej2 = Raiz 5 [Arb 3 (Arb 1 Nil Nil) (Hoja 4), Arb 3 Nil Nil, Nil]

ej3 :: AdjAB Int
ej3 = Raiz 10 []

foldAB :: b -> (a -> b) -> (a -> b -> b -> b) -> AB a -> b
foldAB cNil cHoja cArb arbol = case arbol of
    Nil           -> cNil
    Hoja x        -> cHoja x
    Arb x izq der ->  cArb x (foldAB cNil cHoja cArb izq) (foldAB cNil cHoja cArb der)

foldAdjAB :: (a -> [b] -> c) -> ([b] -> c) -> b -> (a -> b) -> (a -> b -> b -> b) -> AdjAB a -> c
foldAdjAB cRaiz cAdj cNil cHoja cArb adjs = case adjs of
    Raiz x abs -> cRaiz x (map (foldAB cNil cHoja cArb) abs)
    Adj abs    -> cAdj (map (foldAB cNil cHoja cArb) abs)

mapAdjAB :: (a -> b) -> AdjAB a -> AdjAB b
mapAdjAB f adjAB = foldAdjAB (\x rec -> Raiz (f x) rec) Adj Nil (\x -> Hoja (f x)) (\x i d -> Arb (f x) i d) adjAB

recAB :: 
        b  
    ->  (a -> b) 
    ->  (a -> AB a -> AB a -> b -> b -> b) 
    -> AB a 
    -> b

recAB cNil cHoja cArb arbol = case arbol of
    Nil -> cNil
    Hoja x -> cHoja x
    Arb x izq der -> cArb x izq der (recAB cNil cHoja cArb izq) (recAB cNil cHoja cArb der)

recAdjAB :: 
        (a -> [AB a] -> [b] -> c) 
    ->  ([AB a] -> [b] -> c) 
    ->  b 
    ->  (a -> b) 
    ->  (a -> AB a -> AB a -> b -> b -> b) 
    ->  AdjAB a 
    ->  c

recAdjAB cRaiz cAdj cNil cHoja cArb adjs = case adjs of
    Raiz x abs -> cRaiz x abs (map (recAB cNil cHoja cArb) abs)
    Adj abs    -> cAdj abs (map (recAB cNil cHoja cArb) abs)

ordenado :: Ord a => AdjAB a -> Bool
ordenado = recAdjAB
    (\x abs absRec -> (foldr (&&) True (union (map (\ab -> ordAB x ab (>)) abs) absRec)))
    (\abs absRec -> foldr (&&) True absRec)
    True
    (\_ -> True)
    (\x izq der izqRec derRec -> (ordAB x izq (>))&&(ordAB x der (<))&&izqRec&&derRec)
    where
        ordAB = \x sub f -> case sub of Nil -> True; Hoja y -> f x y; Arb y _ _ -> f x y