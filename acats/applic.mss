@Part(applic, Root="acats.msm")

@comment{$Source: e:\\cvsroot/ARM/ACATS/applic.mss,v $}
@comment{$Revision: 1.8 $ $Date: 2016/04/30 02:41:12 $}

@LabeledAnnex{Test Applicability Criteria}

Certain tests in the suite may be considered inapplicable to an implementation
depending on the way the implementation treats the implementation-dependent
features of the language. A brief summary of these implementation-dependent
features and the tests they affect are listed in this appendix.

@leading@;Note that the applicability of each one of these tests is based on
the criteria listed in the test file. During conformity assessment, all the
implementation-dependent tests are submitted for compilation and (if compiled
successfully) are executed, with the following exceptions:

@begin{Itemize}
Tests which require a floating point @key[digits] value that exceeds
@exam{System.Max_Digits} need not be submitted to the compiler. (The testing
laboratory may require pre-validation evidence that the tests are properly
rejected.)

If file I/O is not supported, then the tests listed in
Section @RefSecNum{File I/O Tests} will not
be part of the customized test suite for bare target validations and will not
be run during witness testing.
@end{Itemize}


@LabeledClause{Compile-Time Inapplicability}

@leading@;The first part of this appendix is concerned with tests for which the
applicability is determined at compile time. Class B tests that are
inapplicable should be successfully compiled, or, in a few cases, should report
an error on the line marked "--N/A => ERROR". Executable tests that are
inapplicable based on their compile-time behavior must be rejected as a result
of the unsupported feature. Lines containing the implementation-dependent
features are marked "--N/A => ERROR". In every case, tests may be graded
NOT-APPLICABLE only if all the following conditions are met:

@begin{Itemize}
The implementation's treatment of the test is consistent with the applicability
criteria given in the test comments;

All other tests having the same applicability criteria exhibit the same
behavior; and

The behavior is consistent with the implementation's documentation.
@end{Itemize}

@LabeledSubClause{Type Short_Integer}

@leading@keepnext@;If there is no predefined type @exam{Short_Integer}, then the tests
contained in the following files are not applicable:

@begin{FourCol}
B36105C.DEP@*
B52004E.DEP@*
B55B09D.DEP@*
C45231B.DEP@*
C45304B.DEP@*
C45411B.DEP@*
C45502B.DEP@*
C45503B.DEP@*
C45504B.DEP@*
C45504E.DEP@*
C45611B.DEP@*
C45613B.DEP@*
C45614B.DEP@*
C45631B.DEP@*
C45632B.DEP@*
C55B07B.DEP@*
CD7101E.DEP
@end{FourCol}

@LabeledSubClause{Type Long_Integer}

@leading@keepnext@;If there is no predefined type @exam{Long_Integer}, then the tests
contained in the following files are not applicable:

@begin{FourCol}
B52004D.DEP@*
B55B09C.DEP@*
C45231C.DEP@*
C45304C.DEP@*
C45411C.DEP@*
C45502C.DEP@*
C45503C.DEP@*
C45504C.DEP@*
C45504F.DEP@*
C45611C.DEP@*
C45613C.DEP@*
C45614C.DEP@*
C45631C.DEP@*
C45632C.DEP@*
C55B07A.DEP@*
CD7101F.DEP
@end{FourCol}

@LabeledSubClause{Other Predefined Integer Types}

@leading@keepnext@;If there are no predefined integer types with names other than
@exam{Integer}, @exam{Short_Integer}, and @exam{Long_Integer},
then the tests contained in the following files are not applicable.

@begin{FourCol}
C45231D.TST@*
CD7101G.TST
@end{FourCol}

@LabeledSubClause{Fixed Point Restrictions}

@leading@keepnext@;If @Exam{System.Max_Mantissa} is less than 47 or
@Exam{System.Fine_Delta} is greater than 2.0**-47, then the tests
contained in the following files are not applicable:

@begin{FourCol}
C45531M.DEP@*
C45531N.DEP@*
C45531O.DEP@*
C45531P.DEP@*
C45532M.DEP@*
C45532N.DEP@*
C45532O.DEP@*
C45532P.DEP
@end{FourCol}


