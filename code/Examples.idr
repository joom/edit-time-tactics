module Examples

import Language.Reflection.Editor

%language ElabReflection

%editor
easy : TTName -> Elab TT
easy n =
  do (_, _, ty) <- lookupTyExact n
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
