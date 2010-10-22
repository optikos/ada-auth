@Part(glossary, Root="ada.mss")

@Comment{$Date: 2010/10/15 07:05:38 $}
@LabeledAddedInformativeAnnex{Version=[2],Name=[Language-Defined Entities]}

@comment{$Source: e:\\cvsroot/ARM/Source/langdef.mss,v $}
@comment{$Revision: 1.5 $}

@begin{Intro}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00440-01]}
@ChgAdded{Version=[2],Text=[This annex lists the language-defined entities of
the language. A list of language-defined library units can be found
in @RefSec{Predefined Language Environment}.]}
@end{Intro}

@LabeledAddedClause{Version=[2],Name=[Language-Defined Packages]}

@begin{Intro}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00440-01]}
@ChgAdded{Version=[2],Text=[This clause lists all language-defined packages.@Defn{Language-defined packages}]}
@end{Intro}

@PackageList

@LabeledAddedClause{Version=[2],Name=[Language-Defined Types and Subtypes]}

@begin{Intro}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00440-01]}
@ChgAdded{Version=[2],Text=[This clause lists all language-defined types and
subtypes.@Defn{Language-defined types}@Defn{Language-defined subtypes}]}
@end{Intro}

@TypeList

@Comment{@RMNewPage@Comment{For printed version of Ada 2005 RM} - Now Ada 2012}
@LabeledAddedClause{Version=[2],Name=[Language-Defined Subprograms]}

@begin{Intro}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00440-01]}
@ChgAdded{Version=[2],Text=[This clause lists all language-defined subprograms.@Defn{Language-defined subprograms}]}
@end{Intro}

@SubprogramList

@LabeledAddedClause{Version=[2],Name=[Language-Defined Exceptions]}

@begin{Intro}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00440-01]}
@ChgAdded{Version=[2],Text=[This clause lists all language-defined exceptions.@Defn{Language-defined exceptions}]}
@end{Intro}

@ExceptionList


@LabeledAddedClause{Version=[2],Name=[Language-Defined Objects]}

@begin{Intro}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00440-01]}
@ChgAdded{Version=[2],Text=[This clause lists all language-defined constants,
variables, named numbers, and enumeration literals.@Defn{Language-defined objects}@Defn{Language-defined constants}@Defn{Language-defined values}]}
@begin{Honest}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[Formally, named numbers and enumeration literals
  aren't objects, but it was thought to be too weird to say @lquotes@;Language-Defined
  Objects and Values@rquotes.]}
@end{Honest}
@end{Intro}

@ObjectList

