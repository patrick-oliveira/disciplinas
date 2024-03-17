module Main (main) where

import Atividade03 hiding (main)

import Data.Char

import Test.Tasty
import Test.Tasty.HUnit



main :: IO ()
main = do
  defaultMain tests

tests :: TestTree
tests = testGroup "Testes da Atividade 3" [vendingMachine, validacoes]

transicaoDummy :: Transicao Aguardando ServindoPedido
transicaoDummy = Transicao (`rem` 5)

transicaoFull :: Transicao Aguardando Aguardando
transicaoFull = Transicao (+ 1)

compraChocolate :: MaquinaDeVenda Aguardando -> MaquinaDeVenda Aguardando
compraChocolate m =
  m
  |> insereMoeda
  |> escolheProduto
  |> entregaPedido
  |> finalizaEntrega

vendingMachine :: TestTree
vendingMachine = testGroup "MaquinaDeVenda"
                 [
                   testCase "transicao dummy" (
                     assertEqual ""
                       (MaquinaDeVenda 2 :: MaquinaDeVenda ServindoPedido)
                       (transicao transicaoDummy (MaquinaDeVenda 7)))
                 , testCase "transicao dummy2" (
                     assertEqual ""
                       (MaquinaDeVenda 3 :: MaquinaDeVenda Aguardando)
                       (transicao transicaoFull (MaquinaDeVenda 2)))
                 , testCase "compraChocolate" (
                     assertEqual ""
                       (MaquinaDeVenda 8 :: MaquinaDeVenda Aguardando)
                       (compraChocolate (MaquinaDeVenda 7)))
                 ]

data AllCaps
isAllCaps :: Checker AllCaps
isAllCaps s =
  case filter isLower s of
    [] -> Just $ CheckedString s
    _  -> Nothing

instance CheckStringClass AllCaps where
  check = isAllCaps

