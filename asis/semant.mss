@Part(ids, root="asis.msm")
@comment{$Source: e:\\cvsroot/ARM/ASIS/semant.mss,v $}
@comment{$Revision: 1.12 $ $Date: 2010/04/09 07:02:39 $}

@LabeledAddedSection{Version=[2],Name=[ASIS Semantic Subsystem]}

@LabeledAddedClause{Version=[2],Name=[Introduction for ASIS Semantic Subsystem]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[The ASIS Semantic
Subsystem@Defn{semantic subsystem}@Defn2{Term=[subsystem],Sec=[semantic]}
comprises a set of
packages that provide a semantic-level interface to the program library. Other
parts of ASIS are based on Elements that represent syntactic constructs. The
Semantic Subsystem defines a set of types that represent views of entities
defined by syntactic constructs (see 3.1(7) in the Ada Standard). The type
View is the most general, representing
a view of essentially any kind of program entity. There are seven first-level
extensions of View defined: Subtype_View, Object_View, Callable_View,
Package_View, Generic_View, Statement_View, and Exception_View.
Elementary_Subtype and Composite_Subtype are extensions of Subtype_View, and
there are further extensions for particular subcategories of types.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[In general, a View represents a view of a program
entity that can be denoted by a Name, and each extension of View corresponds to
a different sort of program entity. In addition, every Expression is said to
denote a View (in particular an Object_View), even if the Expression is not
syntactically a name. Finally, any subtype, whether named or anonymous, is
represented by a Subtype_View.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Object_View is used to represent a view that might
denote either an object or a pure value. Callable_View is used to represent
entries, accept statements, and all forms of subprograms including enumeration
literals and predefined operators. A Package_View is used to
represent either the full view or the limited view of a package. Generic_View,
Statement_View, and Exception_View are used to represent generic units,
statements, and exceptions, respectively.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Statement_Views are used for representing labels
or named statements, and are returned from Corresponding_View when given a Name
that corresponds to a statement_identifier (see 5.1(12) in the Ada Standard).
Statement_Views are not provided for unnamed, unlabeled statements.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[In addition to View and its various extensions, the
Semantic Subsystem includes a type View_Declaration used to represent the
declaration of a View. These are grouped into Region_Parts, which in turn are
grouped into Declarative_Regions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[There are various operations for navigating back and
forth between the Semantic Subsystem and other parts of ASIS. When starting from
the Semantic Subsystem, given a View_Declaration, there is an operation that
identifies the corresponding Asis.Declaration and one that identifies the
associated Asis.Identifier. Given a View, there is an operation that identifies
the Asis.Expression that denotes it, if any. Given a Declarative_Region, there
is an operation that identifies the Asis.Element that defines it, if any.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[When starting from an Asis.Element, there is an
operation that given an Asis.Declaration can identify the corresponding
View_Declaration, one that given an Asis.Type_Definition can identify the
corresponding Subtype_View, and one that given an Asis.Expression can identify
the corresponding Object_View (or more generally "View" in the case where the
Expression is a Name).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The generic packages Containers.Vectors and
Containers.Indefinite_Holders are instantiated as needed for various types used in
the ASIS Semantic Subsystem. These instantiations permit more convenient
manipulation of objects of a class-wide type, allowing for extensible lists and
more easily updatable variables, despite the fact that class-wide types are
indefinite, and normally require initialization at the point of declaration.]}

@begin{Notes}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The semantic subsystem does not include a value that
represents no view. Such a value would be difficult to define for an interface
type (which allows no objects), and it is not needed for the intended use of the
views. A holder container in the empty state can mean "no view" if the program
requires that functionality.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Exception ASIS_Not_In_Context is raised for any
operation defined in the packages of the semantic subsystem, if the result is an
entity that is not part of the current context (see Section 5). An entity could
not be present in the current context because, for instance, if the View is of
an incomplete view, and the full view is not included in the context. It also
can happen if only a portion of the semantic dependencies of the queried unit is
included in the context, and the query returns an entity defined in one of the
semantic dependencies that is not included in the context.]}
@end{Notes}

@begin{ImplNote}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The ASIS semantic subsystem is intended to be
implemented on top of the internal representation used by the semantic analysis
part of the Ada implementation. This typically consists of an annotated abstract
syntax tree, with a symbol table that either exists along side the annotated
tree, or is interwoven through it. The internal representation may be built up
"on the fly" while the ASIS-based tool is executing, or may be a persistent,
disk-based representation (such as the typical implementation of the DIANA
intermediate representation).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[One of the challenges of the ASIS interface is that
an ASIS-based tool may store the result from a call on an ASIS operation
indefinitely, while the underlying implementation may be paging in and out parts
of the internal representation. Thus it is presumed that the Ada types used to
represent an ASIS element in the syntactic subsystem, or an ASIS view in the
semantic subsystem, consist of an identifier that remains meaningful
indefinitely, potentially coupled with a shorter-lived "memory pointer" (access
value) that gives more direct access to the associated part of the internal
representation.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[In the syntactic subsystem, there are relatively few
types, with the most important being the Element, and this can map quite
directly to an Ada record object, presumably giving the element kind, and the
conceptual "pointer" to the associated internal representation "node."]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[In the Semantic Subsystem, there is a hierarchy of
interface types at the user level. Underneath, there is still probably a record
object that similarly would have an entity/view kind and a conceptual pointer to
the corresponding symbol table or annotated tree "node." In some cases, the
semantic subsystem may make distinctions or combine information in a view in a
way different from that of the compiler's internal representation. In these
cases, this record object might need to carry additional information, since
there is no single node in the compiler's internal representation that matches
the Semantic Subsystem notion.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[To support the hierarchy of interface types used in
the Semantic Subsystem, this "record object" would be of a (concrete) tagged
type in a parallel hierarchy of non-interface types. This parallel hierarchy
would allow sharing of data structures and operations across the Semantic
Subsystem. Each point in the non-interface type hierarchy would implement the
corresponding type in the interface hierarchy. This allows the "concrete" types
to share as little or as much as desired with each other, while preserving the
"purity" of an interface hierarchy at the user level.]}

@end{ImplNote}



@LabeledAddedClause{Version=[2],Name=[package Asis.Views]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis],Child=[Views]}Asis.Views shall exist. The package
shall provide interfaces equivalent to those described in the following
subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[type View_Kinds and type View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{View_Kinds} @key[is] (
   A_Boolean_Subtype,
   A_Character_Subtype,
   An_Ordinary_Enumeration_Subtype,
   A_Signed_Integer_Subtype,
   A_Modular_Integer_Subtype,
   An_Ordinary_Fixed_Subtype,
   A_Decimal_Fixed_Subtype,
   A_Float_Subtype,
   An_Access_To_Object_Subtype,
   An_Access_To_Subprogram_Subtype,]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[   An_Array_Subtype,
   A_Record_Subtype,
   A_Record_Extension,
   A_Task_Subtype,
   A_Protected_Subtype,
   An_Interface,]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[   A_Private_Subtype,
   A_Private_Extension,]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[   An_Incomplete_Subtype,]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[   A_Standalone_Object,
   A_Formal_Parameter_Object,
   An_Object_Renaming,
   A_Designated_Object,
   A_Component_Object,
   An_Attribute_Object,
   An_Aggregate_Object,
   A_Function_Result_Object,
   A_Named_Number,
   An_Attribute_Value,
   An_Expression_Value,]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[   A_Noninstance_Subprogram,
   A_Subprogram_Instance,
   A_Subprogram_Renaming,
   A_Protected_Subprogram,
   An_Imported_Subprogram,
   An_Attribute_Subprogram,
   An_Intrinsic_Subprogram,
   A_Designated_Subprogram,
   A_Protected_Entry,
   A_Task_Entry,]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[   A_Noninstance_Package,
   A_Package_Instance,
   A_Package_Renaming,
   A_Limited_Package_View,]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[   A_Generic_Package,
   A_Generic_Package_Renaming,
   A_Generic_Subprogram,
   A_Generic_Subprogram_Renaming,]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[   An_Exception,
   An_Exception_Renaming,]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[   A_Label_Statement_View,
   A_Block_Statement_View,
   A_Loop_Statement_View);]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[subtype] @AdaSubtypeDefn{Name=[Subtype_View_Kinds],Of=[View_Kinds]} @key[is] View_Kinds
   @key[range] A_Boolean_Subtype .. An_Incomplete_Subtype;]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[subtype] @AdaSubtypeDefn{Name=[Object_View_Kinds],Of=[View_Kinds]} @key[is] View_Kinds
   @key[range] A_Standalone_Object .. An_Expression_Value;]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[subtype] @AdaSubtypeDefn{Name=[Callable_View_Kinds],Of=[View_Kinds]} @key[is] View_Kinds
   @key[range] A_Noninstance_Subprogram .. A_Task_Entry;]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[subtype] @AdaSubtypeDefn{Name=[Package_View_Kinds],Of=[View_Kinds]} @key[is] View_Kinds @key[range]
   A_Noninstance_Package..A_Limited_Package_View;]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[subtype] @AdaSubtypeDefn{Name=[Generic_View_Kinds],Of=[View_Kinds]} @key[is] View_Kinds
   @key[range] A_Generic_Package .. A_Generic_Subprogram_Renaming;]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[subtype] @AdaSubtypeDefn{Name=[Exception_View_Kinds],Of=[View_Kinds]} @key[is] View_Kinds
   @key[range] An_Exception .. An_Exception_Renaming;]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[subtype] @AdaSubtypeDefn{Name=[Statement_View_Kinds],Of=[View_Kinds]} @key[is] View_Kinds @key[range]
   A_Label_Statement_View .. A_Loop_Statement_View;]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{View} @key[is interface];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The tagged type View is the root of a hierarchy of types used to represent
views on program entities. The distinct kinds of entities are enumerated
by the type View_Kind. Subranges of this enumeration type are defined to
correspond to the extensions of the View type.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Kind} (V : View) @key[return] View_Kinds @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Subtype} (V : View'Class) @key[return] Boolean;]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Object_Or_Value} (V : View'Class) @key[return] Boolean;]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Callable} (V : View'Class) @key[return] Boolean;]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Package} (V : View'Class) @key[return] Boolean;]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Generic} (V : View'Class) @key[return] Boolean;]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Exception} (V : View'Class) @key[return] Boolean;]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Statement} (V : View'Class) @key[return] Boolean;]}

@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[V specifies the view to query for each of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The View_Kind of an object V whose type is covered
by View'Class may be determined by the Kind dispatching operation. In addition,
Boolean queries Is_Object_Or_Value, Is_Callable, Is_Subtype, Is_Package,
Is_Generic, Is_Exception, and Is_Statement, are provided to determine to which
extension of View the specified view V belongs. For example, @exam{Is_Callable(V)}
is equivalent to @exam{V @key[in] Callable_View'Class}.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[The "=" operator is defined for View and its
descendants. For views A and B, "A = B" returns True if A and B are both
produced by calls on Corresponding_View applied to the same Element (as
determined by Is_Identical). Similarly, "A = B" returns True if A and B are both
produced by calls on Corresponding_Subtype_View applied to the same Element. "A
= B" returns False if any ASIS query defined for A and B would return results
that are not equal when applied to A and B. It is unspecified whether "A = B"
returns True if A and B produce identical results from all ASIS queries, but A
and B were produced from distinct Elements or a distinct sequence of ASIS
queries.]}


@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Statically_Specified} (V : View) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[V specifies the view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Type=[Leading],Text=[Is_Statically_Specified returns True if:]}

