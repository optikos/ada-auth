@Part(07, Root="ada.mss")

@SetPageHeadings{$Date: 2000/04/20 02:42:02 $}
@LabeledSection{Packages}

@Comment{$Source: e:\\cvsroot/ARM/Source/07.mss,v $}
@Comment{$Revision: 1.6 $}

@begin{Intro}
@redundant[
@ToGlossaryAlso{Term=<Package>,
  Text=<Packages are program units that allow the specification of groups of
  logically related entities.
  Typically, a package contains the declaration of a type
  (often a private type or private extension) along with
  the declarations of primitive subprograms of the type,
  which can be called from outside the package,
  while their inner workings remain hidden from outside users.>}
@IndexSee{Term=[information hiding],See=(package)}
@IndexSee{Term=[encapsulation],See=(package)}
@IndexSee{Term=[module],See=(package)}
@IndexSeeAlso{Term=[class],See=(package)}
]
@end{Intro}

@LabeledClause{Package Specifications and Declarations}

@begin{Intro}
@redundant[
A package is generally provided in two parts: a
@nt{package_specification} and a @nt{package_body}.
Every package has a @nt{package_specification}, but not all packages
have a @nt{package_body}.
]
@end{Intro}

@begin{Syntax}
@Syn{lhs=<package_declaration>,rhs="@Syn2{package_specification};"}
@Hinge{}