@LabeledSubClause{Non-binary Values of 'Small}

@leading@keepnext@;If @Exam{'Small} representation clauses which are not powers of two
are not supported, then the tests contained in the following files are not
applicable:

@begin{FourCol}
C45536A.DEP@*
CD2A53A.ADA
@end{FourCol}


@LabeledSubClause{Compiler Rejection of Supposedly Static Expression}

@leading@keepnext@;Consider the following declarations:
@begin{Example}
@Key[type] F @Key[is digits] System.Max_Digits;
N : @key[constant] := 2.0 * F'Machine_Radix ** F'Machine_EMax;
@end{Example}

If the declaration of @Exam{N} is rejected on the grounds that evaluation of
the expression will raise an exception, then the following test is not
applicable:

@begin{FourCol}
C4A013B.ADA
@end{FourCol}


@LabeledSubClause{Machine Code Insertions}

@leading@keepnext@;If machine code insertions are not supported, then the tests
contained in the following files are not applicable:

@begin{FourCol}
AD8011A.TST@*
BD8001A.TST@*
BD8002A.TST@*
BD8003A.TST@*
BD8004A.TST@*
BD8004B.TST@*
BD8004C.TST
@end{FourCol}


@LabeledSubClause{Illegal External File Names}

@leading@keepnext@;If there are no strings which are illegal as external file names,
then the tests contained in the following files are not applicable:

@begin{FourCol}
CE2102C.TST@*
CE2102H.TST@*
CE3102B.TST@*
CE3107A.TST
@end{FourCol}


@LabeledSubClause{Decimal Types}

@leading@keepnext@;If decimal types are not supported, then the tests contained in the
following files are not applicable: (Note that implementations testing Annex F
must support decimal types.)

@begin{FourCol}
C460011.A@*
CXAA010.A
@end{FourCol}


@LabeledSubClause{Instantiation of Sequential_IO with indefinite types}

@leading@keepnext@;If Sequential_IO does not support indefinite types, then the
tests contained in the following files are not applicable:

@begin{FourCol}
CE2201D.DEP@*
CE2201E.DEP
@end{FourCol}


@LabeledSubClause{Package Ada.Directories.Hierarchical_File_Names}

@leading@keepnext@;If package Ada.Directories.Hierarchical_File_Names is
not supported, then the test contained in the following file is
not applicable:

@begin{FourCol}
CXAG002.A
@end{FourCol}


@LabeledSubClause{Convention C}

@leading@keepnext@;If convention C is not supported, then the tests contained
in the following files are not applicable:

@begin{FourCol}
BXB3001.A@*
BXB3002.A@*
BXB3003.A@*
BXB3004.A@*
CXB30041.AM@*
CXB30061.AM@*
CXB30132.AM@*
CXB30172.AM@*
CXB30182.AM@*
CXB3019.A@*
CXB3020.A@*
CXB3021.A@*
CXB3022.A
@end{FourCol}


@LabeledSubClause{Convention COBOL}

@leading@keepnext@;If convention COBOL is not supported, then the test
contained in the following file is not applicable:

@begin{FourCol}
CXB40093.AM
@end{FourCol}


@LabeledSubClause{Convention Fortran}

@leading@keepnext@;If convention Fortran is not supported, then the tests
contained in the following files are not applicable:

@begin{FourCol}
C552002.A@*
CXB50042.AM@*
CXB50052.AM
@end{FourCol}


@LabeledSubClause{Package Interfaces.C}

@leading@keepnext@;If package Interfaces.C is
not supported, then the tests contained in the following files are
not applicable:

@begin{FourCol}
BXB3001.A@*
BXB3002.A@*
BXB3003.A@*
BXB3004.A@*
CXB3001.A@*
CXB3002.A@*
CXB3003.A@*
CXB30041.AM@*
CXB3005.A@*
CXB30061.AM@*
CXB3007.A@*
CXB3008.A@*
CXB3009.A@*
CXB3010.A@*
CXB3011.A@*
CXB3012.A@*
CXB30132.AM@*
CXB3014.A@*
CXB3015.A@*
CXB3016.A@*
CXB30172.AM@*
CXB30182.AM@*
CXB3019.A@*
CXB3020.A@*
CXB3021.A@*
CXB3022.A
@end{FourCol}

See also @RefSec{Foreign Language Interface Tests} for more information on
processing these tests.


@LabeledSubClause{Package Interfaces.C.Strings}

@leading@keepnext@;If package Interfaces.C.Strings is
not supported, then the tests contained in the following files are
not applicable:

@begin{FourCol}
CXB3002.A@*
CXB3008.A@*
CXB3009.A@*
CXB3010.A@*
CXB3011.A@*
CXB3012.A@*
CXB30132.AM@*
CXB3014.A@*
CXB3016.A@*
CXB30182.AM
@end{FourCol}


@LabeledSubClause{Package Interfaces.C.Pointers}

@leading@keepnext@;If package Interfaces.C.Pointers is
not supported, then the tests contained in the following files are
not applicable:

@begin{FourCol}
CXB3003.A@*
CXB3014.A@*
CXB3015.A@*
CXB3016.A
@end{FourCol}


@LabeledSubClause{Package Interfaces.COBOL}

@leading@keepnext@;If package Interfaces.COBOL is
not supported, then the tests contained in the following files are
not applicable:

@begin{FourCol}
CXB4001.A@*
CXB4002.A@*
CXB4003.A@*
CXB4004.A@*
CXB4005.A@*
CXB4006.A@*
CXB4007.A@*
CXB4008.A@*
CXB40093.AM
@end{FourCol}

See also @RefSec{Foreign Language Interface Tests} for more information on
processing these tests.


@LabeledSubClause{Package Interfaces.Fortran}

@leading@keepnext@;If package Interfaces.Fortran is
not supported, then the tests contained in the following files are
not applicable:

@begin{FourCol}
CXB5001.A@*
CXB5002.A@*
CXB5003.A@*
CXB50042.AM@*
CXB50052.AM
@end{FourCol}

See also @RefSec{Foreign Language Interface Tests} for more information on
processing these tests.


@LabeledSubClause{Unchecked Unions}

@leading@keepnext@;If unchecked unions are not supported, then the tests
contained in the following files are not applicable:

@begin{FourCol}
BXB3001.A@*
BXB3002.A@*
BXB3003.A@*
BXB3004.A@*
CXB3021.A@*
CXB3022.A
@end{FourCol}


@LabeledSubClause{Special Handling Tests}

@leading@keepnext@;Tests requiring special handling may also be not applicable.
See section @RefSec{Tests with Special Processing Requirements}, for details.


@LabeledClause{Reported Inapplicability}

This section is concerned with tests that can detect, at runtime, certain
implementation characteristics that render the objective meaningless or prevent
testing of the objective. These tests must compile and execute, reporting
"NOT_APPLICABLE" as the result. This behavior must be consistent with other
tests for related objective and with the implementation's documentation.

@LabeledSubClause{Value of Machine_Overflows is False}

@leading@keepnext@;If @Exam{Machine_Overflows} is @Exam{False} for floating point types,
then the tests contained in the following files should report NOT_APPLICABLE:

@begin{FourCol}
C45322A.ADA@*
C45523A.ADA@*
C4A012B.ADA
@end{FourCol}


@LabeledSubClause{System.Max_Digits}

@leading@keepnext@;If the value of @Exam{System.Max_Digits} is greater than 35,
then the test contained in the following file should report NOT_APPLICABLE:

@begin{FourCol}
C4A011A.ADA
@end{FourCol}


@LabeledSubClause{Floating Point Overflow}

@leading@keepnext@;Consider the declaration
@begin{Example}
@Key[type] F @key[is digits] System.Max_Digits;
@end{Example}

@leading@keepnext@;If @Exam{F'Machine_Overflows = False} and
@Exam{2.0*F'Machine_Radix**F'Machine_EMax <= F'Base'Last}
then the test contained in the following file should report NOT_APPLICABLE (if
it compiles without error):

@begin{FourCol}
C4A013B.ADA
@end{FourCol}


@LabeledSubClause{Type Duration}

@leading@keepnext@;If @Exam{Duration'First = Duration'Base'First} or
@Exam{Duration'Last = Duration'Base'Last} then
the tests contained in the following file should report NOT_APPLICABLE:

@begin{FourCol}
C96005B.TST
@end{FourCol}


@LabeledSubClause{Text Files (Non-supported Features)}

@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt
to create or open a text file (this is the appropriate behavior for an
implementation which does not support text files other than standard input and
output), then the tests contained in the following files should report
NOT_APPLICABLE:

@begin{FourCol}
CE2109C.ADA@*
CE3102A.ADA@*
CE3102B.TST@*
CE3102F.ADA@*
CE3102G.ADA@*
CE3102H.ADA@*
CE3102J.ADA@*
CE3102K.ADA@*
CE3103A.ADA@*
CE3104A.ADA@*
CE3104B.ADA@*
CE3104C.ADA@*
CE3106A.ADA@*
CE3106B.ADA@*
CE3107A.TST@*
CE3107B.ADA@*
CE3108A.ADA@*
CE3108B.ADA@*
CE3110A.ADA@*
CE3112C.ADA@*
CE3112D.ADA@*
CE3114A.ADA@*
CE3115A.ADA@*
CE3207A.ADA@*
CE3301A.ADA@*
CE3302A.ADA@*
CE3304A.TST@*
CE3305A.ADA@*
CE3401A.ADA@*
CE3402A.ADA@*
CE3402C.ADA@*
CE3402D.ADA@*
CE3403A.ADA@*
CE3403B.ADA@*
CE3403C.ADA@*
CE3403E.ADA@*
CE3403F.ADA@*
CE3404B.ADA@*
CE3404C.ADA@*
CE3404D.ADA@*
CE3405A.ADA@*
CE3405C.ADA@*
CE3405D.ADA@*
CE3406A.ADA@*
CE3406B.ADA@*
CE3406C.ADA@*
CE3406D.ADA@*
CE3407A.ADA@*
CE3407B.ADA@*
CE3407C.ADA@*
CE3408A.ADA@*
CE3408B.ADA@*
CE3408C.ADA@*
CE3409A.ADA@*
CE3409C.ADA@*
CE3409D.ADA@*
CE3409E.ADA@*
CE3410A.ADA@*
CE3410C.ADA@*
CE3410D.ADA@*
CE3410E.ADA@*
CE3411A.ADA@*
CE3411C.ADA@*
CE3412A.ADA@*
CE3413A.ADA@*
CE3413B.ADA@*
CE3413C.ADA@*
CE3414A.ADA@*
CE3602A.ADA@*
CE3602B.ADA@*
CE3602C.ADA@*
CE3602D.ADA@*
CE3603A.ADA@*
CE3604A.ADA@*
CE3604B.ADA@*
CE3605A.ADA@*
CE3605B.ADA@*
CE3605C.ADA@*
CE3605D.ADA@*
CE3605E.ADA@*
CE3606A.ADA@*
CE3606B.ADA@*
CE3704A.ADA@*
CE3704B.ADA@*
CE3704C.ADA@*
CE3704D.ADA@*
CE3704E.ADA@*
CE3704F.ADA@*
CE3704M.ADA@*
CE3704N.ADA@*
CE3704O.ADA@*
CE3705A.ADA@*
CE3705B.ADA@*
CE3705C.ADA@*
CE3705D.ADA@*
CE3705E.ADA@*
CE3706D.ADA@*
CE3706F.ADA@*
CE3706G.ADA@*
CE3804A.ADA@*
CE3804B.ADA@*
CE3804C.ADA@*
CE3804D.ADA@*
CE3804E.ADA@*
CE3804F.ADA@*
CE3804G.ADA@*
CE3804H.ADA@*
CE3804I.ADA@*
CE3804J.ADA@*
CE3804M.ADA@*
CE3804O.ADA@*
CE3804P.ADA@*
CE3805A.ADA@*
CE3805B.ADA@*
CE3806A.ADA@*
CE3806B.ADA@*
CE3806D.ADA@*
CE3806E.ADA@*
CE3806G.ADA@*
CE3806H.ADA@*
CE3902B.ADA@*
CE3904A.ADA@*
CE3904B.ADA@*
CE3905A.ADA@*
CE3905B.ADA@*
CE3905C.ADA@*
CE3905L.ADA@*
CE3906A.ADA@*
CE3906B.ADA@*
CE3906C.ADA@*
CE3906E.ADA@*
CE3906F.ADA@*
CXAA001.A@*
CXAA002.A@*
CXAA003.A@*
CXAA004.A@*
CXAA005.A@*
CXAA006.A@*
CXAA007.A@*
CXAA008.A@*
CXAA009.A@*
CXAA010.A@*
CXAA011.A@*
CXAA012.A@*
CXAA013.A@*
CXAA014.A@*
CXAA015.A@*
CXAA016.A@*
CXAA017.A@*
CXAA018.A@*
CXAA019.A@*
CXAA020.A@*
CXAA021.A@*
CXAA022.A@*
CXAG001.A@*
CXF3A06.A@*
CXG1003.A@*
EE3203A.ADA@*
EE3204A.ADA@*
EE3402B.ADA@*
EE3409F.ADA@*
EE3412C.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt
to create or open a text file with mode @Exam{In_File}, then the tests
contained in the following files should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE3102F.ADA@*
CE3102H.ADA@*
CE3104B.ADA@*
CE3106A.ADA@*
CE3108A.ADA@*
CE3108B.ADA@*
CE3112D.ADA@*
CE3301A.ADA@*
CE3302A.ADA@*
CE3402A.ADA@*
CE3403B.ADA@*
CE3403C.ADA@*
CE3403E.ADA@*
CE3403F.ADA@*
CE3404B.ADA@*
CE3404C.ADA@*
CE3404D.ADA@*
CE3406A.ADA@*
CE3406C.ADA@*
CE3406D.ADA@*
CE3407A.ADA@*
CE3407C.ADA@*
CE3408A.ADA@*
CE3408C.ADA@*
CE3409C.ADA@*
CE3409D.ADA@*
CE3409E.ADA@*
CE3410C.ADA@*
CE3410D.ADA@*
CE3410E.ADA@*
CE3411A.ADA@*
CE3411C.ADA@*
CE3412A.ADA@*
CE3413A.ADA@*
CE3413B.ADA@*
CE3413C.ADA@*
CE3602A.ADA@*
CE3602B.ADA@*
CE3602D.ADA@*
CE3603A.ADA@*
CE3604A.ADA@*
CE3604B.ADA@*
CE3605C.ADA@*
CE3704A.ADA@*
CE3704C.ADA@*
CE3704D.ADA@*
CE3704E.ADA@*
CE3704F.ADA@*
CE3704M.ADA@*
CE3704N.ADA@*
CE3704O.ADA@*
CE3705B.ADA@*
CE3705C.ADA@*
CE3705D.ADA@*
CE3705E.ADA@*
CE3706D.ADA@*
CE3706G.ADA@*
CE3804A.ADA@*
CE3804B.ADA@*
CE3804D.ADA@*
CE3804E.ADA@*
CE3804F.ADA@*
CE3804G.ADA@*
CE3804H.ADA@*
CE3804I.ADA@*
CE3804J.ADA@*
CE3804M.ADA@*
CE3804P.ADA@*
CE3805A.ADA@*
CE3805B.ADA@*
CE3806A.ADA@*
CE3806B.ADA@*
CE3806D.ADA@*
CE3806G.ADA@*
CE3902B.ADA@*
CE3904B.ADA@*
CE3905A.ADA@*
CE3905C.ADA@*
CE3905L.ADA@*
CE3906B.ADA@*
CE3906C.ADA@*
EE3203A.ADA@*
EE3204A.ADA@*
EE3412C.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt
to create or open a text file with mode @Exam{Out_File}, then the tests
contained in the following files should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2109C.ADA@*
CE3102A.ADA@*
CE3102B.TST@*
CE3102F.ADA@*
CE3102G.ADA@*
CE3102H.ADA@*
CE3102J.ADA@*
CE3102K.ADA@*
CE3103A.ADA@*
CE3104A.ADA@*
CE3104B.ADA@*
CE3104C.ADA@*
CE3106A.ADA@*
CE3106B.ADA@*
CE3107A.TST@*
CE3107B.ADA@*
CE3108A.ADA@*
CE3108B.ADA@*
CE3110A.ADA@*
CE3112C.ADA@*
CE3112D.ADA@*
CE3114A.ADA@*
CE3115A.ADA@*
CE3207A.ADA@*
CE3301A.ADA@*
CE3302A.ADA@*
CE3304A.TST@*
CE3305A.ADA@*
CE3401A.ADA@*
CE3402A.ADA@*
CE3402C.ADA@*
CE3402D.ADA@*
CE3403A.ADA@*
CE3403B.ADA@*
CE3403C.ADA@*
CE3403E.ADA@*
CE3403F.ADA@*
CE3404B.ADA@*
CE3404C.ADA@*
CE3404D.ADA@*
CE3405A.ADA@*
CE3405C.ADA@*
CE3405D.ADA@*
CE3406A.ADA@*
CE3406B.ADA@*
CE3406C.ADA@*
CE3406D.ADA@*
CE3407A.ADA@*
CE3407B.ADA@*
CE3407C.ADA@*
CE3408A.ADA@*
CE3408B.ADA@*
CE3408C.ADA@*
CE3409A.ADA@*
CE3409C.ADA@*
CE3409D.ADA@*
CE3409E.ADA@*
CE3410A.ADA@*
CE3410C.ADA@*
CE3410D.ADA@*
CE3410E.ADA@*
CE3411A.ADA@*
CE3411C.ADA@*
CE3412A.ADA@*
CE3413A.ADA@*
CE3413B.ADA@*
CE3413C.ADA@*
CE3414A.ADA@*
CE3602A.ADA@*
CE3602B.ADA@*
CE3602C.ADA@*
CE3602D.ADA@*
CE3603A.ADA@*
CE3604A.ADA@*
CE3604B.ADA@*
CE3605A.ADA@*
CE3605B.ADA@*
CE3605C.ADA@*
CE3605D.ADA@*
CE3605E.ADA@*
CE3606A.ADA@*
CE3606B.ADA@*
CE3704A.ADA@*
CE3704B.ADA@*
CE3704C.ADA@*
CE3704D.ADA@*
CE3704E.ADA@*
CE3704F.ADA@*
CE3704M.ADA@*
CE3704N.ADA@*
CE3704O.ADA@*
CE3705A.ADA@*
CE3705B.ADA@*
CE3705C.ADA@*
CE3705D.ADA@*
CE3705E.ADA@*
CE3706D.ADA@*
CE3706F.ADA@*
CE3706G.ADA@*
CE3804A.ADA@*
CE3804B.ADA@*
CE3804C.ADA@*
CE3804D.ADA@*
CE3804E.ADA@*
CE3804F.ADA@*
CE3804G.ADA@*
CE3804H.ADA@*
CE3804I.ADA@*
CE3804J.ADA@*
CE3804M.ADA@*
CE3804O.ADA@*
CE3804P.ADA@*
CE3805A.ADA@*
CE3805B.ADA@*
CE3806A.ADA@*
CE3806B.ADA@*
CE3806D.ADA@*
CE3806E.ADA@*
CE3806G.ADA@*
CE3806H.ADA@*
CE3902B.ADA@*
CE3904A.ADA@*
CE3904B.ADA@*
CE3905A.ADA@*
CE3905B.ADA@*
CE3905C.ADA@*
CE3905L.ADA@*
CE3906A.ADA@*
CE3906B.ADA@*
CE3906C.ADA@*
CE3906E.ADA@*
CE3906F.ADA@*
CXAA003.A@*
CXAA004.A@*
CXAA005.A@*
CXAA009.A@*
CXAA010.A@*
CXAA011.A@*
CXAA012.A@*
CXAA014.A@*
CXAA016.A@*
CXAA017.A@*
CXAA018.A@*
CXAA019.A@*
CXAA020.A@*
CXAA021.A@*
CXAA022.A@*
CXAG001.A@*
CXF3A06.A@*
CXG1003.A@*
EE3203A.ADA@*
EE3204A.ADA@*
EE3402B.ADA@*
EE3409F.ADA@*
EE3412C.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt
to create or open a text file with mode @Exam{Append_File}, then the tests
contained in the following files should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CXAA001.A@*
CXAA002.A@*
CXAA006.A@*
CXAA007.A@*
CXAA008.A@*
CXAA013.A@*
CXAA015.A
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Reset} is not supported for text files, then the following
tests should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE3104C.ADA@*
CE3115A.ADA@*
CXAA020.A
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Delete} is not supported for text files, then the following
tests should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE3110A.ADA@*
CE3114A.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If association of multiple internal text files (opened for reading
and writing) to a single external file is not supported, then the test
contained in the following file should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE3115A.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If there are no inappropriate values for either line length or page
length, then the test contained in the following file should report
NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE3304A.TST
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If the value of @Exam{Count'Last} is greater than 150_000, then the
following test should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE3413B.ADA
@end{FourCol}



@Newpage@Comment{To avoid nasty page break}
@LabeledSubClause{Text Files (Supported Features)}

@leading@keepnext@;If @Exam{Create} with mode @Exam{In_File} is supported for text files, then
the test contained in the following file should report NOT_APPLICABLE:

@begin{FourCol}
CE3102E.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Open} with mode @Exam{In_File} is supported for text files, then
the test contained in the following file should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE3102J.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Create} with mode @Exam{Out_File} is supported for text
files, then the test contained in the following file should report
NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE3102I.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Open} with mode @Exam{Out_File} is supported for text files,
then the following test should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE3102K.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Reset} is supported for text files, then the test contained
in the following file should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE3102F.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Delete} for text files is supported, then the test contained
in the following file should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE3102G.ADA
@end{FourCol}

