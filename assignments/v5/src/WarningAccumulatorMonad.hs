module WarningAccumulatorMonad(WarningAccumulator(..),getResult,getWarnings) where

newtype WarningAccumulator w a = WarningAccumulator (a,[w])
   deriving (Show,Eq)

getResult :: WarningAccumulator w a -> a
getResult (WarningAccumulator (x,ws)) = x

getWarnings :: WarningAccumulator w a -> [w]
getWarnings (WarningAccumulator (x,ws)) = ws

instance Functor (WarningAccumulator w) where
   -- fmap = error "Unimplemented"
   fmap f (WarningAccumulator (x,ws)) = WarningAccumulator (f x,ws)

instance Applicative (WarningAccumulator w) where
   -- pure = error "Unimplemented"
   -- (<*>) = error "Unimplemented"
   pure x = WarningAccumulator(x,[])
   WarningAccumulator (f,ws) <*> WarningAccumulator (x1,x2) = WarningAccumulator (f x1,ws++x2)

instance Monad (WarningAccumulator w) where
   return = pure
   -- (>>=) = error "Unimplemented"
   WarningAccumulator(x,ws) >>= f = WarningAccumulator (getResult(f x), ws++getWarnings(f x))