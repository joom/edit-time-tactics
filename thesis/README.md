Library-defined derived actions / edit-time tactics (from Hazelnut slides)

# To do list

* Finish the red-black tree example
* Mention scriptable IDEs, maybe Visual Studio has some macro system that does a similar thing
* For programmable IDEs, look at Cyrus Omar's dissertation and look for other people
* Mention LCF style provers and contrast that with the current IDE mode
  * Any videos online that show how the interactive thing works?
* Look at Isar, human readable tactic language for Isabelle
* Look at Pombrio & Krishnamurthi's work on resugaring: blackboxes

* Have a plan for the minimal viable implementation

* Look at Racket literature for macro system and how that interacts with module
  * modules export and import things for syntax
  * macro expansion happens prior to running programs

* Try sneaking in mutual recursion to the elaborator proofs (done, it works, nothing interesting here)

* Line numbers do exist in the whole parsed file, you can look up whatever you
  need from the whole file afterwards, line numbers suffice as an argument.
   * Use `SourceLocation`?

* How do you check preferred names for variables in Elab?
  * Currently there is no way to do this, but it's trivial to write
    a primitive tactic to do that.

* Is ALF really the first with typed holes? Ask Twitter and other people.
  * "One of the earliest" might be a way to get around that.
* Look at De Bruijn and Automath in the 60s.

* Explain that one of the challenges of this is to delaborate the code

* TODO as of early March:
  - local variables
  - higher order prims (done)
  - delaboration of implicits
  - check for %editor (done)

* using transport(subst) in Agda, it cannot infer F, so write a tactic that does that for you
  * this is only an issue if you use homogeneous equality, but Idris generally uses heterogeneous

* Add Prim__TryCatch, inspired by tryCatch to Idris. (done)

* TODO as of mid March:
  * add {from,to}Editor instances for TyDecl, DataDefn, FunDefn, FunClause
  * figure out implicit arguments in pretty printing. printdef somehow does this properly

* Leif Andersen from Northeastern works on a generalized version of what I'm doing:
  Her work allows users to define their own editors, with 4 elements: state, serialization/deserialization, elaboration, UI
  In my work, the UI is Emacs commands, serialization/deserialization is my contribution,
  and elaboration and (proof)state are provided by elaborator reflection.
  There's currently no paper but there will be a Github repo and blog post in time for my thesis.

* David: fromEditor and toEditor should be in Elab, because:
  * they might want to check if there's an implementation for some interface
  * they might want to limit Editorableness to

* do case-splitting as a more compelling example than the theorem prover

* Questions to ask David:
  * Namespace resolution. (solved)
    If I pass Z it can't resolve, but it can resolve Prelude.Nat.Z
  * How should I handle local contexts? (solved)
    Elaborating an expression that has some local variables fails because I don't have a way to get them from the context.
  * How does printdef handle implicit variables? (solved)

* Add to IState a new field, that is an interval map (implemented with FingerTree),
  where the keys will be an interval of source positions, and values will be
  a pair of local context and goal type. (done)
  * This solves the local context problem we have in fromEditor. (done)
  * We have to record every type to this interval map during elaboration. (done)
  * We can add a REPL command that gets a sourceposition and returns info. (trying)

## Ed Morehouse's questions:

* S-expressions seem pretty limiting.  What might be a better encoding for
abstract syntax in the communications protocol between an editor and a
compiler?
* What are the prospects for building editor interactions into a compiler from
the start?  Is it feasible to implement delaboration in such a way that the
compiler could respond directly with surface-syntax terms that fit in the
current binding context?
* What other low-hanging fruit can you implement with this tool?  For example,
  could you uniformly rename a binder within a file? Lift a hole to a lemma?
  Prune unused arguments to a function? etc.

## David Christiansen's questions:

* How is the performance?
* What if the editor buffer is modified since last type-check?
* Is anything in the way of ripping out the Haskell editing interface and doing it all in Idris?
* How could the design of elaborator reflection better support edit-time tactics?

Inline questions:
* How much of the proof term size is due to calling normalize?
  * JK: I'd say not much, since the proof term size is mostly about how the
  tactic is designed. Coq's omega returns a huge proof term because of the
  order in which it tries different cases.
* Lean has a similar system

Other benefits:
* Library and DSL authors can provide domain-specific editor tactics
* Users gain control and customization
* More people can extend Idris. Contributing to the standard library is much easier than to the compiler.