@begin{Itemize}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[the view V is of a static expression, or]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[the view V statically denotes an entity, or]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[the view V is of an indexed component, all indexing
expressions are static expressions, and Is_Statically_Specified returns true for
its prefix, or]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[the view V is of a slice whose discrete range is
static, and Is_Statically_Specified returns true for its prefix, or]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[the view V is a selected component (other than an
expanded name) and Is_Statically_Specified returns true for its prefix, or]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[the view V is of a renaming declaration, and
Is_Statically_Specified returns true for the renamed entity.]}
@end{Itemize}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Is_Statically_Specified returns False otherwise.]}

@begin{Ramification}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0062-1]}
  @ChgAdded{Version=[2],Text=[If V is a view of a value and
  Is_Statically_Specified(V) returns True, then one of Is_Static_Discrete,
  Is_Static_Real, or Is_Static_String returns True.]}
@end{Ramification}


@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Are_Views_Of_Same_Entity} (V1, V2 : View'Class) @key[return] Boolean;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[V1 and V2 specify the views to compare.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Type=[Leading],Text=[Are_Views_Of_Same_Entity returns
True if V1 = V2, or Is_Statically_Specified(V1) returns True,
Is_Statically_Specified(V2) returns True, and:]}

@begin{Itemize}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[V1 and V2 are views of static expressions with the
same value, or]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[V1 and V2 statically denote the same entity, or]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[V1 and V2 are views of indexed components, all
indexing expressions have the same static value for matching positions, and
Are_Views_Of_Same_Entity returns true for the respective prefixes of V1 and V2,
or]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[V1 and V2 are views of slices whose discrete ranges
statically match, and Are_Views_Of_Same_Entity returns true for the respective
prefixes of V1 and V2, or]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[V1 and V2 are views of selected components (other
than expanded names), the selectors are the same, and Are_Views_Of_Same_Entity
returns true for the respective prefixes of V1 and V2, or]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[V1 is a view of a renaming declaration, VR1 is the
renamed view, and Are_Views_Of_Same_Entity(VR1, V2) returns True, or]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[V2 is a view of a renaming declaration, VR2 is the
renamed view, and Are_Views_Of_Same_Entity(V1, VR2) returns True.]}
@end{Itemize}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Are_Views_Of_Same_Entity returns False otherwise.]}

@begin{Discussion}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0062-1]}
  @ChgAdded{Version=[2],Text=[Are_Views_Of_Same_Entity refers to the entity, going
  through renamings used to denote the entity. The properties of each view may
  differ however (like one being a variable view, and the other one a constant
  view).]}
@end{Discussion}
@end{DescribeCode}



@LabeledAddedSubClause{Version=[2],Name=[function Element_Denoting_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Element_Denoting_View} (V : View) @key[return] Asis.Element @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[V specifies the view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Returns an Asis.Element that denotes (or defines)
the View V, with Element_Kinds of either An_Expression, or A_Definition with
Definition_Kinds A_Type_Definition or A_Subtype_Indication. Calling
Corresponding_View or Corresponding_Subtype_View, as appropriate, on the
returned Asis.Element, will return a View equivalent to the given View. In the
case of an expanded name, returns an Asis.Element representing the simple name
(An_Identifier, An_Operator_Symbol, A_Character_Literal), rather than
A_Selected_Component. Returns Nil_Element if there is no Asis.Element associated
with the View.]}
@end{DescribeCode}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[This is one of the primary mechanisms for navigating
from the Semantic Subsystem to the other parts of ASIS. This is the element that
includes the syntactic construct that caused the particular usage represented by
the view. This is not the definition of the view unless the view is of a
subtype.]}
@end{SingleNote}

@begin{Examples}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Type=[Leading],Keepnext=[T],Text=[For instance, in the
following program fragment:]}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[declare]
   Var : Boolean := Func; -- @examcom[(1)]
@key[begin]
   @key[loop]
      @key[exit when] Var; -- @examcom[(2)]
      ...]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0057-1]}
@ChgAdded{Version=[2],Text=[If V is a view representing the use of Var in the
exit statement at (2), the element returned by Element_Denoting_View is the one
in the exit statement, and not the one in the declaration at (1). In particular,
if E is the element representing the exit statement, then Exit_Condition (E) =
Element_Denoting_View (V).]}
@end{Examples}


@LabeledAddedSubClause{Version=[2],Name=[type Conventions]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Conventions} is (
   Intrinsic_Convention,
   Ada_Convention,
   Protected_Convention,
   Entry_Convention,
   Other_Convention,
   Unspecified_Convention);]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Convention} (V : View) @key[return] Conventions @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Convention_Identifier} (V : View) @key[return] Wide_String @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[V specifies the view to query for both of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Each program entity can have an associated
convention (see 6.3.1(2) in the Ada Standard). The convention of the entity
identified by the view V is given by the functions Convention and
Convention_Identifier. Function
Convention_Identifier returns "Intrinsic", "Ada", "Protected", or "Entry" when
function Convention returns the corresponding value of type Conventions. When
Convention returns Other_Convention, Convention_Identifier returns the
convention identifier given in the pragma Convention, Import, or Export used to
specify the convention of the entity; the case of the result of this function is
implemention-defined, but returning results in the same case as was used in the
original compilation text is preferred. When Convention returns
Unspecified_Convention, Convention_Identifier returns the null string.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[subpackage Declarative_Regions]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[The subpackage @AdaPackDefn{Declarative_Regions}
within package Views provides semantic
information about the declaration, if any, associated with a given view
of an entity (see 3.1(7) in the Ada Standard). This includes the identifier
introduced by the declaration to denote the view, as well as indicating the
particular part of the declarative region in which the declaration occurred
(see 8.1 in the Ada Standard). The subpackage has the contents given in the
subclauses @RefSecNum{type Declarative_Region and type View_Declaration} through
@RefSecNum{View Declaration Vectors}.]}


@LabeledAddedSubClause{Version=[2],Name=[type Declarative_Region and type View_Declaration]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Declarative_Region} @key[is private];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{View_Declaration} @key[is interface];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[A View_Declaration specifies the declaration, if
any, that defines a given view and associates a name with it (see 3.1(5) in the
Ada Standard). Some views are defined by constructs without an associated name.
Such (anonymous) views will not have their own View_Declaration, though they may
be defined within a declaration for an outer entity (see
Is_Defined_In_Declaration in @RefSecNum{Views and Declarations}).
A Declarative_Region represents a
declarative region in which declarations may occur (see 8.1(1) in the Ada
Standard).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Two View_Declarations are "=" if they correspond to
the same Defining_Name Element, as determined by Is_Identical. Two
View_Declarations are not "=" if they correspond to different Defining_Name
Elements, as determined by Is_Equal. It is not specified whether two
View_Declarations are "=" if the corresponding Defining_Name Elements are
"Is_Equal" but not "Is_Identical". Corresponding rules apply to "=" for
Declarative_Region, as determined by Is_Identical and Is_Equal applied to the
Element associated with the corresponding declarative region.]}


@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Defined_View} (D : View_Declaration) @key[return] View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Element_for_View_Declaration} (D : View_Declaration)
   @key[return] Asis.Declaration @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{View_Defining_Name} (D : View_Declaration)
   @key[return] Asis.Defining_Name @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Imported} (D : View_Declaration) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Enclosing_Region} (D : View_Declaration)
   @key[return] Declarative_Region @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[D specifies the view declaration to query for each of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Defined_View returns the View defined by
declaration D. If a declaration defines multiple views because the list of
Identifiers has more than one element, then a separate View_Declaration is
associated with each view, just as though they were defined by separate
declarations. In the case of an object declaration that includes the definition
of an anonymous type or a non-first subtype, Defined_View returns an
Object_View, not a Subtype_View. Views returned by Defined_View, other than
Subtype_Views, do not have an associated usage name Asis.Element, meaning that
Element_Denoting_View will return Nil_Element.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Element_for_View_Declaration returns the
Asis.Declaration corresponding to the declaration D.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function View_Defining_Name returns the
Asis.Defining_Name introduced by the declaration D. For most declarations,
View_Defining_Name returns an identifier, but it can also return an operator
symbol, a character literal (for an enumeration value), or an expanded name (for
a child unit).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Is_Imported returns True if and only
if the declaration D is completed with a pragma Import.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Enclosing_Region returns the
Declarative_Region immediately enclosing the declaration D (see 8.1(13) in
the Ada Standard).]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Are_Declared_In_Same_Region} (Decl1, Decl2 : View_Declaration)
   @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Decl1 and Decl2 specify the view declarations to compare.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns True if Enclosing_Region (Decl1) and
Enclosing_Region (Decl2) represent the same region, and returns False
otherwise.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Declared_Earlier_In_Same_Region} (Earlier, Later : View_Declaration)
   @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Earlier and Later specify the view declarations to compare.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns True if Are_Declared_In_Same_Region
(Earlier, Later) is True and Earlier occurs before Later in the logical sequence
of the program, where a package specification is presumed to occur before the
corresponding package body in this sequence. Otherwise returns False.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[type Region_Part and type Region_Part_Kinds]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Region_Part} @key[is private];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Region_Part_List} @key[is array] (Positive @key[range] <>) @key[of] Region_Part;]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Region_Part_Kinds} @key[is] (
   Generic_Formal_Part,
   Callable_Formal_Part,
   Discriminant_Part,
   Entry_Family_Index_Part,
   Record_Part,
   Extension_Part,
   Package_Visible_Part,
   Package_Private_Part,
   Task_Visible_Part,
   Task_Private_Part,
   Protected_Visible_Part,
   Protected_Private_Part,
   Body_Part,
   Block_Declarative_Part,
   Loop_Declarative_Part,
   Public_Child_Part,
   Private_Child_Part);]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Certain declarative regions are broken up into
distinct parts, represented by the type Region_Part. The type Region_Part_Kinds
enumerates the distinct kinds of region parts (see 8.2(5-9) in the Ada
Standard).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Callable_Formal_Part is the formal part of the
region defined by a subprogram, entry, or accept statement. For a record type,
Record_Part includes the non-discriminant components. For a record extension,
the Extension_Part includes the components declared in the
record_extension_part, and the Record_Part includes the other non-discriminant
components. Public_Child_Part includes the public children of a library unit.
Private_Child_Part includes the private children of a library unit. The
Public_Child_Part and the Private_Child_Part might not include child
units that are unreferenced by the units within the current context.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[The @i<visible* parts>@Defn{Visible part} of a
declarative region are those parts containing declarations that are visible
outside the immediate scope of the region. As an example, for
a type this could include a Discriminant_Part, a Record_Part, an Extension_Part,
a Task_Visible_Part, and a Protected_Visible_Part. For a generic unit, this
could include a Generic_Formal_Part, a Callable_Formal_Part, a
Package_Visible_Part, and a Public_Child_Part.]}

