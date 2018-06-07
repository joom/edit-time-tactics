import Language.Reflection.Editor

data Act : Type where
  Done : (a : Type) -> Editorable a => Act
  Arg : (a : Type) -> Editorable a => Act -> Act

actTy : Act -> Type
actTy (Done a) = Elab a
actTy (Arg a e) = a -> actTy e

easy : actTy (Arg TTName (Done TT))
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
