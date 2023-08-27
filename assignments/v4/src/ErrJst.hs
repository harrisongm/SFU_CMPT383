module ErrJst(ErrJst(..)) where
import Data.Bits (Bits(xor))

data ErrJst e a = 
     Err e
   | Jst a
   deriving (Eq,Show)

instance Functor (ErrJst e) where
   -- fmap = error "Unimplemented"
   fmap func (Err x) = Err x
   fmap func (Jst x) = Jst(func x)

instance Applicative (ErrJst e) where
   -- pure = error "Unimplemented"
   -- (<*>) = error "Unimplemented"
   pure = Jst
   (<*>) (Err x) (Err y) = Err x
   (<*>) (Jst x) (Jst y) = Jst (x y)
   (<*>) (Err x) (Jst y) = Err x
   (<*>) (Jst x) (Err y) = Err y