@begin{Ramification}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[The Callable_Formal_Part is a visible part; it
is the profile minus the return type (if any).]}
@end{Ramification}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Kind} (P : Region_Part) @key[return] Region_Part_Kinds;]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Empty} (P : Region_Part) @key[return] Boolean;]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Declarative_Items} (P : Region_Part)
   @key[return] Asis.Declarative_Item_List;]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[procedure] @AdaSubDefn{Declarations} (P : Region_Part;
   Declarations : @key[out] View_Declaration_Vector'Class);]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Region} (P : Region_Part) @key[return] Declarative_Region;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the region part to query for each of these subprograms.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Kind returns the kind of the
region part P. Function Is_Empty returns True if and only if the
region part P has no declarative items within it. Function
Declarative_Items returns the list of Asis.Declarative_Items that occur
within the region part P. Procedure Declarations returns in the
parameter Declarations a vector comprising the declarations that occur
within the region part P. Function Region returns the Declarative_Region
of which the region part P is a part.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{All_Region_Parts} (R : Declarative_Region)
   @key[return] Region_Part_List;]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Visible_Region_Parts} (R : Declarative_Region)
   @key[return] Region_Part_List;]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Private_Part} (R : Declarative_Region)
   @key[return] Region_Part;]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Body_Part} (R : Declarative_Region)
   @key[return] Region_Part;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[R specifies the declarative region to query for each of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function All_Region_Parts returns an array of the region parts comprising
the declarative region R. Function Visible_Region_Parts returns an
array of the visible parts of the declarative region R.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Private_Part returns the private part of the declarative region R.
Private_Part returns an empty Region_Part if R has no private part, or if
the private part of R is empty. Function Body_Part returns the body part
of the declarative region R. Body_Part returns an empty Region_Part if R
has no body part, or if the body part of R is empty. The declarative region
of a loop statement or of a block statement has only a body part.
Other kinds of regions may have multiple region parts.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Enclosing_Region_Part} (D : View_Declaration)
   @key[return] Region_Part @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[D specifies the view declaration to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns the Region_Part in which the declaration D occurs.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Nested Declarative Regions]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Element_Defining_Region} (R : Declarative_Region)
   @key[return] Asis.Element;]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Defining_Declaration} (R : Declarative_Region) @key[return] Boolean;]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Defining_Declaration} (R : Declarative_Region)
   @key[return] View_Declaration'Class;]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Enclosing_Region} (R : Declarative_Region) @key[return] Boolean;]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Enclosing_Region} (R : Declarative_Region)
   @key[return] Declarative_Region;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[R specifies the declarative region to query for each of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Declarative regions are generally associated with
language constructs, and may be nested (see 8.1 in the Ada Standard). Function
Element_Defining_Region returns the Asis.Element for the construct that defines
the declarative region R.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Has_Defining_Declaration returns True if
and only if the declarative region R is associated with an enclosing
declaration. Function Defining_Declaration returns the declaration that defines
the region R. Defining_Declaration raises ASIS_Inappropriate_View if
Has_Defining_Declaration (R) returns False.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Has_Enclosing_Region returns True if and
only the region R has an enclosing region. Function Enclosing_Region returns the
enclosing region of region R, or raises ASIS_Inappropriate_View if
Has_Enclosing_Region (R) returns False.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Enclosing_Compilation_Unit} (D : View_Declaration)
   @key[return] Asis.Compilation_Unit @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Expanded_Name} (D : View_Declaration)
   @key[return] Wide_String @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[D specifies the view declaration to query for each
of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Enclosing_Compilation_Unit returns the
Asis.Compilation_Unit representing the compilation unit in which the declaration
D occurs. Function Expanded_Name returns the Wide_String representing the full
expanded name denoting the declaration D (encoded in UTF-16, as described in
@RefSecNum{package Asis}). The result is implementation defined if D is declared
within an unnamed block or loop statement.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Overloading, Overriding, and Renaming]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Overloadable} (D : View_Declaration)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Overriding} (D : View_Declaration)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[procedure] @AdaSubDefn{Overridden_Declarations} (D : View_Declaration;
   Overridden : @key[out] View_Declaration_Vector'Class) @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Renaming} (D : View_Declaration) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Renamed_View} (D : View_Declaration) @key[return] View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Renaming_As_Body} (D : View_Declaration) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[D specifies the view declaration to query for each
of these subprograms.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Declarations may overload, override, or rename views of
other declarations (see 8.3(6-9) and 8.5(3) in the Ada Standard). Function
Is_Overloadable returns True if and only if the
declaration D is a declaration that may be overloaded. Function Is_Overriding
returns True if and only if the declaration D overrides one or more other
declarations. Procedure Overridden_Declarations returns (in the Overridden
parameter) a vector of those declarations overridden by the declaration D.
Overridden will be an empty vector if D does not override any other declaration.
Function Is_Renaming returns True if and only if the declaration D is a renaming
of another view. Function Renamed_View returns the view that the declaration D
is a renaming of, or raises ASIS_Inappropriate_View if Is_Renaming (D) returns
False. Function Is_Renaming_As_Body returns True if and only if the declaration
D is a renaming-as-body.]}
@end{DescribeCode}



@LabeledAddedSubClause{Version=[2],Name=[Aspect Items]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Aspect_Items} (D : View_Declaration)
    @key[return] Asis.Aspect_Clause_List @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[D specifies the view declaration to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Aspect_Items returns a list of aspect
clauses that are visible for the view of the declaration D (see 13.1 in the
Ada Standard).]}
@end{DescribeCode}



@LabeledAddedSubClause{Version=[2],Name=[View Declaration Vectors]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[package] @AdaPackDefn{View_Declaration_Vectors} @key[is]
   @key[new] Ada.Containers.Indefinite_Vectors (Positive, View_Declaration'Class);
@key[type] @AdaTypeDefn{View_Declaration_Vector} @key[is new]
   View_Declaration_Vectors.Vector @key[with null record];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type View_Declaration_Vector allows the declaration
of a list of View_Declarations.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[These are the last interfaces defined in subpackage
Declarative_Regions; following subclauses contain interfaces directly defined in
package Asis.Views.]}
@end{DescribeCode}



@LabeledAddedSubClause{Version=[2],Name=[Views and Declarations]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Declaration} (V : View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Declaration} (V : View)
   @key[return] Declarative_Regions.View_Declaration'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Defined_In_Declaration} (V : View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Declaration_Containing_Definition} (V : View)
   @key[return] Declarative_Regions.View_Declaration'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Defines_Declarative_Region} (V : View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Defined_Region} (V : View)
   @key[return] Declarative_Regions.Declarative_Region @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[V specifies the view to query for all of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Has_Declaration returns True if and only if
view V was defined by a declaration. Has_Declaration returns True for both
explicitly and implicitly declared subprograms. Function Declaration returns the
declaration that defines view V, or raises ASIS_Inappropriate_View if
Has_Declaration (V) returns False.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Is_Defined_In_Declaration returns True if and only
if view V was defined as part of a declaration. Is_Defined_In_Declaration always
returns True given a view of a first subtype, even if the type is anonymous.
Declaration_Containing_Definition returns the declaration that contained the
definition of the view V, or raises ASIS_Inappropriate_View if
Is_Defined_In_Declaration(V) returns False. For the first subtype of an
anonymous type defined as part of an object declaration,
Declaration_Containing_Definition returns the associated object declaration. For
the first subtype of an anonymous type defined as part of the return subtype of
a function declaration, Declaration_Containing_Definition returns the associated
function declaration. If a non-first subtype is defined by a subtype_indication
or discrete_range appearing within a declaration, then Is_Defined_In_Declaration
returns True, and Declaration_Containing_Definition returns the Declaration
containing the subtype definition.]}


@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Defines_Declarative_Region returns
True if and only if view V is of an entity that has its own declarative region
(see 8.1(1) of the Ada Standard). Function Defined_Region returns the
declarative region of the entity represented by view V, or raises
ASIS_Inappropriate_View if Defines_Declarative_Region (V) returns False.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Representational and Operational Aspects]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Language_Defined_Aspect_Kinds} @key[is] (
    Address,
    Alignment,
    Asynchronous,
    Atomic,
    Atomic_Components,
    Bit_Order,
    Coding,
    Component_Size,
    Controlled,
    Convention,
    Discard_Names,
    Exported,
    External_Tag,
    Imported,
    Independent,
    Independent_Components,
    Input,
    Layout,
    No_Return,
    Output,
    Packing,
    Read,
    Size,
    Small,
    Storage_Pool,
    Storage_Size,
    Stream_Size,
    Volatile,
    Volatile_Components,
    Write);]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Aspect_Specified} (V : View;
   Aspect : Language_Defined_Aspect_Kinds) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Aspect_Directly_Specified} (V : View;
   Aspect : Language_Defined_Aspect_Kinds) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[V specifies the view to query and Aspect specifies
the language-defined aspect to query for both of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Aspect_Specified returns True if the
representational or operational aspect Aspect is specified for the declaration
of the view V, and returns False otherwise (see 13.1(17) in the Ada Standard).
Function Is_Aspect_Directly_Specified returns True if the representational or
operational aspect Aspect is directly specified for the declaration of the view
V, and returns False otherwise (see 13.1(8) in the Ada Standard).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[These functions return False if the Aspect named
cannot be specified for the kind of entity represented by V, or if the view V
does not have a declaration.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Implementation_Defined_Aspect_Kinds} @key[is] (@examcom{<implementation-defined>});]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Aspect_Specified} (V : View;
   Aspect : Implementation_Defined_Aspect_Kinds) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Aspect_Directly_Specified} (V : View;
   Aspect : Implementation_Defined_Aspect_Kinds) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type Implementation_Defined_Aspect_Kinds is an
implementation-defined enumeration of aspect names; it should include the names
of all implementation-defined aspects defined by the implementation.
If there are no implementation-defined aspects, it should consist of the single
item None.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[V specifies the view to query and Aspect specifies
the implementation-defined aspect to query for both of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Aspect_Specified returns True if the
representational or operational aspect Aspect is specified for the declaration
of the view V, and returns False otherwise. Function
Is_Aspect_Directly_Specified returns True if the representational or operational
aspect Aspect is directly specified for the declaration of the view V, and
returns False otherwise.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[These functions return False if the Aspect named
cannot be specified for the kind of entity represented by V, or if the view V
does not have a declaration.]}

@end{DescribeCode}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[To find out all of the aspect clauses for an entity,
use function Aspect_Items on the declaration of the entity.]}
@end{SingleNote}



@LabeledAddedSubClause{Version=[2],Name=[View Holders]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[package] @AdaPackDefn{View_Holders} @key[is new]
   Ada.Containers.Indefinite_Holders (View'Class);
@key[type] @AdaTypeDefn{View_Holder} @key[is new] View_Holders.Holder @key[with null record];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type View_Holder allows the declaration of an
uninitialized variable (including a component) that can hold a View.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[View Vectors]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[package] @AdaPackDefn{View_Vectors} @key[is new]
   Ada.Containers.Indefinite_Vectors (Positive, View'Class);
@key[type] @AdaTypeDefn{View_Vector} @key[is new] View_Vectors.Vector @key[with null record];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type View_Vector allows the declaration of a list of
Views.]}
@end{DescribeCode}



@LabeledAddedClause{Version=[2],Name=[package Asis.Subtype_Views]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis],Child=[Subtype_Views]}Asis.Subtype_Views shall exist.
The package shall provide interfaces equivalent to those described in the
following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[type Subtype_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0057-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Subtype_View} @key[is interface and] Views.View;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Subtype_View represents a view of a
subtype.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Elementary} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Composite} (S : Subtype_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Scalar} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Enumeration} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Boolean} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Character} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Numeric} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Discrete} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Integer} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Signed_Integer} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Modular_Integer} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Real} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Fixed_Point} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Ordinary_Fixed_Point} (S : Subtype_View)
   @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Decimal_Fixed_Point} (S : Subtype_View)
   @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Floating_Point} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Access} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Access_To_Object} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Access_To_Subprogram} (S : Subtype_View)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Record} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Record_Extension} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Array} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_String} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Protected} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Task} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Tagged} (S : Subtype_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Formal_Subtype} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Descended_From_Formal_Subtype} (S : Subtype_View)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Constrained} (S : Subtype_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Definite} (S : Subtype_View) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The category and other characteristics of the
subtype can be determined with the above functions. S specifies the view of a
subtype to query for each of these functions.]}
@end{DescribeCode}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[The characteristics of a subtype view depend on the
location of the view; different views of the same subtype can get different
answers from these functions. In particular, these functions respect privacy, so
the characteristics can change depending on the visibility of the full view of
the subtype.]}
@end{SingleNote}


