{-# LANGUAGE NoImplicitPrelude #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# HLINT ignore "Use foldr" #-}

module GameEngine
    (   Score (..),
        toCandidateBasis,
        extractBases,
        basisToPuzzle,
        isWordCorrect,
        allAnswers,
        finalScore
    ) where

import Helpers
import Prelude hiding (foldl, foldr, init, map, length, filter)
import Control.Monad.ST.Lazy (strictToLazyST)

data Score = Zero | Bad | OK | Good | Great | Perfect
    deriving (Eq, Show)

type Dictionary = [String]
type Basis = [Char]
type Puzzle = (Char,[Char])

unique :: Eq a => [a] -> [a]
unique [] = []
unique (x:xs) = x:unique (filter (x /=) xs)

toCandidateBasis :: String -> Maybe Basis
-- toCandidateBasis = error "Unimplemented"
toCandidateBasis str | length (unique str) /= 7 = Nothing | otherwise = Just (Helpers.sort (unique str))

extractBases :: [String] -> [String]
-- extractBases = error "Unimplemented"
extractBases [] = []
extractBases (x:xs)
    | null (filterMap toCandidateBasis (x:xs)) = []
    | otherwise = filter' (binder' (filterMap toCandidateBasis (x:xs)))

binder' :: (Eq a, Ord a) => [a] -> [[a]]
binder' [] =[]
binder' [x] = [[x]]
binder' (x:xs) = group(sort (x:xs))

filter' :: [[a]] -> [a]
filter' [] = []
filter' [[x]] = [x]
filter' (x:xs)
    | length x > 1 = filter' xs
    | otherwise = head x : filter' xs

basisToPuzzle :: Basis -> Int -> Puzzle
-- basisToPuzzle = error "Unimplemented"
basisToPuzzle basis index = (basis!!index, removeChar basis index)

removeChar :: [Char] -> Int -> [Char]
removeChar [] _ = []
removeChar (h:t) 0 = t
removeChar (h:t) n = h:removeChar t (n-1)

isWordCorrect :: Dictionary -> Puzzle -> String -> Bool
-- isWordCorrect = error "Unimplemented"
isWordCorrect dicStr puzzle inputStr
    | not (exists (==inputStr) dicStr) = False
    | not (exists (==fst puzzle) inputStr) = False
    | not (charString (fst puzzle) inputStr && stringString (uncurry (:) puzzle) inputStr) = False
    | otherwise = True

charString :: Char -> String -> Bool
charString x [xs] = x == xs
charString x (h:t) = (x == h) || charString x t

stringString :: String -> String -> Bool
stringString x [h] = charString h x
stringString x (h:t) = charString h x && stringString x t

allAnswers :: Dictionary -> Puzzle -> [String]
-- allAnswers = error "Unimplemented"
allAnswers [] puzzle = []
allAnswers dicStr puzzle =
    if isWordCorrect dicStr puzzle (head dicStr)
        then head dicStr : allAnswers (tail dicStr) puzzle
    else allAnswers (tail dicStr) puzzle

finalScore :: Dictionary -> Puzzle -> [String] -> Score
-- finalScore = error "Unimplemented"
finalScore dicStr puzzle str
    -- | null str  = Zero
    -- | countDuplicates (allAnswers dicStr puzzle) str == 0 = Zero
    -- | length str `divide` length (allAnswers dicStr puzzle) > 0 && length str `divide` length (allAnswers dicStr puzzle) < 0.25 = Bad
    -- | length str `divide` length (allAnswers dicStr puzzle) >= 0.25 && length str `divide` length (allAnswers dicStr puzzle) < 0.5 = OK
    -- | length str `divide` length (allAnswers dicStr puzzle) >= 0.5 && length str `divide` length (allAnswers dicStr puzzle) < 0.75 = Good
    -- | length str `divide` length (allAnswers dicStr puzzle) >= 0.75 && length str `divide` length (allAnswers dicStr puzzle) < 1.0 = Great
    -- | otherwise = Perfect
    | countDuplicates (allAnswers dicStr puzzle) str == length (allAnswers dicStr puzzle) = Perfect
    | countDuplicates (allAnswers dicStr puzzle) str `divide` length (allAnswers dicStr puzzle) >= 0.75 = Great
    | countDuplicates (allAnswers dicStr puzzle) str `divide` length (allAnswers dicStr puzzle) >= 0.5 = Good
    | countDuplicates (allAnswers dicStr puzzle) str `divide` length (allAnswers dicStr puzzle) >= 0.25 = OK
    | countDuplicates (allAnswers dicStr puzzle) str `divide` length (allAnswers dicStr puzzle) > 0 = Bad
    | otherwise = Zero

countDuplicates :: (Eq a) => [a] -> [a] -> Int
countDuplicates [] b = 0
countDuplicates (x:rest) b =
    let index = if x `elem` b then 1 else 0
    in index + countDuplicates rest b