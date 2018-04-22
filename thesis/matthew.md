# Matthew's notes

Relevant (unordered) notions, facts, observations, events, comments to include
in the Introduction - a very brief history of how your project's opportunity
and potential arose

## Program Logics and Development Methodology

* Formalization tools for programming languages have been steadily maturing for
decades, and in particular, functional programming languages have become
steadily more formalized, enabling more and more intrinsic program verification
* Formalization tools include static types, functional orientation, etc.
* Type-driven development (TDD) is a programming methodology, in which users
write program specifications (properties) in a formalized type theory language,
      and mechanized proof search/synthesis is used to discover (derive)
  program implementations that provably conform to the specification
* “Double specification” is a design smell of many program
analysis/verification tools, wherein program specs and implementations are
written to be consumed by multiple tools with distinct program logics..
encompassing techniques such as writing tests, devising model-checking
programs, or writing extrinsic proofs about programs written in languages whose
semantics or implementations have not been fully formalized and verified (every
    language).  It is called “double specification” because one is effectively
writing two versions of the program/specification in distinct program logics,
        consumed by tools whose logic correspondence is only assumed (let alone
            verified).
* Someday, double specification won’t be a problem in languages where program
specifications (properties) and implementations (executables) are written in
the same language (for instance, type theory), AND where their implementations
have been verified (to some degree of certainty of correspondence of
    computation and resource consumption models).

## User Interface and Feedback/Mechanization Techniques

* IDEs enable rapid feedback and interaction cycles between the user and the
formalization (checking) tools of the language and computation environment.
* IDEs and highly interactive editors have enabled rapid feedback cycles when
using all sorts of programming languages, but since highly formalized (proving)
  languages have the longest feedback cycles and most comprehensive scopes of
  analysis, they have the biggest opportunity for improvement in programmer
  effectiveness and productivity.
