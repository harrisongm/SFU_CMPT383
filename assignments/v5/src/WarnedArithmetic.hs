module WarnedArithmetic(Warning(..),Expr(..),evaluate) where

import WarningAccumulatorMonad

data Warning = DivByZero | AddByNaN
   deriving (Show,Eq)

{- Hint: If the second input is x2, check if x2 == 0.0 -}
warningDivide :: Float -> Float -> WarningAccumulator Warning Float
-- warningDivide = error "Unimplemented"
warningDivide x1 x2 = if (x2 == 0)
   then WarningAccumulator (x1/x2, [DivByZero])
   else WarningAccumulator (x1/x2, [])

{- Hint: use the isNaN function -}
warningPlus :: Float -> Float -> WarningAccumulator Warning Float
-- warningPlus = error "Unimplemented"
warningPlus x1 x2 = if (isNaN x1 || isNaN x2)
   then WarningAccumulator (x1+x2, [AddByNaN])
   else WarningAccumulator (x1+x2, [])

data Expr =
     Base Float
   | Divide (Expr,Expr)
   | Plus (Expr,Expr)
   deriving (Show,Eq)

evaluateHelper :: Expr -> WarningAccumulator Warning Float
-- evaluateHelper = error "Unimplemented"
evaluateHelper (Base x) = WarningAccumulator (x, [])
evaluateHelper (Divide(Base x1, Base x2)) = warningDivide x1 x2
evaluateHelper (Divide(x1, x2)) = if (getResult(evaluateHelper x2) == 0.0)
   then WarningAccumulator (getResult(evaluateHelper x1)/getResult(evaluateHelper x2), getWarnings(evaluateHelper x1) ++ getWarnings(evaluateHelper x2) ++ [DivByZero])
   else WarningAccumulator (getResult(evaluateHelper x1)/getResult(evaluateHelper x2), getWarnings(evaluateHelper x1) ++ getWarnings(evaluateHelper x2))
evaluateHelper (Plus(Base x1, Base x2)) = warningPlus x1 x2
evaluateHelper (Plus(x1, x2)) = if (isNaN (getResult(evaluateHelper x1)) || isNaN (getResult(evaluateHelper x2)))
   then WarningAccumulator (getResult(evaluateHelper x1)/getResult(evaluateHelper x2), getWarnings(evaluateHelper x1) ++ getWarnings(evaluateHelper x2) ++ [AddByNaN])
   else WarningAccumulator (getResult(evaluateHelper x1)/getResult(evaluateHelper x2), getWarnings(evaluateHelper x1) ++ getWarnings(evaluateHelper x2))

evaluate :: Expr -> (Float,[Warning])
evaluate e =
   let res = evaluateHelper e in
   (getResult res, getWarnings res)