@Syn{lhs=<package_specification>,rhs="
    @key{package} @Syn2{defining_program_unit_name} @key{is}
      {@Syn2{basic_declarative_item}}
   [@key{private}
      {@Syn2{basic_declarative_item}}]
    @key{end} [[@Syn2{parent_unit_name}.]@Syn2{identifier}]"}

@begin{SyntaxText}
If an @nt{identifier} or @nt{parent_unit_name}.@nt{identifier}
appears at the end of a @nt{package_specification},
then this sequence of lexical elements shall repeat the
@nt{defining_program_unit_name}.
@end{SyntaxText}
@end{Syntax}

@begin{Legality}
@PDefn2{Term=[requires a completion], Sec=(@nt{package_declaration})}
@PDefn2{Term=[requires a completion], Sec=(@nt{generic_package_declaration})}
A @nt{package_declaration} or @nt{generic_package_declaration}
requires a completion @Redundant[(a body)]
if it contains any @nt<declarative_item> that requires a completion,
but whose completion is not in its @nt{package_specification}.
@begin(Honest)
  If an implementation supports it, a @nt{pragma} Import may substitute
  for the body of a package or generic package.
@end(Honest)
@end{Legality}

@begin{StaticSem}
@PDefn2{Term=[visible part], Sec=<of a package
(other than a generic formal package)>}
The first list of @nt{declarative_item}s of a
@nt{package_specification} of a package other than a generic formal package
is called the @i{visible part} of the package.
@Redundant[@PDefn2{Term=[private part], Sec=(of a package)}
The optional list of @nt{declarative_item}s after the reserved word
@key{private} (of any @nt{package_specification}) is called the
@i{private part} of the package.
If the reserved
word @key{private} does not appear, the package has an implicit empty
private part.]
@begin{Ramification}
This definition of visible part does not apply to generic formal
packages @em @RefSecNum{Formal Packages} defines
the visible part of a generic formal package.

The implicit empty private part is important because certain
implicit declarations occur there if the package is a child package,
and it defines types in its visible part that are derived from,
or contain as components, private types declared within the
parent package.  These implicit declarations are visible
in children of the child package.
See @RefSecNum(Compilation Units - Library Units).
@end{Ramification}

@redundant[
An entity declared in the private part of a package is visible
only within the declarative region of the package itself
(including any child units @em
see @RefSecNum{Compilation Units - Library Units}).
In contrast, expanded names denoting
entities declared in the visible part can be used even outside the
package; furthermore, direct visibility of such entities can be
achieved by means of @nt{use_clause}s
(see @RefSecNum{Selected Components} and @RefSecNum{Use Clauses}).
]
@end{StaticSem}

@begin{RunTime}
@PDefn2{Term=[elaboration], Sec=(package_declaration)}
The elaboration of a @nt{package_declaration} consists of the elaboration of
its @nt{basic_declarative_item}s in the given order.
@end{RunTime}

@begin{NotesNotes}
The visible part of a package contains all the information that
another program unit is able to know about the package.

If a declaration occurs immediately within the specification
of a package, and the declaration has a corresponding completion that
is a body,
then that body has to occur immediately within the body of
the package.
@begin{TheProof}
This follows from the fact that the declaration and completion are
required to occur
immediately within the same declarative region,
and the fact that @nt{bodies} are disallowed (by the @SyntaxName@;s)
in @nt{package_specification}s.
This does not apply to instances of generic units,
whose bodies can occur in @nt{package_specification}s.
@end{TheProof}
@end{NotesNotes}

@begin{Examples}
@i{Example of a package declaration:}
@begin{Example}
@key[package] Rational_Numbers @key[is]

   @key[type] Rational @key[is]
      @key[record]
         Numerator   : Integer;
         Denominator : Positive;
      @key[end] @key[record];

   @key[function] "="(X,Y : Rational) @key[return] Boolean;

   @key[function] "/"  (X,Y : Integer)  @key[return] Rational;  --@i{  to construct a rational number}

   @key[function] "+"  (X,Y : Rational) @key[return] Rational;
   @key[function] "-"  (X,Y : Rational) @key[return] Rational;
   @key[function] "*"  (X,Y : Rational) @key[return] Rational;
   @key[function] "/"  (X,Y : Rational) @key[return] Rational;
@key[end] Rational_Numbers;
@end{Example}

There are also many examples of package declarations in the predefined
language environment
(see @RefSecNum{Predefined Language Environment}).
@end{Examples}

@begin{Incompatible83}
In Ada 83, a library package is allowed to have a body even if
it doesn't need one.
In Ada 9X, a library package body is either
required or forbidden @em never optional.
The workaround is to add @key[pragma] Elaborate_Body,
or something else requiring a body,
to each library package that has a body that isn't otherwise
required.
@end{Incompatible83}

@begin{DiffWord83}
We have moved the syntax into this clause and the next clause from
RM83-7.1, ``Package Structure'', which we have removed.

RM83 was unclear on the rules about when a package requires a body.
For example, RM83-7.1(4) and RM83-7.1(8) clearly forgot about the
case of an incomplete type declared in a @nt{package_declaration} but
completed in the body.
In addition,
RM83 forgot to make this rule apply to a generic package.
We have corrected these rules.
Finally, since we now allow a @nt{pragma} Import for any explicit
declaration, the completion rules need to take this into account as
well.
@end{DiffWord83}

@LabeledClause{Package Bodies}

@begin{Intro}
@redundant[
In contrast to the entities declared in the visible part of a
package, the entities declared in the @nt{package_body} are
visible only
within the @nt{package_body} itself.
As a consequence, a
package with a @nt{package_body} can be used for the construction of
a group of related subprograms in
which the logical operations available to clients are clearly
isolated from the internal entities.
]
@end{Intro}

@begin{Syntax}
@Syn{lhs=<package_body>,rhs="
    @key{package} @key{body} @Syn2{defining_program_unit_name} @key{is}
       @Syn2{declarative_part}
   [@key{begin}
        @Syn2{handled_sequence_of_statements}]
    @key{end} [[@Syn2{parent_unit_name}.]@Syn2{identifier}];"}

@begin{SyntaxText}
If an @nt{identifier} or @nt{parent_unit_name}.@nt{identifier}
appears at the end of a @nt{package_body},
then this sequence of lexical elements shall repeat the
@nt{defining_program_unit_name}.
@end{SyntaxText}
@end{Syntax}

@begin{Legality}
A @nt{package_body} shall be the completion of a previous
@nt{package_declaration} or @nt{generic_package_declaration}.
A library @nt{package_declaration} or
library @nt{generic_package_declaration}
shall not have a body
unless it requires a body@Redundant[;
@key<pragma> Elaborate_Body can be used to require
a @nt<library_unit_declaration> to have a body
(see @RefSecNum{Elaboration Control})
if it would not otherwise require one].
@begin{Ramification}
The first part of the rule forbids a @nt{package_body} from
standing alone @em it has to belong to some previous
@nt{package_declaration} or @nt{generic_package_declaration}.

A nonlibrary @nt{package_declaration} or
nonlibrary @nt<generic_package_declaration>
that does not require a completion may
have a corresponding body anyway.
@end{Ramification}
@end{Legality}

@begin{StaticSem}
In any @nt{package_body} without @nt{statement}s
there is an implicit @nt{null_statement}.
For any @nt{package_declaration} without an explicit completion,
there is an implicit @nt{package_body} containing a single
@nt{null_statement}.
For a noninstance, nonlibrary package,
this body occurs at the end of the
@nt{declarative_part} of the innermost enclosing program unit or
@nt{block_statement};
if there are several such packages,
the order of the implicit @nt{package_bodies} is unspecified.
@PDefn{unspecified}
@Redundant[(For an instance, the implicit @nt{package_body}
occurs at the place of the instantiation
(see @RefSecNum{Generic Instantiation}).
For a library package, the place is partially determined by the
elaboration dependences (see Section 10).)]
@begin{Discussion}
Thus, for example, we can refer to something happening just
after the @key{begin} of a @nt{package_body},
and we can refer to the @nt{handled_sequence_of_statements}
of a @nt{package_body},
without worrying about all the optional pieces.
The place of the implicit body makes a difference for tasks
activated by the package.
See also RM83-9.3(5).

The implicit body would be illegal if explicit in the case of a library
package that does not require (and therefore does not allow)
a body.
This is a bit strange, but not harmful.
@end{Discussion}
@end{StaticSem}

@begin{RunTime}
@PDefn2{Term=[elaboration], Sec=(nongeneric package_body)}
For the elaboration of a nongeneric @nt{package_body},
its @nt{declarative_part} is first
elaborated, and its @nt{handled_sequence_of_statements} is then executed.
@end{RunTime}

@begin{NotesNotes}
A variable declared in the body of a package is only visible
within this body and, consequently, its value can only be
changed within the @nt{package_body}.  In the absence of local tasks,
the value of such a variable remains unchanged between calls issued
from outside the package to subprograms declared in the visible part.
The properties of such a variable are similar to those of a ``static''
variable of C.

The elaboration of the body of a subprogram explicitly declared
in the visible part of a package is caused by the elaboration of the
body of the package.  Hence a call of such a subprogram by an
outside program unit raises the exception Program_Error if the call
takes place before the elaboration of the
@nt{package_body} (see @RefSecNum{Declarative Parts}).
@end{NotesNotes}

@begin{Examples}
@i{Example of a package body
(see @RefSecNum{Package Specifications and Declarations}):}
@begin{Example}
@key[package] @key[body] Rational_Numbers @key[is]

   @key[procedure] Same_Denominator (X,Y : @key[in] @key[out] Rational) @key[is]
   @key[begin]
      --@i{  reduces X and Y to the same denominator:}
      ...
   @key[end] Same_Denominator;

   @key[function] "="(X,Y : Rational) @key[return] Boolean @key[is]
      U : Rational := X;
      V : Rational := Y;
   @key[begin]
      Same_Denominator (U,V);
      @key[return] U.Numerator = V.Numerator;
   @key[end] "=";

   @key[function] "/" (X,Y : Integer) @key[return] Rational @key[is]
   @key[begin]
      @key[if] Y > 0 @key[then]
         @key[return] (Numerator => X,  Denominator => Y);
      @key[else]
         @key[return] (Numerator => -X, Denominator => -Y);
      @key[end] @key[if];
   @key[end] "/";

   @key[function] "+" (X,Y : Rational) @key[return] Rational @key[is] ...  @key[end] "+";
   @key[function] "-" (X,Y : Rational) @key[return] Rational @key[is] ...  @key[end] "-";
   @key[function] "*" (X,Y : Rational) @key[return] Rational @key[is] ...  @key[end] "*";
   @key[function] "/" (X,Y : Rational) @key[return] Rational @key[is] ...  @key[end] "/";

@key[end] Rational_Numbers;
@end{Example}
@end{Examples}

@begin{DiffWord83}
The syntax rule for @nt{package_body} now uses the syntactic category
@nt{handled_sequence_of_statements}.

The @nt{declarative_part} of a @nt{package_body} is now required;
that doesn't make any real difference,
since a @nt{declarative_part} can be empty.

RM83 seems to have forgotten to say that a @nt{package_body} can't
stand alone, without a previous declaration.
We state that rule here.

RM83 forgot to restrict the definition of elaboration of
@nt{package_bodies} to nongeneric ones.
We have corrected that omission.

The rule about implicit bodies (from RM83-9.3(5))
is moved here, since it is more generally applicable.
@end{DiffWord83}

@LabeledClause{Private Types and Private Extensions}

@begin{Intro}
@redundant[
The declaration (in the visible part of a
package) of a type as a private type or private extension
serves to separate the characteristics that can be used
directly by outside program units (that is, the logical properties)
from other characteristics whose direct use is confined to the
package (the details of the definition of the type itself).
See @RefSecNum(Type Extensions) for an overview of type extensions.
@Defn{private types and private extensions}
@IndexSee{Term=[information hiding],See=(private types and private extensions)}
@IndexSee{Term=[opaque type],See=(private types and private extensions)}
@IndexSee{Term=[abstract data type (ADT)],See=(private types and private extensions)}
@IndexSee{Term=[ADT (abstract data type)],See=(private types and private extensions)}
]
@end{Intro}

@begin{MetaRules}
A private (untagged) type can be thought of as a record type
with the type of its single (hidden) component being the full view.

A private tagged type can be thought of as a private extension
of an anonymous parent with no components.  The only
dispatching operation of the parent is equality
(although the Size attribute, and, if nonlimited, assignment are allowed,
and those will presumably be implemented in terms of dispatching).
@end{MetaRules}

@begin{Syntax}
@Syn{lhs=<private_type_declaration>,rhs="
   @key{type} @Syn2{defining_identifier} [@Syn2{discriminant_part}] @key{is} [[@key{abstract}] @key{tagged}] [@key{limited}] @key{private};"}

@Syn{lhs=<private_extension_declaration>,rhs="
   @key{type} @Syn2{defining_identifier} [@Syn2{discriminant_part}] @key{is}
     [@key{abstract}] @key{new} @SynI(ancestor_)@Syn2{subtype_indication} @key{with private};"}
@end{Syntax}

@begin{Legality}
@Defn2{Term=[partial view], Sec=(of a type)}
@PDefn2{Term=[requires a completion], Sec=(declaration of a partial view)}
A @nt<private_type_declaration>
or @nt<private_extension_declaration>
declares a @i{partial view} of the type;
such a declaration is allowed only as a
@nt{declarative_item} of the visible part of a package,
and it requires a completion,
which shall be a @nt{full_type_declaration} that occurs as
a @nt{declarative_item} of the private part of the package.
@Defn2{Term=[full view], Sec=(of a type)}
The view of the type declared by the @nt<full_type_declaration>
is called the @i(full view).
A generic formal private type or a
generic formal private extension is also a partial view.
@begin(Honest)
  A private type can also be completed by a @nt{pragma}
  Import, if supported by an implementation.
@end(Honest)
@begin{Reason}
  We originally used the term ``private view,'' but this was easily
  confused with the view provided @i(from) the private part, namely the
  full view.
@end{Reason}


@Redundant[A type shall be completely defined before it is frozen
(see @RefSecNum{Completions of Declarations} and
@RefSecNum{Freezing Rules}).
Thus, neither the declaration
of a variable of a partial view of a type, nor the creation by an
@nt{allocator} of an object of the partial view are allowed before
the full declaration of the type.
Similarly, before the full declaration, the name of the partial view
cannot be used in a @nt{generic_instantiation} or in a
representation item.]
@begin{TheProof}
  This rule is stated officially in
  @RefSec{Completions of Declarations}.
@end{TheProof}



@Redundant[A private type is limited if its declaration includes
the reserved word @key[limited];
a private extension is limited if its ancestor type is limited.]
If the partial view is nonlimited, then
the full view shall be nonlimited.

If a tagged partial view is limited,
then the full view shall be limited.
@Redundant[On the other hand,
if an untagged partial view is limited,
the full view may be limited or nonlimited.]

If the partial view is tagged,
then the full view shall be tagged.
@Redundant[On the other hand, if the partial view is untagged,
then the full view may be tagged or untagged.]
In the case where the partial view is untagged and the full view is
tagged,
no derivatives of the partial view are allowed within the immediate
scope of the partial view;
@Redundant[derivatives of the full view are allowed.]
@begin{Ramification}
Note that deriving from a partial view within its immediate scope
can only occur in a package that is a child of the one where the partial
view is declared.
The rule implies that in the visible part of a public child package,
it is impossible to derive from an untagged private type declared in the
visible part of the parent package in the case where the full
view of the parent type turns out to be tagged.
We considered a model in which the derived type was implicitly
redeclared at the earliest place within its immediate scope where
characteristics needed to be added.
However, we rejected that model, because (1) it would imply that (for an
untagged type) subprograms explicitly declared after the derived type
could be inherited, and (2) to make this model work for composite types
as well, several implicit redeclarations would be
needed, since new characteristics can become visible one by one;
that seemed like too much mechanism.
@end{Ramification}
@begin{Discussion}
  The rule for tagged partial views
  is redundant for partial views that are private extensions,
  since all extensions of a given ancestor tagged type are tagged,
  and limited if the ancestor is limited.
  We phrase this rule partially redundantly to keep its structure parallel
  with the other rules.
@end{Discussion}
@begin{Honest}
  This rule is checked in a generic unit,
  rather than using the ``assume the best'' or ``assume the worst''
  method.
@end{Honest}
@begin{Reason}
  Tagged limited private types have certain capabilities that are
  incompatible with having assignment for the full view of the type.
  In particular, tagged limited private types can be extended
  with access discriminants and components of a limited type,
  which works only because assignment is not allowed.
  Consider the following example:
  @begin{Example}
@key[package] P1 @key[is]
    @key[type] T1 @key[is] @key[tagged] @key[limited] @key[private];
    @key[procedure] Foo(X : @key[in] T1'Class);
@key[private]
    @key[type] T1 @key[is] @key[tagged] @key[null] @key[record]; --@i{ Illegal!}
        --@i{ This should say ``@key[tagged limited null record]''.}
@key[end] P1;

@key[package] @key[body] P1 @key[is]
    @key[type] A @key[is] @key[access] T1'Class;
    Global : A;
    @key[procedure] Foo(X : @key[in] T1'Class) @key[is]
    @key[begin]
        Global := @key[new] T1'Class'(X);
            --@i{ This would be illegal if the full view of}
            --@i{ T1 were limited, like it's supposed to be.}
    @key[end] A;
@key[end] P1;

@key[with] P1;
@key[package] P2 @key[is]
    @key[type] T2(D : @key[access] Integer) --@i{ Trouble!}
            @key[is] @key[new] P1.T1 @key[with]
        @key[record]
            My_Task : Some_Task_Type; --@i{ More trouble!}
        @key[end] @key[record];
@key[end] P2;

@key[with] P1;
@key[with] P2;
@key[procedure] Main @key[is]
    Local : @key[aliased] Integer;
    Y : P2.T2(A => Local'Access);
@key[begin]
    P1.Foo(Y);
@key[end] Main;
  @end{Example}

  If the above example were legal,
  we would have succeeded in making an access value that points
  to Main.Local after Main has been left,
  and we would also have succeeded in doing an assignment of a task
  object, both of which are supposed to be no-no's.

  This rule is not needed for private extensions,
  because they inherit their limitedness from their ancestor,
  and there is a separate rule forbidding limited components of the
  corresponding record extension if the parent is nonlimited.
@end{Reason}
@begin{Ramification}

A type derived from an untagged private type is untagged,
even if the full view of the parent is tagged,
and even at places that can see the parent:
@begin{Example}
@key[package] P @key[is]
    @key[type] Parent @key[is] @key[private];
@key[private]
    @key[type] Parent @key[is] @key[tagged]
        @key[record]
            X: Integer;
        @key[end] @key[record];
@key[end] P;

@key[package] Q @key[is]
    @key[type] T @key[is] @key[new] Parent;
@key[end] Q;

@key[with] Q; @key[use] Q;
@key[package] @key[body] P @key[is]
    ... T'Class ... --@i{ Illegal!}
    Object: T;
    ... Object.X ... --@i{ Illegal!}
    ... Parent(Object).X ... --@i{ OK.}
@key[end] P;
@end{Example}

The declaration of T declares an untagged view.
This view is always untagged, so T'Class is illegal,
it would be illegal to extend T, and so forth.
The component name X is never visible for this view,
although the component is still there @em one
can get one's hands on it via a @nt{type_conversion}.

@end{Ramification}

@Defn2{Term=[ancestor subtype], Sec=(of a @nt<private_extension_declaration>)}
The @i(ancestor subtype) of a @nt<private_extension_declaration>
is the subtype defined by the @i(ancestor_)@nt<subtype_indication>;
the ancestor type shall be a specific tagged type.
The full view of a private extension shall be derived
(directly or indirectly) from the ancestor type.
In addition to the places where @LegalityTitle normally apply
(see @RefSecNum{Generic Instantiation}),
the requirement that the ancestor be specific applies also in the
private part of an instance of a generic unit.
@begin{Reason}
  This rule allows the full view to be defined
  through several intermediate derivations,
  possibly from a series of types produced by
  @nt{generic_instantiation}s.
@end{Reason}


If the declaration of a partial view includes
a @nt{known_discriminant_part}, then
the @nt{full_type_declaration} shall have a fully conforming
@Redundant[(explicit)]
@nt{known_discriminant_part}
@Redundant[(see @RefSec(Conformance Rules))].
@Defn2{Term=[full conformance],Sec=(required)}
@Redundant[The ancestor subtype may be unconstrained;
the parent subtype of the full view is required to be constrained
(see @RefSecNum{Discriminants}).]
@begin{Discussion}
  If the ancestor subtype has discriminants,
  then it is usually best to make it unconstrained.
@end{Discussion}

@begin{Ramification}
  If the partial view has a @nt<known_discriminant_part>,
  then the full view has to be a composite, non-array type,
  since only such types may have known discriminants.
  Also, the full view cannot inherit the discriminants in this case;
  the @nt{known_discriminant_part} has to be explicit.

  That is, the following is illegal:
  @begin{Example}
@key[package] P @key[is]
    @key[type] T(D : Integer) @key[is] @key[private];
@key[private]
    @key[type] T @key[is] @key[new] Some_Other_Type; --@i{ Illegal!}
@key[end] P;
  @end{Example}

  even if Some_Other_Type has an integer discriminant called D.

  It is a ramification of this and other rules that in order for
  a tagged type to privately inherit unconstrained discriminants,
  the private type declaration has to have an
  @nt{unknown_discriminant_part}.
@end{Ramification}


If a private extension inherits known discriminants from the ancestor
subtype,
then the full view shall also inherit its discriminants from the
ancestor subtype,
and the parent subtype of the full view shall be constrained
if and only if the ancestor subtype is constrained.
@begin{Reason}
  The first part ensures that the full view has the same discriminants
  as the partial view.
  The second part ensures that if the partial view is unconstrained,
  then the full view is also unconstrained;
  otherwise, a client might constrain the partial view in a way that
  conflicts with the constraint on the full view.
@end{Reason}

@Redundant[If a partial view has unknown discriminants,
then the @nt{full_type_declaration} may define
a definite or an indefinite subtype,
with or without discriminants.]



If a partial view has neither known nor unknown discriminants,
then the @nt{full_type_declaration} shall define a definite subtype.


If the ancestor subtype of a private extension has constrained
discriminants,
then the parent subtype of the full view shall impose a statically
matching constraint on those discriminants.
@PDefn2{Term=[statically matching],Sec=(required)}
@begin{Ramification}
  If the parent type of the full view is not the ancestor type,
  but is rather some descendant thereof, the constraint on
  the discriminants of the parent type might come from
  the declaration of some intermediate type in the derivation
  chain between the ancestor type and the parent type.
@end{Ramification}
@begin{Reason}
This prevents the following:
@begin{Example}
@key[package] P @key[is]
    @key[type] T2 @key[is] @key[new] T1(Discrim => 3) @key[with] @key[private];
@key[private]
    @key[type] T2 @key[is] @key[new] T1(Discrim => 999) --@i{ Illegal!}
        @key[with] @key[record] ...;
@key[end] P;
@end{Example}

The constraints in this example do not statically match.


If the constraint on the parent subtype of the full view depends on
discriminants of the full view, then the ancestor subtype has to be
unconstrained:
@begin{Example}
@key[type] One_Discrim(A: Integer) @key[is] @key[tagged] ...;
...
@key[package] P @key[is]
    @key[type] Two_Discrims(B: Boolean; C: Integer) @key[is] @key[new] One_Discrim @key[with] @key[private];
@key[private]
    @key[type] Two_Discrims(B: Boolean; C: Integer) @key[is] @key[new] One_Discrim(A => C) @key[with]
        @key[record]
            ...
        @key[end] @key[record];
@key[end] P;
@end{Example}

The above example would be illegal if the private extension said
``is new One_Discrim(A => C);'',
because then the constraints would not statically match.
(Constraints that depend on discriminants are not static.)

@end{Reason}
@end{Legality}

@begin{StaticSem}
@PDefn{private type}
A @nt{private_type_declaration} declares a private type
and its first subtype.
@PDefn{private extension}
Similarly, a @nt{private_extension_declaration} declares a private
extension and its first subtype.
@begin{Discussion}
@Defn{package-private type}
A @i(package-private type) is one
declared by a @nt<private_type_declaration>;
that is,
a private type other than a generic formal private type.
@Defn{package-private extension}
Similarly, a @i(package-private extension) is one
declared by a @nt<private_extension_declaration>.
These terms are not used in the RM9X version of this document.
@end{Discussion}

A declaration of a partial view and the corresponding
@nt{full_type_declaration} define two views of a single type.
The declaration of a partial view
together with the visible part define the operations that are
available to outside program units;
the declaration of the full view together with
the private part define other operations whose direct use is
possible only within the declarative region of the package itself.
@Defn{characteristics}
Moreover, within the scope of the declaration of the full view, the
@i{characteristics} of the type are determined by the full view;
in particular, within its scope, the full view determines
the classes that include the type,
which components, entries, and protected subprograms are visible,
what attributes and other predefined operations are allowed,
and whether the first subtype is static.
See @RefSecNum{Private Operations}.

A private extension inherits components (including
discriminants unless there is a new @nt<discriminant_part>
specified) and user-defined primitive
subprograms from its ancestor type, in the same way that
a record extension inherits components and user-defined primitive
subprograms from its parent type
(see @RefSecNum{Derived Types and Classes}).
@begin{Honest}
If an operation of the parent type is abstract,
then the abstractness of the inherited operation
is different for nonabstract record extensions
than for nonabstract private extensions
(see @RefSecNum{Abstract Types and Subprograms}).
@end{Honest}
@end{StaticSem}

@begin{RunTime}
@PDefn2{Term=[elaboration], Sec=(private_type_declaration)}
The elaboration of a @nt{private_type_declaration} creates a partial
view of a type.
@PDefn2{Term=[elaboration], Sec=(private_extension_declaration)}
The elaboration of a @nt{private_extension_declaration} elaborates
the @i(ancestor_)@nt<subtype_indication>, and creates a
partial view of a type.
@end{RunTime}

@begin{NotesNotes}
The partial view of a type as declared by a @nt<private_type_declaration>
is defined to be a composite view (in @RefSecNum{Types and Subtypes}).
The full view of the type might or might not be composite.
A private extension is also composite,
as is its full view.

Declaring a private type with an @nt{unknown_discriminant_part} is a
way of preventing clients from creating uninitialized objects of the
type; they are then forced to initialize each object by calling some
operation declared in the visible part of the package.
If such a type is also limited, then no objects of the type can
be declared outside the scope of the @nt{full_type_declaration}, restricting
all object creation to the package defining the type.  This allows
complete control over all storage allocation for the type.
Objects of such a type can still be passed as parameters, however.
@begin{Discussion}
@Defn{generic contract/private type contract analogy}
Packages with private types are analogous to generic packages with
formal private types,
as follows:
The declaration of a package-private type is like the declaration of
a formal private type.
The visible part of the package is like the generic formal part;
these both specify a contract (that is, a set of operations and other
things available for the private type).
The private part of the package is like an instantiation of the generic;
they both give a @nt{full_type_declaration} that specifies implementation
details of the private type.
The clients of the package are like the body of the generic;
usage of the private type in these places is restricted to the
operations defined by the contract.

In other words, being inside the package is like being outside the
generic, and being outside the package is like being inside the
generic;
a generic is like an ``inside-out'' package.

This analogy also works for private extensions
in the same inside-out way.

Many of the legality rules are defined with this analogy in mind.
See, for example, the rules relating to operations of [formal]
derived types.

The completion rules for a private
type are intentionally quite similar to the matching rules for a
generic formal private type.

This analogy breaks down in one respect:
a generic actual subtype is a subtype,
whereas the full view for a private type is always a new type.
(We considered allowing the completion of a @nt{private_type_declaration}
to be a @nt{subtype_declaration},
but the semantics just won't work.)
This difference is behind the fact that a generic actual type can be
class-wide, whereas the completion of a private type always declares
a specific type.
@end{Discussion}

The ancestor type specified in a @nt<private_extension_declaration>
and the parent type specified in the corresponding declaration
of a record extension given in the private part need not be the
same @em the parent type of the full view can be any descendant
of the ancestor type.
In this case, for a primitive subprogram that is inherited from the
ancestor type and
not overridden, the formal parameter names and default expressions (if any)
come from the corresponding primitive subprogram of the specified ancestor
type, while the body comes from the corresponding primitive subprogram
of the parent type of the full view.
See @RefSecNum{Dispatching Operations of Tagged Types}.
@end{NotesNotes}

@begin{Examples}
@i{Examples of private type declarations:}
@begin{Example}
@key[type] Key @key[is] @key[private];
@key[type] File_Name @key[is] @key[limited] @key[private];
@end{Example}

@i{Example of a private extension declaration:}
@begin{Example}
@key[type] List @key[is] @key[new] Ada.Finalization.Controlled @key[with] @key[private];
@end{Example}
@end{Examples}

@begin{Extend83}
The syntax for a @nt{private_type_declaration} is augmented to
allow the reserved word @key{tagged}.

In Ada 83, a private type without discriminants cannot be completed
with a type with discriminants.
Ada 9X allows the full view to have discriminants,
so long as they have defaults
(that is, so long as the first subtype is definite).
This change is made for uniformity with generics,
and because the rule as stated is simpler and easier to remember
than the Ada 83 rule.
In the original version of Ada 83, the same restriction applied
to generic formal private types.
However, the restriction was removed by the ARG for generics.
In order to maintain the ``generic contract/private type contract analogy''
discussed above, we have to apply the same rule to
package-private types.
Note that a private untagged type without discriminants can be
completed with a tagged type with discriminants only if the
full view is constrained, because discriminants of tagged types
cannot have defaults.
@end{Extend83}

@begin{DiffWord83}
RM83-7.4.1(4),
``Within the specification of the package that declares a private type
and before the end of the corresponding full type declaration, a
restriction applies....'',
is subsumed (and corrected) by the rule that
a type shall be completely defined before it is frozen,
and the rule that the parent type of a derived type declaration shall be
completely defined, unless the derived type is a private extension.
@end{DiffWord83}

@LabeledSubClause{Private Operations}

@begin{Intro}
@Redundant[For a type declared in the visible part of a package
or generic package, certain operations on the type
do not become visible until later in the package @em
either in the private part or the body.
@Defn{private operations}
Such @i{private operations} are available only inside the declarative
region of the package or generic package.]
@end{Intro}

@begin{StaticSem}
The predefined operators that exist for a given type are determined by
the classes to which the type belongs.
For example, an integer type has a predefined "+" operator.
In most cases, the predefined operators of a type are declared
immediately after the definition of the type;
the exceptions are explained below.
Inherited subprograms are also implicitly declared
immediately after the definition of the type,
except as stated below.

For a composite type, the characteristics
(see @RefSecNum{Private Types and Private Extensions})
of the type are determined in part by the
characteristics of its component types.
At the place where the composite type is declared,
the only characteristics of component types used are those
characteristics visible at that place.
If later within the immediate scope of the composite type additional
characteristics become visible for a component type,
then any corresponding characteristics become visible for the composite
type.
Any additional predefined operators are implicitly declared at that place.

The corresponding rule applies to a type defined by a
@nt{derived_type_definition},
if there is a place within its immediate scope where additional
characteristics of its parent type become visible.

@Defn{become nonlimited}
@Defn2{Term=[nonlimited type],Sec=(becoming nonlimited)}
@Defn2{Term=[limited type],Sec=(becoming nonlimited)}
@Redundant[For example, an array type whose component type is limited
private becomes nonlimited if the full view of the component type is
nonlimited and visible at some later place within the immediate scope of
the array type.
In such a case, the predefined "=" operator is implicitly declared at
that place, and assignment is allowed after that place.]

Inherited primitive subprograms follow a different rule.
For a @nt{derived_type_definition},
each inherited primitive subprogram
is implicitly declared at the earliest place, if any,
within the immediate scope of the @nt{type_declaration},
but after the @nt{type_declaration},
where the corresponding declaration from the parent is
visible.
If there is no such place, then the inherited subprogram
is not declared at all.
@Redundant[An inherited subprogram that is not declared at all
cannot be named in a call and cannot be overridden,
but for a tagged type, it is possible to dispatch to it.]

For a @nt{private_extension_declaration},
each inherited subprogram is declared immediately after
the @nt{private_extension_declaration}
if the corresponding declaration from the ancestor is visible at that
place.
Otherwise, the inherited subprogram is not declared for the private
extension,
@Redundant[though it might be for the full type].
@begin{Reason}
  There is no need for the ``earliest place within the immediate scope''
  business here, because a @nt{private_extension_declaration} will be
  completed with a @nt{full_type_declaration}, so we can hang the
  necessary private implicit declarations on the
  @nt{full_type_declaration}.
@end{Reason}
@begin{Discussion}
The above rules matter only when the component type (or parent type) is
declared in the visible part of a package, and the composite type (or
derived type) is declared within the declarative region of that package
(possibly in a nested package or a child package).

Consider:
@begin{Example}
@key[package] Parent @key[is]
    @key[type] Root @key[is] @key[tagged] @key[null] @key[record];
    @key[procedure] Op1(X : Root);

    @key[type] My_Int @key[is] @key[range] 1..10;
@key[private]
    @key[procedure] Op2(X : Root);

    @key[type] Another_Int @key[is] @key[new] My_Int;
    @key[procedure] Int_Op(X : My_Int);
@key[end] Parent;

@key[with] Parent; @key[use] Parent;
@key[package] Unrelated @key[is]
    @key[type] T2 @key[is] @key[new] Root @key[with] @key[null] @key[record];
    @key[procedure] Op2(X : T2);
@key[end] Unrelated;

@key[package] Parent.Child @key[is]
    @key[type] T3 @key[is] @key[new] Root @key[with] @key[null] @key[record];
    --@i{ Op1(T3) implicitly declared here.}

    @key[package] Nested @key[is]
        @key[type] T4 @key[is] @key[new] Root @key[with] @key[null] @key[record];
    @key[private]
        ...
    @key[end] Nested;
@key[private]
    --@i{ Op2(T3) implicitly declared here.}
    ...
@key[end] Parent.Child;

@key[with] Unrelated; @key[use] Unrelated;
@key[package] @key[body] Parent.Child @key[is]
    @key[package] @key[body] Nested @key[is]
        --@i{ Op2(T4) implicitly declared here.}
    @key[end] Nested;

    @key[type] T5 @key[is] @key[new] T2 @key[with] @key[null] @key[record];
@key[end] Parent.Child;
@end{Example}

Another_Int does not inherit Int_Op,
because Int_Op does not ``exist'' at the place
where Another_Int is declared.

Type T2 inherits Op1 and Op2 from Root.
However, the inherited Op2 is never declared,
because Parent.Op2 is never visible within the immediate scope of T2.
T2 explicitly declares its own Op2,
but this is unrelated to the inherited one @em it
does not override the inherited one,
and occupies a different slot in the type descriptor.

T3 inherits both Op1 and Op2.  Op1 is implicitly declared immediately
after the type declaration,
whereas Op2 is declared at the beginning of the private part.
Note that if Child were a private child of Parent,
then Op1 and Op2 would both be implicitly declared immediately after the
type declaration.

T4 is similar to T3, except that the earliest place within T4's
immediate scope where Root's Op2 is visible is in the body of Nested.

If T3 or T4 were to declare a type-conformant Op2,
this would override the one inherited from Root.
This is different from the situation with T2.


T5 inherits Op1 and two Op2's from T2.
Op1 is implicitly declared immediately after the declaration of T5,
as is the Op2 that came from Unrelated.Op2.
However, the Op2 that originally came from Parent.Op2 is never
implicitly declared for T5,
since T2's version of that Op2 is never visible (anywhere @em it never
got declared either).


For all of these rules, implicit private parts and bodies are assumed as
needed.

It is possible for characteristics of a type to be revealed in more than
one place:

@begin{Example}
@key[package] P @key[is]
    @key[type] Comp1 @key[is] @key[private];
@key[private]
    @key[type] Comp1 @key[is] @key[new] Boolean;
@key[end] P;

@key[package] P.Q @key[is]
    @key[package] R @key[is]
        @key[type] Comp2 @key[is] @key[limited] @key[private];
        @key[type] A @key[is] @key[array](Integer @key[range] <>) @key[of] Comp2;
    @key[private]
        @key[type] Comp2 @key[is] @key[new] Comp1;
        --@i{ A becomes nonlimited here.}
        --@i{ "="(A, A) return Boolean is implicitly declared here.}
        ...
    @key[end] R;
@key[private]
    --@i{ Now we find out what Comp1 really is, which reveals}
    --@i{ more information about Comp2, but we're not within}
    --@i{ the immediate scope of Comp2, so we don't do anything}
    --@i{ about it yet.}
@key[end] P.Q;

@key[package] @key[body] P.Q @key[is]
    @key[package] @key[body] R @key[is]
        --@i{ Things like "@key[xor]"(A,A) return A are implicitly}
        --@i{ declared here.}
    @key[end] R;
@key[end] P.Q;
@end{Example}

@end{Discussion}

@Redundant[The Class attribute is defined for tagged subtypes in
@RefSecNum{Tagged Types and Type Extensions}.
In addition,] for
@PrefixType{every subtype S of an untagged private type
whose full view is tagged},
the following attribute is defined:
@begin(description)
@Attribute{Prefix=<S>, AttrName=<Class>,
  Text=<Denotes the class-wide subtype corresponding to the full
  view of S.
  This attribute is allowed only from the beginning of the private part
  in which the full view is declared, until the declaration of the full
  view.
  @Redundant[After the full view,
  the Class attribute of the full view can be used.]>}
@end(description)
@EndPrefixType{}
@end{StaticSem}

@begin{NotesNotes}
@begin{Multiple}
Because a partial view and a full view
are two different views of one and the same type,
outside of the defining package the characteristics of the type are
those defined by the visible part.
Within these outside program units the type is just a private type
or private extension,
and any language rule that applies only to another class of types
does not apply.  The fact that the full declaration might implement
a private type with a type of a particular class (for example, as
an array type) is relevant only
within the declarative region of the package itself
including any child units.

The consequences of this actual implementation are, however, valid
everywhere.  For example: any default initialization of components
takes place; the attribute Size provides the size of the full view;
finalization is still done for controlled components of the full view;
task dependence rules still apply to components that are task
objects.
@end{Multiple}

Partial views provide assignment (unless the view is limited),
membership tests, selected components for the selection of
discriminants and inherited components, qualification,
and explicit conversion.

For a subtype S of a partial view, S'Size is defined
(see @RefSecNum{Representation Attributes}).
For an object A of a partial view,
the attributes A'Size and A'Address are defined
(see @RefSecNum{Representation Attributes}).
The Position, First_Bit, and Last_Bit attributes
are also defined for discriminants and inherited components.
@end{NotesNotes}

@begin{Examples}
@i{Example of a type with private operations:}
@begin{Example}
@key[package] Key_Manager @key[is]
   @key[type] Key @key[is] @key[private];
   Null_Key : @key[constant] Key; --@i{ a deferred constant declaration (see @RefSecNum{Deferred Constants})}
   @key[procedure] Get_Key(K : @key[out] Key);
   @key[function] "<" (X, Y : Key) @key[return] Boolean;
@key[private]
   @key[type] Key @key[is] @key[new] Natural;
   Null_Key : @key[constant] Key := Key'First;
@key[end] Key_Manager;
@Hinge{}

@key[package] @key[body] Key_Manager @key[is]
   Last_Key : Key := Null_Key;
   @key[procedure] Get_Key(K : @key[out] Key) @key[is]
   @key[begin]
      Last_Key := Last_Key + 1;
      K := Last_Key;
   @key[end] Get_Key;

   @key[function] "<" (X, Y : Key) @key[return] Boolean @key[is]
   @key[begin]
      @key[return] Natural(X) < Natural(Y);
   @key[end] "<";
@key[end] Key_Manager;
@end{Example}
@end{Examples}

@begin{NotesNotes}
@begin{Multiple}
@i{Notes on the example:}
Outside of the package Key_Manager, the operations available for
objects of type Key include assignment, the comparison for equality
or inequality, the procedure Get_Key and the operator "<"; they do
not include other relational operators such as ">=", or arithmetic
operators.

The explicitly declared operator "<" hides the predefined operator
"<" implicitly declared by the @nt{full_type_declaration}.  Within the
body of the function, an explicit conversion of X and Y to the
subtype Natural is necessary to invoke the "<" operator of the parent
type.
Alternatively, the result of the function could be written as not (X
>= Y), since the operator ">=" is not redefined.

The value of the variable Last_Key, declared in the package body,
remains unchanged between calls of the procedure Get_Key.  (See also
the NOTES of @RefSecNum{Package Bodies}.)
@end{Multiple}
@end{NotesNotes}

@begin{DiffWord83}
The phrase in RM83-7.4.2(7), ``...after the full type declaration'',
doesn't work in the presence of child units, so we define that rule in
terms of visibility.

The definition of the Constrained attribute for private types
has been moved to ``Obsolescent Features.''
(The Constrained attribute of an object has not been moved there.)
@end{DiffWord83}

@LabeledClause{Deferred Constants}

@begin{Intro}
@redundant[
Deferred constant declarations may be used to declare constants
in the visible part of a package,
but with the value of the constant given in the private part.
They may also be used to declare constants imported from other
languages (see @RefSecNum{Interface to Other Languages}).
]
@end{Intro}

@begin{Legality}
@Redundant[@Defn{deferred constant declaration}
A @i(deferred constant declaration) is an @nt<object_declaration>
with the reserved word @key(constant) but no initialization expression.]
@begin{TheProof}
This is stated officially in Section 3.
@end{TheProof}
@Defn{deferred constant}
The constant declared by a deferred constant declaration is called
a @i{deferred constant}.
@PDefn2{Term=[requires a completion], Sec=(deferred constant declaration)}
A deferred constant declaration requires a completion,
which shall be a full constant declaration
(called the @i{full declaration} of the deferred constant),
or a @nt{pragma} Import (see @RefSecNum(Interface to Other Languages)).
@Defn{full declaration}

A deferred constant declaration that is completed
by a full constant declaration shall occur immediately
within the visible part of a @nt<package_specification>.
For this case, the following additional rules apply to the
corresponding full declaration:
@begin(itemize)
  The full declaration shall occur immediately
  within the private part of the same package;

  The deferred and full constants shall have the same type;
  @begin{Ramification}
  This implies that
  both the deferred declaration and the full declaration
  have to have a @nt<subtype_indication> rather than an
  @nt<array_type_definition>, because each @nt{array_type_definition}
  would define a new type.
  @end{Ramification}

  If the subtype defined by the @nt<subtype_indication> in
  the deferred declaration is constrained,
  then the subtype defined by the @nt<subtype_indication> in
  the full declaration shall match it statically.
@Redundant[On the other hand,
  if the subtype of the deferred constant is unconstrained,
  then the full declaration is still allowed to impose a constraint.
  The constant itself will be constrained, like all constants;]

  If the deferred constant declaration
  includes the reserved word @key(aliased), then the
  full declaration shall also.
  @begin{Ramification}
  On the other hand, the full constant can be aliased
  even if the deferred constant is not.
  @end{Ramification}
@end(itemize)

@Redundant[A deferred constant declaration
  that is completed by a @nt{pragma} Import need not appear in
  the visible part of a @nt{package_specification},
  and has no full constant declaration.]


The completion of a deferred constant declaration shall occur
before the constant is frozen
(see @RefSecNum{Deferred Constants}).


@end{Legality}

@begin{RunTime}
@PDefn2{Term=[elaboration], Sec=(deferred constant declaration)}
The elaboration of a deferred constant declaration
elaborates the @nt<subtype_indication> or (only allowed in the case of an
imported constant) the @nt<array_type_definition>.
@end{RunTime}

@begin{NotesNotes}
The full constant declaration for a deferred constant that is of a given
private type or private extension is not allowed before the corresponding
@nt{full_type_declaration}.  This is a consequence of the freezing
rules for types
(see @RefSecNum{Freezing Rules}).
@begin{Ramification}
Multiple or single declarations are allowed for the
deferred and the full declarations, provided that the
equivalent single declarations would be allowed.

Deferred constant declarations are useful for declaring constants of
private views, and types with components of private views.
They are also useful for declaring
access-to-constant objects that designate
variables declared in the private part of a package.
@end{Ramification}
@end{NotesNotes}

@begin{Examples}
@i{Examples of deferred constant declarations:}
@begin{Example}
Null_Key : @key[constant] Key;      @i[-- see @RefSecNum{Private Operations}]

CPU_Identifier : @key[constant] String(1..8);
@key[pragma] Import(Assembler, CPU_Identifier, Link_Name => "CPU_ID");
                              @i[-- see @RefSecNum{Interfacing Pragmas}]
@end{Example}
@end{Examples}

@begin{Extend83}
In Ada 83, a deferred constant is required to be of a private type
declared in the same visible part.
This restriction is removed for Ada 9X;
deferred constants can be of any type.

In Ada 83, a deferred constant declaration was not permitted to
include a constraint, nor the reserved word @key(aliased).

In Ada 83, the rules required conformance of type marks; here
we require static matching of subtypes if the deferred constant
is constrained.

A deferred constant declaration can be completed with a @nt{pragma}
Import.  Such a deferred constant declaration need not be within a
@nt{package_specification}.

The rules for too-early uses of deferred constants are modified in
Ada 9X to allow more cases, and catch all errors at compile time.
This change is necessary in order to allow deferred constants of a
tagged type without violating the principle that for a dispatching call,
there is always an implementation to dispatch to.
It has the beneficial side-effect of catching some Ada-83-erroneous
programs at compile time.
The new rule fits in well with the new freezing-point rules.
Furthermore, we are trying to convert undefined-value problems into
bounded errors, and we were having trouble for the case of deferred
constants.
Furthermore, uninitialized deferred constants cause trouble for the
shared variable / tasking rules, since they are really variable, even
though they purport to be constant.
In Ada 9X, they cannot be touched until they become constant.

Note that we do not consider this change to be an upward
incompatibility, because it merely changes an erroneous execution in Ada
83 into a compile-time error.

The Ada 83 semantics are unclear in the case where
the full view turns out to be an access type.
It is a goal of the language design to prevent uninitialized access
objects.
One wonders if the implementation is required to initialize the
deferred constant to null, and then initialize it (again!) to its
real value.
In Ada 9X, the problem goes away.
@end{Extend83}

@begin{DiffWord83}
Since deferred constants can now be of a nonprivate type,
we have made this a stand-alone clause, rather than
a subclause of @RefSec{Private Types and Private Extensions}.

Deferred constant declarations used to have their own syntax, but now
they are simply a special case of @nt<object_declaration>s.
@end{DiffWord83}

@LabeledClause{Limited Types}

@begin{Intro}
@redundant[
@ToGlossaryAlso{Term=<Limited type>,
  Text=<A limited type is (a view of) a type for which
  the assignment operation is not allowed.
  A nonlimited type is a (view of a) type for which the assignment
  operation is allowed.>}
]
@begin{Discussion}
The concept of the @i(value) of a limited type is difficult
to define, since the abstract value of a limited type often
extends beyond its physical representation.  In some
sense, values of a limited type cannot be divorced from
their object.  The value @i(is) the object.

In Ada 83, in the two places where limited types were defined
by the language, namely tasks and files, an implicit
level of indirection was implied by the semantics to
avoid the separation of the value from an associated
object.
In Ada 9X, most limited types are passed by reference,
and even return-ed by reference.
@end{Discussion}
@begin{Honest}
For a limited partial view whose full view is nonlimited,
assignment is possible on parameter passing and function return.
To prevent any copying whatsoever, one should make both the partial
@i{and} full views limited.
@end{Honest}
@end{Intro}

@begin{Legality}
If a tagged record type has any limited components,
then the reserved word @key[limited] shall
appear in its @nt<record_type_definition>.
@begin{Reason}
This prevents tagged limited types from becoming nonlimited.
Otherwise, the following could happen:
@begin{Example}
@key[package] P @key[is]
    @key[type] T @key[is] @key[limited] @key[private];
    @key[type] R @key[is] @key[tagged]
        @key[record] --@i{ Illegal!}
               --@i{ This should say ``@key[limited record]''.}
            X : T;
        @key[end] @key[record];
@key[private]
    @key[type] T @key[is] @key[new] Integer; --@i{ R becomes nonlimited here.}
@key[end] P;

@key[package] Q @key[is]
    @key[type] R2(Access_Discrim : @key[access] ...) @key[is] @key[new] R @key[with]
        @key[record]
            Y : Some_Task_Type;
        @key[end] @key[record];
@key[end] Q;
@end{Example}

If the above were legal,
then assignment would be defined for R'Class in the body of P,
which is bad news, given the access discriminant and the task.
@end{Reason}
@end{Legality}

@begin{StaticSem}
@Defn{limited type}
A type is @i{limited} if it
is a descendant of one of the following:
@begin(itemize)
  a type with the reserved word @b(limited) in its definition;
  @begin{Ramification}
  Note that there is always a ``definition,'' conceptually,
  even if there is no syntactic category called ``..._definition''.
  @end{Ramification}

  a task or protected type;

  a composite type with a limited component.
@end(itemize)

@Defn{nonlimited type}
Otherwise, the type is nonlimited.

@Redundant[There are no predefined equality operators for
a limited type.]
@end{StaticSem}

@begin{NotesNotes}
The following are consequences of the rules for limited types:
@begin{Itemize}
An initialization expression is not allowed in an
@nt{object_declaration} if the type of the object is limited.

A default expression is not allowed in a @nt{component_declaration} if
the type of the record component is limited.

An initialized allocator is not allowed if the designated type is
limited.

A generic formal parameter of mode @key[in] must not be of a limited
type.
@end{Itemize}

@nt{Aggregate}s are not available for a limited composite type.
Concatenation is not available for a limited array type.

The rules do not exclude a @nt{default_expression} for a formal
parameter of a limited type; they do not exclude a deferred constant
of a limited type if the full declaration of the constant
is of a nonlimited type.

@Defn{become nonlimited}
@Defn2{Term=[nonlimited type],Sec=(becoming nonlimited)}
@Defn2{Term=[limited type],Sec=(becoming nonlimited)}
As illustrated in @RefSecNum{Private Operations},
an untagged limited type can become nonlimited under certain
circumstances.
@begin{Ramification}
  Limited private types do not become nonlimited;
  instead, their full view can be nonlimited,
  which has a similar effect.

  It is important to remember
  that a single nonprivate type can be both limited and nonlimited
  in different parts of its scope.  In other words, ``limited'' is a property
  that depends on where you are in the scope of the type.
  We don't call this a ``view property'' because there is no particular
  declaration to declare the nonlimited view.

  Tagged types never become nonlimited.
@end{Ramification}
@end{NotesNotes}

@begin{Examples}
@i{Example of a package with a limited type:}
@begin{Example}
@key[package] IO_Package @key[is]
   @key[type] File_Name @key[is] @key[limited] @key[private];

   @key[procedure] Open (F : @key[in] @key[out] File_Name);
   @key[procedure] Close(F : @key[in] @key[out] File_Name);
   @key[procedure] Read (F : @key[in] File_Name; Item : @key[out] Integer);
   @key[procedure] Write(F : @key[in] File_Name; Item : @key[in]  Integer);
@key[private]
   @key[type] File_Name @key[is]
      @key[limited] @key[record]
         Internal_Name : Integer := 0;
      @key[end] @key[record];
@key[end] IO_Package;
@Hinge{}

@key[package] @key[body] IO_Package @key[is]
   Limit : @key[constant] := 200;
   @key[type] File_Descriptor @key[is] @key[record]  ...  @key[end] @key[record];
   Directory : @key[array] (1 .. Limit) @key[of] File_Descriptor;
   ...
   @key[procedure] Open (F : @key[in] @key[out] File_Name) @key[is]  ...  @key[end];
   @key[procedure] Close(F : @key[in] @key[out] File_Name) @key[is]  ...  @key[end];
   @key[procedure] Read (F : @key[in] File_Name; Item : @key[out] Integer) @key[is] ... @key[end];
   @key[procedure] Write(F : @key[in] File_Name; Item : @key[in]  Integer) @key[is] ... @key[end];
@key[begin]
   ...
@key[end] IO_Package;
@end{Example}
@end{Examples}

@begin{NotesNotes}
@begin{Multiple}
@i{Notes on the example:}
In the example above, an outside subprogram making use of IO_Package
may obtain a file name by calling Open and later use it in calls to
Read and Write.  Thus, outside the package, a file name obtained from
Open acts as a kind of password; its internal properties (such as
containing a numeric value) are not known and no other operations
(such as addition or comparison of internal names) can be performed
on a file name.
Most importantly, clients of the package cannot make copies
of objects of type File_Name.

This example is characteristic of any case where complete control
over the operations of a type is desired.  Such packages serve a dual
purpose.  They prevent a user from making use of the internal
structure of the type.  They also implement the notion of an
encapsulated data type where the only operations on the type are
those given in the package specification.

The fact that the full view of File_Name is explicitly declared
@key[limited] means that
parameter passing and function return will always be by reference
(see @RefSecNum{Formal Parameter Modes} and @RefSecNum{Return Statements}).
@end{Multiple}
@end{NotesNotes}

@begin{Extend83}
The restrictions in RM83-7.4.4(4),
which disallowed @key[out] parameters of limited types in certain
cases, are removed.
@end{Extend83}

@begin{DiffWord83}
Since limitedness and privateness are orthogonal in Ada 9X (and
to some extent in Ada 83), this is now its own clause rather
than being a subclause of
@RefSec{Private Types and Private Extensions}.
@end{DiffWord83}

@LabeledClause{User-Defined Assignment and Finalization}

@begin{Intro}
@redundant[
@Defn{user-defined assignment}
@Defn2{Term=[assignment], Sec=(user-defined)}
Three kinds of actions are
fundamental to the manipulation of objects:
initialization, finalization, and assignment.
Every object is initialized, either explicitly
or by default, after being created
(for example, by an @nt{object_declaration} or @nt{allocator}).
Every object is finalized before being destroyed
(for example, by leaving a @nt{subprogram_body} containing an
@nt{object_declaration}, or by a call to an instance of
Unchecked_Deallocation).
An assignment operation is used as part of @nt{assignment_statement}s,
explicit initialization, parameter passing, and other operations.
@IndexSee{Term=[constructor],See=[initialization]}
@IndexSee{Term=[constructor],See=[Initialize]}
@IndexSee{Term=[destructor],See=[finalization]}

Default definitions for these three fundamental
operations are provided by the
language, but
@Defn{controlled type}
a @i{controlled} type gives the user additional
control over parts of these operations.
@ToGlossary{Term=<Controlled type>,
  Text=<A controlled type supports user-defined assignment and
  finalization.
  Objects are always finalized before being destroyed.>}
@Defn{Initialize}
@Defn{Finalize}
@Defn{Adjust}
In particular, the user can define, for a controlled type,
an Initialize procedure which is invoked immediately after
the normal default initialization of a controlled object, a Finalize procedure
which is invoked immediately before finalization of any of the
components of a controlled object, and an Adjust
procedure which is invoked as the last step of an assignment to
a (nonlimited) controlled object.
]
@begin{Ramification}
Here's the basic idea of initialization, value adjustment, and finalization,
whether or not user defined:
When an object is created,
if it is explicitly assigned an initial value,
the assignment copies and adjusts the initial value.
Otherwise, Initialize is applied to it
(except in the case of an @nt{aggregate} as a whole).
An @nt{assignment_statement} finalizes the target before
copying in and adjusting the new value.
Whenever an object goes away, it is finalized.
Calls on Initialize and Adjust happen bottom-up; that is,
components first, followed by the containing object.
Calls on Finalize happens top-down; that is,
first the containing object, and then its components.
These ordering rules ensure that any components will be in a
well-defined state when Initialize, Adjust,
or Finalize is applied to the containing object.
@end{Ramification}
@end{Intro}

@begin{StaticSem}
The following language-defined library package exists:
@begin{Example}
@tabclear()
@ChildUnit{Parent=[Ada],Child=[Finalization],Expanded=[Ada.Finalization]}
@key[package] Ada.Finalization @key[is]
    @key[pragma] Preelaborate(Finalization);

@LangDefType{Package=[Ada.Finalization],Type=[Controlled]}
    @key[type] Controlled @key[is abstract tagged private];

    @key(procedure) Initialize@^(Object : @key(in out) Controlled);
    @key(procedure) Adjust@\(Object : @key(in out) Controlled);
    @key(procedure) Finalize@\(Object : @key(in out) Controlled);

@LangDefType{Package=[Ada.Finalization],Type=[Limited_Controlled]}
    @key[type] Limited_Controlled @key[is abstract tagged limited private];

@tabclear()
    @key(procedure) Initialize@^(Object : @key(in out) Limited_Controlled);
    @key(procedure) Finalize@\(Object : @key(in out) Limited_Controlled);
@key(private)
    ... -- @i{not specified by the language}
@key[end] Ada.Finalization;
@end{Example}

@Defn{controlled type}
A controlled type is a descendant of Controlled or Limited_Controlled.
@begin{Discussion}
We say ``nonlimited controlled types'' when we want to talk
about descendants of Controlled only.
@end{Discussion}
The (default) implementations of
Initialize, Adjust, and Finalize have no effect.

The predefined "=" operator of type Controlled always returns True,
@Redundant[since this operator is incorporated into
the implementation of the predefined equality operator of types derived
from Controlled, as explained in
@RefSecNum(Relational Operators and Membership Tests).]

The type Limited_Controlled is like Controlled, except
that it is limited and it lacks the primitive subprogram Adjust.
@begin{Reason}
  We considered making Adjust and Finalize abstract.
  However, a reasonable coding convention is e.g. for Finalize to
  always call the parent's Finalize after doing whatever work is needed
  for the extension part.
  (Unlike CLOS, we have no way to do that automatically in Ada 9X.)
  For this to work, Finalize cannot be abstract.
  In a generic unit, for a generic formal abstract derived type whose
  ancestor is Controlled or Limited_Controlled, calling the ancestor's
  Finalize would be illegal if it were abstract, even though the actual
  type might have a concrete version.

  Types Controlled and Limited_Controlled are abstract, even though
  they have no abstract primitive subprograms.
  It is not clear that they need to be abstract, but there seems to be
  no harm in it, and it might make an implementation's life easier to
  know that there are no objects of these types @em in case the
  implementation wishes to make them ``magic'' in some way.
@end{Reason}
@end{StaticSem}

@begin{RunTime}
@PDefn2{Term=[elaboration], Sec=(object_declaration)}
During the elaboration of an @nt{object_declaration},
for every controlled subcomponent of
the object that is not assigned an
initial value
(as defined in @RefSecNum{Object Declarations}),
Initialize is called on that subcomponent.
Similarly, if the object as a whole is controlled
and is not assigned an initial value,
Initialize is called on the object.
The same applies to the evaluation of an @nt{allocator},
as explained in @RefSecNum{Allocators}.

For an @nt{extension_aggregate} whose @nt{ancestor_part} is a
@nt{subtype_mark},
Initialize is called on all controlled subcomponents of the ancestor part;
if the type of the ancestor part is itself controlled,
the Initialize procedure of the ancestor type is called,
unless that Initialize procedure is abstract.
@begin{Discussion}
Example:
@begin{Example}
@key[type] T1 @key[is] @key[new] Controlled @key[with]
    @key[record]
        ... --@i{ some components might have defaults}
    @key[end] @key[record];

@key[type] T2 @key[is] @key[new] Controlled @key[with]
    @key[record]
        X : T1; --@i{ no default}
        Y : T1 := ...; --@i{ default}
    @key[end] @key[record];

A : T2;
B : T2 := ...;
@end{Example}

As part of the elaboration of A's declaration, A.Y is assigned a
value; therefore Initialize is not applied to A.Y.
Instead, Adjust is applied to A.Y as part of the assignment operation.
Initialize is applied to A.X and to A, since those objects are not
assigned an initial value.
The assignment to A.Y is not considered an assignment to A.

For the elaboration of B's declaration, Initialize is not called at
all.
Instead the assignment adjusts B's value;
that is, it applies Adjust to B.X, B.Y, and B.
@end{Discussion}

Initialize and other initialization
operations are done in an arbitrary order,
except as follows.
Initialize is applied to an object after initialization
of its subcomponents, if any
@Redundant[(including both implicit initialization and Initialize calls)].
If an object has a component with an access discriminant
constrained by a per-object expression,
Initialize is applied to this component after any components that do not
have such discriminants.
For an object with several components with such a discriminant,
Initialize is applied to them in order
of their @nt{component_declaration}s.
For an @nt<allocator>,
any task activations follow all calls
on Initialize.
@begin{Reason}
  The fact that Initialize is done for subcomponents
  first allows Initialize for a composite
  object to refer to its subcomponents knowing
  they have been properly initialized.

  The fact that Initialize is done for components with access
  discriminants after other components
  allows the Initialize operation for a component
  with a self-referential access discriminant to assume
  that other components of the enclosing object have already been
  properly initialized.
  For multiple such components, it allows some predictability.
@end{Reason}

@Defn{assignment operation}
When a target object with any controlled parts is assigned a value,
@Redundant[either when created or in a subsequent
@nt{assignment_statement},]
the @i{assignment operation} proceeds as follows:
@begin(itemize)
  The value of the target becomes the assigned value.

  @Defn{adjusting the value of an object}
  @Defn{adjustment}
  The value of the target is @i{adjusted.}
@end(itemize)
@begin{Ramification}
    If any parts of the object are controlled,
    abort is deferred during the assignment operation.
@end{Ramification}

@Defn{adjusting the value of an object}
@Defn{adjustment}
To adjust the value of a @Redundant[(nonlimited)] composite object,
the values of the components of the object are first
adjusted in an arbitrary order,
and then, if the object is controlled,
Adjust is called.
Adjusting the value of an elementary object has no effect@Redundant[,
nor does adjusting the value of a composite object with no
controlled parts.]
@begin{Ramification}
Adjustment is never performed for values of
  a by-reference limited type, since these
  types do not support copying.
@end{Ramification}
@begin{Reason}
  The verbiage in the Initialize rule about access discriminants
    constrained by per-object expressions is not necessary here,
    since such types are limited,
    and therefore are never adjusted.
@end{Reason}

@PDefn2{Term=[execution], Sec=(assignment_statement)}
For an @nt{assignment_statement},
@Redundant[ after the @nt{name} and
@nt{expression} have been evaluated,
and any conversion (including constraint checking) has been done,]
an anonymous object is created, and
the value is assigned into it;
@Redundant[that is, the assignment operation is applied].
@Redundant[(Assignment includes value adjustment.)]
The target of the @nt{assignment_statement} is then finalized.
The value of the anonymous object is then assigned into the target of
the @nt{assignment_statement}.
Finally, the anonymous object is finalized.
@Redundant[As explained below,
the implementation may eliminate the intermediate anonymous object,
so this description subsumes the one given in
@RefSec{Assignment Statements}.]
@begin{Reason}
An alternative design for user-defined assignment might involve an
Assign operation instead of Adjust:
@begin{Example}
@key[procedure] Assign(Target : @key[in] @key[out] Controlled; Source : @key[in] @key[out] Controlled);
@end{Example}

Or perhaps even a syntax like this:
@begin{Example}
@key[procedure] ":="(Target : @key[in] @key[out] Controlled; Source : @key[in] @key[out] Controlled);
@end{Example}

Assign (or ":=") would have the responsibility of doing the copy,
as well as whatever else is necessary.
This would have the advantage that the Assign operation knows about both
the target and the source at the same time @em it would be possible to
do things like reuse storage belonging to the target, for example,
which Adjust cannot do.
However, this sort of design would not work in the case of unconstrained
discriminated variables, because there is no way to change the
discriminants individually.
For example:
@begin{Example}
@key[type] Mutable(D : Integer := 0) @key[is]
    @key[record]
        X : Array_Of_Controlled_Things(1..D);
        @key[case] D @key[is]
            @key[when] 17 => Y : Controlled_Thing;
            @key[when] @key[others] => @key[null];
        @key[end] D;
    @key[end] @key[record];
@end{Example}

An assignment to an unconstrained variable of type Mutable can cause
some of the components of X, and the component Y, to appear and/or
disappear.
There is no way to write the Assign operation to handle this sort of
case.

Forbidding such cases is not an option @em it would cause generic
contract model violations.
@end{Reason}
@end{RunTime}

@begin{ImplPerm}
An implementation is allowed to relax the above rules
@Redundant[(for nonlimited controlled types)]
in the following ways:
@begin{TheProof}
The phrase ``for nonlimited controlled types'' follows from the fact
that all of the following permissions apply to cases involving
assignment.
It is important because the programmer can count on a stricter semantics
for limited controlled types.
@end{TheProof}
@begin{Itemize}
For an @nt{assignment_statement} that assigns to an object the value
of that same object,
the implementation need not do anything.
@begin{Ramification}
  In other words, even if an object is controlled and a combination
  of Finalize and Adjust on the object might have a net
  side effect, they need not be performed.
@end{Ramification}

For an @nt{assignment_statement} for a noncontrolled type,
the implementation may finalize and assign each
component of the variable separately (rather than finalizing the entire
variable and assigning the entire new value)
unless a discriminant of the variable is changed by the assignment.
@begin{Reason}
For example, in a slice assignment, an anonymous object is not necessary
if the slice is copied component-by-component in the right direction,
since array types are not controlled (although their components may be).
Note that the direction, and even the fact that it's a slice assignment,
can in general be determined only at run time.
@end{Reason}

For an
@nt{aggregate} or function call whose value is assigned
into a target object,
the implementation need not create a separate anonymous object if
it can safely create the value of
the @nt{aggregate} or function call
directly in the target object.
Similarly, for an @nt{assignment_statement},
the implementation need not create an anonymous object if
the value being assigned is the result of evaluating a @nt{name}
denoting an object (the source object) whose storage cannot overlap
with the target.  If the source object might overlap with the
target object, then the implementation can avoid the need for
an intermediary anonymous object by exercising one of the
above permissions and perform the assignment one component
at a time (for an overlapping array assignment), or not at all
(for an assignment where the target and the source of the assignment are
the same object).
Even if an anonymous object is created,
the implementation may move its value to the target object as part of
the assignment without re-adjusting so long as the
anonymous object has no aliased subcomponents.
@begin{Ramification}
In the @nt{aggregate} case,
only one value adjustment is necessary,
and there is no anonymous object to be finalized.

In the @nt{assignment_statement} case as well,
no finalization of the anonymous object is needed.
On the other hand, if the target has aliased subcomponents,
then an adjustment takes place directly on the target object
as the last step of the assignment, since some of the
subcomponents may be self-referential or otherwise position-dependent.
@end{Ramification}

@end{Itemize}
@end{ImplPerm}

@begin{Extend83}
Controlled types and user-defined finalization are new to Ada 9X.
(Ada 83 had finalization semantics only for masters of tasks.)
@end{Extend83}

@LabeledSubClause{Completion and Finalization}

@begin{Intro}
@redundant[
This subclause defines @i{completion} and @i{leaving} of the execution
of constructs and entities.
A @i{master} is the execution of a construct that
includes finalization of local objects after it is complete
(and after waiting for any local tasks
@em see @RefSecNum(Task Dependence - Termination of Tasks)),
but before leaving.
Other constructs and entities are left immediately upon completion.
@IndexSee{Term=[cleanup],See=(finalization)}
@IndexSee{Term=[destructor],See=(finalization)}
]
@end{Intro}

@begin{RunTime}
@Defn{completion and leaving (completed and left)}
@Defn2{Term=[completion], Sec=(run-time concept)}
The execution of a construct or entity
is @i{complete} when the end of that execution has been reached,
or when a transfer of control
(see @RefSecNum{Simple and Compound Statements - Sequences of Statements})
causes it to be abandoned.
@Defn{normal completion}
@Defn2{Term=[completion], Sec=(normal)}
@Defn{abnormal completion}
@Defn2{Term=[completion], Sec=(abnormal)}
Completion due to reaching the end of execution,
or due to the transfer of control of an @nt{exit_},
@nt{return_}, @nt{goto_},
or @nt{requeue_statement} or of the
selection of a @nt{terminate_alternative}
is @i{normal completion}.
Completion is @i{abnormal} otherwise @Redundant[@em
when control is transferred out of a construct
due to abort or the raising of an exception].
@begin{Discussion}
Don't confuse the run-time concept of completion with
the compile-time concept of completion
defined in @RefSecNum{Completions of Declarations}.
@end{Discussion}

@Defn{leaving}
@Defn{left}
@begin{Multiple}
After execution of a construct or entity is complete,
it is @i{left},
meaning that execution continues with the next action,
as defined for the execution that is taking place.
@Defn{master}
Leaving an execution happens immediately after its completion,
except in the case of a @i{master}:
the execution of
a @nt{task_body}, a @nt{block_statement},
a @nt{subprogram_body}, an @nt{entry_body}, or an @nt{accept_statement}.
A master is finalized after it is
complete, and before it is left.

@begin{Reason}
  Note that although an @nt{accept_statement} has no
  @nt{declarative_part}, it can call functions and evaluate
  @nt{aggregate}s,
  possibly causing anonymous controlled objects
  to be created,
  and we don't want those objects to escape outside the rendezvous.
@end{Reason}

@Defn2{Term=[finalization], Sec=(of a master)}

For the @i{finalization} of a master,
dependent tasks are first awaited,
as explained in @RefSecNum{Task Dependence - Termination of Tasks}.
Then each object whose accessibility level is
the same as that of the master is finalized
if the object was successfully initialized and still exists.

@Redundant[These actions are performed whether the master is left
  by reaching the last statement or via a transfer of control.]
@begin{Ramification}

  As explained in @RefSecNum{Operations of Access Types},
  the set of objects with the same accessibility level
  as that of the master
  includes objects declared immediately within the master,
  objects declared in nested packages,
  objects created by @nt{allocator}s
  (if the ultimate ancestor access type is declared in one of those places)
  and subcomponents of all of these things.
  If an object was already finalized by Unchecked_Deallocation,
  then it is not finalized again when the master is left.

  Note that any object whose accessibility level is deeper than that of
  the master would no longer exist;
  those objects would have been finalized by some inner master.
  Thus, after leaving a master, the only objects yet to be
  finalized are those whose accessibility level is less deep than that
  of the master.

@end{Ramification}
@begin{Honest}
Subcomponents of objects due to be finalized are not finalized
by the finalization of the master;
they are finalized by the finalization of the containing object.
@end{Honest}
@begin{Reason}
We need to finalize subcomponents of objects even if the containing
object is not going to get finalized because it was not fully
initialized.
But if the containing object is finalized, we don't want to require
repeated finalization of the subcomponents,
as might normally be implied by the recursion in finalization of a
master and the recursion in finalization of an object.
@end{Reason}
When a transfer of control causes completion of an execution, each
included master is finalized in order, from
innermost outward.
@begin{Honest}
Formally, completion and leaving refer to executions of constructs or
entities.
However, the standard sometimes (informally) refers
to the constructs or entities whose executions are being completed.
Thus, for example,
``the @nt{subprogram_call} or task is complete''
really means
``@i{the execution of} the @nt{subprogram_call} or task is complete.''
@end{Honest}
@end{Multiple}

@RootDefn2{Term=[finalization], Sec=(of an object)}
For the @i{finalization} of an object:
@begin{Itemize}
  If the object is of an elementary type, finalization has no effect;

  If the object is of a controlled type, the Finalize procedure is
  called;

  If the object is of a protected type, the actions defined in
  @RefSecNum{Protected Units and Protected Objects} are performed;

  If the object is of a composite type, then after performing the
  above actions, if any, every component of the object
  is finalized in an arbitrary order, except as follows:
  if the object has
  a component with an access discriminant constrained by a per-object
  expression, this component is finalized before any components that
  do not have such discriminants; for an object with several components
  with such a discriminant, they are finalized in the
  reverse of the order of their @nt<component_declaration>s.
  @begin{Reason}
    This allows the finalization of a component with an access discriminant
    to refer to other components of the enclosing object prior to
    their being finalized.
  @end{Reason}
@end{Itemize}

@PDefn2{Term=[execution], Sec=(instance of Unchecked_Deallocation)}
Immediately before an instance of Unchecked_Deallocation
reclaims the storage of an object,
the object is finalized.
@Redundant[If an instance of Unchecked_Deallocation is never applied to
an object created by an @nt{allocator},
the object will still exist when the corresponding master completes,
and it will be finalized then.]

The order in which the finalization of a master performs finalization of
objects is as follows:
Objects created by declarations in the master are finalized
in the reverse order of their creation.
For objects that were created
by @nt{allocator}s for an access type whose
ultimate ancestor is declared in the master,
this rule is applied as though each
such object that still exists had been created
in an arbitrary order
at the first freezing point
(see @RefSecNum{Freezing Rules})
of the ultimate ancestor type.
@begin{Reason}
  Note that we talk about the type of the @nt{allocator} here.
    There may be access values of a (general) access type
    pointing at objects created by @nt{allocator}s for some other
    type; these are not finalized at this point.

  The freezing point of the ultimate ancestor access type is chosen
  because before that point, pool elements cannot be created,
  and after that point, access values designating (parts of)
  the pool elements can be created.
  This is also the point after which the pool object cannot have been
  declared.
  We don't want to finalize the pool elements until after anything
  finalizing objects that contain access values designating them.
  Nor do we want to finalize pool elements after finalizing the pool
  object itself.
@end{Reason}
@begin{Ramification}
Finalization of allocated objects is done according
  to the (ultimate ancestor) @nt{allocator} type, not according to the storage pool
  in which they are allocated.
  Pool finalization might reclaim storage (see @RefSec{Storage Management}),
  but has nothing (directly) to do with finalization of the
  pool elements.

Note that finalization is done only for objects that still exist;
if an instance of Unchecked_Deallocation has already gotten rid of a
given pool element, that pool element will not be finalized when
the master is left.

Note that a deferred constant declaration does not create the
constant; the full constant declaration creates it.
Therefore, the order of finalization depends on where the full
constant declaration occurs,
not the deferred constant declaration.

An imported object is not created by its declaration.
It is neither initialized nor finalized.
@end{Ramification}
@begin{ImplNote}
An implementation has to ensure that the storage for an object is not
reclaimed when references to the object are still possible
(unless, of course, the user explicitly requests reclamation via an
instance of Unchecked_Deallocation).
This implies, in general, that objects cannot be deallocated one by one
as they are finalized;
a subsequent finalization might reference an object that has been
finalized, and that object had better be in its (well-defined)
finalized state.
@end{ImplNote}

@PDefn2{Term=[execution], Sec=(assignment_statement)}
The target of an assignment statement is finalized before copying in the
new value, as explained
in @RefSecNum{User-Defined Assignment and Finalization}.

The anonymous objects created by function calls and by @nt{aggregate}s
are finalized no later than the end of the innermost enclosing
@nt{declarative_item} or @nt{statement};
if that is a @nt{compound_statement},
they are finalized before starting the execution of any
@nt{statement} within the @nt{compound_statement}.
@begin{Honest}
This is not to be construed as permission to call Finalize
asynchronously with respect to normal user code.
For example,
@begin{Example}
@key[declare]
    X : Some_Controlled_Type := F(G(...));
    --@i{ The anonymous objects created for F and G are finalized}
    --@i{ no later than this point.}
    Y : ...
@key[begin]
    ...
@key[end];
@end{Example}

The anonymous object for G should not be finalized at some random
point in the middle of the body of F,
because F might manipulate the same data structures as
the Finalize operation, resulting in erroneous access
to shared variables.
@end{Honest}
@begin{Reason}
It might be quite inconvenient for the implementation to defer
finalization of the anonymous object for G until after copying the
value of F into X, especially if the size of the result
is not known at the call site.
@end{Reason}

@end{RunTime}

@begin{Bounded}
It is a bounded error for a call on
Finalize or Adjust to propagate an exception.
The possible consequences depend on what action invoked the Finalize or
Adjust operation:
@begin{Ramification}
  It is not a bounded error for Initialize to propagate an
  exception.  If Initialize propagates an exception,
  then no further calls on Initialize are performed,
  and those components that have already been initialized
  (either explicitly or by default)
  are finalized in the usual way.
@end{Ramification}
@begin{Itemize}
@Defn2{Term=[Program_Error],Sec=(raised by failure of run-time check)}
For a Finalize invoked as part of an @nt<assignment_statement>,
Program_Error is raised at that point.

@Defn2{Term=[Program_Error],Sec=(raised by failure of run-time check)}
For an Adjust invoked as part of an assignment operation,
any other adjustments due to be performed are performed,
and then Program_Error is raised.

@Defn2{Term=[Program_Error],Sec=(raised by failure of run-time check)}
For a Finalize invoked as part of a call on an instance of
Unchecked_Deallocation, any other finalizations due to
be performed are performed, and then Program_Error is raised.

@Defn2{Term=[Program_Error],Sec=(raised by failure of run-time check)}
For a Finalize invoked
by the transfer of control of
an @nt{exit_}, @nt{return_}, @nt{goto_},
or @nt{requeue_statement},
Program_Error is raised no earlier than after the finalization of the
master being finalized when the exception occurred,
and no later than the point where normal execution would have continued.
Any other finalizations due to be performed up to that point are
performed before raising Program_Error.
@begin{Ramification}
For example, upon leaving a @nt{block_statement} due to a
@nt{goto_statement}, the Program_Error would be raised at the point of the
target statement denoted by the label,
or else in some more dynamically nested place,
but not so nested as to allow an @nt{exception_handler} that has
visibility upon the finalized object to handle it.
For example,
@begin{Example}
@key[procedure] Main @key[is]
@key[begin]
    <<The_Label>>
    Outer_Block_Statement : @key[declare]
        X : Some_Controlled_Type;
    @key[begin]
        Inner_Block_Statement : @key[declare]
            Y : Some_Controlled_Type;
            Z : Some_Controlled_Type;
        @key[begin]
            @key[goto] The_Label;
        @key[exception]
            @key[when] Program_Error => ... --@i{ Handler number 1.}
        @key[end];
    @key[exception]
        @key[when] Program_Error => ... --@i{ Handler number 2.}
    @key[end];
@key[exception]
    @key[when] Program_Error => ... --@i{ Handler number 3.}
@key[end] Main;
@end{Example}

The @nt{goto_statement} will first cause
Finalize(Y) to be called.
Suppose that Finalize(Y) propagates an exception.
Program_Error will be raised after leaving Inner_Block_Statement,
but before leaving Main.
Thus, handler number 1 cannot handle this Program_Error;
it will be handled either by handler number 2 or handler number 3.
If it is handled by handler number 2,
then Finalize(Z) will be done before executing the handler.
If it is handled by handler number 3,
then Finalize(Z) and Finalize(X) will both
be done before executing the handler.
@end{Ramification}

For a Finalize invoked by a transfer of control
that is due to raising an exception,
any other finalizations due to be performed for the same master are
performed; Program_Error is raised immediately after leaving the master.
@begin{Ramification}
If, in the above example, the @nt{goto_statement} were replaced by a
@nt{raise_statement}, then the Program_Error would be handled by
handler number 2, and
Finalize(Z) would be done before executing the handler.
@end{Ramification}
@begin{Reason}
We considered treating this case in the same way as the others,
but that would render certain @nt{exception_handler}s useless.
For example, suppose the only @nt{exception_handler} is
one for @key{others} in the main subprogram.
If some deeply nested call raises an exception,
causing some Finalize operation to be called,
which then raises an exception,
then normal execution ``would have continued''
at the beginning of the @nt{exception_handler}.
Raising Program_Error at that point would cause that
handler's code to be skipped.
One would need two nested @nt{exception_handler}s
to be sure of catching such cases!

On the other hand, the @nt{exception_handler} for a given master
should not be allowed to handle exceptions raised during finalization
of that master.
@end{Reason}

For a Finalize invoked by a transfer of control due to
an abort or selection of a terminate alternative,
the exception is ignored;
any other finalizations due to be performed are performed.
@begin{Ramification}
This case includes an asynchronous transfer of control.
@end{Ramification}
@begin{Honest}
@Defn2{Term=[Program_Error],Sec=(raised by failure of run-time check)}
This violates the general principle that it is always possible for
a bounded error to raise Program_Error
(see @RefSec{Classification of Errors}).
@end{Honest}
@end{Itemize}
@end{Bounded}

@begin{NotesNotes}
The rules of Section 10 imply that
immediately prior to partition termination, Finalize operations
are applied to library-level controlled objects (including those
created by @nt{allocator}s of library-level access types, except those
already finalized).
This occurs after waiting for library-level
tasks to terminate.
@begin{Discussion}
We considered defining a pragma that would apply to a controlled
type that would suppress Finalize operations for library-level objects
of the type upon partition termination.
This would be useful for types whose finalization actions
consist of simply reclaiming global heap storage, when this is already
provided automatically by the environment upon program termination.
@end{Discussion}

A constant is only constant between its initialization and
finalization.
Both initialization and finalization are allowed to
change the value of a constant.

Abort is deferred during certain operations related to controlled types,
as explained in
@RefSecNum{Abort of a Task - Abort of a Sequence of Statements}.
Those rules prevent an abort from causing a controlled object
to be left in an ill-defined state.

The Finalize procedure is called upon finalization of
a controlled object, even if Finalize was called earlier,
either explicitly or as part of an assignment; hence,
if a controlled type is visibly controlled (implying that its Finalize
primitive is directly callable), or is nonlimited (implying that
assignment is allowed), its Finalize procedure should be
designed to have no ill effect if it is applied a second time
to the same object.
@begin{Discussion}
  Or equivalently, a Finalize procedure
  should be ``idempotent'';
  applying it twice to the same object should be equivalent to
  applying it once.
@end{Discussion}
@begin{Reason}
  A user-written Finalize procedure should be idempotent since it
  can be called explicitly
  by a client (at least if the type is "visibly" controlled).
  Also, Finalize is used implicitly as part of the
  @nt<assignment_statement> if the
  type is nonlimited, and an abort is permitted to disrupt an
  @nt<assignment_statement> between finalizing the left-hand side
  and assigning the new value to it (an abort is not permitted to
  disrupt an assignment operation between copying in the new value
  and adjusting it).
@end{Reason}
@begin{Discussion}
Either Initialize or Adjust,
but not both, is applied to (almost) every controlled object
when it is created:
Initialize is done when no initial value is assigned to the object,
whereas Adjust is done as part of assigning the initial value.
The one exception is the anonymous object created by an @nt{aggregate};
Initialize is not applied to the @nt{aggregate} as a whole,
nor is the value of the @nt<aggregate> adjusted.

@Defn2{Term=[assignment operation], Sec=(list of uses)}
All of the following use the assignment operation,
and thus perform value adjustment:
@begin{Itemize}
the @nt{assignment_statement} (see @RefSecNum{Assignment Statements});

explicit initialization of a stand-alone object
(see @RefSecNum{Object Declarations})
or of a pool element (see @RefSecNum{Allocators});

default initialization of a component of a stand-alone object
or pool element
(in this case, the value of each component is assigned, and therefore adjusted,
but the value of the object as a whole is not adjusted);

function return, when the result type is not a
return-by-reference
type (see @RefSecNum{Return Statements});
(adjustment of the result happens before finalization of
the function;
values of return-by-reference types are not
adjusted);

predefined operators (although the only one that matters is
concatenation; see @RefSecNum{Binary Adding Operators});

generic formal objects of mode @key{in}
(see @RefSecNum{Formal Objects});
these are defined in terms of @nt{constant_declaration}s; and

@nt{aggregate}s (see @RefSecNum{Aggregates})
(in this case, the value of each component, and the parent part, for an
@nt{extension_aggregate}, is assigned, and therefore adjusted,
but the value of the @nt{aggregate} as a whole is not adjusted;
neither is Initialize called);
@end{Itemize}

The following also use the assignment operation,
but adjustment never does anything interesting in these cases:
@begin{Itemize}
By-copy parameter passing uses the assignment operation
(see @RefSecNum{Parameter Associations}),
but controlled objects are always passed by reference,
so the assignment operation never does anything interesting in
this case.
If we were to allow by-copy parameter passing for controlled objects,
we would need to make sure that the actual is finalized before doing
the copy back for [@key{in}] @key{out} parameters.
The finalization of the parameter itself needs to happen
after the copy back (if any),
similar to the finalization of an anonymous function return
object or @nt{aggregate} object.

@key{For} loops use the assignment operation
(see @RefSecNum{Loop Statements}), but since the type
of the loop parameter is never controlled,
nothing interesting happens there, either.
@end{Itemize}

Because Controlled and Limited_Controlled
are library-level tagged types,
all controlled types will be library-level types,
because of the accessibility rules
(see @RefSecNum{Operations of Access Types} and @RefSecNum{Type Extensions}).
This ensures that the Finalize operations may be applied without
providing any ``display'' or ``static-link.''
This simplifies finalization as a result of garbage collection,
abort, and asynchronous transfer of control.

Finalization of the parts of a protected object are not done as
protected actions.
It is possible (in pathological cases)
to create tasks during finalization that
access these parts in parallel with the finalization itself.
This is an erroneous use of shared variables.
@end{Discussion}
@begin{ImplNote}
One implementation technique for finalization is to chain the
controlled objects together on a per-task list.
When leaving a master, the list can be walked up to a marked place.
The links needed to implement the list can be declared (privately)
in types Controlled and Limited_Controlled,
so they will be inherited by all controlled types.

Another implementation technique, which we refer to as the ``PC-map''
approach essentially implies inserting exception handlers at various
places, and finalizing objects based on where the exception was
raised.

@Defn{PC-map approach to finalization}
@Defn{program-counter-map approach to finalization}
The PC-map approach is for the compiler/linker to create a map of
code addresses; when an exception is raised, or abort occurs,
the map can be consulted to see where the task was executing,
and what finalization needs to be performed.
This approach was given in the Ada 83 Rationale as a
possible implementation strategy for exception handling @em the
map is consulted to determine which exception handler applies.

If the PC-map approach is used, the implementation must take care in the
case of arrays.  The generated code will generally contain a loop to
initialize an array.  If an exception is raised part way through the
array, the components that have been initialized must be finalized,
and the others must not be finalized.

It is our intention that both of these implementation methods should
be possible.
@end{ImplNote}
@end{NotesNotes}

@begin{DiffWord83}
Finalization depends on the concepts of completion and leaving,
and on the concept of a master.
Therefore, we have moved the definitions of these concepts here,
from where they used to be in Section 9.
These concepts also needed to be generalized somewhat.
Task waiting is closely related to user-defined finalization;
the rules here refer to the task-waiting rules of Section 9.
@end{DiffWord83}
