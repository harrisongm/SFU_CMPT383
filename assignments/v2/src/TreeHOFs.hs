module TreeHOFs
    ( Tree(..),
      treeMap,
      treeFold,
      treeHeight,
      treeSum,
      treeSizer
    ) where
import Data.Bits (Bits(xor))

data Tree a =
    Leaf
  | Node (Tree a,a,Tree a)
  deriving (Eq,Show)

{-
  First you should implement tree map. Tree map takes a tree, and updates all
  the values at the internal nodes according to the provided function. The
  structure of the tree should not change, but simply the values contained
  within the tree.
-}
treeMap :: (a -> b) -> Tree a -> Tree b
-- treeMap = error "Unimplemented"
treeMap tree Leaf = Leaf
treeMap tree (Node (l,a,r)) = Node (treeMap tree l,tree a, treeMap tree r)

{-
  Next, we want to be able to fold our trees. treeFold is the tree analogue's
  of List's foldr. In particular, when we hit leaves, we return the provided
  initial "b". On nodes, we fold the subtrees, and use the provided higher-
  order function to fold the values computed by those trees with the value at
  the node.
-}
treeFold :: (b -> a -> b -> b) -> b -> Tree a -> b
treeFold = error "Unimplemented"


{-
  Now we would like to find the height of the tree. Could you find a way to do
  this with a higher-order function?
-}
treeHeight :: Tree a -> Int
-- treeHeight = error "Unimplemented"
treeHeight Leaf = 0
treeHeight (Node (l,a,r)) = 1 + max (treeHeight l) (treeHeight r)

{-
  Next we would like to find the total sum of all the values in a tree of
  integers. Could you find a way to do this using a higher-order function?
-}
treeSum :: Tree Int -> Int
-- treeSum = error "Unimplemented"
treeSum Leaf = 0
treeSum (Node (l,a,r)) = a + (treeSum l) +(treeSum r)

{-
  Finally, we would like to turn the trees into a "sized tree." On the nodes of
  the sized tree are pairs of initial values and sizes of the trees. This one
  is trickier, but still possible to do with a fold. Hint: you may need to use
  a higher order function that returns a pair of values, then project the
  relevant portion of the pair. In a way, this is analogous to strengthening an
  inductive hypothesis.
-}
treeSizer :: Tree a -> Tree (a,Int)
treeSizer = error "Unimplemented"
