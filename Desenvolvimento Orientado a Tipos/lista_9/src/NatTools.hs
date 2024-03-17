{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE StandaloneKindSignatures #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE PolyKinds #-}
{-# OPTIONS_GHC -Wno-unticked-promoted-constructors #-}

module NatTools where

import Data.Type.Equality (type (:~:)(..))
import GHC.TypeNats (KnownNat, Nat, CmpNat, natVal)
import Unsafe.Coerce (unsafeCoerce)
import Data.Kind ( Constraint )

type InvRel :: Ordering -> Ordering
type family InvRel r where
  InvRel EQ = EQ
  InvRel LT = GT
  InvRel GT = LT

data Restriction = CR | TR
type BiCmp :: Restriction -> Nat -> Nat -> Ordering -> k
type family BiCmp r a b o where
  BiCmp CR a b o = (CmpNat a b ~ o, CmpNat b a ~ InvRel o)
  BiCmp TR a b o = (CmpNat a b :~: o, CmpNat b a :~: InvRel o)

type BiCmpC a b o = BiCmp CR a b o
type BiCmpT a b o = BiCmp TR a b o

data OrderingI a b where
  LTI :: BiCmpC a b LT => OrderingI a b
  EQI :: BiCmpC a a EQ => OrderingI a a
  GTI :: BiCmpC a b GT => OrderingI a b

cmpNat :: forall a b proxy1 proxy2. (KnownNat a, KnownNat b)
       => proxy1 a -> proxy2 b -> OrderingI a b
cmpNat x y = case compare (natVal x) (natVal y) of
  EQ -> case unsafeCoerce Refl :: a :~: b of
    Refl -> EQI
  LT -> case unsafeCoerce (Refl, Refl) :: (BiCmpT a b LT) of
    (Refl, Refl) -> LTI
  GT -> case unsafeCoerce (Refl, Refl) :: (BiCmpT a b GT) of
    (Refl, Refl) -> GTI

type OrdCond :: Ordering -> Nat -> Nat -> Nat -> Nat
type family OrdCond o lt eq gt where
  OrdCond LT lt eq gt = lt
  OrdCond EQ lt eq gt = eq
  OrdCond GT lt eq gt = gt

type Min :: Nat -> Nat -> Nat
type Min a b = OrdCond (CmpNat a b) a a b

type CoMin :: Nat -> Nat -> Constraint
type CoMin a b = Min a b ~ Min b a

type MinEq :: Nat -> Nat -> Nat -> Constraint
type MinEq a b c = (CoMin a b, Min a b ~ c)
