{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant bracket" #-}

module Synthesizer
    (numberSplit
    ,baseExpressionsAtSize
    ,varExpressionsAtSize
    ,notExpressionsAtSize
    ,andExpressionsAtSize
    ,orExpressionsAtSize
    ,expressionsAtSize
    ,expressionSatisfiesExamples
    ,generator
    )
     where

import Language
import Data.List
import Data.Maybe
import Foreign (Storable(sizeOf))
import Type.Reflection 

numberSplit :: Int -> [(Int,Int)]
-- numberSplit = error "Unimplemented"
numberSplit x = [(xs, x - xs) | xs<-[1..x], x - xs /= 0]

{-  This should only return a nonempty list at size 1.
    At size 1, it should return a list consisting of the two base expressions
-}
baseExpressionsAtSize :: Int -> [Expression]
-- baseExpressionsAtSize = error "Unimplemented"
baseExpressionsAtSize size
    | size == 1 = [EBase False, EBase True]
    | otherwise = []


{-  This should only return a nonempty list at size 1.
    At size 1, it should return a list consisting of the variable expressions

    HINT: fmap will be useful here.
-}
varExpressionsAtSize :: Context -> Int -> [Expression]
-- varExpressionsAtSize = error "Unimplemented"
varExpressionsAtSize (Context c) size
    | size == 1 = fmap EVariable c
    | otherwise = []

{-  At size 0, it should return an empty list.
    At other sizes, it should call the provided function to get expressions of
    a given size. The resulting expression size should be n and should be a
    "not" expression.

    HINT: fmap will be useful here.
-}
notExpressionsAtSize :: (Int -> [Expression]) -> Int -> [Expression]
-- notExpressionsAtSize = error "Unimplemented"
notExpressionsAtSize f x
    | x == 0 = []
    | otherwise = fmap ENot (f (x - 1))

{-  At size 0, it should return an empty list.
    At other sizes, it should call the provided function to get expressions of
    given sizes. The resulting expression size should be n and should be a
    "and" expression.

    TO GET FULL CREDIT, YOU MUST USE DO SYNTAX WITH THE LIST MONAD.

    HINT: numbersplit will be useful here.
-}
andExpressionsAtSize :: (Int -> [Expression]) -> Int -> [Expression]
andExpressionsAtSize f 0 = []
andExpressionsAtSize f n = do
    -- error "Unimplemented"
    x <- (>>=) (map fst(numberSplit(n-1))) f
    y <- (>>=) (map snd (numberSplit(n-1))) f
    [EAnd (x, y) | (Language.expressionSize x + Language.expressionSize y) == (n-1)]

{-  At size 0, it should return an empty list.
    At other sizes, it should call the provided function to get expressions of
    given sizes. The resulting expression size should be n and should be an
    "or" expression.

    TO GET FULL CREDIT, YOU MUST USE DO SYNTAX WITH THE LIST MONAD.

    HINT: numbersplit will be useful here.
-}
orExpressionsAtSize :: (Int -> [Expression]) -> Int -> [Expression]
orExpressionsAtSize f 0 = []
orExpressionsAtSize f n = do
    -- error "Unimplemented"
    x <- (>>=) (map fst(numberSplit(n-1))) f
    y <- (>>=) (map snd (numberSplit(n-1))) f
    [EOr (x, y) | (Language.expressionSize x + Language.expressionSize y) == (n-1)]

{-  This should simply call andExpressionsAtSize, orExpressionsAtSize,
    notExpressionsAtSize, varExpressionsAtSize, and baseExpressionsAtSize,
    with the appropriate arguments, and concatenate the results.
-}
expressionsAtSize :: Context -> Int -> [Expression]
-- expressionsAtSize = error "Unimplemented"
expressionsAtSize (Context c) size
    | size == 0 = []
    | size == 1 = baseExpressionsAtSize size ++ varExpressionsAtSize (Context c) size
    | size == 2 = notExpressionsAtSize (varExpressionsAtSize (Context c)) size ++ notExpressionsAtSize (baseExpressionsAtSize) size
    | otherwise = notExpressionsAtSize (notExpressionsAtSize (varExpressionsAtSize (Context c))) size ++
        notExpressionsAtSize (notExpressionsAtSize (baseExpressionsAtSize)) size ++
        andExpressionsAtSize (varExpressionsAtSize (Context c)) size ++
        andExpressionsAtSize ((baseExpressionsAtSize)) size ++
        orExpressionsAtSize (varExpressionsAtSize (Context c)) size ++
        orExpressionsAtSize ((baseExpressionsAtSize)) size

{-  Check whether a given expression satisfies the provided examples.

    HINT: the "all" function will be useful here.
-}
expressionSatisfiesExamples :: Examples -> Expression -> Bool
-- expressionSatisfiesExamples = error "Unimplemented"
expressionSatisfiesExamples (Examples []) _ = True
expressionSatisfiesExamples (Examples [(Assignment [], b)]) (EBase a) = a == b
expressionSatisfiesExamples (Examples [(a, b)]) (c) = evaluate a (c) == b
expressionSatisfiesExamples (Examples (x:xs)) (c) = expressionSatisfiesExamples
    (Examples  [x]) (c) && expressionSatisfiesExamples (Examples xs) (c)

{-  Generate an expression that satisfies the examples. Check if there are 
    examples at size 1, then at size 2, ... until either there are no 
    expressions at size max or until an expression is found that satisfies the
    examples.

    HINT: Use a helper function
    HINT: The "find" function will be useful here
    HINT: The "evaluate" function will be useful here
-}
generator :: Context -> Examples -> Int -> Maybe Expression
-- generator = error "Unimplemented"
generator (Context c) exp size = do
    a <- Just (length c)
    if a >= size then Nothing
    else if isNothing (find (expressionSatisfiesExamples exp) (expressionsAtSize (Context c) a))
        then find (expressionSatisfiesExamples exp) (expressionsAtSize (Context c) (a + 1))
    else
        find (expressionSatisfiesExamples exp) (expressionsAtSize (Context c) a)