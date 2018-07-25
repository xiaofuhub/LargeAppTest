$PBExportHeader$w_dynamic_dw.srw
forward
global type w_dynamic_dw from w_response
end type
type dw_detail from u_dw within w_dynamic_dw
end type
type cb_3 from commandbutton within w_dynamic_dw
end type
type cb_2 from commandbutton within w_dynamic_dw
end type
type dw_master from u_dw within w_dynamic_dw
end type
type cb_1 from commandbutton within w_dynamic_dw
end type
end forward

global type w_dynamic_dw from w_response
int Height=1824
dw_detail dw_detail
cb_3 cb_3
cb_2 cb_2
dw_master dw_master
cb_1 cb_1
end type
global w_dynamic_dw w_dynamic_dw

type variables
Boolean ib_browse = true

u_dw idw[]


end variables

on w_dynamic_dw.create
int iCurrent
call super::create
this.dw_detail=create dw_detail
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_master=create dw_master
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detail
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_master
this.Control[iCurrent+5]=this.cb_1
end on

on w_dynamic_dw.destroy
call super::destroy
destroy(this.dw_detail)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_master)
destroy(this.cb_1)
end on

type dw_detail from u_dw within w_dynamic_dw
int X=78
int Y=656
int Width=2336
int Height=1060
int TabOrder=10
boolean BringToTop=true
end type

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve()
end event

event rowfocuschanged;call super::rowfocuschanged;this.inv_linkage.of_refresh(1)
end event

type cb_3 from commandbutton within w_dynamic_dw
int X=2158
int Y=96
int Width=247
int Height=84
int TabOrder=40
string Text="Update"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Integer   li_return

//dw_3.Event pfc_update(TRUE,TRUE)

li_return = Parent.Event pfc_Save( )

messagebox("", li_return)
end event

type cb_2 from commandbutton within w_dynamic_dw
int X=1842
int Y=96
int Width=247
int Height=84
int TabOrder=30
string Text="Create"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Integer li_col_count, I
String ls_grey

string ERRORS, sql_syntax

string presentation_str, dwsyntax_str


String  ls_table_1_fields[]
String ls_table_2_fields[]
String ls_table_1_update_fields[]
String ls_table_2_update_fields[]

ls_table_1_fields[1] = "sys_tables_table_id"

ls_table_1_update_fields[1] = "sys_tables_table_id"
ls_table_1_update_fields[2] = "sys_tables_table_name"

ls_table_2_fields[1] = "sys_fields_table_id"
ls_table_2_fields[2] = "sys_fields_field_id"

ls_table_2_update_fields[1] = "sys_fields_field_name_allias"
ls_table_2_update_fields[2] = "sys_fields_field_id"
ls_table_2_update_fields[3] = "sys_fields_table_id"


//sys_tables.table_id, sys_tables.table_name, sys_fields.table_id, sys_fields.field_id, sys_fields.field_name_allias
sql_syntax = "SELECT sys_tables.table_id, sys_tables.table_name, sys_fields.table_id, sys_fields.field_id, sys_fields.field_name_allias FROM sys_tables, sys_fields"
//sql_syntax = "SELECT *  FROM sys_tables, sys_fields"


ls_grey = String(rgb(192,192,192))
presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_grey + " )" + "Text(Background.Color=" + ls_grey + ")"


dwsyntax_str = SQLCA.SyntaxFromSQL(sql_syntax, &
	presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN

END IF

dw_detail.Create( dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN
END IF


IF ib_browse THEN
	//CREATE GRID
	sql_syntax = "SELECT sys_tables.table_id, sys_tables.table_name, sys_fields.table_id, sys_fields.field_id, sys_fields.field_name_allias FROM sys_tables, sys_fields"

	presentation_str = "style(type=grid)"

	dwsyntax_str = SQLCA.SyntaxFromSQL(sql_syntax, &
		presentation_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN
	END IF

	dw_master.Create( dwsyntax_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS)
		RETURN
	END IF
END IF


dw_detail.Modify("sys_tables_table_name.TabSequence = '2'")
dw_detail.Modify("sys_fields_field_name_allias.TabSequence = '3'")
dw_detail.Modify("sys_tables_table_id.TabSequence = '1'")

IF ib_browse THEN
	dw_master.of_SetMultiTable(TRUE)
	dw_master.inv_multitable.of_Register("sys_fields", ls_table_2_fields, ls_table_2_update_fields, TRUE, 0)
	dw_master.inv_multitable.of_Register("sys_tables", ls_table_1_fields, ls_table_1_update_fields, TRUE, 0)

	dw_detail.of_SetMultiTable(TRUE)
	dw_detail.inv_multitable.of_Register("sys_fields", ls_table_2_fields, ls_table_2_update_fields, TRUE, 0)
	dw_detail.inv_multitable.of_Register("sys_tables", ls_table_1_fields, ls_table_1_update_fields, TRUE, 0)

	
	dw_master.of_SetLinkage(TRUE)
	dw_detail.of_SetLinkage(TRUE)

	dw_detail.inv_linkage.of_LinkTo(dw_master)
	dw_master.inv_linkage.of_SetTransObject(SQLCA)
	dw_detail.inv_linkage.of_Register( "sys_tables_table_id", "sys_tables_table_id" )
	dw_detail.inv_linkage.of_SetStyle(1)
	dw_master.inv_linkage.of_Retrieve( )
	dw_master.SetFocus()
	
	dw_master.Modify("sys_tables_table_name.TabSequence = '2'")
   dw_master.Modify("sys_fields_field_name_allias.TabSequence = '3'")
   dw_master.Modify("sys_tables_table_id.TabSequence = '1'")
	
	//dw_master.sharedata(dw_detail)

ELSE
	dw_detail.of_SetMultiTable(TRUE)
	dw_detail.inv_multitable.of_Register("sys_fields", ls_table_2_fields, ls_table_2_update_fields, TRUE, 0)
	dw_detail.inv_multitable.of_Register("sys_tables", ls_table_1_fields, ls_table_1_update_fields, TRUE, 0)
	
	dw_detail.SetTransObject( sqlca )
	dw_detail.Event pfc_Retrieve()
END IF


li_col_count = Integer(dw_detail.Describe("DataWindow.Column.Count"))


FOR i = 1 TO li_col_count

	dw_master.Modify("{"+String(i) + "}.TabSequence = '" + String(i) + "'")
	dw_detail.Modify(String(i) + ".TabSequence = '" + String(i) + "'")
END FOR




end event

type dw_master from u_dw within w_dynamic_dw
int X=73
int Y=196
int Width=2336
int Height=400
int TabOrder=20
boolean BringToTop=true
end type

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve()
end event

type cb_1 from commandbutton within w_dynamic_dw
int X=1536
int Y=96
int Width=247
int Height=84
int TabOrder=50
string Text="Syntax"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_syntax

//ls_syntax = dw_master.Object.DataWindow.Syntax

ls_syntax = dw_master.Object.DataWindow.Selected.Data

messagebox("", ls_syntax)
end event

