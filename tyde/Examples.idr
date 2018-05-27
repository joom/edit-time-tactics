module Examples

import Language.Reflection.Editor

%language ElabReflection

%editor
trivial : TTName -> Elab TT
trivial n =
  do (_, _, ty) <- lookupTyExact n
     case ty of
       `(Unit) =>
         pure `(MkUnit)
       `((=) {A=~a} {B=~b} ~x ~y) =>
         do converts a b <|> fail [TextPart "Not equal"]
            converts x y <|> fail [TextPart "Not equal"]
            pure `(Refl {A=~a} {x=~x})
       _ =>
         fail [TextPart "Cannot solve"]


