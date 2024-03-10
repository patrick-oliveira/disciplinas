module Main where

import Atividade01

import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = do
  defaultMain tests

tests :: TestTree
tests = (testGroup "Testes da Atividade 1" [mult3Test, mult8Test, mult83Test, ehPrimoTest, bissextosTest, lastNBissextosTest, stringToIntegersTest, ex8Test, ex10Test])


mult3Test = testGroup "mult3"
            [testCase "test1" (assertEqual "Test 1" True (mult3 3)),
             testCase "test2" (assertEqual "Test 2" True (mult3 30)),
             testCase "test3" (assertEqual "Test 3" False (mult3 1)),
             testCase "test4" (assertEqual "Test 4" False (mult3 5)),
             testCase "test5" (assertEqual "Test 5" False (mult3 8)),
             testCase "test6" (assertEqual "Test 6" True (mult3 9)),
             testCase "test7" (assertEqual "Test 7" True (mult3 24)),
             testCase "test8" (assertEqual "Test 8" False (mult3 25))
             ]


mult8Test = testGroup "mult8"
            [testCase "test1" (assertEqual "Test 1" False (mult8 3)),
             testCase "test2" (assertEqual "Test 2" False (mult8 30)),
             testCase "test3" (assertEqual "Test 3" False (mult8 1)),
             testCase "test4" (assertEqual "Test 4" False (mult8 5)),
             testCase "test5" (assertEqual "Test 5" True (mult8 8)),
             testCase "test6" (assertEqual "Test 6" False (mult8 9)),
             testCase "test7" (assertEqual "Test 7" True (mult8 24)),
             testCase "test8" (assertEqual "Test 8" False (mult8 25))
             ]

mult83Test = testGroup "mult83"
            [testCase "test1" (assertEqual "Test 1" False (mult83 3)),
             testCase "test2" (assertEqual "Test 2" False (mult83 30)),
             testCase "test3" (assertEqual "Test 3" False (mult83 1)),
             testCase "test4" (assertEqual "Test 4" False (mult83 5)),
             testCase "test5" (assertEqual "Test 5" False (mult83 8)),
             testCase "test6" (assertEqual "Test 6" False (mult83 9)),
             testCase "test7" (assertEqual "Test 7" True (mult83 24)),
             testCase "test8" (assertEqual "Test 8" False (mult83 25))
             ]


ehPrimoTest = testGroup "ehPrimo"
            [testCase "test1" (assertEqual "Test 1" False (ehPrimo 1)),
             testCase "test2" (assertEqual "Test 2" True (ehPrimo 2)),
             testCase "test3" (assertEqual "Test 3" True (ehPrimo 3)),
             testCase "test4" (assertEqual "Test 4" False (ehPrimo 4)),
             testCase "test5" (assertEqual "Test 5" True (ehPrimo 5)),
             testCase "test6" (assertEqual "Test 6" False (ehPrimo 21)),
             testCase "test7" (assertEqual "Test 7" False (ehPrimo 20))
             ]


bissextosTest = testGroup "bissextos"
          [testCase "test1" (assertEqual "Test 1" [1584,1588,1592,1596,1600,1604,1608,1612,1616,1620,1624,1628,1632,1636,1640,1644,1648,1652,1656,1660,1664,1668,1672,1676,1680,1684,1688,1692,1696,1704,1708,1712,1716,1720,1724,1728,1732,1736,1740,1744,1748,1752,1756,1760,1764,1768,1772,1776,1780,1784,1788,1792,1796,1804,1808,1812,1816,1820,1824,1828,1832,1836,1840,1844,1848,1852,1856,1860,1864,1868,1872,1876,1880,1884,1888,1892,1896,1904,1908,1912,1916,1920,1924,1928,1932,1936,1940,1944,1948,1952,1956,1960,1964,1968,1972,1976,1980,1984,1988,1992,1996,2000,2004,2008,2012,2016,2020] (bissextos))
          ]

lastNBissextosTest = testGroup "lastNBissextos"
            [testCase "test1" (assertEqual "Test 1" [1984,1988,1992,1996,2000,2004,2008,2012,2016,2020] (lastNBissextos 10)),
             testCase "test2" (assertEqual "Test 2" [2020] (lastNBissextos 1)),
             testCase "test3" (assertEqual "Test 3" [2016,2020] (lastNBissextos 2)),
             testCase "test4" (assertEqual "Test 4" [] (lastNBissextos 0))
             ]


stringToIntegersTest = testGroup "stringToInteger"
            [testCase "test1" (assertEqual "Test 1" [0] (stringToIntegers "0")),
             testCase "test2" (assertEqual "Test 2" [0,1] (stringToIntegers "01")),
             testCase "test3" (assertEqual "Test 3" [1,0] (stringToIntegers "10")),
             testCase "test4" (assertEqual "Test 4" [0,9,8,7,6,5,4,3,2,1] (stringToIntegers "0987654321")),
             testCase "test3" (assertEqual "Test 3" [9,9,9,0,1,1,1] (stringToIntegers "9990111"))
             ]

ex8Test = testGroup "ex8"
            [testCase "test1" (assertEqual "Test 1" True (ex8 0)),
             testCase "test2" (assertEqual "Test 2" True (ex8 600)),
             testCase "test3" (assertEqual "Test 3" False (ex8 (-1))),
             testCase "test4" (assertEqual "Test 4" False (ex8 (-2))),
             testCase "test3" (assertEqual "Test 3" True(ex8 243))
             ]


ex10Test = testGroup "ex10"
            [
              testCase "test1" (assertEqual "Test 1" (-2) (subtrair 9 11)),
              testCase "test2" (assertEqual "Test 2" (-6) (dobro (-3))),
              testCase "test3" (assertEqual "Test 3" 9 (quad (-3))),
              testCase "test4" (assertEqual "Test 4" "Olá pessoa" (cumprimentar "pessoa")),
              testCase "test5" (assertEqual "Test 5" "Você fará 23 anos em 2023!" (aniversario 2000)),
              testCase "test6" (assertEqual "Test 6" "Você fará 43 anos em 2023!" (aniversario 1980))
            ]