@LabeledSubClause{Sequential Files (Non-supported Features)}

@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt
to create or open a sequential file (this is appropriate behavior for an
implementation which does not support sequential files), then the tests
contained in the following files should report NOT_APPLICABLE:

@begin{FourCol}
CE2102A.ADA@*
CE2102C.TST@*
CE2102G.ADA@*
CE2102N.ADA@*
CE2102O.ADA@*
CE2102P.ADA@*
CE2102Q.ADA@*
CE2102X.ADA@*
CE2103A.TST@*
CE2103C.ADA@*
CE2104A.ADA@*
CE2104B.ADA@*
CE2106A.ADA@*
CE2108E.ADA@*
CE2108F.ADA@*
CE2109A.ADA@*
CE2110A.ADA@*
CE2111A.ADA@*
CE2111C.ADA@*
CE2111F.ADA@*
CE2111I.ADA@*
CE2201A.ADA@*
CE2201B.ADA@*
CE2201C.ADA@*
CE2201D.DEP@*
CE2201E.DEP@*
CE2201F.ADA@*
CE2201G.ADA@*
CE2201H.ADA@*
CE2201I.ADA@*
CE2201J.ADA@*
CE2201K.ADA@*
CE2201L.ADA@*
CE2201M.ADA@*
CE2201N.ADA@*
CE2203A.TST@*
CE2204A.ADA@*
CE2204B.ADA@*
CE2204C.ADA@*
CE2204D.ADA@*
CE2205A.ADA@*
CE2206A.ADA@*
CE2208B.ADA@*
CXA8001.A@*
CXA8002.A
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt
to create or open a sequential file with mode @Exam{In_File},
then the tests contained in the following files should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102G.ADA@*
CE2102O.ADA@*
CE2104A.ADA@*
CE2104B.ADA@*
CE2108F.ADA@*
CE2111A.ADA@*
CE2111C.ADA@*
CE2111F.ADA@*
CE2201A.ADA@*
CE2201B.ADA@*
CE2201C.ADA@*
CE2201F.ADA@*
CE2201G.ADA@*
CE2201H.ADA@*
CE2201I.ADA@*
CE2201J.ADA@*
CE2201K.ADA@*
CE2201L.ADA@*
CE2201M.ADA@*
CE2201N.ADA@*
CE2204A.ADA@*
CE2205A.ADA@*
CE2206A.ADA@*
CE2208B.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt
to create or open a sequential file with mode @Exam{Out_File}, then the tests
contained in the following files should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102A.ADA@*
CE2102C.TST@*
CE2102G.ADA@*
CE2102N.ADA@*
CE2102O.ADA@*
CE2102P.ADA@*
CE2102Q.ADA@*
CE2102X.ADA@*
CE2103A.TST@*
CE2103C.ADA@*
CE2104A.ADA@*
CE2104B.ADA@*
CE2106A.ADA@*
CE2108E.ADA@*
CE2108F.ADA@*
CE2109A.ADA@*
CE2110A.ADA@*
CE2111A.ADA@*
CE2111C.ADA@*
CE2111F.ADA@*
CE2111I.ADA@*
CE2201A.ADA@*
CE2201B.ADA@*
CE2201C.ADA@*
CE2201D.DEP@*
CE2201E.DEP@*
CE2201F.ADA@*
CE2201G.ADA@*
CE2201H.ADA@*
CE2201I.ADA@*
CE2201J.ADA@*
CE2201K.ADA@*
CE2201L.ADA@*
CE2201M.ADA@*
CE2201N.ADA@*
CE2203A.TST@*
CE2204A.ADA@*
CE2204B.ADA@*
CE2204C.ADA@*
CE2204D.ADA@*
CE2205A.ADA@*
CE2206A.ADA@*
CE2208B.ADA@*
CXA8001.A
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt
to create or open a sequential file with mode APPEND_FILE, then
the tests contained in the following files should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CXA8001.A
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If reset to mode @Exam{Out_File} is not supported for sequential
files, then the tests contained in the following files should report
NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2111C.ADA@*
CE2111F.ADA@*
CE2111I.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If reset to mode @Exam{In_File} is not supported for sequential files, then the tests contained in the following files should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2111F.ADA@*
CE2111I.ADA@*
CE2204C.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Delete} for sequential files is not supported, then the tests contained in the following files should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2106A.ADA@*
CE2110A.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If the implementation cannot restrict the file capacity for a sequential file, then the test contained in the following file should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2203A.TST
@end{FourCol}