@LabeledAddedSubClause{Version=[2],Name=[Types, Subtypes, and Constraints]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Are_Of_Same_Type} (Left, Right : Subtype_View)
   @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Left and Right specify the views of subtypes to
test.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns True if and only if Left and Right represent
subtypes of the same type.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Unadorned_Subtype} (S : Subtype_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Unadorned_Subtype} (S : Subtype_View)
   @key[return] Subtype_View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_First_Subtype} (S : Subtype_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Secondary_Subtype} (S : Subtype_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{First_Subtype} (S : Subtype_View)
   @key[return] Subtype_View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Constraint} (S : Subtype_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Constraint} (S : Subtype_View)
   @key[return] Asis.Constraint @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[S specifies the view of a subtype to query for each
of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Unadorned_Subtype returns True if the
subtype S is scalar and the base subtype of its type (see 3.5(15) in the
Ada Standard), or the subtype S is tagged
and the first subtype of its type, or the subtype S is neither tagged nor
scalar, and the subtype has no constraint or null exclusion (see 3.2(8-9) in
the Ada Standard). Otherwise, Is_Unadorned_Subtype returns False.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Unadorned_Subtype returns a view of a
subtype without any constraints or null exclusions. Specifically, if the subtype
S is a scalar subtype, Unadorned_Subtype returns a view of the base subtype of
S. If the subtype S is a tagged subtype, Unadorned_Subtype returns the first
subtype of the type of S. If the subtype S is neither tagged nor scalar,
Unadorned_Subtype returns a view of a subtype of the type of S that has no
constraints or null exclusions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_First_Subtype returns True if and only
if the subtype S is the first subtype of its type (see 3.2.1(6) oin the Ada
Standard). Function Is_Secondary_Subtype
(S) is equivalent to not Is_First_Subtype (S). Function First_Subtype returns
the a view of the first subtype for the type of the subtype S. If
Is_First_Subtype (S) is True, First_Subtype returns S.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Has_Constraint returns True if and only if
the subtype S has a constraint (see 3.2(7) in the Ada Standard). Function
Constraint returns the Asis element representing the constraint of the subtype
S, or raises ASIS_Inappropriate_View if Has_Constraint (S) returns False.]}
@end{DescribeCode}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The definition of Unadorned_Subtype corresponds to
the meaning of the italicized T in the Ada Standard. The Ada Standard does not
name this concept.]}
@end{SingleNote}


@LabeledAddedSubClause{Version=[2],Name=[Static Subtypes and Constraints]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Static_Subtype} (S : Subtype_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Statically_Constrained} (S : Subtype_View)
   @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[S specifies the view of a subtype to query for each
of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Static_Subtype returns True if and only
if the subtype S is static (see 4.9(26) in the Ada Standard), and returns False
otherwise.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Statically_Constrained returns True if
and only if the subtype S is constrained and its constraint is static (see
4.9(27-32) in the Ada Standard), and returns False otherwise.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Are_Statically_Matching} (S1, S2 : Subtype_View)
   @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[S1 and S2 specify views of subtypes to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Are_Statically_Matching returns True if and
only if the subtypes S1 and S2 are of the same type and are statically matching
(see 4.9.1(2) in the Ada Standard), and returns False otherwise.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Statically_Compatible} (S : Subtype_View;
   With_Subtype : Subtype_View) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[S and With_Subtype specify views of subtypes to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Is_Statically_Compatible returns True if
and only if the constraint of the subtype S is statically compatible with the
subtype With_Subtype (see 4.9.1(4) in the Ada Standard), and returns False
otherwise.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Derived Types and Primitive Subprograms]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[procedure] @AdaSubDefn{Primitive_Subprograms} (S : Subtype_View;
   Primitives : @key[out] Declarative_Regions.View_Declaration_Vector'Class) @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Derived} (S : Subtype_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Parent_Subtype} (S : Subtype_View)
   @key[return] Subtype_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[S specifies the view of a subtype to query for each
of these subprograms.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Primitive_Subprograms returns in the
parameter Primitives a vector of view declarations for the primitive subprograms of
the type of the subtype S (see 3.2.3(2-7) in the Ada Standard). Function
Is_Derived returns True if and only if the type of the subtype S is defined by a
derived_type_definition, a private_extension_declaration, or a
formal_derived_type_definition. Function Parent_Subtype returns the parent or
ancestor subtype for the derived type S, or raises ASIS_Inappropriate_View if
Is_Derived (S) returns False.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Descendant} (S : Subtype_View; Of_Subtype : Subtype_View)
   @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[S and Of_Subtype specify the views of subtypes to compare.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Descendant returns True if and only if
the type of the subtype S is a descendant of the type of the subtype
Of_Subtype (see 3.4.1(10) in the Ada Standard).]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Ultimate_Ancestors} (S : Subtype_View)
   @key[return] Subtype_Vector @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[S specifies the view of a subtype to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Ultimate_Ancestors returns all of the
ancestors of the subtype S that are not themselves a descendant of any other
type (see 3.4.1(10) in the Ada Standard); the list will just be the type itself
if Is_Derived (S) returns False and Progenitors (S) (see
@RefSecNum{Tagged Subtypes}) returns an empty vector.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Root_Noninterface_Ancestor} (S : Subtype_View)
   @key[return] Subtype_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[S specifies the view of a subtype to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Root_Noninterface_Ancestor raises
Asis_Inappropriate_View if S is composite and Is_Interface (S) (see
@RefSecNum{Tagged Subtypes}) is True. Otherwise, it returns the noninterface
ancestor of the subtype S that is not itself a descendant of any other type; it
will be the type itself if Is_Derived (S) returns False returns False.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Full_View_Root_Noninterface_Ancestor} (S : Subtype_View)
   @key[return] Subtype_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[S specifies the view of a subtype to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Full_View_Root_Noninterface_Ancestor raises
Asis_Inappropriate_View if S is composite and Is_Interface (S) (see
@RefSecNum{Tagged Subtypes}) is True. Otherwise, it returns the full view of the
noninterface ancestor of the subtype S that is not itself a descendant of any
other type.]}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Root_Noninterface_Ancestor may stop on an
incomplete or partial view. If the ultimate full view is needed, call
Full_View_Noninterface_Ancestor instead.]}
@end{SingleNote}
@begin{UsageNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[The Full_View of the Root_Noninterface_Ancestor may be a
derived type; Full_View_Root_Noninterface_Ancestor keeps going until the full
view of an ancestor that has no non-interface ancestor.]}
@end{UsageNote}

@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Incomplete and Partial Views]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Incomplete_View} (S : Subtype_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Complete_View} (S : Subtype_View)
   @key[return] Subtype_View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Partial_View} (S : Subtype_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Full_View} (S : Subtype_View) @key[return] Subtype_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[S specifies the view of a subtype to query for all
of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Incomplete_View returns True if and only
if the type of S is an incomplete view of a type (see 3.10.1 in the Ada Standard).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[If S is an incomplete view, Complete_View returns
a view of the completion of S (see 3.10.1(3) in the Ada Standard). Otherwise,
Complete_View returns S.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Partial_View returns True if and only if
the type of S is a partial view of a type (see 7.3(4) in the Ada Standard).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Full_View returns the full view of S. If S
is already a full view, Full_View returns S.]}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The Full_View of an incomplete type gives the full
view of the completion. This is even true for an incomplete view declared by a
limited view of a private type. However, the Complete_View of such an incomplete
view is the private type.]}
@end{SingleNote}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Representation and Operational Subtype Aspects]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Subtype_Size} (S : Subtype_View) @key[return] ASIS_Natural @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Subtype_Alignment} (S : Subtype_View) @key[return] ASIS_Natural @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[S specifies the view of a subtype to query for both
of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Subtype_Size returns the same value as the
Size attribute of the subtype S, if the subtype is elementary or if
Is_Aspect_Specified (S, Size) returns True. The result is
implementation-defined in other cases, and may be
ASIS_Natural'Last. Function Subtype_Alignment returns the same value as the
Alignment attribute of the subtype S.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Stream_Attribute_Available} (S : Subtype_View;
   Attribute : Views.Language_Defined_Aspect_Kinds) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[S specifies the view of a subtype to query.
Attribute specifies the stream attribute of interest; if it is not
Read, Write, Input, or Output, raises Asis_Inappropriate_View.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Returns True if the specified attribute of the
subtype is available for S (see 13.13.2(39-48) in the Ada Standard),
and False otherwise.]}
@end{DescribeCode}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Stream attribute availability depends on the
location of the subtype view; different views of the same subtype can get
different answers from this function.]}
@end{SingleNote}


@LabeledAddedSubClause{Version=[2],Name=[Subtype Holders]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[package] @AdaPackDefn{Subtype_Holders} @key[is new]
   Ada.Containers.Indefinite_Holders (Subtype_View'Class);
@key[type] @AdaTypeDefn{Subtype_Holder} @key[is new] Subtype_Holders.Holder @key[with null record];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type Subtype_Holder allows the declaration of an
uninitialized variable (including a component) that can hold a Subtype_View.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Subtype Vectors]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[package] @AdaPackDefn{Subtype_Vectors} @key[is new]
   Ada.Containers.Indefinite_Vectors (Positive, Subtype_View'Class);
@key[type] @AdaTypeDefn{Subtype_Vector} @key[is new] Subtype_Vectors.Vector @key[with null record];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type Subtype_Vector allows the declaration of a list
of Subtype_Views.]}
@end{DescribeCode}



@LabeledAddedClause{Version=[2],Name=[package Asis.Subtype_Views.Elementary]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis.Subtype_Views],Child=[Elementary]}Asis.Subtype_Views.Elementary
shall exist. The package shall provide interfaces equivalent to those
described in the following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[Elementary subtypes]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Elementary_Subtype} @key[is interface and] Subtype_View;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Elementary_Subtype represents a view of an
elementary subtype.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Universal} (E : Elementary_Subtype) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[E specifies the Elementary_Subtype to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns True if and only if the type of the given
subtype is universal_integer, universal_real, universal_fixed, or
universal_access. Returns False otherwise.]}
@end{DescribeCode}



@LabeledAddedSubClause{Version=[2],Name=[Scalar subtypes]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Scalar_Subtype} @key[is interface and] Elementary_Subtype;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Scalar_Subtype represents a view of a
scalar subtype.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Base_Subtype} (S : Scalar_Subtype)
   @key[return] Scalar_Subtype'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Low_Bound} (S : Scalar_Subtype)
   @key[return] Object_Views.Object_View'Class @key[is abstract];
