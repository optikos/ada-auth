with ARM_Contents;
package ARM_Output is

    --
    -- Ada reference manual formatter.
    --
    -- This package defines the abstract definition of an output object.
    -- Output objects are responsible for implementing the details of
    -- a particular format.
    --
    -- We use dispatching calls to call the formatter, so the details of
    -- formatting are insulated from the code that reads the source and
    -- determines the details of the text.
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
    --  4/14/00 - RLB - Created base package.
    --  4/18/00 - RLB - Added index and contents marker routines.
    --  4/21/00 - RLB - Added line break and hard space routines.
    --  4/24/00 - RLB - Added DR references and Insert/Delete text formats.
    --  4/25/00 - RLB - Added size to format.
    --  4/29/00 - RLB - Added Indented and Bulleted formats.
    --  5/10/00 - RLB - Added Syntax and Hanging formats.
    --		- RLB - Added End_Hang_Item.
    --  5/12/00 - RLB - Added No_Prefix to Start_Paragraph.
    --  5/13/00 - RLB - Added Special_Character.
    --  5/16/00 - RLB - Added more special characters.
    --  5/17/00 - RLB - Added New_Page.
    --  5/22/00 - RLB - Added Includes_Changes to Create.
    --  5/23/00 - RLB - Added Set_Column and New_Column.
    --		      - Added Tab_Info and Tab_Stops.
    --  5/24/00 - RLB - Added Location to Text_Format.
    --		- RLB - Added No_Breaks and Keep_with_Next to Start_Paragraph.
    --  5/25/00 - RLB - Added Big_Files to Create. Added Justification.
    --		- RLB - Added Separator_Lines and TOC routines.
    --  5/26/00 - RLB - Added table operations.
    --  6/ 2/00 - RLB - Added Soft_Line_Break.
    --  8/ 2/00 - RLB - Added Soft_Hyphen_Break and left and right quote
    --			characters.
    --		- RLB - Added new styles.
    --  8/ 7/00 - RLB - Added Leading flag to Start_Paragraph, removed "Leading"
    --			styles.
    --  8/11/00 - RLB - Added Hanging_in_Bulleted styles.
    --  8/16/00 - RLB - Added Code_Indented_Nested_Bulleted.
    --  8/17/00 - RLB - Replaced "Leading" by "Space_After".
    -- 		- RLB - Added Nested_Enumerated.
    --  8/22/00 - RLB - Added Revised_Clause_Header.
    --  9/26/00 - RLB - Added Syntax_Summary style.

    type Output_Type is abstract tagged limited null record;

    Not_Valid_Error : exception; -- Raised when an operation is invalid.

    type Document_Type is (RM, RM_ISO, AARM);
    type Page_Size is (A4, Letter, Ada95);
	-- A4 is standard European letter size.
	-- Letter is standard American letter size (8.5x11).
	-- Ada95 is the size of the existing Ada 95 standard (7x9).

    procedure Create (Output_Object : in out Output_Type;
		      Document : in ARM_Output.Document_Type;
		      Page_Size : in ARM_Output.Page_Size;
		      Includes_Changes : in Boolean;
		      Big_Files : in Boolean) is abstract;
	-- Create an Output_Object for a document of Document type, with
	-- the specified page size. Changes from the base standard are included
	-- if Includes_Changes is True. Generate a few large output files if
	-- Big_Files is True; otherwise generate smaller output files.


    procedure Close (Output_Object : in out Output_Type) is abstract;
	-- Close an Output_Object. No further output to the object is
	-- allowed after this call.


    procedure Section (Output_Object : in out Output_Type;
		       Section_Title : in String;
		       Section_Name : in String) is abstract;
	-- Start a new section. The title is Section_Title (this is
	-- intended for humans). The name is Section_Name (this is
	-- intended to be suitable to be a portion of a file name).

    subtype Column_Count is Natural range 1 .. 8;
    procedure Set_Columns (Output_Object : in out Output_Type;
			   Number_of_Columns : in ARM_Output.Column_Count) is abstract;
	-- Set the number of columns.
	-- Raises Not_Valid_Error if in a paragraph.

    type Paragraph_Type is (Normal, Wide,
	Notes, Notes_Header, Annotations, Wide_Annotations, Index, Syntax_Summary,
	Examples, Small_Examples,
	Indented_Examples, Small_Indented_Examples,
	Syntax_Indented, Code_Indented,
	Small_Code_Indented, Indented, Small_Indented,
	Bulleted, Nested_Bulleted, Small_Bulleted, Small_Nested_Bulleted,
	Indented_Bulleted, Code_Indented_Bulleted, Code_Indented_Nested_Bulleted,
        Syntax_Indented_Bulleted, Notes_Bulleted, Notes_Nested_Bulleted,
	Hanging, Small_Hanging, Indented_Hanging, Small_Indented_Hanging,
	Hanging_in_Bulleted, Small_Hanging_in_Bulleted,
	Enumerated, Small_Enumerated, Nested_Enumerated, Small_Nested_Enumerated);
	-- The type of paragraph (this controls the formatting).
	-- Normal paragraphs have the style of the body text for the
	--     Reference Manual.
	-- Notes paragraphs are indented one unit, and are in a smaller font.
	-- Notes_Header paragraphs are indented one unit, and are in a
	--     smaller font, and have much less space than normal following.
	-- Annotations are indented two units, and are in a smaller font (same
	--     as Notes).
	-- Index paragraphs are not indented, and are in a smaller font. If
	--     possible, lines that wrap are indented.
	-- Syntax_Summary paragraphs are indented one unit, and are in a
	--     smaller font.
	-- Examples are indented one unit, and are in a fixed font.
	-- Small_Examples are indented three units, and are in a smaller
	--     fixed font.
	-- Indented_Examples are indented four units, and are in a fixed font.
	-- Small_Indented_Examples are indented six units, and are in a smaller
	--     fixed font.
	-- Syntax_Indented paragraphs are indented one unit, and are in the
	--     normal font.
	-- Code_Indented paragraphs are indented two units, and are in the
	--     normal font.
	-- Small_Code_Indented paragraphs are indented four units, and are in a
	--     smaller font.
	-- Indented paragraphs are indented three units, and are in the normal
	--     font.
	-- Small_Indented paragraphs are indented five units, and are in a
	--     smaller font.
	-- Bulleted paragraphs are indented one unit, with a right indent of
	--     one unit, and each paragraph is preceeded by a bullet (a solid circle).
	-- Nested Bulleted paragraphs are indented two units, with a right
	--     indent of one unit, and each paragraph is preceeded by a small
	--     bullet (a solid circle). [These are intended to be used inside
	--     of an outer bulleted or enumerated list.]
	-- Small_Bulleted paragraphs are indented three units, with a right
	--     indent of one unit, each paragraph is preceeded by a bullet,
	--     and are in a smaller font (same as Notes).
	-- Small Nested Bulleted paragraphs are indented four units, with a
	--     right indent of one unit, each paragraph is preceeded by a
	--     small bullet, and are in a smaller font (same as Notes).
	-- Indented_Bulleted paragraphs are indented four units, with a right
	--     indent of one unit, and each paragraph is preceeded by a bullet.
	-- Code_Indented_Bulleted paragraphs are indented three units, and each
	--     paragraph is preceeded by a bullet.
	-- Code_Indented_Nested_Bulleted paragraphs are indented four units,
	--     and each paragraph is preceeded by a small bullet.
	-- Syntax_Indented_Bulleted paragraphs are indented two units, and each
	--     paragraph is preceeded by a bullet.
	-- Notes_Bulleted paragraphs are indented two units, are in a
	--     smaller font, and each paragraph is preceeded by a bullet.
	-- Notes_Nested_Bulleted paragraphs are indented three units, are in a
	--     smaller font, and each paragraph is preceeded by a small bullet.
	-- Hanging paragraphs are indented three units, but the first part
	--     of each paragraph (up to the call of End_Hang_Item) hangs out to
	--     the margin.
	-- Indented_Hanging paragraphs are indented three units, but the first
	--     part of each paragraph (up to the call of End_Hang_Item) hangs
	--     out to an indent of two units.
	-- Small_Hanging paragraphs are indented five units, but the first part
	--     of each paragraph (up to the call of End_Hang_Item) hangs out to
	--     an indent of two units, and are in a smaller font (same as
	--     Notes).
	-- Small_Indented_Hanging paragraphs are indented five units, but the
	--     first part of each paragraph (up to the call of End_Hang_Item)
	--     hangs out to an indent of four units, and are in a smaller font
	--     (same as Notes).
	-- Hanging_in_Bulleted paragraphs are indented three units, but the first
	--     part of each paragraph (up to the call of End_Hang_Item) hangs
	--     out to an indent of one unit; there is a right indent of one unit.
	--     This is used in a bulleted list.
	-- Small_Hanging_in_Bulleted paragraphs are indented five units, but the first part
	--     of each paragraph (up to the call of End_Hang_Item) hangs out to
	--     an indent of three units, and are in a smaller font (same as
	--     Notes). This is used in a bulleted list.
	-- Small_Indented_Hanging paragraphs are indented five units, but the
	--     first part of each paragraph (up to the call of End_Hang_Item)
	--     hangs out to an indent of four units, and are in a smaller font
	--     (same as Notes).
	-- Enumerated paragraphs are indented one unit, with a right indent of
	--     one unit, but the first part of each paragraph (up to the call of
	--     End_Hang_Item) hangs out as would a bullet.
	-- Small_Enumerated paragraphs are indented three units, with a right
	--     indent of one unit, but the first part of each paragraph (up to
	--     the call of End_Hang_Item) hangs out as would a bullet, and
	--     are in a smaller font (same as Notes).
	-- Nested_Enumerated paragraphs are indented two units, with a right
	--     indent of one unit, but the first part of each paragraph (up to
	--     the call of End_Hang_Item) hangs out as would a bullet.
	-- Small_Nested_Enumerated paragraphs are indented four units, with a
	--     right indent of one unit, but the first part of each paragraph
	--     (up to the call of End_Hang_Item) hangs out as would a bullet,
	--     and are in a smaller font (same as Notes).

	-- The indentation of paragraphs is described in "units", a mostly
	-- fixed amount from the left margin.

    subtype Tab_Location is Natural range 0 .. 200; -- Location of tab stops, in picas.
    type Tab_Kind_Type is (Left_Fixed, Left_Proportional);
	-- Proportional tabs are adjusted based on the default font size of
	-- the paragraph; they are given as if the font is 12 points.
    type Tab_Stop_Type is record
	Stop : Tab_Location;
	Kind : Tab_Kind_Type;
    end record;
    type Tab_Stops_Type is array (1 .. 20) of Tab_Stop_Type;
    type Tab_Info is record
	Number : Natural;
	Stops : Tab_Stops_Type;
    end record;
    NO_TABS : constant Tab_Info := (Number => 0, Stops => (others =>
	(Kind => Left_Fixed, Stop => 0)));

    type Justification_Type is (Default, Justified, Left, Center, Right);
	-- Defines the text justification for the paragraph.

    type Space_After_Type is (Normal, Narrow, Wide);
	-- Defines the space following the paragraph. Narrow is about 30%
	-- less than normal; Wide is about 50% more than normal.

    procedure Start_Paragraph (Output_Object : in out Output_Type;
			       Format : in ARM_Output.Paragraph_Type;
			       Number : in String;
			       No_Prefix : in Boolean := False;
			       Tab_Stops : in ARM_Output.Tab_Info := ARM_Output.NO_TABS;
			       No_Breaks : in Boolean := False;
			       Keep_with_Next : in Boolean := False;
			       Space_After : in ARM_Output.Space_After_Type
				   := ARM_Output.Normal;
			       Justification : in ARM_Output.Justification_Type
				   := ARM_Output.Default) is abstract;
	-- Start a new paragraph. The format of the paragraph is as specified.
	-- The (AA)RM paragraph number (which might include update and version
	-- numbers as well: [12.1/1]) is Number. If the format is a type with
	-- a prefix (bullets, hangining items), the prefix is omitted if
	-- No_Prefix is true. Tab_Stops defines the tab stops for the
	-- paragraph. If No_Breaks is True, we will try to avoid page breaks
	-- in the paragraph. If Keep_with_Next is true, we will try to avoid
	-- separating this paragraph and the next one. (These may have no
	-- effect in formats that don't have page breaks). Space_After
	-- specifies the amount of space following the paragraph. Justification
	-- specifies the text justification for the paragraph. Not_Valid_Error
	-- is raised if Tab_Stops /= NO_TABS for a hanging or bulleted format.

    procedure End_Paragraph (Output_Object : in out Output_Type) is abstract;
	-- End a paragraph.

    procedure Category_Header (Output_Object : in out Output_Type;
			       Header_Text : String) is abstract;
	-- Output a Category header (that is, "Legality Rules",
	-- "Dynamic Semantics", etc.)
	-- (Note: We did not use a enumeration here to insure that these
	-- headers are spelled the same in all output versions).
	-- Raises Not_Valid_Error if in a paragraph.

    procedure Clause_Header (Output_Object : in out Output_Type;
			     Header_Text : in String;
			     Level : in ARM_Contents.Level_Type;
			     Clause_Number : in String;
			     No_Page_Break : in Boolean := False) is abstract;
	-- Output a Clause header. The level of the header is specified
	-- in Level. The Clause Number is as specified.
	-- These should appear in the table of contents.
	-- For hyperlinked formats, this should generate a link target.
	-- If No_Page_Break is True, suppress any page breaks.
	-- Raises Not_Valid_Error if in a paragraph.

    procedure Revised_Clause_Header (Output_Object : in out Output_Type;
			     New_Header_Text : in String;
			     Old_Header_Text : in String;
			     Level : in ARM_Contents.Level_Type;
			     Clause_Number : in String;
			     No_Page_Break : in Boolean := False) is abstract;
	-- Output a revised clause header. Both the original and new text will
	-- be output. The level of the header is specified in Level. The Clause
	-- Number is as specified.
	-- These should appear in the table of contents.
	-- For hyperlinked formats, this should generate a link target.
	-- If No_Page_Break is True, suppress any page breaks.
	-- Raises Not_Valid_Error if in a paragraph.

    procedure TOC_Marker (Output_Object : in out Output_Type;
			  For_Start : in Boolean) is abstract;
	-- Mark the start (if For_Start is True) or end (if For_Start is
	-- False) of the table of contents data. Output objects that
	-- auto-generate the table of contents can use this to do needed
	-- actions.

    type Page_Kind_Type is (Any_Page, Odd_Page_Only, Soft_Page);

    procedure New_Page (Output_Object : in out Output_Type;
			Kind : ARM_Output.Page_Kind_Type := ARM_Output.Any_Page) is abstract;
	-- Output a page break.
	-- Note that this has no effect on non-printing formats.
	-- Any_Page breaks to the top of the next page (whatever it is);
	-- Odd_Page_Only breaks to the top of the odd-numbered page;
	-- Soft_Page allows a page break but does not force one (use in
	-- "No_Breaks" paragraphs.)
	-- Raises Not_Valid_Error if in a paragraph if Kind = Any_Page or
	-- Odd_Page, and if not in a paragraph if Kind = Soft_Page.

    procedure New_Column (Output_Object : in out Output_Type) is abstract;
	-- Output a column break.
	-- Raises Not_Valid_Error if in a paragraph, or if the number of
	-- columns is 1.

    procedure Separator_Line (Output_Object : in out Output_Type;
			      Is_Thin : Boolean := True) is abstract;
	-- Output a separator line. It is thin if "Is_Thin" is true.
	-- Raises Not_Valid_Error if in a paragraph.

    procedure Start_Table (Output_Object : in out Output_Type;
			   Columns : in ARM_Output.Column_Count) is abstract;
	-- Starts a table. The number of columns is Columns.
	-- This command starts a paragraph; the entire table is a single
	-- paragraph. Text will be considered part of the caption until the
	-- next table marker call.
	-- Raises Not_Valid_Error if in a paragraph.

    type Table_Marker_Type is (End_Caption, End_Item, End_Header,
	End_Row, End_Row_Next_Is_Last, End_Table);
    procedure Table_Marker (Output_Object : in out Output_Type;
			    Marker : in ARM_Output.Table_Marker_Type) is abstract;
	-- Marks the end of an entity in a table.
	-- If Marker is End_Caption, the table caption ends and the
	--	future text is part of the table header.
	-- If Marker is End_Header, the table header ends and the
	--	future text is part of the table body.
	-- If Marker is End_Row, a row in the table is completed, and another
	--	row started.
	-- If Marker is End_Row_Next_Is_Last, a row in the table is completed,
	--	and another row started. That row is the last row in the table.
	-- If Marker is End_Item, an item in the table header or body is ended,
	--	and another started.
	-- If Marker is End_Table, the entire table is finished.
	-- Raises Not_Valid_Error if not in a table.

    -- Text output: These are only allowed after a Start_Paragraph and
    -- before any End_Paragraph. Raises Not_Valid_Error if not allowed.

    procedure Ordinary_Text (Output_Object : in out Output_Type;
			     Text : in String) is abstract;
	-- Output ordinary text.
	-- The text must end at a word break, never in the middle of a word.

    procedure Ordinary_Character (Output_Object : in out Output_Type;
			          Char : in Character) is abstract;
	-- Output an ordinary (Latin-1) character.
	-- Spaces will be used to break lines as needed.

    procedure Hard_Space (Output_Object : in out Output_Type) is abstract;
	-- Output a hard space. No line break should happen at a hard space.

    procedure Line_Break (Output_Object : in out Output_Type) is abstract;
	-- Output a line break. This does not start a new paragraph.
	-- This corresponds to a "<BR>" in HTML.

    procedure Index_Line_Break (Output_Object : in out Output_Type;
				Clear_Keep_with_Next : in Boolean) is abstract;
	-- Output a line break for the index. This does not start a new
	-- paragraph in terms of spacing. This corresponds to a "<BR>"
	-- in HTML. If Clear_Keep_with_Next is true, insure that the next
	-- line does not require the following line to stay with it.
	-- Raises Not_Valid_Error if the paragraph is not in the index format.

    procedure Soft_Line_Break (Output_Object : in out Output_Type) is abstract;
	-- Output a soft line break. This is a place (in the middle of a
	-- "word") that we allow a line break. It is usually used after
	-- underscores in long non-terminals.

    procedure Soft_Hyphen_Break (Output_Object : in out Output_Type) is abstract;
	-- Output a soft line break, with a hyphen. This is a place (in the middle of
	-- a "word") that we allow a line break. If the line break is used,
	-- a hyphen will be added to the text.

    procedure Tab (Output_Object : in out Output_Type) is abstract;
	-- Output a tab, inserting space up to the next tab stop.
	-- Raises Not_Valid_Error if the paragraph was created with
	-- Tab_Stops = ARM_Output.NO_TABS.

    type Special_Character_Type is (EM_Dash, -- EM (very long) dash.
				    EN_Dash, -- EN (long) dash
				    GEQ, -- Greater than or equal symbol.
				    LEQ, -- Less than or equal symbol.
				    NEQ, -- Not equal symbol.
				    PI,  -- PI.
				    Left_Ceiling, -- Left half of ceiling.
				    Right_Ceiling, -- Right half of ceiling.
				    Left_Floor, -- Left half of floor.
				    Right_Floor, -- Right half of floor.
				    Thin_Space, -- A thinner than usual space.
				    Left_Quote, -- A left facing single quote.
				    Right_Quote, -- A right facing single quote.
				    Left_Double_Quote, -- A left facing double quote.
				    Right_Double_Quote -- A right facing double quote.
				   );

    procedure Special_Character (Output_Object : in out Output_Type;
			         Char : in ARM_Output.Special_Character_Type) is abstract;
	-- Output an special character.

    procedure End_Hang_Item (Output_Object : in out Output_Type) is abstract;
	-- Marks the end of a hanging item. Call only once per paragraph.
	-- Raises Not_Valid_Error if the paragraph format is not
	-- Hanging .. Small_Nested_Enumerated, or if this has already been
	-- called for the current paragraph, or if the paragraph was started
	-- with No_Prefix = True.

	-- Note that this has no effect on non-printing formats.
	-- Raises Not_Valid_Error if in a paragraph.

    type Font_Family_Type is (Roman, Swiss, Fixed, Default);
	-- Determines the font family. "Default" is the font family
	-- of a paragraph before it is changed.

    type Change_Type is (None, Insertion, Deletion);
	-- Determines the change state of the current text.

    type Size_Type is range -9 .. 9;
	-- Determines the relative size. This is the change in size. For
	-- formats that allow it, this is the change in size in points.
	-- Otherwise, this is a relative change.

    type Location_Type is (Normal, Subscript, Superscript);
	-- Determines the location (vertical position) of the text: in the
	-- normal position, subscripted (below the normal position), or
	-- superscripted (above the normal position).

    procedure Text_Format (Output_Object : in out Output_Type;
			   Bold : in Boolean;
			   Italic : in Boolean;
			   Font : in ARM_Output.Font_Family_Type;
			   Size : in ARM_Output.Size_Type;
			   Change : in ARM_Output.Change_Type;
			   Location : in ARM_Output.Location_Type) is abstract;
	-- Change the text format so that Bold, Italics, the font family,
	-- the text size, and the change state are as specified.
	-- Note: Changes to these properties must be stack-like; that is,
	-- Bold on, Italic on, Italic off, Bold off is OK; Bold on, Italic on,
	-- Bold off, Italic off is not allowed (as separate commands).

    procedure Clause_Reference (Output_Object : in out Output_Type;
				Text : in String;
				Clause_Number : in String) is abstract;
	-- Generate a reference to a clause in the standard. The text of
	-- the reference is "Text", and the number of the clause is
	-- Clause_Number. For hyperlinked formats, this should generate
	-- a link; for other formats, the text alone is generated.

    procedure Index_Target (Output_Object : in out Output_Type;
			    Index_Key : in Natural) is abstract;
	-- Generate a index target. This marks the location where an index
	-- reference occurs. Index_Key names the index item involved.
	-- For hyperlinked formats, this should generate a link target;
	-- for other formats, nothing is generated.

    procedure Index_Reference (Output_Object : in out Output_Type;
			       Text : in String;
			       Index_Key : in Natural;
			       Clause_Number : in String) is abstract;
	-- Generate a reference to an index target in the standard. The text
	-- of the reference is "Text", and Index_Key and Clause_Number denotes
	-- the target. For hyperlinked formats, this should generate
	-- a link; for other formats, the text alone is generated.

    procedure DR_Reference (Output_Object : in out Output_Type;
			    Text : in String;
			    DR_Number : in String) is abstract;
	-- Generate a reference to an DR from the standard. The text
	-- of the reference is "Text", and DR_Number denotes
	-- the target. For hyperlinked formats, this should generate
	-- a link; for other formats, the text alone is generated.

end ARM_Output;