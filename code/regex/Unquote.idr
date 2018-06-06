module Unquote
%access public export

||| An interface to recover things from their canonical representations
||| as reflected terms, i.e. to reify things.
|||
||| This interface is intended to be used during proof
||| automation and the construction of custom tactics.
|||
||| @ t the type to quote it from (typically `TT` or `Raw`)
||| @ a the type to be unquoted
interface Unquotable t a where
  unquote : t -> Elab a

implementation Unquotable TT Bool where
  unquote `(True) = pure True
  unquote `(False) = pure False
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a" , NamePart `{{Bool}}]

implementation Unquotable Raw Bool where
  unquote `(True) = pure True
  unquote `(False) = pure False
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a" , NamePart `{{Bool}}]

implementation Unquotable TT Char where
  unquote (TConst (Ch c)) = pure c
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a" , NamePart `{{Char}}]

implementation Unquotable Raw Char where
  unquote (RConstant (Ch c)) = pure c
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a" , NamePart `{{Char}}]

implementation Unquotable TT String where
  unquote (TConst (Str s)) = pure s
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a" , NamePart `{{String}}]

implementation Unquotable Raw String where
  unquote (RConstant (Str s)) = pure s
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a" , NamePart `{{String}}]

implementation Unquotable TT Double where
  unquote (TConst (Fl d)) = pure d
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a" , NamePart `{{Double}}]

implementation Unquotable Raw Double where
  unquote (RConstant (Fl d)) = pure d
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a" , NamePart `{{Double}}]

implementation Unquotable TT Bits8 where
  unquote (TConst (B8 b)) = pure b
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a" , NamePart `{{Bits8}}]

implementation Unquotable Raw Bits8 where
  unquote (RConstant (B8 b)) = pure b
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a" , NamePart `{{Bits8}}]

implementation Unquotable TT Bits16 where
  unquote (TConst (B16 b)) = pure b
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                 , TextPart "as a" , NamePart `{{Bits16}}]

implementation Unquotable Raw Bits16 where
  unquote (RConstant (B16 b)) = pure b
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a" , NamePart `{{Bits16}}]

implementation Unquotable TT Bits32 where
  unquote (TConst (B32 b)) = pure b
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                 , TextPart "as a" , NamePart `{{Bits32}}]

implementation Unquotable Raw Bits32 where
  unquote (RConstant (B32 b)) = pure b
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a" , NamePart `{{Bits32}}]

implementation Unquotable TT Bits64 where
  unquote (TConst (B64 b)) = pure b
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                 , TextPart "as a" , NamePart `{{Bits64}}]

implementation Unquotable Raw Bits64 where
  unquote (RConstant (B64 b)) = pure b
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a" , NamePart `{{Bits64}}]

implementation Unquotable TT NativeTy where
  unquote `(IT8) = pure IT8
  unquote `(IT16) = pure IT16
  unquote `(IT32) = pure IT32
  unquote `(IT64) = pure IT64
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a" , NamePart `{NativeTy}]

implementation Unquotable Raw NativeTy where
  unquote `(IT8) = pure IT8
  unquote `(IT16) = pure IT16
  unquote `(IT32) = pure IT32
  unquote `(IT64) = pure IT64
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a" , NamePart `{NativeTy}]

implementation Unquotable TT IntTy where
  unquote `(ITFixed ~nt) = ITFixed <$> unquote nt
  unquote `(ITNative) = pure ITNative
  unquote `(ITBig) = pure ITBig
  unquote `(ITChar) = pure ITChar
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                 , TextPart "as an" , NamePart `{IntTy}]

implementation Unquotable Raw IntTy where
  unquote `(ITFixed ~nt) = ITFixed <$> unquote nt
  unquote `(ITNative) = pure ITNative
  unquote `(ITBig) = pure ITBig
  unquote `(ITChar) = pure ITChar
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                 , TextPart "as an" , NamePart `{IntTy}]

implementation Unquotable TT ArithTy where
  unquote `(ATInt ~it) = ATInt <$> unquote it
  unquote `(ATDouble) = pure ATDouble
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as an" , NamePart `{ArithTy}]

implementation Unquotable Raw ArithTy where
  unquote `(ATInt ~it) = ATInt <$> unquote it
  unquote `(ATDouble) = pure ATDouble
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as an" , NamePart `{ArithTy}]

implementation Unquotable TT Integer where
  unquote (TConst (BI i)) = pure i
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as an" , NamePart `{{Integer}}]

implementation Unquotable Raw Integer where
  unquote (RConstant (BI i)) = pure i
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as an" , NamePart `{{Integer}}]