@key[function] @AdaSubDefn{High_Bound} (S : Scalar_Subtype)
   @key[return] Object_Views.Object_View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Root_Numeric} (S : Scalar_Subtype) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[S specifies the view of a scalar subtype to query
for each of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Base_Subtype returns a view of the base
subtype of the type of the subtype S (see 3.5(15) in the Ada Standard).
Functions Low_Bound and High_Bound return
a view of the corresponding bound of the scalar subtype S. If the scalar subtype
S is unconstrained, Low_Bound and High_Bound return a view of the corresponding
bound of the base range of the type of the subtype (see 3.5(6) in the Ada
Standard).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Is_Root_Numeric returns True if the type of
S is root_integer or root_real, and returns False otherwise.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Discrete subtypes]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Discrete_Subtype} @key[is interface and] Scalar_Subtype;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Discrete_Subtype represents a view of a
discrete subtype.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Access subtypes]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Access_Subtype} @key[is interface and] Elementary_Subtype;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Access_Subtype represents a view of an
access subtype.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Anonymous_Access} (A : Access_Subtype) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Access_Parameter} (A : Access_Subtype) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Access_Result} (A : Access_Subtype) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Access_Discriminant} (A : Access_Subtype)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Static_Accessibility_Level} (A : Access_Subtype)
   @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Library_Level} (A : Access_Subtype) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Statically_Deeper_Than} (A : Access_Subtype;
   Compared_To : Access_Subtype) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Excludes_Null} (A : Access_Subtype) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[A specifies the view of an access subtype to query
for each of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Is_Anonymous_Access returns True if and
only if the type of the subtype A is defined by an access_definition rather than
an access_type_definition. Function Is_Access_Parameter returns True if and only
if the type of the subtype A is that of an access parameter (see 6.1(24) in the
Ada Standard). Function Is_Access_Result returns True if and only if the type of
the subtype A is the result type of a function with an access result (see 6.1(24)
in the Ada Standard). Function Is_Access_Discriminant returns True if and only
if the type of the subtype A is that of an access discriminant (see 3.7(9) in
the Ada Standard).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Has_Static_Accessibility_Level returns True
if the statically deeper relationship is defined for the accessibility level of
the subtype A (see 3.10.2(17-21) in the Ada Standard). Function Is_Library_Level
returns True if Has_Static_Accessibility_Level (A) is True and the accessibility
level is library level (see 3.10.2(22) in the Ada Standard). Function
Is_Statically_Deeper_Than raises ASIS_Inappropriate_View if
Has_Static_Accessibility_Level returns False for either operand; otherwise it
returns True if and only if the accessibility level of A is statically deeper
than that of the subtype Compared_To (see 3.10.2(17-21) in the Ada Standard).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Excludes_Null returns True if and only
if the subtype A excludes null (see 3.10(13.1) in the Ada Standard).]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Access-to-object subtypes]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Access_To_Object_Subtype} @key[is interface and] Access_Subtype;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Access_To_Object_Subtype represents a view
of an access-to-object subtype.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Designated_Subtype} (A : Access_To_Object_Subtype)
   @key[return] Subtype_View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Access_To_Constant} (A : Access_To_Object_Subtype)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Pool_Specific} (A : Access_To_Object_Subtype)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Storage_Pool} (A : Access_To_Object_Subtype)
   @key[return] Object_Views.Object_View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Storage_Size} (A : Access_To_Object_Subtype)
   @key[return] Object_Views.Object_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[A specifies the Access_To_Object_Subtype to query
for each of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Designated_Subtype returns a view of the
designated subtype of the access-to-object subtype A. Function
Is_Access_To_Constant returns True if and only if the type of the subtype A is
an access-to-constant type. Function Is_Pool_Specific returns True if and only
if the type of the subtype A is pool specific.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Storage_Pool returns a view of the object
denoted by the Storage_Pool attribute of the type of the subtype A, if
Is_Aspect_Specified (A, Storage_Pool) returns True. The result is
implementation-defined in other cases.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Storage_Size returns a view of a value
equal to the Storage_Size of the type of the subtype A, if the type is defined
to have zero Storage_Size, or if Is_Aspect_Specified (A, Storage_Size) returns
True. The result is implementation-defined in other cases.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Access-to-subprogram subtypes]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Access_To_Subprogram_Subtype} @key[is interface and] Access_Subtype;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Access_To_Subprogram_Subtype represents a
view of an access-to-subprogram subtype.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Designated_Profile} (A : Access_To_Subprogram_Subtype)
   @key[return] Profiles.Profile @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[A specifies the view of an access-to-subprogram subtype to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns a view of the designated profile of the type of the subtype A.]}
@end{DescribeCode}



@LabeledAddedClause{Version=[2],Name=[package Asis.Subtype_Views.Composite]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis.Subtype_Views],Child=[Composite]}Asis.Subtype_Views.Composite
shall exist. The package shall provide interfaces equivalent to those
described in the following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[Composite Subtypes]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Composite_Subtype} @key[is interface and] Subtype_View;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Composite_Subtype represents a view of a
composite subtype.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Limited} (C : Composite_Subtype) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Task_Part} (C : Composite_Subtype) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Needs_Finalization} (C : Composite_Subtype)
  @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Preelaborable_Initialization} (C : Composite_Subtype)
  @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Unknown_Discriminants} (C : Composite_Subtype)
  @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Known_Discriminants} (C : Composite_Subtype)
  @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Discriminants} (C : Composite_Subtype)
  @key[return] Views.Declarative_Regions.Region_Part @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Discriminants_Have_Defaults} (C : Composite_Subtype)
  @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Nondiscriminant_Region_Parts} (C : Composite_Subtype)
  @key[return] Views.Declarative_Regions.Region_Part_List @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[C specifies the view of a composite subtype to query
for each of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Is_Limited returns True if and only if the
view of the subtype C is limited (see 7.5(3-7) in the Ada Standard).
Function Has_Task_Part returns True if and
only if the type of the subtype C has a part (see 3.2(6) in the Ada Standard)
that is of a task type (whether visibly or only in the full definition). If
subtype C is a class-wide
subtype S'Class, then returns Has_Task_Part(S). Function Needs_Finalization
returns True if and only if the type of the subtype C needs finalization
(see 7.6(9.1-9.5) in the Ada Standard).
Function Has_Preelaborable_Initialization returns True if and only if the
subtype C has preelaborable initialization (see 10.2.1(11.1-11.8) in the
Ada Standard).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Has_Unknown_Discriminants returns True if
and only if the subtype C has unknown discriminants (see 3.7(26) in the Ada
Standard). Function Has_Known_Discriminants returns True if and only if the
subtype C has known discriminants (see 3.7(26) in the Ada Standard). Function
Discriminants returns a Region_Part for the discriminant
part of the subtype C, or raises ASIS_Inappropriate_View if the subtype view
does not have known discriminants. Function Discriminants_Have_Defaults returns
True if and only if the subtype C has known discriminants with
default_expressions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function
Nondiscriminant_Region_Parts returns a list of Region_Parts, one for each
separate visible region part, each comprising components, entries, and protected
subprograms from the list of components or items from the declaration
of some ancestor of subtype C. The returned list is empty if subtype C is not a
descendant of a record type, a record extension, a task type, or a protected
type.]}

@begin{Discussion}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[There is one part for each record or extension,
even if the record or extension is null (empty).]}
@end{Discussion}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Array Subtypes]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Array_Subtype} @key[is interface and] Composite_Subtype;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Array_Subtype represents a view of an array
subtype.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Component_Subtype} (A : Array_Subtype)
   @key[return] Subtype_View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Num_Dimensions} (A : Array_Subtype) @key[return] Positive @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Index_Subtype} (A : Array_Subtype; Dimension : Positive := 1)
   @key[return] Elementary.Discrete_Subtype'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_String_Subtype} (A : Array_Subtype) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[A specifies the view of an array subtype to query
for each of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Component_Subtype returns a view of the
component subtype of the type of the array subtype A. Function Num_Dimensions
returns a count of the number of dimensions of the type of the array subtype A.
Function Index_Subtype returns a view of the Dimension-th index subtype of the
type of the array subtype A, or raises ASIS_Inappropriate_View if Dimension is
greater than Num_Dimensions(A). Function Is_String_Subtype returns True if and
only if the type of the subtype A is a string type.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Tagged Subtypes]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Tagged_Subtype} @key[is interface and] Composite_Subtype;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Tagged_Subtype represents a view of a
tagged subtype.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Interface} (T : Tagged_Subtype) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Abstract} (T : Tagged_Subtype) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Synchronized_Tagged} (T : Tagged_Subtype)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Classwide} (T : Tagged_Subtype) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Root_Subtype} (T : Tagged_Subtype)
  @key[return] Tagged_Subtype'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Specific} (T : Tagged_Subtype) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Classwide_Subtype} (T : Tagged_Subtype)
  @key[return] Tagged_Subtype'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[procedure] @AdaSubDefn{Progenitors} (
  T : Tagged_Subtype;
  Progenitors : @key[out] Tagged_Subtype_Vector'Class) @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{External_Tag} (T : Tagged_Subtype) @key[return] String @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[T specifies the view of a tagged subtype to query
for each of these subprograms.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Interface returns True if and only if
the type of the subtype T is an interface. Function Is_Abstract returns True if
and only if the type of the subtype T is abstract. Function
Is_Synchronized_Tagged returns True if and only if the type of the subtype T is
a synchronized tagged type (see 3.9.4(6) in the Ada Standard).
Function Is_Classwide returns True if and only if
the type of the subtype T is classwide.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Root_Subtype returns a view of a specific
subtype @I{S} that is the root of the class T (that is, @I{S}'Class = T),
or raises ASIS_Inappropriate_View if the type of the
subtype T is not classwide. Function Is_Specific returns True if and only if the
type of the subtype T is a specific tagged type (see 3.4.1(3) in the Ada Standard).
Function Classwide_Subtype
returns a view of the classwide subtype rooted at the subtype T, equivalent to
the Class attribute of the subtype T, or raises ASIS_Inappropriate_View if the
subtype T is not a specific tagged subtype. Function Progenitors returns a
vector of the progenitors, if any, of the type of the subtype T (see 3.9.4(9) in
the Ada Standard). The result is
an empty vector if the type has no progenitors. Function External_Tag returns a
view of the string value equal to the External_Tag of the type of the subtype T,
if External_Tag is specified. Otherwise, the result is implementation-defined.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Tagged Subtype Vectors]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[package] @AdaPackDefn{Tagged_Subtype_Vectors} @key[is new]
   Ada.Containers.Indefinite_Vectors (Positive, Tagged_Subtype'Class);
@key[type] @AdaTypeDefn{Tagged_Subtype_Vector} @key[is new]
   Tagged_Subtype_Vectors.Vector @key[with null record];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type Tagged_Subtype_Vector allows the declaration of
a list of Tagged_Subtypes.]}
@end{DescribeCode}



@LabeledAddedClause{Version=[2],Name=[package Asis.Object_Views]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis],Child=[Object_Views]}Asis.Object_Views shall exist.
The package shall provide interfaces equivalent to those described in the
following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[type Object_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0057-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Object_View} @key[is interface and] Views.View;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Object_View represents views of objects and
values, as denoted by names or expressions.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Constant_View} (O : Object_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Formal_Object} (O : Object_View)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Nominal_Subtype} (O : Object_View)
   @key[return] Subtype_Views.Subtype_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[O specifies the view of an object to query for all
of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Is_Constant_View returns True if and only
if the object O is a constant view of an object, or is a view of a value.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Is_Formal_Object returns True if and only
if the object O denotes a generic formal object.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Nominal_Subtype returns the nominal subtype
of the view (see 3.3(23 and 3.3.1(8) in the Ada Standard). The returned
Subtype_View corresponds to the subtype_indication, subtype_mark with a
null_exclusion, discrete_range, or type definition that defined the nominal
subtype of the object or value. The nominal subtype of a numeric literal or
named number is a view of the corresponding universal base subtype. The nominal
subtype of a use of an operator is that of the equivalent function call, namely
the result subtype of the corresponding function.]}
@end{DescribeCode}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[When an Object_View denotes an object renaming, the
properties of the view as reported by the queries in the semantic subsystem are
as determined by the Ada Standard for a renaming (see 8.5.1(6/2) in the Ada
Standard). Thus, the properties are those of the renamed object; for instance, a
renamed constant is a constant, even though constant cannot be specified in a
renaming.]}
@end{SingleNote}

@LabeledAddedSubClause{Version=[2],Name=[Components of Objects]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Component} (O : Object_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Enclosing_Object} (O : Object_View)
   @key[return] Object_View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Indexed_Component} (O : Object_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Index_Value} (O : Object_View; Dimension : Positive := 1)
   @key[return] Object_View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Selected_Component} (O : Object_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Selector_Declaration} (O : Object_View)
   @key[return] Views.Declarative_Regions.View_Declaration'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Storage_Place_Attributes} (O : Object_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Position} (O : Object_View) @key[return] Object_View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{First_Bit} (O : Object_View) @key[return] Object_View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Last_Bit} (O : Object_View) @key[return] Object_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[O specifies the view of an object to query for each
