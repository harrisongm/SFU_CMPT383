module AssocList(AssocList(..),doubleMap) where
import ErrJst

data AssocList k a = 
     Nil
   | Cons(k,a,AssocList k a)
   deriving (Eq,Show)

instance Functor (AssocList k) where
   -- fmap = error "Unimplemented"
   fmap func Nil = Nil
   fmap func (Cons(x,y,z)) = Cons(x, func y, fmap func z)

doubleMap :: (k -> a -> (k',a')) -> AssocList k a -> AssocList k' a'
-- doubleMap = error "Unimplemented"
doubleMap func Nil = Nil
doubleMap func (Cons(x,y,z)) = Cons(fst(func x y), snd(func x y), doubleMap func z)