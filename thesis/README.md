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

* Try sneaking in mutual recursion to the elaborator proofs

* You might wanna define a new type for possible outputs from the Elab action
  * Current `FunDefn` is too messy
  * Or a library to deal with the messiness

* Line numbers do exist in the whole parsed file, you can look up whatever you
  need from the whole file afterwards, line numbers suffice as an argument.
   * Use `SourceLocation`

* How do you check preferred names for variables in Elab?