of these functions. Note that these are semantic queries, rather than
syntactic queries @em for all of these functions, if the view O is defined by an
object renaming, the result is determined by the properties of the renamed
object.]}

@begin{Ramification}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Type=[Leading],Text=[For example, if we have]}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[X : Natural @key[renames] O.C;]}
@end{Example}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Type=[Leading],Text=[Is_Component on a view of Z will
return True, even though X is not syntactically a component selection.]}
@end{Ramification}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Is_Component returns True if and only if
the view O is of a component of an enclosing composite object. Function
Enclosing_Object returns a view of the enclosing object of the component O, or
raises ASIS_Inappropriate_View if Is_Component (O) returns False.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Is_Indexed_Component returns True if and
only if the view O is of an indexed component for the given dimension.
Function Index_Value returns a view of the value of the index of the indexed
component O for the given dimension, or raises ASIS_Inappropriate_View if
Is_Indexed_Component (O) returns False or Dimension is greater than
Num_Dimensions applied to the subtype of Enclosing_Object(O).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Is_Selected_Component returns True if and
only if the view O is of a selected component. Function Selector_Declaration
returns the declaration of the selected component O, or raises
ASIS_Inappropriate_View if Is_Selected_Component (O) returns False.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Has_Storage_Place_Attributes returns
True if and only if the view O is of a selected component that has storage
place attributes. Functions Position, First_Bit, and Last_Bit, return a view of the
value of a reference to the corresponding attribute of the given component O, or
raise ASIS_Inappropriate_View if Has_Storage_Place_Attributes (O) returns
False.]}

@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Aliased Views and Dereferences]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Aliased} (O : Object_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Static_Accessibility_Level} (O : Object_View)
   @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Library_Level} (O : Object_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Statically_Deeper_Than} (O : Object_View; Compared_To : Object_View)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Dereference} (O : Object_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Dereferenced_Value} (O : Object_View)
   @key[return] Object_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[O specifies the view of an object to query for each
of these functions. Note that these are semantic queries, not syntactic
queries @em for all of these functions, if the view O is defined by an
object renaming, the result is determined by the properties of the
renamed object.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Function Is_Aliased returns True if and only if the
view O is aliased (see ARM 3.10(9) in the Ada Standard). Function
Has_Static_Accessibility_Level returns True if Is_Aliased (O) and the statically
deeper relationship is defined for the accessibility level of the view O (see
3.10.2(17-21) in the Ada Standard). Function Is_Library_Level returns True if
Has_Static_Accessibility_Level (O) is True and the accessibility level is
library level (see 3.10.2(22) in the Ada Standard). Function
Is_Statically_Deeper_Than raises ASIS_Inappropriate_View if
Has_Static_Accessibility_Level returns False for either operand; otherwise it
returns True if and only if the accessibility level of O is statically deeper
than that of the object view Compared_To (see 3.10.2(17-21) in the Ada
Standard).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Is_Dereference returns True if and only if
the object O is a dereference of an access-to-object value. Function
Dereferenced_Value returns a view of the access value that was dereferenced in
the dereference O, or raises ASIS_Inappropriate_View if Is_Dereference (O)
returns False.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Static Values]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Longest_Discrete} @key[is range] @examcom{<implementation-defined>};]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Static_Discrete} (O : Object_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Static_Discrete_Value} (O : Object_View)
   @key[return] Longest_Discrete @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Static_Discrete_Image} (O : Object_View)
   @key[return] Wide_String @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Longest_Float} @key[is digits] @examcom{<implementation-defined>};]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Static_Real} (O : Object_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Static_Real_Value} (O : Object_View)
   @key[return] Longest_Float @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Static_Real_Image} (O : Object_View)
   @key[return] Wide_String @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Static_String} (O : Object_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Static_String_Value} (O : Object_View)
   @key[return] Wide_String @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[O specifies the view of an object to query for each
of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Static_Discrete returns True if and only
if the view O is a view of the value of a static expression of a discrete type
(see 4.9(2-13) in the Ada Standard).
Function Static_Discrete_Value returns the position number of the value of the
static discrete expression O, or raises ASIS_Inappropriate_View if
Is_Static_Discrete (O) returns False. If the position number of the value is
outside the range of Longest_Discrete, it raises Constraint_Error. Function
Static_Discrete_Image returns the image of the position number of the value of
the static discrete expression O, with the syntax used by the Image attribute of
its type (with a leading minus if negative, and a leading space otherwise), or
raises ASIS_Inappropriate_View if Is_Static_Discrete (O) returns False. A
correct image is returned even if the position number of the value is outside
the base range of the type.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Static_Real returns True if and only if
the view O is of the value of a static expression of a real type
(see 4.9(2-13) in the Ada Standard). Function
Static_Real_Value returns the value of the static real expression O converted to
the Longest_Float type, or raises ASIS_Inappropriate_View if Is_Static_Real (O)
returns False. If the value is outside the range of Longest_Real, it raises
Constraint_Error. Function Static_Real_Image returns a string containing an
optional minus sign, followed by a pair of non-negative integers separated by
the character '/' corresponding to a numerator and a denominator for the reduced
rational representation of the exact absolute value of the static real
expression O. The denominator is one when the numerator is zero.
Static_Real_Image raises ASIS_Inappropriate_View if Is_Static_Real (O) returns
False.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Static_String returns True if and only
if the view O is of the value of a static expression of a string type
(see 4.9(2-13) in the Ada Standard). Function
Static_String_Value returns a Wide_String whose characters match the
corresponding characters of the static value of the string expression O (encoded
in UTF-16, as described in Section 3). The function raises
ASIS_Inappropriate_View if Is_Static_String (O) returns False.]}
@end{DescribeCode}

@begin{Notes}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Static_Discrete_Value can be used on integer,
character, and enumeration values.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The result of Static_Real_Value may not have all of
the precision of the original static value even if it is in range. If the exact
value is important, use Static_Real_Image to retrieve the value instead of
Static_Real_Value.]}
@end{Notes}


@LabeledAddedSubClause{Version=[2],Name=[Representational Object Attributes]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Object_Size} (O : Object_View) @key[return] ASIS_Natural @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Object_Alignment} (O : Object_View) @key[return] ASIS_Natural @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[O specifies the view of an object to query for both
of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Object_Size returns the same value as the
Size attribute of the object O, if the object is elementary, if
Is_Aspect_Specified (O, Size) returns True, or if its  subtype's size is
specified. The result is implementation-defined in other
cases, and may be ASIS_Natural'Last. Function Object_Alignment returns the same
value as the Alignment attribute of the object O. If the view is of a value
rather than an object, the result of Object_Size and Object_Alignment is
implementation-defined, but is within the range of values possible for objects
of the same type.]}

@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Object Holders]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[package] @AdaPackDefn{Object_Holders} @key[is new]
   Ada.Containers.Indefinite_Holders (Object_View'Class);
@key[type] @AdaTypeDefn{Object_Holder} @key[is new] Object_Holders.Holder @key[with null record];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type Object_Holder allows the declaration of an
uninitialized variable (including a component) that can hold a Object_View.]}
@end{DescribeCode}



@LabeledAddedClause{Version=[2],Name=[package Asis.Object_Views.Access_Views]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis.Object_Views],Child=[Access_Views]}Asis.Object_Views.Access_Views
shall exist. The package shall provide interfaces equivalent to those
described in the following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[type Access_Object_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Access_Object_View} @key[is interface and] Object_View;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Access_Object_View represents views of access objects and values, as
denoted by names or expressions.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Designated object operations]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Object_Access_Attribute_Reference} (O : Access_Object_View) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Designated_Object} (O : Access_Object_View)
   @key[return] Object_View'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Implicit_Access_Attribute_Reference} (O : Access_Object_View)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Subprogram_Access_Attribute_Reference} (O : Access_Object_View)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Designated_Subprogram} (O : Access_Object_View)
   @key[return] Callable_Views.Callable_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[O specifies the view of an access object to query for each of these
functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Is_Object_Access_Attribute_Reference returns True if and only
if the view O is of an (explicit or implicit) Access or Unchecked_Access
attribute reference of an aliased object. Function Designated_Object returns
the object designated by the access value in the attribute O, or raises
ASIS_Inappropriate_View if Is_Object_Access_Attribute_Reference (O) returns False.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Implicit_Access_Attribute_Reference returns True if and
only if the view O is of a value produced by an implicit Access attribute
reference as part of a call on a prefixed view of a subprogram, where the
first parameter of the unprefixed subprogram is an access parameter (see 6.4(10.1)
in the Ada Standard).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Subprogram_Access_Attribute_Reference returns True if and only
if the view O is of an Access attribute reference of
a subprogram. Function Designated_Subprogram returns a view of the subprogram
designated by the access value in the attribute O, or raises
ASIS_Inappropriate_View if Is_Subprogram_Access_Attribute_Reference (O)
returns False.]}
@end{DescribeCode}



@LabeledAddedClause{Version=[2],Name=[package Asis.Program_Units]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis],Child=[Program_Units]}Asis.Program_Units shall exist.
The package shall provide interfaces equivalent to those described in the
following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[type Program_Unit]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0057-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Program_Unit} @key[is interface and] Views.Declarative_Regions.View_Declaration;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Program_Unit is an extension of
View_Declaration, and is used to represent the declaration of a program unit
(package, subprogram, task unit, protected unit, protected entry, or generic
unit).]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Requires_Completion} (P : Program_Unit) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Body} (P : Program_Unit) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Body_Of_Program_Unit} (P : Program_Unit)
   @key[return] Asis.Declaration @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Instance} (P : Program_Unit) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Instantiated_Generic} (P : Program_Unit)
   @key[return] Program_Unit'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Actual_Part} (P : Program_Unit)
   @key[return] Asis.Association_List @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Expanded_Body} (P : Program_Unit)
   @key[return] Asis.Declaration @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the program unit view declaration to
query for each of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Requires_Completion returns True if and
only if the program unit P requires a completion (see 3.11.1(1) in the Ada
Standard). Function Has_Body returns True
if the program unit P has a completion that is a body. Function
Body_Of_Program_Unit returns the body that completes the program unit P, or
raises ASIS_Inappropriate_View if Has_Body (P) returns False.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Is_Instance returns True if and only if the
program unit P is an instance of a generic unit. Function Instantiated_Generic
returns the generic unit given the instance P, or raises ASIS_Inappropriate_View
if Is_Instance (P) returns False. Function Actual_Part returns the list of
actual parameters passed to the instantiation P, or raises
ASIS_Inappropriate_View if Is_Instance (P) returns False. Function Expanded_Body
returns the expanded body of the instantiation P, or raises
ASIS_Inappropriate_View if Is_Instance returns False.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Compilation Units]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Compilation_Unit} (P : Program_Unit)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[procedure] @AdaSubDefn{Depends_Semantically_On} (
   P : Program_Unit; Depends_On : @key[out] Program_Unit_Vector'Class) @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Subunit} (P : Program_Unit) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Stub_Of_Program_Unit} (P : Program_Unit)
   @key[return] Asis.Declaration @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Library_Item} (P : Program_Unit) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the program unit view declaration to
