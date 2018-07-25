$PBExportHeader$w_copy_field_info.srw
forward
global type w_copy_field_info from window
end type
type sle_table_id from singlelineedit within w_copy_field_info
end type
type st_4 from statictext within w_copy_field_info
end type
type st_3 from statictext within w_copy_field_info
end type
type sle_start from singlelineedit within w_copy_field_info
end type
type cb_1 from commandbutton within w_copy_field_info
end type
type sle_screen_id from singlelineedit within w_copy_field_info
end type
type st_2 from statictext within w_copy_field_info
end type
type st_1 from statictext within w_copy_field_info
end type
type sle_dv_id from singlelineedit within w_copy_field_info
end type
type dw_2 from datawindow within w_copy_field_info
end type
type dw_1 from datawindow within w_copy_field_info
end type
end forward

global type w_copy_field_info from window
integer x = 823
integer y = 360
integer width = 2821
integer height = 2052
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12639424
sle_table_id sle_table_id
st_4 st_4
st_3 st_3
sle_start sle_start
cb_1 cb_1
sle_screen_id sle_screen_id
st_2 st_2
st_1 st_1
sle_dv_id sle_dv_id
dw_2 dw_2
dw_1 dw_1
end type
global w_copy_field_info w_copy_field_info

on w_copy_field_info.create
this.sle_table_id=create sle_table_id
this.st_4=create st_4
this.st_3=create st_3
this.sle_start=create sle_start
this.cb_1=create cb_1
this.sle_screen_id=create sle_screen_id
this.st_2=create st_2
this.st_1=create st_1
this.sle_dv_id=create sle_dv_id
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.sle_table_id,&
this.st_4,&
this.st_3,&
this.sle_start,&
this.cb_1,&
this.sle_screen_id,&
this.st_2,&
this.st_1,&
this.sle_dv_id,&
this.dw_2,&
this.dw_1}
end on

on w_copy_field_info.destroy
destroy(this.sle_table_id)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.sle_start)
destroy(this.cb_1)
destroy(this.sle_screen_id)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_dv_id)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;SQLCA.DBMS="ODBC"
SQLCA.DbParm="ConnectString='DSN=screenpainter;UID=DBA;PWD=SQL;',DelimitIdentifier='Yes'"

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
	MessageBox("Login", "Login Failed!")
	Close( This )
END IF

end event

type sle_table_id from singlelineedit within w_copy_field_info
integer x = 393
integer y = 100
integer width = 247
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_copy_field_info
integer x = 393
integer y = 40
integer width = 297
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Table ID"
boolean focusrectangle = false
end type

type st_3 from statictext within w_copy_field_info
integer x = 1042
integer y = 44
integer width = 297
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "id start"
boolean focusrectangle = false
end type

type sle_start from singlelineedit within w_copy_field_info
integer x = 1038
integer y = 104
integer width = 247
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_copy_field_info
integer x = 1408
integer y = 100
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy"
end type

event clicked;Integer li_rc, I, li_nr, li_dv_id

dw_1.reset()
dw_2.reset()

dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(SQLCA)

dw_1.Retrieve( Integer(sle_table_id.text) )

li_rc = dw_1.RowCount()

li_dv_id = Integer(sle_start.Text)

FOR i = 1 TO li_rc
	li_nr = dw_2.InsertRow( 0 )	
	
	IF li_dv_id = 0 OR IsNull( li_dv_id ) THEN
		li_dv_id = 1
	END IF

	dw_2.SetItem(li_nr, "data_view_field_id", li_dv_id )
	dw_2.SetItem(li_nr, "data_view_id", Integer(sle_dv_id.Text) )
	dw_2.SetItem(li_nr, "screen_id", Integer(sle_screen_id.Text) )
	dw_2.SetItem(li_nr, "field_order", i * 10 )
	dw_2.SetItem(li_nr, "field_label", dw_1.GetItemString(i, "sys_fields_field_name_allias" ) )
	dw_2.SetItem(li_nr, "field_id", dw_1.GetItemNumber(i, "sys_fields_field_id" ) )
	dw_2.SetItem(li_nr, "field_label_y", 	i * 100 )
	dw_2.SetItem(li_nr, "field_label_x", 100 )
	dw_2.SetItem(li_nr, "field_x", 700 )
	dw_2.SetItem(li_nr, "field_label_width", 500 )
	
	li_dv_id ++
END FOR

dw_2.update()

COMMIT USING SQLCA;


	
end event

type sle_screen_id from singlelineedit within w_copy_field_info
integer x = 709
integer y = 100
integer width = 247
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_copy_field_info
integer x = 713
integer y = 40
integer width = 297
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Screen ID"
boolean focusrectangle = false
end type

type st_1 from statictext within w_copy_field_info
integer x = 69
integer y = 44
integer width = 315
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Data View ID"
boolean focusrectangle = false
end type

type sle_dv_id from singlelineedit within w_copy_field_info
integer x = 64
integer y = 104
integer width = 247
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_copy_field_info
integer x = 50
integer y = 768
integer width = 2432
integer height = 468
integer taborder = 70
string dataobject = "d_data_view_fields"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_copy_field_info
integer x = 55
integer y = 252
integer width = 2432
integer height = 468
integer taborder = 60
string dataobject = "d_copy_sys_fields"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

