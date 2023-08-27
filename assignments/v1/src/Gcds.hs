module Gcds
    ( isDivisor,
      allDivisors,
      listIntersection,
      listGcd
    ) where

{-
  First you should implement divisors. isDivisor a b should return true exactly
  when there exists some integer k such that a * k = b. A way to quickly check
  this is by determining whether b % a == 0. In Haskell the mod function is
  just a function: mod. The code: "mod a b" returns the same as most languages
  "a % b", or what is commonly known in English as "a mod b"

  Once you've implemented isDivisor, test it! We have provided a benchmark
  suite of a few tests to check your code with. However, this benchmark suite
  is non-exhaustive. Try adding some of your own!
-}
isDivisor :: Int -> Int -> Bool
-- isDivisor = error "Unimplemented"
isDivisor a b = mod b a == 0

--- >>> isDivisor 7 21
--- True
---

--- >>> isDivisor 9 21
--- False
---

{-
  Next, given a number, we want to get all divisors from that number. We want
  those numbers returned from largest to smallest. For example, given the
  number 8, allDivisors would return [8,4,2,1].
-}
allDivisors :: Int -> [Int]
-- allDivisors = error "Unimplemented"
-- allDivisors n = [n | d<-[1..(n-1)], mod n d == 0]
-- allDivisors n = [ x | x <- [1 .. n `div` 2], x `isDivisor` n]
allDivisors n = divisors n
  where
    divisors x
      | (x == 1) = [1]
      | (n `mod` x == 0) = x : rest
      | otherwise = rest
      where rest = divisors (x - 1)

--- >>> allDivisors 13
--- [13,1]
---

--- >>> allDivisors 21
--- [21,7,3,1]
---


{-
  Almost done! Now we would like to figure out the intersection of two lists.
  In listIntersection, you can assume that the incoming lists are ordered from
  largest to smallest. You should output a list also ordered from largest to
  smallest. For example, if you intersect the same list with itself, you should
  get that list back!
-}
listIntersection :: [Int] -> [Int] -> [Int]
-- listIntersection = error "Unimplemented"
listIntersection [] _ = []
listIntersection _ [] = []
listIntersection l1 l2 = filter (\x -> x `elem` l1) l2

--- >>> listIntersection [4,3,2,1,0] [9,3,2,0]
--- [3,2,0]
---

{-
  Last bit! From here, you can find a list of all common divisors by
  intersecting the list of a's divisors with the list of b's divisors. This
  list should be ordered from largest to smallest, so you just need to extract
  the first from it!
-}
listGcd :: Int -> Int -> Int
-- listGcd = error "Unimplemented"
listGcd x y = head (allDivisors x `listIntersection` allDivisors y)

--- >>> listGcd 35 20
--- 5
---