@LabeledSubClause{Sequential Files (Supported Features)}

@leading@keepnext@;If @Exam{Create} with mode @Exam{In_File} is supported for sequential files,
then the test contained in the following file should report NOT_APPLICABLE:

@begin{FourCol}
CE2102D.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Open} with mode @Exam{In_File} is supported for sequential
files, then the test contained in the following file should report
NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102N.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Reset} to mode @Exam{In_File} is supported for sequential
files, then the test contained in the following file should report
NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102O.ADA@*
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Create} with mode @Exam{Out_File} is supported, then the
test contained in the following file should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102E.ADA@*
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Open} with mode @Exam{Out_File} is supported, then the test
contained in the following file should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102P.ADA@*
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Reset} to mode @Exam{Out_File} is supported for sequential
files, then the test contained in the following file should report
NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102Q.ADA@*
@end{FourCol}


@LabeledSubClause{Direct Files (Non-supported Features)}

@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt
to create or open a direct access file (this is appropriate behavior for an
implementation which does not support direct access files), then the tests
contained in the following files should report NOT_APPLICABLE:

@begin{FourCol}
CE2102B.ADA@*
CE2102H.TST@*
CE2102K.ADA@*
CE2102R.ADA@*
CE2102S.ADA@*
CE2102T.ADA@*
CE2102U.ADA@*
CE2102V.ADA@*
CE2102W.ADA@*
CE2102Y.ADA@*
CE2103B.TST@*
CE2103D.ADA@*
CE2104C.ADA@*
CE2104D.ADA@*
CE2106B.ADA@*
CE2108G.ADA@*
CE2108H.ADA@*
CE2109B.ADA@*
CE2110C.ADA@*
CE2111B.ADA@*
CE2111E.ADA@*
CE2111G.ADA@*
CE2401A.ADA@*
CE2401B.ADA@*
CE2401C.ADA@*
CE2401E.ADA@*
CE2401F.ADA@*
CE2401H.ADA@*
CE2401I.ADA@*
CE2401J.ADA@*
CE2401K.ADA@*
CE2401L.ADA@*
CE2403A.TST@*
CE2404A.ADA@*
CE2404B.ADA@*
CE2405B.ADA@*
CE2406A.ADA@*
CE2407A.ADA@*
CE2407B.ADA@*
CE2408A.ADA@*
CE2408B.ADA@*
CE2409A.ADA@*
CE2409B.ADA@*
CE2410A.ADA@*
CE2410B.ADA@*
CE2411A.ADA@*
CXA8003.A@*
CXA9001.A@*
CXA9002.A
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt
to create or open a direct access file with mode @Exam{In_File}, then the tests
contained in the following files should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102K.ADA@*
CE2102U.ADA@*
CE2104C.ADA@*
CE2104D.ADA@*
CE2108H.ADA@*
CE2111B.ADA@*
CE2111E.ADA@*
CE2401A.ADA@*
CE2401B.ADA@*
CE2401C.ADA@*
CE2401E.ADA@*
CE2401F.ADA@*
CE2401H.ADA@*
CE2401I.ADA@*
CE2405B.ADA@*
CE2406A.ADA@*
CE2407A.ADA@*
CE2411A.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt
to create or open a direct access file with mode @Exam{Out_File}, then the
tests contained in the following files should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102B.ADA@*
CE2102K.ADA@*
CE2102R.ADA@*
CE2102W.ADA@*
CE2102Y.ADA@*
CE2103B.TST@*
CE2103D.ADA@*
CE2104C.ADA@*
CE2104D.ADA@*
CE2106B.ADA@*
CE2108G.ADA@*
CE2108H.ADA@*
CE2110C.ADA@*
CE2111B.ADA@*
CE2111E.ADA@*
CE2403A.TST@*
CE2404A.ADA@*
CE2404B.ADA@*
CE2405B.ADA@*
CE2407A.ADA@*
CE2407B.ADA@*
CE2408A.ADA@*
CE2409B.ADA@*
CE2410A.ADA@*
CE2410B.ADA@*
CE2411A.ADA@*
CXA8003.A@*
CXA9001.A@*
CXA9002.A
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt
to create or open a direct access file with mode @exam{InOut_File}, then the
tests contained in the following files should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102H.TST@*
CE2102K.ADA@*
CE2102S.ADA@*
CE2102T.ADA@*
CE2102U.ADA@*
CE2102V.ADA@*
CE2109B.ADA@*
CE2111B.ADA@*
CE2111E.ADA@*
CE2111G.ADA@*
CE2401A.ADA@*
CE2401B.ADA@*
CE2401C.ADA@*
CE2401E.ADA@*
CE2401F.ADA@*
CE2401H.ADA@*
CE2401I.ADA@*
CE2401J.ADA@*
CE2401K.ADA@*
CE2401L.ADA@*
CE2405B.ADA@*
CE2406A.ADA@*
CE2408B.ADA@*
CE2409A.ADA@*
CE2411A.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Delete} for direct access files is not supported, then the
following tests should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2106B.ADA@*
CE2110C.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If the implementation cannot restrict the file capacity for a direct
file, then the test contained in the following file should report
NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2403A.TST
@end{FourCol}

