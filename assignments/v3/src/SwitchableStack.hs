{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use first" #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module SwitchableStack
    ( State,
      empty,
      push,
      pop,
      setInactive,
      setActive,
      mapState,
      popWhere
    ) where

import Data.List (elem,nub)

newtype State a = State ([a], Int)

{- This should create an empty state of your stack. 
   By default, your stack should be active. -}
empty :: State a
empty = State ([], 1)

{- This should push a new element onto your stack.
   In this stack, you cannot have two of the element on the stack.
   If the element already exists on the stack, do not edit the state. -}
push :: (Eq a) => State a -> a -> State a
-- push = error "Not Implemented"
push (State a) elems
 | elems `elem` fst a = State a
 | otherwise = State (elems : fst a, snd a)

{- This should pop the most recently added element off the stack.
   If there are no elements on the stack, return Nothing and an
   unedited version of the stack.
   If the stack is not active, return Nothing and an unedited version
   of the stack. -}
pop :: (Eq a) => State a -> (Maybe a,State a)
-- pop = error "Not Implemented"
pop (State a)
   | null (fst a) = (Nothing, State a)
   | snd a == 1 = (Just (head (fst a)), State (tail (fst a), 1))
   | otherwise = (Nothing, State a)

{- This should switch the stack to the "inactive" state.
When a stack is inactive, elements can be pushed on it, but they
cannot be popped off it. -}
setInactive :: State a -> State a
-- setInactive = error "Not Implemented"
setInactive (State a)
   | snd a /= 0 = State (fst a, 0)
   | otherwise = State a

{- This should switch the stack to the "active" state.
When a stack is active, elements can be pushed on it, and they
can be popped off it. -}
setActive :: State a -> State a
-- setActive = error "Not Implemented"
setActive (State a)
   | snd a /= 1 = State (fst a, 1)
   | otherwise = State a

{- This edits elements on the stack according to the provided function.
   However, this edit may cause duplicates to be added. After mapping the state,
   be sure to remove duplicate elements. -}
mapState :: (Eq b) => (a -> b) -> State a -> State b
-- mapState = error "Not Implemented"
mapState func (State a) = State(nub (applyFunc func (fst a)), snd a)

applyFunc :: (a -> b) -> [a] -> [b]
applyFunc _ [] = []
applyFunc func (h:t) = func h : applyFunc func t

{- This pops all elements that satisfy a given predicate off the stack.
   The remaining elements on the stack are those that do not satisfy
   the provided predicate, in the original order.
   Do not pop any elements from the stack if the stack is inactive. -}
popWhere :: (a -> Bool) -> State a -> ([a],State a)
-- popWhere = error "Not Implemented"
popWhere equat (State a) = 
   if snd a == 1
      then (satisElem equat (fst a), State(notSatisElem equat (fst a), snd a))
   else ([], State a)

satisElem :: (a -> Bool) -> [a] -> [a]
satisElem _ [] = []
satisElem equat (h:t)
   | equat h = h : satisElem equat t
   | otherwise = satisElem equat t

notSatisElem :: (a -> Bool) -> [a] -> [a]
notSatisElem _ [] = []
notSatisElem equat (h:t)
   | equat h = notSatisElem equat t
   | otherwise = h : notSatisElem equat t