implementation Unquotable TT Int where
  unquote (TConst (I i)) = pure i
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as an" , NamePart `{{Int}}]

implementation Unquotable Raw Int where
  unquote (RConstant (I i)) = pure i
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as an" , NamePart `{{Int}}]

implementation Unquotable TT a => Unquotable TT (List a) where
  unquote `(Prelude.List.Nil {elem=~a}) = pure []
  unquote `(Prelude.List.(::) {elem=~a} ~x ~xs) =
    (::) <$> unquote x <*> unquote xs
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a" , NamePart `{List}]

implementation Unquotable Raw a => Unquotable Raw (List a) where
  unquote `(Prelude.List.Nil {elem=~a}) = pure []
  unquote `(Prelude.List.(::) {elem=~a} ~x ~xs) =
    (::) <$> unquote x <*> unquote xs
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a" , NamePart `{List}]

implementation (Unquotable TT a, Unquotable TT b) => Unquotable TT (a, b) where
  unquote `(MkPair {A=~a} {B=~b} ~x ~y) = MkPair <$> unquote x <*> unquote y
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a", NamePart `{Pair}]

implementation (Unquotable Raw a, Unquotable Raw b) => Unquotable Raw (a, b) where
  unquote `(MkPair {A=~a} {B=~b} ~x ~y) = MkPair <$> unquote x <*> unquote y
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a", NamePart `{Pair}]

implementation Unquotable TT a => Unquotable TT (Maybe a) where
  unquote `(Just {a=~a} ~x) = Just <$> unquote x
  unquote `(Nothing {a=~a}) = pure Nothing
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a", NamePart `{Maybe}]

implementation Unquotable Raw a => Unquotable Raw (Maybe a) where
  unquote `(Just {a=~a} ~x) = Just <$> unquote x
  unquote `(Nothing {a=~a}) = pure Nothing
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a", NamePart `{Maybe}]

implementation (Unquotable TT a, Unquotable TT b) => Unquotable TT (Either a b) where
  unquote `(Left {a=~a} {b=~b} ~x) = Left <$> unquote x
  unquote `(Right {a=~a} {b=~b} ~x) = Right <$> unquote x
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as an", NamePart `{Either}]

implementation (Unquotable Raw a, Unquotable Raw b) => Unquotable Raw (Either a b) where
  unquote `(Left {a=~a} {b=~b} ~x) = Left <$> unquote x
  unquote `(Right {a=~a} {b=~b} ~x) = Right <$> unquote x
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as an", NamePart `{Either}]

implementation Unquotable TT Unit where
  unquote `(MkUnit) = pure MkUnit
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as an", NamePart `{Unit}]

implementation Unquotable Raw Unit where
  unquote `(MkUnit) = pure MkUnit
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as an", NamePart `{Unit}]

implementation Unquotable TT Void where
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as an", NamePart `{Void}]

implementation Unquotable Raw Void where
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as an", NamePart `{Void}]

implementation Unquotable TT SourceLocation where
  unquote `(FileLoc ~fn ~start ~end) =
    FileLoc <$> unquote fn <*> unquote start <*> unquote end
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a", NamePart `{SourceLocation}]

implementation Unquotable Raw SourceLocation where
  unquote `(FileLoc ~fn ~start ~end) =
    FileLoc <$> unquote fn <*> unquote start <*> unquote end
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a", NamePart `{SourceLocation}]

mutual
  implementation Unquotable TT SpecialName where
    unquote `(WhereN ~i ~n1 ~n2) = WhereN <$> unquote i <*> unquote n1 <*> unquote n2
    unquote `(WithN ~i ~n) = WithN <$> unquote i <*> unquote n
    unquote `(ImplementationN ~n ~xs) = ImplementationN <$> unquote n <*> unquote xs
    unquote `(ParentN ~n ~s) = ParentN <$> unquote n <*> unquote s
    unquote `(MethodN ~s) = MethodN <$> unquote s
    unquote `(CaseN ~loc ~n) = CaseN <$> unquote loc <*> unquote n
    unquote `(ImplementationCtorN ~n) = ImplementationCtorN <$> unquote n
    unquote `(MetaN ~n1 ~n2) = MetaN <$> unquote n1 <*> unquote n2
    unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a", NamePart `{SpecialName}]

  implementation Unquotable TT TTName where
    unquote `(UN ~x) = UN <$> unquote x
    unquote `(NS ~n ~xs) = NS <$> unquote n <*> unquote xs
    unquote `(MN ~i ~s) = MN <$> unquote i <*> unquote s
    unquote `(SN ~sn) = SN <$> unquote sn
    unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a", NamePart `{TTName}]

