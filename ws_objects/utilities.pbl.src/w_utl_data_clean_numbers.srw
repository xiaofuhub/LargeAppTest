$PBExportHeader$w_utl_data_clean_numbers.srw
forward
global type w_utl_data_clean_numbers from window
end type
type cb_4 from commandbutton within w_utl_data_clean_numbers
end type
type cb_2 from commandbutton within w_utl_data_clean_numbers
end type
type st_1 from statictext within w_utl_data_clean_numbers
end type
type dw_select from datawindow within w_utl_data_clean_numbers
end type
type dw_crit1 from datawindow within w_utl_data_clean_numbers
end type
type dw_table from datawindow within w_utl_data_clean_numbers
end type
type cb_3 from commandbutton within w_utl_data_clean_numbers
end type
type cb_find from commandbutton within w_utl_data_clean_numbers
end type
type cb_1 from commandbutton within w_utl_data_clean_numbers
end type
type gb_4 from groupbox within w_utl_data_clean_numbers
end type
type gb_3 from groupbox within w_utl_data_clean_numbers
end type
end forward

global type w_utl_data_clean_numbers from window
integer x = 96
integer y = 36
integer width = 3447
integer height = 2220
boolean titlebar = true
string title = "Batch Update"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
cb_4 cb_4
cb_2 cb_2
st_1 st_1
dw_select dw_select
dw_crit1 dw_crit1
dw_table dw_table
cb_3 cb_3
cb_find cb_find
cb_1 cb_1
gb_4 gb_4
gb_3 gb_3
end type
global w_utl_data_clean_numbers w_utl_data_clean_numbers

type variables
string is_field1
string is_field2
string is_field3
string is_fieldup
string is_table
string is_where
string is_search
long il_v1
long il_v2
long il_v3
long il_vup
long il_resps
long il_upfield_sysid
string is_user
string is_lookup_val
string is_lookup_type
end variables

on w_utl_data_clean_numbers.create
this.cb_4=create cb_4
this.cb_2=create cb_2
this.st_1=create st_1
this.dw_select=create dw_select
this.dw_crit1=create dw_crit1
this.dw_table=create dw_table
this.cb_3=create cb_3
this.cb_find=create cb_find
this.cb_1=create cb_1
this.gb_4=create gb_4
this.gb_3=create gb_3
this.Control[]={this.cb_4,&
this.cb_2,&
this.st_1,&
this.dw_select,&
this.dw_crit1,&
this.dw_table,&
this.cb_3,&
this.cb_find,&
this.cb_1,&
this.gb_4,&
this.gb_3}
end on

on w_utl_data_clean_numbers.destroy
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.dw_select)
destroy(this.dw_crit1)
destroy(this.dw_table)
destroy(this.cb_3)
destroy(this.cb_find)
destroy(this.cb_1)
destroy(this.gb_4)
destroy(this.gb_3)
end on

event open;SQLCA.DBMS="ODBC"
SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='Yes'"

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-14 By: Scofield
//$<Reason> Set the connection cache dynamically on Web
if AppeonGetClientType() = 'WEB' then
	SQLCA.DBMS = gs_CacheType
	SQLCA.DBParm = gs_CacheSet
end if
//---------------------------- APPEON END ----------------------------

CONNECT USING SQLCA;

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Not Logged In", "Login Failed!")
ELSE
	//MESSAGEBOX("","LOGIN OK")
END IF


dw_table.settransobject(sqlca)
dw_table.retrieve()
dw_table.insertrow(1)

is_user = gs_user_id
end event

event close;disCONNECT USING SQLCA;
end event

type cb_4 from commandbutton within w_utl_data_clean_numbers
integer x = 3113
integer y = 268
integer width = 265
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update"
end type

event clicked;dw_select.update()
commit using sqlca;
end event

type cb_2 from commandbutton within w_utl_data_clean_numbers
integer x = 2825
integer y = 148
integer width = 265
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get Data"
end type

event clicked;string ls_field1
string ls_ftype1
string ls_op1
string ls_val1
string ls_search
string ls_table
string syn
date ld_v1
datetime ldt_v2
string ls_field2
string ls_op2
string ls_val2
string ls_ftype2
string ls_dwsyntax_str
datetime ldt_v3
string ls_field3
string ls_op3
string ls_val3
string ls_ftype3
string ls_presentation_str
string ls_where1
string ls_where2
string ls_where3
string errors