query for each of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Function Is_Compilation_Unit returns True if and
only if the program unit P is separately compiled as a compilation unit.
Procedure Depends_Semantically_On returns in the Depends_On parameter the vector
of other compilation units on which compilation unit P depends semantically, or
raises ASIS_Inappropriate_View if Is_Compilation_Unit (P) returns False (see
10.1.1(26)) in the Ada Standard).]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Is_Subunit returns True if and only if the
program unit P is separately compiled as a subunit. Function
Stub_Of_Program_Unit returns the Asis.Declaration that specifies the stub of the
subunit P, or raises ASIS_Inappropriate_View if Is_Subunit (P) returns False.
Function Is_Library_Item returns True if and only if the program unit P is
separately compiled as a library item.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[type Library_Item]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Library_Item} @key[is interface and] Program_Unit;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Library_Item is used to represent program units that are separately
compiled as library items @em those for which Is_Library_Item returns True.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Parent_Library_Unit} (L : Library_Item)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Parent_Library_Unit} (L : Library_Item)
   @key[return] Library_Item'Class @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Pure_Unit} (L : Library_Item) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Preelaborated_Unit} (L : Library_Item) @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Remote_Call_Interface_Unit} (L : Library_Item)
   @key[return] Boolean @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Remote_Types_Unit} (L : Library_Item)
   @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[L specifies the library unit view declaration to
query for each of these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Has_Parent_Library_Unit returns True if and
only if the library item L is a child of a unit other than package Standard.
Function Parent_Library_Unit returns the parent library item of a child unit L,
or raises ASIS_Inappropriate_View if Has_Parent_Library_Unit (L) returns
False.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Is_Pure_Unit returns True if and only if
the library item L is declared pure. Function Is_Preelaborated_Unit returns True
if and only if the library item L is preelaborated. Function
Is_Remote_Call_Interface_Unit returns True if and only if the pragma
Remote_Call_Interface applies to the library item L. Function
Is_Remote_Types_Unit returns True if and only if the pragma Remote_Types applies
to the library item L.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Program Unit Vectors]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[package] @AdaPackDefn{Program_Unit_Vectors} @key[is new]
   Ada.Containers.Indefinite_Vectors (Positive, Program_Unit'Class);
@key[type] @AdaTypeDefn{Program_Unit_Vector} @key[is new]
   Program_Unit_Vectors.Vector @key[with null record];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type Program_Unit_Vector allows the declaration of a
list of Program_Units.]}
@end{DescribeCode}



@LabeledAddedClause{Version=[2],Name=[package Asis.Profiles]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis],Child=[Profiles]}Asis.Profiles shall exist. The package
shall provide interfaces equivalent to those described in the following
subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[type Profile]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[type] Profile @key[is private];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[The type Profile specifies the profile of a callable
entity (see 6.1(22) in the Ada Standard).]}
@end{DescribeCode}



@LabeledAddedSubClause{Version=[2],Name=[function Parameters (Profile)]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Parameters} (P : Profile) @key[return] Declarative_Regions.Region_Part;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the Profile to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns the Region_Part containing the parameters of the profile.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[If there are no parameters in the profile, returns a
Region_Part for which Is_Empty returns true.]}

@end{DescribeCode}



@LabeledAddedSubClause{Version=[2],Name=[Function queries]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Function} (P : Profile) @key[return] Boolean;
@key[function] @AdaSubDefn{Result_Subtype} (P : Profile)
    @key[return] Subtype_Views.Subtype_View'Class;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the Profile to query for both of these
functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Is_Function returns True if the profile represents a
function, and returns False otherwise.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Result_Subtype returns the Subtype_View of the
return part of the profile, if Is_Function (P) is True. Otherwise,
Result_Subtype raises ASIS_Inappropriate_View.]}
@end{DescribeCode}



@LabeledAddedSubClause{Version=[2],Name=[Family index queries]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Family_Index} (P : Profile) @key[return] Boolean;
@key[function] @AdaSubDefn{Family_Index_Subtype} (P : Profile)
   @key[return] Subtype_Views.Subtype_View'Class;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the Profile to query for both of these
functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Has_Family_Index returns True if the Profile applies
to an entry family, and returns False otherwise.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Family_Index_Subtype returns the entry index subtype
of the profile P if Has_Family_Index (P) is True (see 9.5.2(20) in the Ada
Standard). Otherwise, Family_Index_Subtype raises ASIS_Inappropriate_View.]}

@end{DescribeCode}



@LabeledAddedSubClause{Version=[2],Name=[Profile conventions]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Convention} (P : Profile) @key[return] Views.Conventions;
@key[function] @AdaSubDefn{Convention_Identifier} (P : Profile) @key[return] Wide_String;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the Profile to query for both of these
functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Function Convention returns the Convention of
Profile P. Function Convention_Identifier returns "Intrinsic", "Ada",
"Protected", or "Entry" when function Convention returns the corresponding value
of type Conventions. When Convention returns Other_Convention,
Convention_Identifier returns the identifier given in the pragma Convention,
Import, or Export used to specify the convention of the entity.]}
@end{DescribeCode}



@LabeledAddedClause{Version=[2],Name=[package Asis.Callable_Views]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis],Child=[Callable_Views]}Asis.Callable_Views shall exist.
The package shall provide interfaces equivalent to those described in the
following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[type Callable_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0057-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Callable_View} @key[is interface and] Views.View;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[The type Callable_View represents views of callable
entities, as denoted by names or expressions (see 6(2) in the Ada Standard).]}
@end{DescribeCode}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[When a Callable_View denotes a subprogram renaming,
the properties of the view as reported by the queries in the semantic subsystem
are as determined by the Ada Standard for a renaming (see 8.5.4(7) in the Ada
Standard). Thus, some properties come from the renaming, and some from the
renamed view. For instance, a procedure renaming is always a procedure, even
when the renamed view denotes an entry.]}
@end{SingleNote}


@LabeledAddedSubClause{Version=[2],Name=[function Callable_Profile]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Callable_Profile} (C : Callable_View)
   @key[return] Profiles.Profile @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[C specifies the callable view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Returns the Profile of the callable view C (see
6.1(22) in the Ada Standard).]}
@end{DescribeCode}



@LabeledAddedSubClause{Version=[2],Name=[Callable view categorization]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Subprogram} (C : Callable_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Enumeration_Literal} (C : Callable_View)
   @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Procedure} (C : Callable_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Entry} (C : Callable_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Function} (C : Callable_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Abstract} (C : Callable_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Null} (C : Callable_View) @key[return] Boolean @key[is abstract];
@key[function] @AdaSubDefn{Is_Formal_Subprogram} (C : Callable_View) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[C specifies the callable view to query for each of
these functions.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Is_Subprogram returns True if the callable view C is
of a subprogram (that is, C has Callable_View_kinds of A_Noninstance_Subprogram,
A_Subprogram_Instance, A_Subprogram_Renaming, A_Protected_Subprogram,
An_Imported_Subprogram, An_Attribute_Subprogram, An_Intrinsic_Subprogram,
or A_Designated_Subprogram), and returns False otherwise.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Is_Enumeration_Literal returns True if the callable
view C is of an enumeration literal, and returns False otherwise.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Is_Procedure returns True if the callable view C
denotes a procedure, and returns False otherwise.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Is_Entry returns True if the callable view C
denotes an entry (that is, C has Callable_View_kinds of A_Protected_Entry or
A_Task_Entry), otherwise it returns False.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Is_Function returns True if the callable view C
denotes a function, and returns False otherwise.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Is_Abstract returns True if the callable view C
denotes a subprogram declared by an abstract_subprogram_declaration or an
abstract inherited subprogram, and returns False otherwise.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Is_Null returns True if the Callable_View denotes
a Null Procedure, and returns False otherwise.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Is_Formal_Subprogram returns True if the
Callable_View denotes a generic formal subprogram, and returns False otherwise.]}
@end{DescribeCode}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[A use of an enumeration literal is formally a
function call, so a view of such a use is a Callable_View for which Is_Function
returns True.]}
@end{SingleNote}

@LabeledAddedSubClause{Version=[2],Name=[Primitive operations]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Primitive} (C : Callable_View) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[C specifies the callable view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Returns True if the callable view C is of a
primitive subprogram (see 3.2.3(2-7) in the Ada Standard).
Returns False otherwise.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[procedure] @AdaSubDefn{Primitive_On_Subtypes} (C : Callable_View;
   Subtypes : @key[out] Subtype_Views.Subtype_Vector'Class) @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[C specifies the callable view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Subtype_Vector is a vector of the subtypes returned
by the query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns a vector of the subtypes on which the
subprogram C is primitive. For a callable view C that is not primitive, returns
Subtype_Vector(Subtype_Vectors.Empty_Vector).]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Dispatching_Operation} (C : Callable_View)
   @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[C specifies the callable view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Returns True if C denotes a dispatching
operation (see 3.9.2(1) in the Ada Standard). Returns False otherwise.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Associated_Tagged_Type} (C : Callable_View)
   @key[return] Subtype_Views.Composite.Tagged_Subtype'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[C specifies the callable view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns the tagged type of which the dispatching
operation C is a primitive. If C is not a dispatching operation,
ASIS_Inappropriate_View is raised.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Prefixed views]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Prefixed_View} (C : Callable_View) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[C specifies the callable view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Returns True if C is a prefixed view of a
subprogram (see 4.1.3(9.2) in the Ada Standard). Returns False otherwise.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Prefix_Object} (C : Callable_View)
   @key[return] Object_Views.Object_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[C specifies the callable view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[If Is_Prefixed_View (C) is True, returns the Object_View of the of the
prefix of C. Otherwise, raises ASIS_Inappropriate_View.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Unprefixed_Callable_View} (C : Callable_View)
   @key[return] Callable_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[C specifies the callable view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[If Is_Prefixed_View (C), returns the standard
(unprefixed) form callable_view of C. Returns C otherwise.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Access-to-subprogram views]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Designated_Subprogram} (C : Callable_View)
   @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[C specifies the callable view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns True if the callable view C represents an
access to subprogram call; otherwise, returns False.]}

@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Access_To_Subprogram_Value} (C : Callable_View)
   @key[return] Object_Views.Object_View @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[C specifies the callable view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[If Is_Designated_Subprogram (C) is True, returns the
Object_View of the access_to_subprogram object associated with the callable view
C.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Otherwise, raises ASIS_Inappropriate_View.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Callable view holders]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[package] @AdaPackDefn{Callable_Holders} @key[is new]
   Ada.Containers.Indefinite_Holders (Callable_View'Class);
@key[type] @AdaTypeDefn{Callable_Holder} @key[is new] Callable_Holders.Holder @key[with null record];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type Callable_Holder allows the declaration of an uninitialized variable (including
a component) that can hold a Callable_View.]}
@end{DescribeCode}


@LabeledAddedClause{Version=[2],Name=[package Asis.Package_Views]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis],Child=[Package_Views]}Asis.Package_Views shall exist.
The package shall provide interfaces equivalent to those described in the
following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[type Package View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0057-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Package_View} @key[is interface and] Views.View;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[The type Package_View represents a view of a package.
Every package has a non-limited view. A package may also have
a limited view (see 10.1.1(12.1-12.6) in the Ada Standard).]}
@end{DescribeCode}

@begin{Discussion}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[All library packages and packages nested in library
packages have a limited view. Other packages (nested in bodies,
subprograms, tasks, or blocks) do not.]}
@end{Discussion}