mutual
  implementation Unquotable Raw SpecialName where
    unquote `(WhereN ~i ~n1 ~n2) = WhereN <$> unquote i <*> unquote n1 <*> unquote n2
    unquote `(WithN ~i ~n) = WithN <$> unquote i <*> unquote n
    unquote `(ImplementationN ~n ~xs) = ImplementationN <$> unquote n <*> unquote xs
    unquote `(ParentN ~n ~s) = ParentN <$> unquote n <*> unquote s
    unquote `(MethodN ~s) = MethodN <$> unquote s
    unquote `(CaseN ~loc ~n) = CaseN <$> unquote loc <*> unquote n
    unquote `(ImplementationCtorN ~n) = ImplementationCtorN <$> unquote n
    unquote `(MetaN ~n1 ~n2) = MetaN <$> unquote n1 <*> unquote n2
    unquote t = fail [ TextPart "Failed to unquote", RawPart t
                     , TextPart "as a", NamePart `{SpecialName}]

  implementation Unquotable Raw TTName where
    unquote `(UN ~x) = UN <$> unquote x
    unquote `(NS ~n ~xs) = NS <$> unquote n <*> unquote xs
    unquote `(MN ~i ~s) = MN <$> unquote i <*> unquote s
    unquote `(SN ~sn) = SN <$> unquote sn
    unquote t = fail [ TextPart "Failed to unquote", RawPart t
                     , TextPart "as a", NamePart `{TTName}]

implementation Unquotable TT NameType where
  unquote `(Bound) = pure Bound
  unquote `(Ref) = pure Ref
  unquote `(DCon ~i1 ~i2) = DCon <$> unquote i1 <*> unquote i2
  unquote `(TCon ~i1 ~i2) = TCon <$> unquote i1 <*> unquote i2
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a", NamePart `{NameType}]

implementation Unquotable Raw NameType where
  unquote `(Bound) = pure Bound
  unquote `(Ref) = pure Ref
  unquote `(DCon ~i1 ~i2) = DCon <$> unquote i1 <*> unquote i2
  unquote `(TCon ~i1 ~i2) = TCon <$> unquote i1 <*> unquote i2
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a", NamePart `{NameType}]

implementation Unquotable TT a => Unquotable TT (Binder a) where
  unquote `(Lam {a=~a} ~ty) = Lam <$> unquote ty
  unquote `(Pi {a=~a} ~ty ~kind) = Pi <$> unquote ty <*> unquote kind
  unquote `(Let {a=~a} ~ty ~val) = Let <$> unquote ty <*> unquote val
  unquote `(Hole {a=~a} ~ty) = Hole <$> unquote ty
  unquote `(GHole {a=~a} ~ty) = GHole <$> unquote ty
  unquote `(Guess {a=~a} ~ty ~val) = Guess <$> unquote ty <*> unquote val
  unquote `(PVar {a=~a} ~ty) = PVar <$> unquote ty
  unquote `(PVTy {a=~a} ~ty) = PVTy <$> unquote ty
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a", NamePart `{Binder}]

implementation Unquotable Raw a => Unquotable Raw (Binder a) where
  unquote `(Lam {a=~a} ~ty) = Lam <$> unquote ty
  unquote `(Pi {a=~a} ~ty ~kind) = Pi <$> unquote ty <*> unquote kind
  unquote `(Let {a=~a} ~ty ~val) = Let <$> unquote ty <*> unquote val
  unquote `(Hole {a=~a} ~ty) = Hole <$> unquote ty
  unquote `(GHole {a=~a} ~ty) = GHole <$> unquote ty
  unquote `(Guess {a=~a} ~ty ~val) = Guess <$> unquote ty <*> unquote val
  unquote `(PVar {a=~a} ~ty) = PVar <$> unquote ty
  unquote `(PVTy {a=~a} ~ty) = PVTy <$> unquote ty
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a", NamePart `{Binder}]

implementation Unquotable TT Const where
  unquote `(I ~i) = I <$> unquote i
  unquote `(BI ~i) = BI <$> unquote i
  unquote `(Ch ~i) = Ch <$> unquote i
  unquote `(Str ~i) = Str <$> unquote i
  unquote `(B8 ~b) = B8 <$> unquote b
  unquote `(B16 ~b) = B16 <$> unquote b
  unquote `(B32 ~b) = B32 <$> unquote b
  unquote `(B64 ~b) = B64 <$> unquote b
  unquote `(AType ~a) = AType <$> unquote a
  unquote `(StrType) = pure StrType
  unquote `(VoidType) = pure VoidType
  unquote `(Forgot) = pure Forgot
  unquote `(WorldType) = pure WorldType
  unquote `(TheWorld) = pure TheWorld
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a", NamePart `{Const}]

