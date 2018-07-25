$PBExportHeader$w_calc_field.srw
forward
global type w_calc_field from window
end type
type st_3 from statictext within w_calc_field
end type
type st_2 from statictext within w_calc_field
end type
type st_1 from statictext within w_calc_field
end type
type sle_fld_nm from singlelineedit within w_calc_field
end type
type cb_5 from commandbutton within w_calc_field
end type
type cb_4 from commandbutton within w_calc_field
end type
type cb_3 from commandbutton within w_calc_field
end type
type cb_1 from commandbutton within w_calc_field
end type
type mle_cal_fld from multilineedit within w_calc_field
end type
type dw_fields_list from datawindow within w_calc_field
end type
type cb_2 from commandbutton within w_calc_field
end type
end forward

global type w_calc_field from window
integer x = 1056
integer y = 484
integer width = 3026
integer height = 1972
boolean titlebar = true
string title = "Calculated Field"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
st_3 st_3
st_2 st_2
st_1 st_1
sle_fld_nm sle_fld_nm
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_1 cb_1
mle_cal_fld mle_cal_fld
dw_fields_list dw_fields_list
cb_2 cb_2
end type
global w_calc_field w_calc_field

event open;String ls_field
String ls_formula

//w_conversion_lookup_tabs.tab_1.tabpage_convert.tab_analyse.tabpage_normalize.dw_all_fields.ShareData( dw_fields_list )


IF Message.StringParm <> "New" THEN
	ls_field = MidA( Message.StringParm, 1, PosA( Message.StringParm, "-" )-1 )
	sle_fld_nm.Text = ls_field
	ls_formula = MidA( Message.StringParm, PosA( Message.StringParm, "-" )+1, 1000 )
	mle_cal_fld.Text = ls_formula
END IF

end event

on w_calc_field.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_fld_nm=create sle_fld_nm
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_1=create cb_1
this.mle_cal_fld=create mle_cal_fld
this.dw_fields_list=create dw_fields_list
this.cb_2=create cb_2
this.Control[]={this.st_3,&
this.st_2,&
this.st_1,&
this.sle_fld_nm,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_1,&
this.mle_cal_fld,&
this.dw_fields_list,&
this.cb_2}
end on

on w_calc_field.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_fld_nm)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.mle_cal_fld)
destroy(this.dw_fields_list)
destroy(this.cb_2)
end on

type st_3 from statictext within w_calc_field
integer x = 142
integer y = 68
integer width = 896
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Select Fields To Use In View"
boolean focusrectangle = false
end type

type st_2 from statictext within w_calc_field
integer x = 1472
integer y = 292
integer width = 334
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Formula"
boolean focusrectangle = false
end type

type st_1 from statictext within w_calc_field
integer x = 1472
integer y = 76
integer width = 334
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Field Name"
boolean focusrectangle = false
end type

type sle_fld_nm from singlelineedit within w_calc_field
integer x = 1467
integer y = 148
integer width = 1385
integer height = 92
integer taborder = 20
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

type cb_5 from commandbutton within w_calc_field
integer x = 2158
integer y = 1608
integer width = 325
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;CloseWithReturn( Parent, sle_fld_nm.Text + "-" + mle_cal_fld.Text  )
end event

type cb_4 from commandbutton within w_calc_field
integer x = 2523
integer y = 1608
integer width = 325
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type cb_3 from commandbutton within w_calc_field
integer x = 2062
integer y = 1120
integer width = 663
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add # Month to a Date"
end type

event clicked;mle_cal_fld.Text = mle_cal_fld.Text + " dateadd( month , #number_of_months , #fld ) "
end event

type cb_1 from commandbutton within w_calc_field
integer x = 1463
integer y = 1120
integer width = 187
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "+"
end type

event clicked;mle_cal_fld.Text = mle_cal_fld.Text + " + "
end event

type mle_cal_fld from multilineedit within w_calc_field
integer x = 1463
integer y = 360
integer width = 1385
integer height = 712
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_fields_list from datawindow within w_calc_field
integer x = 137
integer y = 148
integer width = 1111
integer height = 1624
integer taborder = 10
string title = "4. Select Fields To Use In View"
string dataobject = "d_conv_view_fields"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	This.SetRow( row )
END IF
end event

event constructor;This.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-11 By: owen chen
//$<reason> add database option for sql excution

string ls_sqlsyntax

choose case gs_dbtype
	case 'ASA'
		ls_sqlsyntax =   "  SELECT systable.table_name, "+&  
									"systable.table_id, "+&
									"sys.syscolumns.cname, "+&  
									"sys.syscolumns.colno, "+&  
									"sys.syscolumns.coltype, "+&  
									"sys.syscolumns.length "+& 
								 "FROM sys.syscolumns, "+&  
										"systable "+& 
									"WHERE ( sys.syscolumns.tname = systable.table_name ) and "+&  
										  " ( ( sys.syscolumns.tname in ( :table_name ) ) ) "  
	case 'SQL'
		ls_sqlsyntax =  "  SELECT v_systable.table_name, "+&  
										"v_systable.table_id, "+&
										"v_syscolumns.cname, "+&  
										"v_syscolumns.colno, "+&  
										"v_syscolumns.coltype, "+&  
										"v_syscolumns.length "+& 
								 "FROM v_syscolumns, "+&  
										"v_systable "+& 
								"WHERE ( v_syscolumns.tname = v_systable.table_name ) and "+&  
									  " ( ( v_syscolumns.tname in ( :table_name ) ) ) " 
end choose
this.modify("DataWindow.Table.Select='"+ls_sqlsyntax+"'")

//---------------------------- APPEON END ----------------------------

end event

event doubleclicked;IF row > 0 THEN
	String ls_field
	String ls_table
	String ls_calc_fld
	String ls_calc_Data
	Integer li_pos
	
	ls_field = This.GetItemString( row, "field_name" ) 
	ls_table = This.GetItemString( row, "table_name" ) 
	
	
	li_pos = mle_cal_fld.Position()
	
	ls_calc_data = mle_cal_fld.Text
	
	ls_calc_fld = ls_table + "." + ls_field
	
	ls_calc_data = MidA( ls_calc_data, 1, li_pos ) + ls_calc_fld + MidA( ls_calc_data, li_pos, 1000 )
	
	mle_cal_fld.Text = ls_calc_data
	
	//This.DeleteRow( row )
END IF
end event

type cb_2 from commandbutton within w_calc_field
integer x = 1696
integer y = 1120
integer width = 325
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Substr"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-04 By: Zhang Lingping
//$<reason> The database function substr is unsupported by SQL2000.
//$<reason> It can be updated to "substring"

//mle_cal_fld.Text = mle_cal_fld.Text + " Substr( fld , start_pos , num_chars ) "
mle_cal_fld.Text = mle_cal_fld.Text + " Substring( fld , start_pos , num_chars ) "
//---------------------------- APPEON END ----------------------------


end event

