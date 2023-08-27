{-# LANGUAGE NoImplicitPrelude #-}

module ListHOFs
    ( zip,
      alternatingMap,
      sumEvens,
      flatten
    ) where

import Prelude(Int(..),Maybe(..),filter,mod,(+),(.),(==),(++))
import GHC.Base

head :: [a] -> a
head [] = error "Nothing in the list"
head (h:_) = h

tail :: [a] -> [a]
tail [] = []
tail (_:t) = t

length :: [a] -> Int
length [] = 0
length (h:t) = 1 + length t

isEven :: Int -> Bool
isEven a = mod a 2 == 0

getSum :: [Int] -> Int
getSum [] = 0
getSum (h:t) = h + getSum t

{-
  One useful thing to do with lists is zip them together. Let's build the zip
  function, that does exactly this. However, lists don't always have the same
  length, so when they have differing lengths, we should return Nothing. If
  they have the same length, we should return Just l, where l is the zipped
  list.
-}
zip :: [a] -> [b] -> Maybe [(a,b)]
zip = error "Unimplemented"
-- zip [] []  = Just []
-- zip (a:as) (b:bs) = (a,b) : zip as bs

{-
  You've seen map before, so it's time to try building an "alternating map". An
  alternating map does the same thing that a map does, but it alternates which
  function is used at a time. The first function used should be the first
  function, then the second element should have the second function applied,
  and so on.
-}
alternatingMap :: (a -> b) -> (a -> b) -> [a] -> [b]
-- alternatingMap = error "Unimplemented"
alternatingMap f g [] = []
alternatingMap f g [x] = [f x]
alternatingMap f g (x : y : t) = f x : g y : alternatingMap f g t

{-
  Now you should sum the even elements of a list up. Can you do this by 
  combining two other functions together. Notice what you've been provided in
  your imports.
-}
sumEvens :: [Int] -> Int
-- sumEvens = error "Unimplemented"
sumEvens x = getSum(filter isEven x)

{-
  The last function is the flatten a list of lists into a single list. This
  can be done by just finding the correct applications for the right higher-
  order function.
-}
flatten :: [[a]] -> [a]
-- flatten = error "Unimplemented"
flatten [] = []
flatten (h:t) = h ++ flatten(t)

--- >>> flatten [[1,2],[3,4]]
--- [1,2,3,4]
---