validacoes :: TestTree
validacoes = testGroup "Validações de strings"
             [
               testCase "Testa Higienização" (
                 assertEqual "Strings deveriam ser prefixadas e sufixadas com a tag correta"
                   (Just $ CheckedString "<SANITIZED>Buemba</SANITIZED>" :: Maybe (CheckedString Sanitized))
                   (sanitizeString "Buemba"))
             , testCase "Testa Validação" (
                 assertEqual "Strings deveriam ser prefixadas e sufixadas com a tag correta"
                   (Just $ CheckedString "<VALIDATED>Buemba</VALIDATED>" :: Maybe (CheckedString Validated))
                   (validateString "Buemba"))
             , testCase "Testa Capitalização" (
                 assertEqual "Strings deveriam ser maiúsculas"
                   (Just $ CheckedString "XIMFORIMPOLA" :: Maybe (CheckedString Capitalized))
                   (capitalizeString "xImFoRimPoLa"))
             , testCase "Testa AllCaps 1" (
                 assertEqual "Todas maiúsculas? Não!"
                   (Nothing :: Maybe (CheckedString AllCaps))
                   (isAllCaps "xImFoRimPoLa"))
             , testCase "Testa AllCaps 2" (
                 assertEqual "Todas maiúsculas? Sim!"
                   (Just $ CheckedString "CHANFLE" :: Maybe (CheckedString AllCaps))
                   (isAllCaps "CHANFLE"))
             , testCase "Testa Higienização++" (
                 assertEqual "Strings deveriam ser prefixadas e sufixadas com a tag correta"
                   (Just $ CheckedString "<SANITIZED>Buemba</SANITIZED>" :: Maybe (CheckedString Sanitized))
                   (check "Buemba"))
             , testCase "Testa Validação++" (
                 assertEqual "Strings deveriam ser prefixadas e sufixadas com a tag correta"
                   (Just $ CheckedString "<VALIDATED>Buemba</VALIDATED>" :: Maybe (CheckedString Validated))
                   (check "Buemba"))
             , testCase "Testa Capitalização++" (
                 assertEqual "Strings deveriam ser maiúsculas"
                   (Just $ CheckedString "XIMFORIMPOLA" :: Maybe (CheckedString Capitalized))
                   (check "xImFoRimPoLa"))
             , testCase "Testa allCaps Class - 1" (
                 assertEqual "Strings deveriam ser todas"
                   (Just $ CheckedString "XIMFORIMPOLA" :: Maybe (CheckedString AllCaps))
                   (check "XIMFORIMPOLA"))
             , testCase "Testa allCaps Class - 2" (
                 assertEqual "Strings deveriam ser todas"
                   (Nothing :: Maybe (CheckedString AllCaps))
                   (check "XIMFORIMPOLa"))
             , testCase "Check Duplo Class - AllCaps Validated - Nothing" (
                 assertEqual ""
                   (Nothing :: Maybe (CheckedString2 AllCaps Validated))
                   (check2 "XIMFORIMPOLa"))
             , testCase "Check Duplo Class - AllCaps Validated - Just" (
                 assertEqual ""
                   (Just (CheckedString2 "<VALIDATED>XIMFORIMPOLA</VALIDATED>") :: Maybe (CheckedString2 AllCaps Validated))
                   (check2 "XIMFORIMPOLA"))
             , testCase "Check Duplo Class - Sanitized Validated" (
                 assertEqual ""
                   (Just (CheckedString2 "<VALIDATED><SANITIZED>XIMFORIMPOLA</SANITIZED></VALIDATED>") :: Maybe (CheckedString2 Sanitized Validated))
                   (check2 "XIMFORIMPOLA"))
             , testCase "Check Duplo Class - Capitalized AllCaps" (
                 assertEqual ""
                   (Just (CheckedString2 "CHAMFLE!") :: Maybe (CheckedString2 Capitalized AllCaps))
                   (check2 "cHamFle!"))
             , testCase "Check Duplo Class - AllCaps Capitalized" (
                 assertEqual ""
                   (Nothing :: Maybe (CheckedString2 AllCaps Capitalized))
                   (check2 "cHamFle!"))
             , testCase "FullCheck" (
                 assertEqual ""
                   (Just (CheckedString3 "<SANITIZED><VALIDATED>CHAMFLE!</VALIDATED></SANITIZED>"))
                   (fullCheck "cHamFle!"))
             , testCase "Check Triplo - Caps antes de AllCaps - 1" (
                 assertEqual ""
                   (Just (CheckedString3 "<VALIDATED>CHAMFLE!</VALIDATED>") :: Maybe (CheckedString3 Capitalized Validated AllCaps))
                   (check3 "cHamFle!"))
             , testCase "Check Triplo - Caps antes de AllCaps - 2" (
                 assertEqual ""
                   (Just (CheckedString3 "<VALIDATED>CHAMFLE!</VALIDATED>") :: Maybe (CheckedString3 Capitalized AllCaps Validated))
                   (check3 "cHamFle!"))
             , testCase "Check Triplo - AllCaps antes de Caps - 1" (
                 assertEqual ""
                   (Nothing :: Maybe (CheckedString3 AllCaps Capitalized Validated))
                   (check3 "cHamFle!"))
             , testCase "Check Triplo - AllCaps antes de Caps - 2" (
                 assertEqual ""
                   (Nothing :: Maybe (CheckedString3 AllCaps Validated Capitalized))
                   (check3 "cHamFle!"))
             , testCase "Check Quádruplo! - Não Ok" (
                 assertEqual ""
                   (Nothing :: Maybe (CheckedString4 AllCaps Validated Capitalized Sanitized))
                   (check4 "cHamFle!"))
             , testCase "Check Quádruplo! - Ok" (
                 assertEqual ""
                   (Just (CheckedString4 "<SANITIZED><VALIDATED>CHAMFLE!</VALIDATED></SANITIZED>") :: Maybe (CheckedString4 Validated Capitalized AllCaps Sanitized))
                   (check4 "cHamFle!"))
             ]