@LabeledAddedSubClause{Version=[2],Name=[function Has_Limited_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Has_Limited_View} (P : Package_View) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the package view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Returns True if a limited view of P exists
(including if P is a limited view @em see 10.1.1(12.1-12.6)).
Returns False otherwise.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[function Is_Limited_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Limited_View} (P : Package_View) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the package view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[Returns True if P denotes the limited view of a
package (see 10.1.1(12.1-12.6) in the Ada Standard). Returns False otherwise.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[function Full_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Full_View} (P : Package_View) @key[return] Package_View'Class
  @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the package view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[If Is_Limited_View (P) then returns the corresponding full view of P.
In this case, Limited_View (Full_View (P)) = P.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns P otherwise.]}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[In all cases, Is_Limited_View (Full_View (P)) = False.]}
@end{SingleNote}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[function Is_Full_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Full_View} (P : Package_View) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the package view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns True if P denotes the full view of a package.
Returns False otherwise.]}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[In all cases, Is_Full_View (P) /= Is_Limited_View (P).]}
@end{SingleNote}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[function Limited_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Limited_View} (P : Package_View)
   @key[return] Package_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the package view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[If Is_Limited_View (P) is True, then returns P.
Otherwise, if Has_Limited_View (P) is True, then
returns the corresponding limited view of P (see 10.1.1(12.1-12.6) in the
Ada Standard). If Has_Limited_View (P) is False, then raises
ASIS_Inappropriate_View.]}
@end{DescribeCode}

@begin{Discussion}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key[If] Has_Limited_View (P) @key[then]
   Is_Limited_View (Limited_View (P)) = True
@key[and]
   Full_View (Limited_View (P)) = P.]}
@end{Example}
@end{Discussion}


@LabeledAddedSubClause{Version=[2],Name=[function Is_Formal_Package]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Formal_Package} (P : Package_View) @key[return] Boolean @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the package view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns True if P denotes a formal package.
Returns False otherwise.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Part selectors]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Visible_Part} (P : Package_View)
   @key[return] Views.Declarative_Regions.Region_Part @key[is abstract];]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Private_Part} (P : Package_View)
   @key[return] Views.Declarative_Regions.Region_Part @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[P specifies the package view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0057-1]}
@ChgAdded{Version=[2],Text=[Function Visible_Part returns the appropriate
(either limited or full) view of the visible part of the package. Function
Private_Part returns the appropriate (either limited or full) view of the
private part of the package.]}
@end{DescribeCode}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[To find the body of a package view P, use Body_Part
(Defined_Region (P)). This technique can also be used to access the stubs of a
package.]}
@end{SingleNote}


@LabeledAddedSubClause{Version=[2],Name=[Package Holders]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[package] @AdaPackDefn{Package_Holders} @key[is new]
   Ada.Containers.Indefinite_Holders (Package_View'Class);
@key[type] @AdaTypeDefn{Package_Holder} @key[is new] Package_Holders.Holder @key[with null record];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type Package_Holder allows the declaration of an
uninitialized variable (including a component) that can hold a Package_View.]}
@end{DescribeCode}


@LabeledAddedClause{Version=[2],Name=[package Asis.Generic_Views]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis],Child=[Generic_Views]}Asis.Generic_Views shall exist.
The package shall provide interfaces equivalent to those
described in the following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[type Generic_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0057-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Generic_View} @key[is interface and] Views.View;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Generic_View represents a view of a generic unit.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[function Generic_Formal_Part (view)]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Generic_Formal_Part} (G : Generic_View)
   @key[return] Views.Declarative_Regions.Region_Part @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[G specifies the view of a generic to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Yields a Region_Part that specifies the formal part
of the generic G.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[function Is_Generic_Package]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Generic_Package} (G : Generic_View) @key[return] Boolean
   @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[G specifies the view of a generic to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns True if G denotes a generic package.
Returns False otherwise.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[function Current_Package_Instance]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Current_Package_Instance} (G : Generic_View)
   @key[return] Package_Views.Package_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[G specifies the view of a generic to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[If Is_Generic_Package (G) is False, then raises
ASIS_Inappropriate_View.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[As seen from within itself, a generic unit is an
instance (that is, the current instance of the given generic @em see 8.6(18) in
the Ada Standard); it is not a
generic unit. This function yields a view of that instance for generic G.
For example, given the generic package Ada.Text_IO.Enumeration_IO,
Current_Package_Instance would return a view of a non-generic
package which can be passed to the interfaces defined for
Package_View, such as Visible_Part, Is_Full_View, etc.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[function Is_Generic_Subprogram]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Is_Generic_Subprogram} (G : Generic_View) @key[return] Boolean
   @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[G specifies the view of a generic to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns True if G denotes a generic subprogram.
Returns False otherwise.]}
@end{DescribeCode}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[In all cases, Is_Generic_Subprogram (G) /= Is_Generic_Package (G).]}
@end{SingleNote}


@LabeledAddedSubClause{Version=[2],Name=[function Current_Subprogram_Instance]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Current_Subprogram_Instance} (G : Generic_View)
   @key[return] Callable_Views.Callable_View'Class @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[G specifies the view of a generic to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[If Is_Generic_Subprogram (G) is False, then raises
ASIS_Inappropriate_View.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[As seen from within itself, a generic unit is an
instance (that is, the current instance of the given generic @em see 8.6(18) in
the Ada Standard); it is not a
generic unit. This function yields a view of that instance for generic G.
For example, given the generic subprogram Ada.Unchecked_Deallocation,
Current_Subprogram_Instance would return a view of a non-generic subprogram
which can be passed to the interfaces defined for Callable_View, such as
Callable_Profile, Is_Procedure, etc.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Generic Holders]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[package] @AdaPackDefn{Generic_Holders} @key[is new]
   Ada.Containers.Indefinite_Holders (Generic_View'Class);
@key[type] @AdaTypeDefn{Generic_Holder} @key[is new] Generic_Holders.Holder @key[with null record];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type Generic_Holder allows the declaration of an
uninitialized variable (including a component) that can hold a Generic_View.]}
@end{DescribeCode}



@LabeledAddedClause{Version=[2],Name=[package Asis.Exception_Views]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis],Child=[Exception_Views]}Asis.Exception_Views shall
exist. The package shall provide interfaces equivalent to those described in the
following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[type Exception_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0057-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Exception_View} @key[is interface and] Views.View;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The type Exception_View represents a view of an
exception.]}
@end{DescribeCode}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[To determine whether a Discard_Names pragma applies to
an exception view E, use Is_Aspect_Specified (E, Discard_Names).]}
@end{SingleNote}

@LabeledAddedSubClause{Version=[2],Name=[Exception Holders]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[package] @AdaPackDefn{Exception_Holders} @key[is new]
   Ada.Containers.Indefinite_Holders (Exception_View'Class);
@key[type] @AdaTypeDefn{Exception_Holder} @key[is new] Exception_Holders.Holder @key[with null record];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type Exception_Holder allows the declaration of an
uninitialized variable (including a component) that can hold a Exception_View.]}
@end{DescribeCode}



@LabeledAddedClause{Version=[2],Name=[package Asis.Statement_Views]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis],Child=[Statement_Views]}Asis.Statement_Views shall
exist. The package shall provide interfaces equivalent to those described in the
following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[type Statement_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0057-1]}
@ChgAdded{Version=[2],Text=[@key[type] @AdaTypeDefn{Statement_View} @key[is interface and] Views.View;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[The type Statement_View represents a view of a
named statement or of a particular statement label.]}

@begin{Ramification}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Since Views are of entities that could have a
name, Statement_Views can only represent named statements (blocks and loops)
or statement labels. These exist so that a name representing one of these
entities can be handled in the semantic subsystem; there is no intent to process
statements through this interface. Use the syntactic subsystem to learn about
other statements.]}
@end{Ramification}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[function Element_For_Statement]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Element_For_Statement} (S : Statement_View)
   @key[return] Asis.Statement @key[is abstract];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[S specifies the statement view to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[Yields the Asis.Statement value corresponding to
the statement view S. If S represents a label, the result is the Asis.Statement
having the label.]}
@end{DescribeCode}


@LabeledAddedSubClause{Version=[2],Name=[Statement Holders]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[package] @AdaPackDefn{Statement_Holders} @key[is new]
   Ada.Containers.Indefinite_Holders (Statement_View'Class);
@key[type] @AdaTypeDefn{Statement_Holder} @key[is new] Statement_Holders.Holder @key[with null record];]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Type Statement_Holder allows the declaration of an
uninitialized variable (including a component) that can hold a Statement_View.]}
@end{DescribeCode}



@LabeledAddedClause{Version=[2],Name=[package Asis.Declarations.Views]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis.Declarations],Child=[Views]}Asis.Declarations.Views
shall exist. The package shall provide interfaces equivalent to those described
in the following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[procedure Corresponding_View_Declarations]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0062-1]}
@ChgAdded{Version=[2],Text=[@key[procedure] @AdaSubDefn{Corresponding_View_Declarations}
   (Declaration: @key[in] Asis.Declaration;
    View_Declarations : @key[out] Declarative_Regions.View_Declaration_Vector'Class);]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Declaration specifies the declaration to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns in parameter View_Declarations a vector of
view declarations, one element for each defining name of Declaration;
each view declaration defines the view of the corresponding named
entity declared by Declaration.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Type=[Leading],Keepnext=[T],Text=[Declaration expects
an element that has the following Element_Kinds:]}
@begin{Display}
@ChgAdded{Version=[2],Text=[A_Declaration]}
@end{Display}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Raises ASIS_Inappropriate_Element with a Status of Value_Error for any element
that does not have this expected kind.]}
@end{DescribeCode}



@LabeledAddedClause{Version=[2],Name=[package Asis.Definitions.Views]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis.Definitions],Child=[Views]}Asis.Definitions.Views shall
exist. The package shall provide interfaces equivalent to those described in the
following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[function Corresponding_Subtype_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Corresponding_Subtype_View} (Definition : @key[in] Asis.Definition)
   @key[return] Asis.Subtype_Views.Subtype_View'Class;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Definition specifies the type definition or
subtype indication to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns a view that specifies the subtype denoted by
Definition.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1],ARef=[SI99-0054-1]}
@ChgAdded{Version=[2],Type=[Leading],Keepnext=[T],Text=[Definition expects
an element that has one of the following Definition_Kinds:]}
@begin{Display}
@ChgAdded{Version=[2],Text=[A_Type_Definition
A_Private_Type_Definition
A_Tagged_Private_Type_Definition
A_Private_Extension_Definition
A_Task_Definition
A_Protected_Definition
A_Formal_Type_Definition
A_Subtype_Indication
A_Discrete_Subtype_Definition
A_Discrete_Range]}
@end{Display}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Raises ASIS_Inappropriate_Element with a Status of
Value_Error for any element that does not have one of these expected kinds.]}
@end{DescribeCode}


@LabeledAddedClause{Version=[2],Name=[package Asis.Expressions.Views]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The library package
@ChildUnit{Parent=[Asis.Expressions],Child=[Views]}Asis.Expressions.Views shall
exist. The package shall provide interfaces equivalent to those described in the
following subclauses.]}


@LabeledAddedSubClause{Version=[2],Name=[function Corresponding_View]}

@begin{DescribeCode}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[@key[function] @AdaSubDefn{Corresponding_View} (Expression : @key[in] Asis.Expression)
   @key[return] Asis.Views.View'Class;]}
@end{Example}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Expression specifies the expression to query.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Returns the view that describes the semantic meaning
of the Expression.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Type=[Leading],Keepnext=[T],Text=[Expression expects an
element that has the following Element_Kinds:]}
@begin{Display}
@ChgAdded{Version=[2],Text=[An_Expression]}
@end{Display}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[Raises ASIS_Inappropriate_Element with a Status of
Value_Error for any element that does not have this expected kind.]}
@end{DescribeCode}

@begin{SingleNote}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[SI99-0024-1]}
@ChgAdded{Version=[2],Text=[The returned view denotes the expression, and not
the declaration of the expression. In addition, the view represents the
information available to the expression. This latter point means that the
information in the view may depend on the visibility at the point of the
reference that the view denotes. For instance, if the Expression denotes a
private type whose full type is not visible at the point of Expression in the
program and Corresponding_View (Expression) returns V, Is_Record (V) will be
False even if the full type of the private type is a record type.]}
@end{SingleNote}