@LabeledSubClause{Direct Files (Supported Features)}

@leading@keepnext@;If @Exam{Create} with mode @Exam{In_File} is supported for direct
access files, then the test contained in the following file should report
NOT_APPLICABLE:

@begin{FourCol}
CE2102I.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Open} with mode @Exam{In_File} is supported for direct access files, then the test contained in the following file should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102T.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Reset} with mode @Exam{In_File} is supported for direct access files, then the test contained in the following file should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102U.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Create} with mode @Exam{Out_File} is supported for direct access files, then the test contained in the following file should report NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102J.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Open} with mode @Exam{Out_File} is supported for direct
access files, then the test contained in the following file should report
NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102V.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Reset} with mode @Exam{Out_File} is supported for direct
access files, then the test contained in the following file should report
NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102W.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Create} with mode @exam{InOut_File} is supported for direct
access files, then the test contained in the following file should report
NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102F.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Open} with mode @exam{InOut_File} is supported for direct
access files, then the test contained in the following file should report
NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102R.ADA
@end{FourCol}

@begin{WideAbove}
@leading@keepnext@;If @Exam{Reset} to mode @exam{InOut_File} is supported for direct access
files, then the test contained in the following file should report
NOT_APPLICABLE:
@end{WideAbove}

@begin{FourCol}
CE2102S.ADA
@end{FourCol}


