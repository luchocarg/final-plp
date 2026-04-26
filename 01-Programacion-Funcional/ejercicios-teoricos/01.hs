mergesort :: (a -> a -> Bool) -> [a] -> [a]
mergesort _ [] = []
mergesort _ [x] = [x]
mergesort comp l = merge comp 
                        (mergesort comp (take (div (length l) 2) l)) 
                        (mergesort comp (drop (div (length l) 2) l))

merge :: (a -> a -> Bool) -> [a] -> [a] -> [a]
merge _ [] ys = ys
merge _ xs [] = xs
merge comp (x:xs) (y:ys) =
    if comp x y
        then x : merge comp xs (y:ys)
        else y : merge comp (x:xs) ys

operatoria :: (a -> a -> a) -> [a] -> a
operatoria f [x]     = x
operatoria f (x:xs)  = f x (operatoria f xs)

sumatoria :: [Int] -> Int
sumatoria = operatoria (+)

productoria :: [Int] -> Int
productoria = operatoria (*)

mientras :: (a -> Bool) -> (a -> a) -> a -> a
mientras cond transform inicial = 
    if cond inicial 
        then mientras cond transform (transform inicial)
        else inicial

fibonacci :: Int -> Int
fibonacci n = 
    (\(res,_,_) -> res) 
    (mientras 
        (\(_,_,p) -> p>0) 
        (\(a,b,p) -> (b, a+b, p-1)) 
        (0, 1, n)
    )

data AB a = Nil | Bin (AB a) a (AB a)
    deriving Show

data ABI a = IBin (ABI a) a (ABI a)
    deriving Show

podadoDesdeElNivel :: Int -> ABI a -> AB a
podadoDesdeElNivel 0 _ = Nil
podadoDesdeElNivel nivel (IBin izq c der) = 
    Bin 
        (podadoDesdeElNivel (nivel-1) izq) 
        c 
        (podadoDesdeElNivel (nivel-1) der)

data Direccion = Izq | Der
    deriving Show

type Camino = [Direccion]

type FuncionDeCaminos a = Camino -> a

funcionDeCaminosDe :: ABI a -> FuncionDeCaminos a
funcionDeCaminosDe (IBin _ c _) [] = c
funcionDeCaminosDe (IBin izq _ _) (Izq:direcciones) = funcionDeCaminosDe izq direcciones
funcionDeCaminosDe (IBin _ _ der) (Der:direcciones) = funcionDeCaminosDe der direcciones

abiDe :: FuncionDeCaminos a -> ABI a
abiDe f = aux []
  where
    aux caminoActual = IBin 
        (aux (caminoActual ++ [Izq]))
        (f caminoActual)
        (aux (caminoActual ++ [Der]))

-- ejemplitos

arbolNaturales n = IBin (arbolNaturales (n+1)) n (arbolNaturales (n+1))

-- funcionDeCaminosDe (arbolNaturales 0) (id [Izq, Der, Der]) -> 3

-- (funcionDeCaminosDe . abiDe) id [Izq, Izq] -> [Izq, Izq]

generadorBiomas :: Camino -> String
generadorBiomas c | length c > 10   = "Desierto"
                  | even (length c) = "Bosque"
                  | otherwise       = "Pradera"

mundoInfinito = abiDe generadorBiomas

explorar = funcionDeCaminosDe mundoInfinito

-- explorar [Izq, Izq, Izq] -> "Pradera"
-- explorar [Izq, Der, Izq, Der] -> "Bosque"