integer vc = 0
long lla_recs[]
integer i
long rc
long r


ls_table = is_table
ls_field1 = is_field1


ls_search = "Select * from " + is_table + ";"
 
ls_search = ls_search + is_where
messagebox("ls_search",ls_search)

syn = ls_search
is_search = ls_search

dw_select.Reset()
dw_select.DataObject = ''

//ls_grey = 
//ls_white = 
ls_presentation_str = "style(type=grid)"
//messagebox("", syn)
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(syn, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN -1
END IF

dw_select.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create caused these errors: " + ERRORS)
	RETURN -1
END IF

dw_select.settransobject(sqlca)
rc = dw_select.retrieve()


	//CREATE SYNTAX FOR export DW
//	ls_presentation_str = "style(type=grid)" 
//	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
//	IF Len(ERRORS) > 0 THEN //this will fail if the table has not been completed
//		if pos(ERRORS,"Table or view not found",1) > 0 then
//			messagebox ("syntax error","Table not found (should have  prefix)" )
//			return -1
//		else
//			MessageBox("Caution", &
//			"SyntaxFromSQL caused these errors: " + ERRORS)
//			RETURN -1
//		end if
//	END IF
//	
//	if rb_dw1.checked = true then 
//		dw_1.Create( ls_dwsyntax_str, ERRORS)
//		dw_1.SetTransObject( SQLCA )
//		cnt = dw_1.retrieve()
//		st_1.text = string(cnt)
//	elseif rb_dw2.checked = true then 
//		dw_2.Create( ls_dwsyntax_str, ERRORS)
//		dw_2.SetTransObject( SQLCA )
//		cnt = dw_2.retrieve()
//		st_2.text = string(cnt)
//	end if
//		cb_commit.enabled = false
//		cb_roll.enabled = false
//
//
//of_syn()
//
//
end event

type st_1 from statictext within w_utl_data_clean_numbers
integer x = 119
integer y = 276
integer width = 2446
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean enabled = false
string text = "Warning: This function will crash if run on fields that are not Char datatype."
boolean focusrectangle = false
end type

type dw_select from datawindow within w_utl_data_clean_numbers
integer x = 9
integer y = 384
integer width = 3314
integer height = 1632
integer taborder = 70
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_crit1 from datawindow within w_utl_data_clean_numbers
integer x = 1417
integer y = 104
integer width = 969
integer height = 96
integer taborder = 30
string dataobject = "d_dv_fields_4_screen"
boolean border = false
boolean livescroll = true
end type

event clicked;integer r




end event

event rowfocuschanged;//datawindowchild dwchild
//string ltable
//string field
//string d
//
//if this.getitemstring(currentrow,"lookup_field") = "Y" then
//	dw_v1.visible = true
//	sle_value1.visible = false
//	ltable = this.getitemstring(currentrow,"lookup_code")
//	if this.getitemstring(currentrow,"lookup_type") = "C" then
//		dw_v1.dataobject = "d_c_look"
//		field = "description"
//	elseif this.getitemstring(currentrow,"lookup_type") = "A" then
//		dw_v1.dataobject = "d_a_look"
//		field = "entity_name_original"
//	end if
//	dw_v1.settransobject(sqlca)
//	dw_v1.retrieve(ltable)
//	dw_v1.GetChild( field, dwchild )
//	dw_v1.insertrow(1)
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve(ltable)
//	dwchild.InsertRow( 1 )
//else
//	dw_v1.visible = false
//	sle_value1.visible = true
//	sle_value1.text = ""
//end if
//
//is_field1 = this.getitemstring(currentrow,"sys_fields_field_name")
//d = this.getitemstring(currentrow,"sys_fields_field_type")
//if d = "D" then 
//	st_date1.visible = true
//else
//	st_date1.visible = false
//end if
end event

event itemchanged;is_field1 = data
end event

type dw_table from datawindow within w_utl_data_clean_numbers
integer x = 151
integer y = 96
integer width = 1088
integer height = 92
integer taborder = 10
string dataobject = "d_table_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;integer ii_screen
integer r
string find
datawindowchild dwchild

ii_screen = integer(data)

//messagebox("",ii_screen)
dw_crit1.settransobject(sqlca)
dw_crit1.retrieve()
dw_crit1.GetChild( "data_view_fields_screen_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve(ii_screen)
//messagebox("crit1",ii_screen)

dw_crit1.InsertRow( 1 )

//dw_crit2.settransobject(sqlca)
//dw_crit2.retrieve(ii_screen)
//dw_crit3.settransobject(sqlca)
//dw_crit3.retrieve(ii_screen)
////dw_crit2.GetChild( "data_view_fields_screen_id", dwchild )
////dwchild.SetTransObject( SQLCA )
////dwchild.Retrieve(ii_screen)
////dw_crit2.InsertRow( 1 )
////
////
//dw_crit_update.settransobject(sqlca)
//dw_crit_update.retrieve(ii_screen)
////dw_crit_update.GetChild( "data_view_fields_screen_id", dwchild )
////dwchild.SetTransObject( SQLCA )
////dwchild.Retrieve(ii_screen)
////dwchild.InsertRow( 1 )
////
find = "screen_id = " + data
////messagebox("",find)
r = dw_table.find(find,1,dw_table.rowcount())
////messagebox("r",r)
is_table = dw_table.getitemstring(r,"sys_tables_table_name")
////messagebox("",is_table)
//cb_find.enabled = false
//cb_update.enabled = false
//
//
//
//
//
//
//
//
//
//
//cb_find.enabled = true
end event

event doubleclicked;//integer is_screen
//integer r
//string find
//
//
//is_screen = this.getitemnumber(row,"data_view_screen_screen_id")
//messagebox("",is_screen)
//dw_crit1.settransobject(sqlca)
////messagebox("crit1",is_screen)
//dw_crit1.retrieve(is_screen)
//
//dw_crit2.settransobject(sqlca)
////messagebox("crit2",is_screen)
//dw_crit2.retrieve(is_screen)
//
//dw_crit_update.settransobject(sqlca)
////messagebox("crit3",is_screen)
//dw_crit_update.retrieve(is_screen)
//
//
//is_table = this.getitemstring(row,"sys_tables_table_name")
//
//messagebox("",is_table)
//
//cb_find.enabled = true
end event

type cb_3 from commandbutton within w_utl_data_clean_numbers
integer x = 3109
integer y = 36
integer width = 265
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

type cb_find from commandbutton within w_utl_data_clean_numbers
integer x = 2647
integer y = 268
integer width = 443
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Remove chars"
end type

event clicked;string ls_field1
string ls_ftype1
string ls_op1
string ls_val1
string ls_search
string ls_table
string syn
date ld_v1
datetime ldt_v2
string ls_field2
string ls_op2
string ls_val2
string ls_ftype2
string ls_dwsyntax_str
datetime ldt_v3
string ls_field3
string ls_op3
string ls_val3
string ls_ftype3
string ls_presentation_str
string ls_where1
string ls_where2
string ls_where3
string errors

integer vc = 0
long lla_recs[]
integer i
long rc
long r


string ls_value = ""
string s
string val
integer il

rc = dw_select.rowcount()

for r = 1 to 5
	ls_value = ""
	val = dw_select.getitemstring(r,is_field1)
	//messagebox("",val)
	il = LenA(val)
	for i = 1 to il
		s = MidA(val,i,1)
		if isnumber(s) then
			ls_value  = ls_value + s
		end if
	next
	dw_select.setitem(r,is_field1,ls_value)
next

dw_select.update()
commit using sqlca;
end event

type cb_1 from commandbutton within w_utl_data_clean_numbers
integer x = 2825
integer y = 36
integer width = 265
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("To operate this function :","(1) Select a Data entry screen from the Select Table dropdown. ~r(2) Select the field name, the operator type, and the criteria value for the records you wish to update. You can set 1 - 3  criteria. ~r(3) Click FIND RECORDS to retrieve the records to be updated.  You can view the retrieved records by clicking the VIEW RESULTS button.~r(4) Select the field you wish to update and set the update value.  ~r(5) Select the Response code for the related Verification records.~r(6) Click UPDATE.~r~r Note: If update verifications is selected all incomplete verifications connected with the retrieved records will be updated the selected response code, the user name and todays date.  VIEW SYNTAX will allow you to view the SQL being generated.")
end event

type gb_4 from groupbox within w_utl_data_clean_numbers
integer x = 1339
integer y = 20
integer width = 1271
integer height = 208
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "(2) Select Field"
end type

type gb_3 from groupbox within w_utl_data_clean_numbers
integer x = 46
integer y = 20
integer width = 1271
integer height = 208
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "(1) Select Table"
end type

