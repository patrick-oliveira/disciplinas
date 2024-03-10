import           Lib
import           Test.Tasty
import           Test.Tasty.HUnit

main :: IO ()
main = do
  defaultMain tests

tests, testInstructions, testPrograms :: TestTree
tests = testGroup "PUSH" [testInstructions, testPrograms]

testInstructions =
  testGroup
    "Individual instructions"
    [ testGroup
        "Int Arithmetic"
        [ testCase "IntAdd" $
          runProgram "(2 3 IntAdd)" @?=
          "Code:  []\nInt:   [5]\nFloat: []\nBool:  []\n"
        , testCase "IntMult" $
          runProgram "(2 3 IntMult)" @?=
          "Code:  []\nInt:   [6]\nFloat: []\nBool:  []\n"
        , testCase "IntSub" $
          runProgram "(2 3 IntSub)" @?=
          "Code:  []\nInt:   [1]\nFloat: []\nBool:  []\n"
        , testCase "IntSub" $
          runProgram "(3 2 IntSub)" @?=
          "Code:  []\nInt:   [-1]\nFloat: []\nBool:  []\n"
        , testCase "IntDiv" $
          runProgram "(7 43 IntDiv)" @?=
          "Code:  []\nInt:   [6]\nFloat: []\nBool:  []\n"
        , testCase "IntDiv" $
          runProgram "(43 7 IntDiv)" @?=
          "Code:  []\nInt:   [0]\nFloat: []\nBool:  []\n"
        ]
    , testGroup
        "Float Arithmetic"
        [ testCase "FloatAdd" $
          runProgram "(2.0 3.0 FloatAdd)" @?=
          "Code:  []\nInt:   []\nFloat: [5.0]\nBool:  []\n"
        , testCase "FloatMult" $
          runProgram "(2.0 3.0 FloatMult)" @?=
          "Code:  []\nInt:   []\nFloat: [6.0]\nBool:  []\n"
        , testCase "FloatSub" $
          runProgram "(2.0 3.0 FloatSub)" @?=
          "Code:  []\nInt:   []\nFloat: [1.0]\nBool:  []\n"
        , testCase "FloatSub" $
          runProgram "(3.0 2.0 FloatSub)" @?=
          "Code:  []\nInt:   []\nFloat: [-1.0]\nBool:  []\n"
        , testCase "FloatDiv" $
          runProgram "(7.0 43.0 FloatDiv)" @?=
          "Code:  []\nInt:   []\nFloat: [6.142857]\nBool:  []\n"
        , testCase "FloatDiv" $
          runProgram "(43.0 7.0 FloatDiv)" @?=
          "Code:  []\nInt:   []\nFloat: [0.1627907]\nBool:  []\n"
        ]
    , testGroup
        "Bool Algebra"
        [ testCase "BoolAnd" $
          runProgram "(True False BoolAnd)" @?=
          "Code:  []\nInt:   []\nFloat: []\nBool:  [False]\n"
        , testCase "BoolOr" $
          runProgram "(True False BoolOr)" @?=
          "Code:  []\nInt:   []\nFloat: []\nBool:  [True]\n"
        ]
    , testGroup
        "Conversions"
        [ testCase "IntToFloat" $
          runProgram "(7 IntToFloat)" @?=
          "Code:  []\nInt:   []\nFloat: [7.0]\nBool:  []\n"
        , testCase "FloatToInt" $
          runProgram "(3.89 FloatToInt)" @?=
          "Code:  []\nInt:   [3]\nFloat: []\nBool:  []\n"
        ]
    ]

testPrograms =
  testGroup
    "Simple Programs"
    [ testCase "(2 3 IntMult 4.1 5.2 FloatAdd True False BoolOr)" $
      runProgram "(2 3 IntMult 4.1 5.2 FloatAdd True False BoolOr)" @?=
      "Code:  []\nInt:   [6]\nFloat: [9.299999]\nBool:  [True]\n"
    , testCase "(5 10 IntAdd 7 IntMult 4.1 IntToFloat FloatDiv)" $
      runProgram "(5 10 IntAdd 7 IntMult 4.1 IntToFloat FloatDiv)" @?=
      "Code:  []\nInt:   []\nFloat: [25.609756]\nBool:  []\n"
    , testCase "(True False BoolAnd False BoolOr False BoolAnd True BoolOr)" $
      runProgram "(True False BoolAnd False BoolOr False BoolAnd True BoolOr)" @?=
      "Code:  []\nInt:   []\nFloat: []\nBool:  [True]\n"
    , testCase "(10 3.14 42 IntDiv BoolAnd IntToFloat FloatMult)" $
      runProgram "(10 3.14 42 IntDiv BoolAnd IntToFloat FloatMult)" @?=
      "Code:  []\nInt:   []\nFloat: [12.56]\nBool:  []\n"
    , testCase "(5 1.23 IntAdd (4) IntSub 5.67 FloatMult)" $
      runProgram "(5 1.23 IntAdd (4) IntSub 5.67 FloatMult)" @?=
      "Code:  []\nInt:   [-1]\nFloat: [6.9741]\nBool:  []\n"
    ]
