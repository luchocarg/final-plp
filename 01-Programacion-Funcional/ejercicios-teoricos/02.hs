-- 1.a. definimos foldr en funcion de recr

recrA :: (a -> [a] -> b -> b) -> b -> [a] -> b
recrA f z []     = z 
recrA f z (x:xs) = f x xs (recrA f z xs)

foldrA :: (a -> b -> b) -> b -> [a] -> b
foldrA f z (x:xs) = recrA (\x _ rec -> f x rec) z (x:xs)

-- 1.b. definimos recr en funcion de foldr

foldrB :: (a -> b -> b) -> b -> [a] -> b
foldrB f z []     = z
foldrB f z (x:xs) = f x (foldrB f z xs)

recrB :: (a -> [a] -> b -> b) -> b -> [a] -> b
recrB f z xs = snd (foldrB (\x (xs, rec) -> (x:xs, f x xs rec)) ([],z) xs)

-- 1.c. definimos foldl en funcion de foldr (chequear para listas infinitas)



-- 2.a.

-- 2.b.