implementation Unquotable Raw Const where
  unquote `(I ~i) = I <$> unquote i
  unquote `(BI ~i) = BI <$> unquote i
  unquote `(Ch ~i) = Ch <$> unquote i
  unquote `(Str ~i) = Str <$> unquote i
  unquote `(B8 ~b) = B8 <$> unquote b
  unquote `(B16 ~b) = B16 <$> unquote b
  unquote `(B32 ~b) = B32 <$> unquote b
  unquote `(B64 ~b) = B64 <$> unquote b
  unquote `(AType ~a) = AType <$> unquote a
  unquote `(StrType) = pure StrType
  unquote `(VoidType) = pure VoidType
  unquote `(Forgot) = pure Forgot
  unquote `(WorldType) = pure WorldType
  unquote `(TheWorld) = pure TheWorld
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a", NamePart `{Const}]

implementation Unquotable TT TTUExp where
  unquote `(UVar ~s ~i) = UVar <$> unquote s <*> unquote i
  unquote `(UVal ~i) = UVal <$> unquote i
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a", NamePart `{TTUExp}]

implementation Unquotable Raw TTUExp where
  unquote `(UVar ~s ~i) = UVar <$> unquote s <*> unquote i
  unquote `(UVal ~i) = UVal <$> unquote i
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a", NamePart `{TTUExp}]

||| Does not work for `NullType` and `UniqueType`.
implementation Unquotable TT Universe where
  unquote `(AllTypes) = pure AllTypes
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a", NamePart `{Universe}]

||| Does not work for `NullType` and `UniqueType`.
implementation Unquotable Raw Universe where
  unquote `(AllTypes) = pure AllTypes
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a", NamePart `{Universe}]

implementation Unquotable TT TT where
  unquote `(P ~nt ~n ~t) = P <$> unquote nt <*> unquote n <*> unquote t
  unquote `(V ~i) = V <$> unquote i
  unquote `(Bind ~n ~b ~t) = Bind <$> unquote n <*> unquote b <*> unquote t
  unquote `(App ~t1 ~t2) = App <$> unquote t1 <*> unquote t2
  unquote `(TConst ~c) = TConst <$> unquote c
  unquote `(Erased : TT) = pure Erased
  unquote `(TType ~u) = TType <$> unquote u
  unquote `(UType ~u) = UType <$> unquote u
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a", NamePart `{TT}]

implementation Unquotable Raw TT where
  unquote `(P ~nt ~n ~t) = P <$> unquote nt <*> unquote n <*> unquote t
  unquote `(V ~i) = V <$> unquote i
  unquote `(Bind ~n ~b ~t) = Bind <$> unquote n <*> unquote b <*> unquote t
  unquote `(App ~t1 ~t2) = App <$> unquote t1 <*> unquote t2
  unquote `(TConst ~c) = TConst <$> unquote c
  unquote `(Erased : TT) = pure Erased
  unquote `(TType ~u) = TType <$> unquote u
  unquote `(UType ~u) = UType <$> unquote u
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a", NamePart `{TT}]

implementation Unquotable TT Raw where
  unquote `(Var ~n) = Var <$> unquote n
  unquote `(RBind ~n ~b ~t) = RBind <$> unquote n <*> unquote b <*> unquote t
  unquote `(RApp ~t1 ~t2) = RApp <$> unquote t1 <*> unquote t2
  unquote `(RType) = pure RType
  unquote `(RUType ~u) = RUType <$> unquote u
  unquote `(RConstant ~c) = RConstant <$> unquote c
  unquote t = fail [ TextPart "Failed to unquote", TermPart t
                   , TextPart "as a", NamePart `{Language.Reflection.Raw}]

implementation Unquotable Raw Raw where
  unquote `(Var ~n) = Var <$> unquote n
  unquote `(RBind ~n ~b ~t) = RBind <$> unquote n <*> unquote b <*> unquote t
  unquote `(RApp ~t1 ~t2) = RApp <$> unquote t1 <*> unquote t2
  unquote `(RType) = pure RType
  unquote `(RUType ~u) = RUType <$> unquote u
  unquote `(RConstant ~c) = RConstant <$> unquote c
  unquote t = fail [ TextPart "Failed to unquote", RawPart t
                   , TextPart "as a", NamePart `{Language.Reflection.Raw}]
