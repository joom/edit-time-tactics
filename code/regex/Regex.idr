module Regex

import Unquote
-- the Unquote module can be found here for now:
-- https://gist.github.com/joom/d8facacdcbdaaf275c6312933ec4e9dc

import Language.Reflection.Editor

data Regex = Lit Char | Concat Regex Regex | Or Regex Regex | Many Regex | Epsilon | Empty

implementation Eq Regex where
  (Lit c) == (Lit c') = c == c'
  (Concat a b) == (Concat a' b') = a == a' && b == b'
  (Or a b) == (Or a' b') = a == a' && b == b'
  (Many a) == (Many a') = a == a'
  Epsilon == Epsilon = True
  Empty == Empty = True
  _ == _ = False

mutual
  simplify : Regex -> Regex
  simplify Empty = Empty
  simplify Epsilon = Epsilon
  simplify (Lit c) = Lit c
  simplify (Many Empty) = Epsilon
  simplify (Many Epsilon) = Epsilon
  simplify (Many (Many x)) = simplify (Many (simplify x))
  simplify (Many x) = Many (simplify x)
  simplify (Or Epsilon (Many y)) = Many (simplify y)
  simplify (Or x (Or y1 y2)) = simplify (Or (Or x y1) y2)
  simplify (Concat x (Concat y1 y2)) = simplify (Concat (Concat x y1) y2)
  simplify (Or x y) =
    if x == Empty then simplify y
    else if y == Empty then simplify x
    else setToRegex $ regToSet (Or x y)
  simplify (Concat x y) =
      let sx = simplify x in
      let sy = simplify y in
      if (sx == Empty) || (sy == Empty) then Empty
      else if sx == Epsilon then sy
      else if sy == Epsilon then sx
      else Concat sx sy

  regToSet : Regex -> List Regex
  regToSet (Or x y) = nub (regToSet x ++ regToSet y)
  regToSet x = [simplify x]

  setToRegex : List Regex -> Regex
  setToRegex [] = Empty
  setToRegex (h :: t) = simpl2 (Or h (setToRegex t))
    where
      simpl2 : Regex -> Regex
      simpl2 (Or x Empty) = x
      simpl2 (Or Empty x) = x
      simpl2 x = x

implementation Quotable Regex TT where
  quotedTy = `(Regex)
  quote (Lit c) = `(Lit ~(quote c))
  quote (Concat x y) = `(Concat ~(quote x) ~(quote y))
  quote (Or x y) = `(Or ~(quote x) ~(quote y))
  quote (Many x) = `(Many ~(quote x))
  quote Epsilon = `(Epsilon)
  quote Empty = `(Empty)

implementation Unquotable TT Regex where
  unquote `(Lit ~c) = Lit <$> unquote c
  unquote `(Concat ~x ~y) = Concat <$> unquote x <*> unquote y
  unquote `(Or ~x ~y) = Or <$> unquote x <*> unquote y
  unquote `(Many ~x) = Many <$> unquote x
  unquote `(Epsilon) = pure Epsilon
  unquote `(Empty) = pure Empty
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a", NamePart `{Regex}]

%editor
simplifyInEditor : TT -> Elab TT
simplifyInEditor t =
  do r <- unquote t
     pure (quote (simplify r))

r : Regex
r = Many (Lit 'a')
