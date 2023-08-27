module WarnedArithmeticTests (
  allTests
) where

import TestingFramework
import WarnedArithmetic

nan :: Float
nan = 0.0 / 0.0

infty :: Float
infty = 1.0 / 0.0

equalityWithNaN :: (Float,[Warning]) -> (Float,[Warning]) -> Bool
equalityWithNaN v1 v2 =
  v1 == v2 || isNaN (fst v1) && isNaN (fst v2) && snd v1 == snd v2

test_evaluateBase :: TestSuite
test_evaluateBase =
  [ ("test_evaluateBaseBasic0",testEqual (1.0,[]) (evaluate (Base 1.0)))
  ]

test_evaluatePlus :: TestSuite
test_evaluatePlus =
  [ ("test_evaluatePlusBasic0",testEqual (2.0,[]) (evaluate (Plus (Base 1.0,Base 1.0))))
   ,("test_evaluatePlusBasic1",testEqual (0.0,[]) (evaluate (Plus (Base (-1.0),Base 1.0)))) 
   ,("test_evaluatePlusBasic2", testEqualManualEq equalityWithNaN (nan,[AddByNaN]) (evaluate (Plus (Base nan,Base 1.0)))) 
   ,("test_evaluatePlusBasic3", testEqualManualEq equalityWithNaN (nan,[AddByNaN]) (evaluate (Plus (Base nan,Base nan)))) 
   ,("test_evaluatePlusBasic4", testEqualManualEq equalityWithNaN (nan,[AddByNaN,AddByNaN]) (evaluate (Plus (Base 1.0,(Plus (Base 1.0,Base nan))))))
   ]

test_evaluateDivide :: TestSuite
test_evaluateDivide =
  [ ("test_evaluateDivideBasic0",testEqual (2.0,[]) (evaluate (Divide (Base 4.0,Base 2.0))))
   ,("test_evaluateDivideBasic1",testEqual (infty,[DivByZero]) (evaluate (Divide (Base 2.0,Base 0.0)))) 
   ,("test_evaluateDivideBasic2",testEqual (0.0,[DivByZero]) (evaluate (Divide (Base 3.0,(Divide (Base 2.0,Base 0.0))))))
   ,("test_evaluateDivideBasic3",testEqual (infty,[DivByZero,DivByZero]) (evaluate (Divide (Base 4.0,(Divide (Base 3.0,(Divide (Base 2.0,Base 0.0))))))))
   ]

allTests :: TestSuite
allTests = test_evaluateBase ++ test_evaluatePlus ++ test_evaluateDivide