@LabeledSubClause{Stream Files (Non-supported Features)}

@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt
to create or open a stream file (this is the appropriate behavior for an
implementation which does not support stream files), then the tests contained
in the following files should report NOT_APPLICABLE:

@begin{FourCol}
CXAA019.A@*
CXAC001.A@*
CXAC002.A@*
CXAC003.A@*
CXAC004.A@*
CXAC005.A@*
CXAC006.A@*
CXAC007.A@*
CXAC008.A@*
CXACA01.A@*
CXACA02.A@*
CXACB01.A@*
CXACB02.A@*
CXACC01.A
@end{FourCol}


@LabeledSubClause{Wide Text Files (Non-supported Features)}

If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt to create
or open a wide text file (this is the appropriate behavior for an
implementation which does not support wide text files), then the tests
contained in the following files should report NOT_APPLICABLE:

@begin{FourCol}
CXAA019.A@*
CXAB001.A@*
CXAB002.AU@*
CXAB004.AU
@end{FourCol}


@LabeledSubClause{Wide Wide Text Files (Non-supported Features)}

If @Exam{Use_Error} or @Exam{Name_Error} is raised by every attempt to create
or open a wide wide text file (this is the appropriate behavior for an
implementation which does not support wide wide text files), then the tests
contained in the following files should report NOT_APPLICABLE:

