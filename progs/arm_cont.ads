package ARM_Contents is

    --
    -- Ada reference manual formatter.
    --
    -- This package contains the routines to manage section/clause/subclause
    -- references.
    --
    -- ---------------------------------------
    -- Copyright 2000, AXE Consultants.
    -- P.O. Box 1512, Madison WI  53701
    -- E-Mail: rbrukardt@bix.com
    --
    -- AXE Consultants grants to all users the right to use/modify this
    -- formatting tool for non-commercial purposes. (ISO/IEC JTC 1 SC 22 WG 9
    -- activities are explicitly included as "non-commercial purposes".)
    -- Commercial uses of this software and its source code, including but not
    -- limited to documents for sale and sales of modified versions of this
    -- tool, are prohibited without the prior written permission of
    -- AXE Consultants. All rights not explicitly granted above are reserved
    -- by AXE Consultants.
    --
    -- You use this tool and/or its source code on the condition that you indemnify and hold harmless
    -- AXE Consultants, its agents, and employees, from any and all liability
    -- or damages to yourself or your hardware or software, or third parties,
    -- including attorneys' fees, court costs, and other related costs and
    -- expenses, arising out of your use of this tool and/or source code irrespective of the
    -- cause of said liability.
    --
    -- AXE CONSULTANTS MAKES THIS TOOL AND SOURCE CODE AVAILABLE ON AN "AS IS"
    -- BASIS AND MAKES NO WARRANTY, EXPRESS OR IMPLIED, AS TO THE ACCURACY,
    -- CAPABILITY, EFFICIENCY, MERCHANTABILITY, OR FUNCTIONING OF THIS TOOL.
    -- IN NO EVENT WILL AXE CONSULTANTS BE LIABLE FOR ANY GENERAL,
    -- CONSEQUENTIAL, INDIRECT, INCIDENTAL, EXEMPLARY, OR SPECIAL DAMAGES,
    -- EVEN IF AXE CONSULTANTS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
    -- DAMAGES.
    -- ---------------------------------------
    --
    -- Edit History:
    --
    --  4/19/00 - RLB - Created base package.
    --  4/26/00 - RLB - Added Previous_Clause and Next_Clause.
    --  5/15/00 - RLB - Added rules about unnumbered sections.
    --  5/22/00 - RLB - Added Unnumbered_Section level.
    --  8/ 7/00 - RLB - Made Make_Clause visible.
    --  8/22/00 - RLB - Added Old_Title handling.

    subtype Title_Type is String (1 .. 80);
	-- The type of a title.

    type Section_Number_Type is range 0 .. 47;
	-- Values > 20 represent annex letters (21 => A, 22 => B, etc.)
	-- Value = 0 represents the preface, introduction, etc. No
	-- number is generated if Section_Number = 0.

    Not_Found_Error : exception;

    procedure Initialize;
	-- Initialize this package; make sure the contents are empty.

    type Level_Type is (Section, Unnumbered_Section, Normative_Annex,
			Informative_Annex, Clause, Subclause);
	-- Defines the level of a clause header.

    procedure Add (Title : in Title_Type;
		   Level : in Level_Type;
		   Section_Number : in Section_Number_Type;
		   Clause_Number : in Natural := 0;
		   Subclause_Number : in Natural := 0);
	-- Add a section or clause to the contents. It has the specified
	-- characteristics.

    procedure Add_Old (Old_Title : in Title_Type;
		       Level : in Level_Type;
		       Section_Number : in Section_Number_Type;
		       Clause_Number : in Natural := 0;
		       Subclause_Number : in Natural := 0);
	-- Add an old title for a section or clause to the contents. It has
	-- the specified characteristics.

    function Make_Clause_Number (Level : in Level_Type;
		   Section_Number : in Section_Number_Type;
		   Clause_Number : in Natural := 0;
		   Subclause_Number : in Natural := 0) return String;
	-- Returns a properly formatted Section or clause number reference.
	-- Note that an unnumbered section returns a number with a
	-- Section_Number of zero (for sorting purposes).

    procedure Make_Clause (Clause_String : in String;
			   Section_Number : out Section_Number_Type;
			   Clause_Number : out Natural;
			   Subclause_Number : out Natural);
	-- Returns the clause number for a properly formatted Section or
	-- clause string.

    function Lookup_Clause_Number (Title : in Title_Type) return String;
	-- Given the title of a clause, returns the formatted Section or
	-- clause number reference for that title. The Title must match
	-- exactly, except for case. Raises Not_Found_Error if not found.

    function Lookup_Level (Title : in Title_Type) return Level_Type;
	-- Given the title of a clause, returns the level for that title. The Title must match
	-- exactly, except for case. Raises Not_Found_Error if not found.

    function Lookup_Title (Level : in Level_Type;
		   Section_Number : in Section_Number_Type;
		   Clause_Number : in Natural := 0;
		   Subclause_Number : in Natural := 0) return Title_Type;
	-- Given the level, section, and clause numbers, return the appropriate
	-- title. Raises Not_Found_Error if not found.

    function Lookup_Old_Title (Level : in Level_Type;
		   Section_Number : in Section_Number_Type;
		   Clause_Number : in Natural := 0;
		   Subclause_Number : in Natural := 0) return Title_Type;
	-- Given the level, section, and clause numbers, return the appropriate
	-- old title. Calls Lookup_Title if not found (thus returning the
	-- regular (new) title.

    function Previous_Clause (Clause : in String) return String;
	-- Returns the string of the previous clause (in the table of contents)
	-- for the properly formatted clause string Clause.
	-- Raises Not_Found_Error if not found.

    function Next_Clause (Clause : in String) return String;
	-- Returns the string of the next clause (in the table of contents)
	-- for the properly formatted clause string Clause.
	-- Raises Not_Found_Error if not found.

    generic
	with procedure Operate (Title : in Title_Type;
		   Level : in Level_Type;
		   Section_Number : in Section_Number_Type;
		   Clause_Number : in Natural;
		   Subclause_Number : in Natural;
		   Quit : out Boolean) is <>;
    procedure For_Each;
	-- Call Operate for each title in the contents, in the order that
	-- they were added to the contents. If the Quit parameter to Operate
	-- is True when Operate returns, the iteration is abandoned.

end ARM_Contents;