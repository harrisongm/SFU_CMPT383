module ZipTree(Tree(..)) where

data Tree a =
      Leaf
    | Node(Tree a,a,Tree a)
   deriving (Eq,Show)

instance Functor Tree where
   fmap f Leaf          = Leaf
   fmap f (Node(l,v,r)) = Node(fmap f l,f v,fmap f r)

instance Applicative Tree where
   pure x = Node(pure x,x,pure x)
   --  (<*>) = error "Unimplemented"
   (<*>) Leaf Leaf = Leaf
   (<*>) (Node(left,a,right)) Leaf = Leaf
   (<*>) Leaf (Node(left,a,right)) = Leaf
   (<*>) (Node(left,a,right)) (Node(left1,b,right1)) = Node((<*>) left left1, a b, (<*>) right right1)