@begin{FourCol}
CXAB003.AU@*
CXAB005.AU
@end{FourCol}


@LabeledSubClause{Directory Operations (Non-supported Features)}

@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every
attempt to read the current default directory, then the tests
contained in the following files should report NOT_APPLICABLE:

@begin{FourCol}
CXAG001.A@*
CXAG002.A
@end{FourCol}

@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every
attempt to set the current default directory, then the tests
contained in the following files should report NOT_APPLICABLE:

@begin{FourCol}
CXAG001.A
@end{FourCol}

@leading@keepnext@;If @Exam{Use_Error} or @Exam{Name_Error} is raised by every
attempt to create a directory, then the tests contained in the following files
should report NOT_APPLICABLE:

@begin{FourCol}
CXAG001.A
@end{FourCol}


@LabeledSubClause{File I/O Tests}

If sequential, text, wide text, wide wide text, direct access, and stream
files are not supported, along with directory operations on them, then the
tests contained in the following files should eport NOT_APPLICABLE:

@begin{FourCol}
CE2102A.ADA@*
CE2102B.ADA@*
CE2102C.TST@*
CE2102G.ADA@*
CE2102H.TST@*
CE2102K.ADA@*
CE2102N.ADA@*
CE2102O.ADA@*
CE2102P.ADA@*
CE2102Q.ADA@*
CE2102R.ADA@*
CE2102S.ADA@*
CE2102T.ADA@*
CE2102U.ADA@*
CE2102V.ADA@*
CE2102W.ADA@*
CE2102X.ADA@*
CE2102Y.ADA@*
CE2103A.TST@*
CE2103B.TST@*
CE2103C.ADA@*
CE2103D.ADA@*
CE2104A.ADA@*
CE2104B.ADA@*
CE2104C.ADA@*
CE2104D.ADA@*
CE2106A.ADA@*
CE2106B.ADA@*
CE2108E.ADA@*
CE2108F.ADA@*
CE2108G.ADA@*
CE2108H.ADA@*
CE2109A.ADA@*
CE2109B.ADA@*
CE2109C.ADA@*
CE2110A.ADA@*
CE2110C.ADA@*
CE2111A.ADA@*
CE2111B.ADA@*
CE2111C.ADA@*
CE2111E.ADA@*
CE2111F.ADA@*
CE2111G.ADA@*
CE2111I.ADA@*
CE2201A.ADA@*
CE2201B.ADA@*
CE2201C.ADA@*
CE2201D.DEP@*
CE2201E.DEP@*
CE2201F.ADA@*
CE2201G.ADA@*
CE2201H.ADA@*
CE2201I.ADA@*
CE2201J.ADA@*
CE2201K.ADA@*
CE2201L.ADA@*
CE2201M.ADA@*
CE2201N.ADA@*
CE2203A.TST@*
CE2204A.ADA@*
CE2204B.ADA@*
CE2204C.ADA@*
CE2204D.ADA@*
CE2205A.ADA@*
CE2206A.ADA@*
CE2208B.ADA@*
CE2401A.ADA@*
CE2401B.ADA@*
CE2401C.ADA@*
CE2401E.ADA@*
CE2401F.ADA@*
CE2401H.ADA@*
CE2401I.ADA@*
CE2401J.ADA@*
CE2401K.ADA@*
CE2401L.ADA@*
CE2403A.TST@*
CE2404A.ADA@*
CE2404B.ADA@*
CE2405B.ADA@*
CE2406A.ADA@*
CE2407A.ADA@*
CE2407B.ADA@*
CE2408A.ADA@*
CE2408B.ADA@*
CE2409A.ADA@*
CE2409B.ADA@*
CE2410A.ADA@*
CE2410B.ADA@*
CE2411A.ADA@*
CE3102A.ADA@*
CE3102B.TST@*
CE3102F.ADA@*
CE3102G.ADA@*
CE3102H.ADA@*
CE3102J.ADA@*
CE3102K.ADA@*
CE3103A.ADA@*
CE3104A.ADA@*
CE3104B.ADA@*
CE3104C.ADA@*
CE3106A.ADA@*
CE3106B.ADA@*
CE3107A.TST@*
CE3107B.ADA@*
CE3108A.ADA@*
CE3108B.ADA@*
CE3110A.ADA@*
CE3112C.ADA@*
CE3112D.ADA@*
CE3114A.ADA@*
CE3115A.ADA@*
CE3207A.ADA@*
CE3301A.ADA@*
CE3302A.ADA@*
CE3304A.TST@*
CE3305A.ADA@*
CE3401A.ADA@*
CE3402A.ADA@*
CE3402C.ADA@*
CE3402D.ADA@*
CE3403A.ADA@*
CE3403B.ADA@*
CE3403C.ADA@*
CE3403E.ADA@*
CE3403F.ADA@*
CE3404B.ADA@*
CE3404C.ADA@*
CE3404D.ADA@*
CE3405A.ADA@*
CE3405C.ADA@*
CE3405D.ADA@*
CE3406A.ADA@*
CE3406B.ADA@*
CE3406C.ADA@*
CE3406D.ADA@*
CE3407A.ADA@*
CE3407B.ADA@*
CE3407C.ADA@*
CE3408A.ADA@*
CE3408B.ADA@*
CE3408C.ADA@*
CE3409A.ADA@*
CE3409C.ADA@*
CE3409D.ADA@*
CE3409E.ADA@*
CE3410A.ADA@*
CE3410C.ADA@*
CE3410D.ADA@*
CE3410E.ADA@*
CE3411A.ADA@*
CE3411C.ADA@*
CE3412A.ADA@*
CE3413A.ADA@*
CE3413B.ADA@*
CE3413C.ADA@*
CE3414A.ADA@*
CE3602A.ADA@*
CE3602B.ADA@*
CE3602C.ADA@*
CE3602D.ADA@*
CE3603A.ADA@*
CE3604A.ADA@*
CE3604B.ADA@*
CE3605A.ADA@*
CE3605B.ADA@*
CE3605C.ADA@*
CE3605D.ADA@*
CE3605E.ADA@*
CE3606A.ADA@*
CE3606B.ADA@*
CE3704A.ADA@*
CE3704B.ADA@*
CE3704C.ADA@*
CE3704D.ADA@*
CE3704E.ADA@*
CE3704F.ADA@*
CE3704M.ADA@*
CE3704N.ADA@*
CE3704O.ADA@*
CE3705A.ADA@*
CE3705B.ADA@*
CE3705C.ADA@*
CE3705D.ADA@*
CE3705E.ADA@*
CE3706D.ADA@*
CE3706F.ADA@*
CE3706G.ADA@*
CE3804A.ADA@*
CE3804B.ADA@*
CE3804C.ADA@*
CE3804D.ADA@*
CE3804E.ADA@*
CE3804F.ADA@*
CE3804G.ADA@*
CE3804H.ADA@*
CE3804I.ADA@*
CE3804J.ADA@*
CE3804M.ADA@*
CE3804O.ADA@*
CE3804P.ADA@*
CE3805A.ADA@*
CE3805B.ADA@*
CE3806A.ADA@*
CE3806B.ADA@*
CE3806D.ADA@*
CE3806E.ADA@*
CE3806G.ADA@*
CE3806H.ADA@*
CE3902B.ADA@*
CE3904A.ADA@*
CE3904B.ADA@*
CE3905A.ADA@*
CE3905B.ADA@*
CE3905C.ADA@*
CE3905L.ADA@*
CE3906A.ADA@*
CE3906B.ADA@*
CE3906C.ADA@*
CE3906E.ADA@*
CE3906F.ADA@*
CXA8001.A@*
CXA8002.A@*
CXA8003.A@*
CXA9001.A@*
CXA9002.A@*
CXAA001.A@*
CXAA002.A@*
CXAA003.A@*
CXAA004.A@*
CXAA005.A@*
CXAA006.A@*
CXAA007.A@*
CXAA008.A@*
CXAA009.A@*
CXAA010.A@*
CXAA011.A@*
CXAA012.A@*
CXAA013.A@*
CXAA014.A@*
CXAA015.A@*
CXAA016.A@*
CXAA017.A@*
CXAA018.A@*
CXAA019.A@*
CXAA020.A@*
CXAA021.A@*
CXAA022.A@*
CXAB001.A@*
CXAB002.AU@*
CXAB003.AU@*
CXAB004.AU@*
CXAB005.AU@*
CXAC001.A@*
CXAC002.A@*
CXAC003.A@*
CXAC004.A@*
CXAC005.A@*
CXAC006.A@*
CXAC007.A@*
CXAC008.A@*
CXACA01.A@*
CXACA02.A@*
CXACB01.A@*
CXACB02.A@*
CXACC01.A@*
CXAG001.A@*
CXAG002.A@*
CXF3A06.A@*
CXG1003.A@*
EE3203A.ADA@*
EE3204A.ADA@*
EE3402B.ADA@*
EE3409F.ADA@*
EE3412C.ADA
@end{FourCol}


