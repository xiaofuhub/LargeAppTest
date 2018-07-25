$PBExportHeader$w_setup_new_field.srw
forward
global type w_setup_new_field from window
end type
type cb_close from commandbutton within w_setup_new_field
end type
type dw_dvf_browse from datawindow within w_setup_new_field
end type
type dw_browse from datawindow within w_setup_new_field
end type
type cb_3 from commandbutton within w_setup_new_field
end type
type cb_2 from commandbutton within w_setup_new_field
end type
type cb_1 from commandbutton within w_setup_new_field
end type
type st_5 from statictext within w_setup_new_field
end type
type dw_table from datawindow within w_setup_new_field
end type
type dw_screen from datawindow within w_setup_new_field
end type
type cb_add from commandbutton within w_setup_new_field
end type
type st_2 from statictext within w_setup_new_field
end type
type dw_data_view from datawindow within w_setup_new_field
end type
type dw_sys_fields from datawindow within w_setup_new_field
end type
end forward

global type w_setup_new_field from window
integer x = 5
integer y = 4
integer width = 4553
integer height = 2416
boolean titlebar = true
string title = "Sys Field Creation"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
cb_close cb_close
dw_dvf_browse dw_dvf_browse
dw_browse dw_browse
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
st_5 st_5
dw_table dw_table
dw_screen dw_screen
cb_add cb_add
st_2 st_2
dw_data_view dw_data_view
dw_sys_fields dw_sys_fields
end type
global w_setup_new_field w_setup_new_field

type variables
integer ii_table
integer ii_screen
end variables

on w_setup_new_field.create
this.cb_close=create cb_close
this.dw_dvf_browse=create dw_dvf_browse
this.dw_browse=create dw_browse
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_5=create st_5
this.dw_table=create dw_table
this.dw_screen=create dw_screen
this.cb_add=create cb_add
this.st_2=create st_2
this.dw_data_view=create dw_data_view
this.dw_sys_fields=create dw_sys_fields
this.Control[]={this.cb_close,&
this.dw_dvf_browse,&
this.dw_browse,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.st_5,&
this.dw_table,&
this.dw_screen,&
this.cb_add,&
this.st_2,&
this.dw_data_view,&
this.dw_sys_fields}
end on

on w_setup_new_field.destroy
destroy(this.cb_close)
destroy(this.dw_dvf_browse)
destroy(this.dw_browse)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_5)
destroy(this.dw_table)
destroy(this.dw_screen)
destroy(this.cb_add)
destroy(this.st_2)
destroy(this.dw_data_view)
destroy(this.dw_sys_fields)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=intellicred client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Login", "Login Failed!")
//	Close( This )
//END IF


dw_table.SetTransObject( sqlca )
dw_table.InsertRow( 0 )

dw_screen.SetTransObject( sqlca )
dw_screen.InsertRow( 0 )

dw_sys_fields.SetTransObject( sqlca )

dw_data_view.SetTransObject( sqlca )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<comment> 01.13.2006 By: owen chen
//$<reason> Perforamnce tuning
//$<modification> Comment out the following script since it is redudant after analysis.
//Return 1
//---------------------------- APPEON END ----------------------------

end event

type cb_close from commandbutton within w_setup_new_field
integer x = 4110
integer y = 104
integer width = 329
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_dvf_browse from datawindow within w_setup_new_field
integer x = 2885
integer y = 224
integer width = 1554
integer height = 732
integer taborder = 60
string dataobject = "d_dvf_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer i
long ll_field_id



i = this.getclickedrow()
if i < 1 then return
ll_field_id = this.getitemnumber(i,"data_view_field_id")
//messagebox("ll_field_id",ll_field_id)
this.selectrow(0,false)
this.selectrow(i,true)

dw_data_view.settransobject(sqlca)
dw_data_view.retrieve(ll_field_id)
end event

type dw_browse from datawindow within w_setup_new_field
integer x = 55
integer y = 232
integer width = 2789
integer height = 732
integer taborder = 50
string dataobject = "d_sys_fields_by_table_id"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer i
long ll_field_id



