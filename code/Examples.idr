module Examples

import Language.Reflection.Editor

%language ElabReflection

getType : TTName -> Elab TT
getType n =
  do (_, _, ty) <- lookupTyExact n
     pure ty

%editor
easy : TTName -> Elab TT
easy n =
  do ty <- getType n
     case ty of
       `(() : Type) =>
         pure `(() : ())
       `((=) {A=~a} {B=~b} ~x ~y) =>
         do converts a b
            converts x y
            pure `(Refl {A=~a} {x=~x})
       _ =>
         fail [TextPart "Cannot solve"]


foo : ()
foo = ?lskdaf


bar : 2 + 2 = 4
bar = ?laskdjr


wat : 2 + 2 = 5
wat = ?lkj