@LabeledSubClause{Memory for Allocated Objects}

@leading@keepnext@;If a large amount of memory (more than 32 megabytes for a typical
implementation) is available for allocated objects (those created by
@Key[new]), then the test contained in the following file should report
NOT_APPLICABLE:

@begin{FourCol}
CB10002.A
@end{FourCol}


@LabeledSubClause{Environment Variables}

@leading@keepnext@;If the target execution environment does not support
reading environment variables, then the tests contained in the following files
should report NOT_APPLICABLE:

@begin{FourCol}
CXAH001.A@*
CXAH002.A@*
CXAH003.A
@end{FourCol}

@leading@keepnext@;If the target execution environment does not support
creating, writing, and deleting environment variables, then the tests
contained in the following files should report NOT_APPLICABLE:

@begin{FourCol}
CXAH002.A@*
CXAH003.A
@end{FourCol}


@LabeledSubClause{Task Attributes}

If Annex C (Systems Programming) is tested and the size of a task attribute is
limited such that an attribute of a controlled type is not supported, then the
test contained in the following file should report NOT_APPLICABLE:

@begin{FourCol}
CXC7003.A
@end{FourCol}


@LabeledSubClause{Reserved Interrupts}

@leading@keepnext@;If Annex C (Systems Programming) is tested and no interrupts are
reserved, then the tests contained in the following files should report
NOT_APPLICABLE:

@begin{FourCol}
CXC3002.A@*
CXC3005.A
@end{FourCol}


@LabeledSubClause{Multiprocessor Systems}

@leading@keepnext@;If Annex D (Real-Time Systems) is tested and the target is a
multiprocessor, then the tests contained in the following files should report
NOT_APPLICABLE:

@begin{FourCol}
CXD2001.A@*
CXD2002.A@*
CXD2003.A@*
CXD2004.A@*
CXD2007.A@*
CXD2008.A@*
CXD6001.A@*
CXD6002.A@*
CXD6003.A
@end{FourCol}


@LabeledSubClause{Non-binary Machine Radix}

@leading@keepnext@;If Annex G (Numerics) is tested and the machine radix is not a power
of two, then the test contained in the following file should report
NOT_APPLICABLE:

@begin{FourCol}
CXG2010.A
@end{FourCol}