i = this.getclickedrow()
if i < 1 then return
ll_field_id = this.getitemnumber(i,"field_id")
this.selectrow(0,false)
this.selectrow(i,true)

dw_sys_fields.settransobject(sqlca)
dw_sys_fields.retrieve(ll_field_id)

end event

type cb_3 from commandbutton within w_setup_new_field
integer x = 3959
integer y = 2148
integer width = 485
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create SQL"
end type

event clicked;String ls_word_path
String ls_table
String ls_field
String ls_sql
Integer li_filenum2
Integer li_filenum
integer li_table
string ls_dtype
integer li_len
string ls_type

string docname, ls_file_name

integer value

//value = GetFilesaveName("Select File",&
//+ docname, ls_file_name, "DOC", &
//	+ "Doc Files (*.SQL),*.SQL")
//IF value <> 1 THEN
//	Return
//END IF

//li_table =  Integer( dw_table.gettext() )
dw_sys_fields.accepttext()

SELECT sys_tables.table_name  
INTO :ls_table  
FROM sys_tables  
WHERE sys_tables.table_id = :ii_table   ;

//ls_word_path = ProfileString("C:\intellicred\intellicred.ini", "paths", "word", "None")
//IF NOT FileExists( "C:\intellicred\intellicred.ini" ) THEN
//	MessageBox("ini File Error", "No intellicred.ini file found at: C:\intellicred\intellicred.ini" )
//		Return -1
//END IF
ls_type = dw_sys_fields.GetItemString( 1, "field_type" )
choose case ls_type
	case "C"
		ls_dtype = "CHAR"
	case "D"
		ls_dtype = "timestamp"
	case "N"
		ls_dtype = "NUMERIC"
end choose
ls_field = dw_sys_fields.GetItemString( 1, "field_name" )
li_len = dw_sys_fields.GetItemnumber( 1, "field_len" )

if ls_type = "D" then
	ls_sql = "ALTER TABLE " + ls_table + " ADD " + ls_field + " " + ls_dtype + " NULL;"
else
	ls_sql = "ALTER TABLE " + ls_table + " ADD " + ls_field + " " + ls_dtype + "(" + string(li_len) + ") NULL;" 
end if
messagebox("",ls_sql)
execute immediate :ls_sql using sqlca;
commit using sqlca;
//li_FileNum = FileOpen( docname ,StreamMode!, Write!, LockWrite!, Append! )
//FileWrite( li_FileNum, "ALTER TABLE " + ls_table + " ADD " + ls_field + " numeric(8,0) NULL;" )
//
//dw_sys_fields.SaveAs( "c:\sys_fields.sql", SQLInsert!, False )
//li_FileNum2 = FileOpen( "c:\sys_fields.sql" ,StreamMode!, Read!, LockWrite!, Append! )
//FileRead( li_filenum2, ls_sql )
//FileClose( li_filenum2 )
//FileWrite( li_FileNum, ls_sql )
//
//
//dw_data_view.SaveAs( "c:\data_view_fields.sql", SQLInsert!, False )
//li_FileNum2 = FileOpen( "c:\data_view_fields.sql" ,StreamMode!, Read!, LockWrite!, Append! )
//FileRead( li_filenum2, ls_sql )
//FileClose( li_filenum2 )
//FileWrite( li_FileNum, ls_sql )
//FileClose( li_FileNum )
//
//Run( ls_word_path + ' "' + docname + '"')
//
end event

type cb_2 from commandbutton within w_setup_new_field
integer x = 3429
integer y = 2148
integer width = 485
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;String ls_table
String ls_field

Integer li_filenum
integer li_table


dw_sys_fields.Update()

dw_data_view.Update()

COMMIT USING SQLCA;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.31.2006 By: Liang QingShi
//$<reason> Fix a defect.

dw_browse.settransobject(sqlca)
//---------------------------- APPEON END ----------------------------
dw_browse.retrieve(ii_table)


end event

type cb_1 from commandbutton within w_setup_new_field
integer x = 2885
integer y = 2148
integer width = 498
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add To Data View 1"
end type

event clicked;Long ll_next_dv_id
Integer li_nr

dw_data_view.update()
commit using sqlca;

li_nr = dw_data_view.InsertRow( 1 )
dw_data_view.SetRow( li_nr )
dw_data_view.ScrollToRow( li_nr )
dw_data_view.SetFocus()

SELECT Max( data_view_field_id )  
INTO :ll_next_dv_id
FROM data_view_fields  ;

ll_next_dv_id++

dw_data_view.SetItem( dw_sys_fields.GetRow(), "data_view_field_id", ll_next_dv_id )
dw_data_view.SetItem( dw_sys_fields.GetRow(), "screen_id", ii_screen )
dw_data_view.SetItem( dw_sys_fields.GetRow(), "field_id", dw_sys_fields.GetItemNumber( 1, "field_id" ) )
dw_data_view.SetItem( dw_sys_fields.GetRow(), "field_label", dw_sys_fields.GetItemString( 1, "field_name_allias" ) )
dw_data_view.SetItem( dw_sys_fields.GetRow(), "field_order", dw_sys_fields.GetItemNumber( 1, "field_order" ) )
dw_data_view.SetItem( dw_sys_fields.GetRow(), "data_view_id", 1 )

end event

type st_5 from statictext within w_setup_new_field
integer x = 2885
integer y = 32
integer width = 750
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select Screen (Data View Fields)"
boolean focusrectangle = false
end type

type dw_table from datawindow within w_setup_new_field
integer x = 50
integer y = 96
integer width = 914
integer height = 108
integer taborder = 20
string dataobject = "d_select_table"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_table = integer(data)

dw_browse.settransobject(sqlca)
dw_browse.retrieve(ii_table)
end event

type dw_screen from datawindow within w_setup_new_field
integer x = 2862
integer y = 88
integer width = 1102
integer height = 92
integer taborder = 40
string dataobject = "d_select_screen_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_screen = integer(data)

dw_dvf_browse.settransobject(sqlca)
dw_dvf_browse.retrieve(ii_screen)
dw_data_view.reset()
end event

type cb_add from commandbutton within w_setup_new_field
integer x = 1289
integer y = 2148
integer width = 485
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Sys Field"
end type

event clicked;Long ll_next_field_id
Integer li_nr

//dw_sys_fields.Reset()
//dw_data_view.Reset()

li_nr = dw_sys_fields.InsertRow( 0 )
dw_sys_fields.SetRow( li_nr )
dw_sys_fields.ScrollToRow( li_nr )
dw_sys_fields.SetFocus()

datawindowchild dwchild

dw_sys_fields.GetChild( "lookup_field_name", dwchild )
dwchild.InsertRow( 0 )
dwchild.SetItem( 1, "field_name", "Description" )

dw_sys_fields.GetChild( "lookup_code", dwchild )
dwchild.SetTransObject( sqlca )
dwchild.Retrieve()

SELECT max(field_id)  
INTO :ll_next_field_id  
FROM sys_fields  ;

ll_next_field_id++

dw_sys_fields.SetItem( dw_sys_fields.GetRow(), "field_id", ll_next_field_id )
dw_sys_fields.SetItem( dw_sys_fields.GetRow(), "table_id", dw_table.GetItemNumber( 1, "table_id" ) )
dw_sys_fields.SetItem( dw_sys_fields.GetRow(), "field_name", "cust_" )
dw_sys_fields.Setcolumn(3)
dw_data_view.reset()

end event

type st_2 from statictext within w_setup_new_field
integer x = 78
integer y = 40
integer width = 539
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select Table (Sys_fields)"
boolean focusrectangle = false
end type

type dw_data_view from datawindow within w_setup_new_field
integer x = 2885
integer y = 980
integer width = 1573
integer height = 1152
integer taborder = 110
string dataobject = "d_data_view_fields_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_sys_fields from datawindow within w_setup_new_field
integer x = 55
integer y = 988
integer width = 2793
integer height = 1144
integer taborder = 30
string dataobject = "d_sys_fields_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

