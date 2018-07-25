$PBExportHeader$w_calc_field_report.srw
forward
global type w_calc_field_report from window
end type
type st_5 from statictext within w_calc_field_report
end type
type st_4 from statictext within w_calc_field_report
end type
type dw_1 from datawindow within w_calc_field_report
end type
type st_3 from statictext within w_calc_field_report
end type
type st_2 from statictext within w_calc_field_report
end type
type st_1 from statictext within w_calc_field_report
end type
type sle_fld_nm from singlelineedit within w_calc_field_report
end type
type cb_5 from commandbutton within w_calc_field_report
end type
type cb_4 from commandbutton within w_calc_field_report
end type
type mle_cal_fld from multilineedit within w_calc_field_report
end type
type dw_fields_list from datawindow within w_calc_field_report
end type
end forward

global type w_calc_field_report from window
integer x = 320
integer y = 236
integer width = 2825
integer height = 1972
boolean titlebar = true
string title = "Calculated Column"
windowtype windowtype = response!
long backcolor = 33551856
st_5 st_5
st_4 st_4
dw_1 dw_1
st_3 st_3
st_2 st_2
st_1 st_1
sle_fld_nm sle_fld_nm
cb_5 cb_5
cb_4 cb_4
mle_cal_fld mle_cal_fld
dw_fields_list dw_fields_list
end type
global w_calc_field_report w_calc_field_report

event open;String ls_field
String ls_formula

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.25.2006 By: LeiWei
//$<reason> Fix a defect.
//w_custom_report.tab_1.tabpage_columns.dw_all_fields.ShareData( dw_fields_list )
IF Isvalid(w_custom_report) THEN
	//$<modify> 05.15.2008 by Andy
	DataWindowChild ldwc_1,ldwc_2
	dw_fields_list.dataobject = 'd_conv_view_fields2'
	dw_fields_list.event constructor( )
	w_custom_report.tab_1.tabpage_columns.dw_all_fields.ShareData( dw_fields_list )
	if w_custom_report.tab_1.tabpage_columns.dw_all_fields.getchild('dbname',ldwc_1) = 1 then
		if dw_fields_list.getchild('dbname',ldwc_2) = 1 then
			ldwc_1.sharedata( ldwc_2 )
		end if
	end if
	//end 05.15.2008
ELSEIF Isvalid(w_custom_report5) THEN
	w_custom_report5.tab_1.tabpage_columns.dw_all_fields.ShareData( dw_fields_list )
END IF
//---------------------------- APPEON END ----------------------------



IF Message.StringParm <> "New" THEN
	ls_field = MidA( Message.StringParm, 1, PosA( Message.StringParm, "-" )-1 )
	sle_fld_nm.Text = ls_field
	ls_formula = MidA( Message.StringParm, PosA( Message.StringParm, "-" )+1, 1000 )
	mle_cal_fld.Text = ls_formula
END IF

end event

on w_calc_field_report.create
this.st_5=create st_5
this.st_4=create st_4
this.dw_1=create dw_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_fld_nm=create sle_fld_nm
this.cb_5=create cb_5
this.cb_4=create cb_4
this.mle_cal_fld=create mle_cal_fld
this.dw_fields_list=create dw_fields_list
this.Control[]={this.st_5,&
this.st_4,&
this.dw_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_fld_nm,&
this.cb_5,&
this.cb_4,&
this.mle_cal_fld,&
this.dw_fields_list}
end on

on w_calc_field_report.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.dw_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_fld_nm)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.mle_cal_fld)
destroy(this.dw_fields_list)
end on

type st_5 from statictext within w_calc_field_report
integer x = 69
integer y = 100
integer width = 992
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
string text = "Select columns to use in computed field"
boolean focusrectangle = false
end type

type st_4 from statictext within w_calc_field_report
integer x = 1353
integer y = 1472
integer width = 1385
integer height = 204
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "To replace the generic field in the formula with a selected column, select the the formula field and then double-click the desired column"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_calc_field_report
integer x = 1344
integer y = 1344
integer width = 1394
integer height = 76
integer taborder = 40
string dataobject = "d_select_function"
boolean hscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject( sqlca )
This.InsertRow( 0 )
end event

event itemchanged;//messagebox("length", len(data))
mle_cal_fld.Text = mle_cal_fld.Text + data
This.Reset()
This.InsertRow( 0 )

end event

type st_3 from statictext within w_calc_field_report
integer x = 1349
integer y = 1276
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
string text = "Functions"
boolean focusrectangle = false
end type

type st_2 from statictext within w_calc_field_report
integer x = 1358
integer y = 388
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

type st_1 from statictext within w_calc_field_report
integer x = 1362
integer y = 100
integer width = 599
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
string text = "Computed Field Name"
boolean focusrectangle = false
end type

type sle_fld_nm from singlelineedit within w_calc_field_report
integer x = 1358
integer y = 180
integer width = 1371
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

type cb_5 from commandbutton within w_calc_field_report
integer x = 2098
integer y = 16
integer width = 325
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;string s

s = sle_fld_nm.Text

sle_fld_nm.Text = of_strip_char(' ', s ,'_')

if of_verify_field_name(sle_fld_nm.Text) = -1 then
	return
else
	CloseWithReturn( Parent, sle_fld_nm.Text + "-" + mle_cal_fld.Text  )
end if
end event

type cb_4 from commandbutton within w_calc_field_report
integer x = 2469
integer y = 16
integer width = 325
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type mle_cal_fld from multilineedit within w_calc_field_report
integer x = 1353
integer y = 456
integer width = 1385
integer height = 712
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_fields_list from datawindow within w_calc_field_report
integer x = 55
integer y = 180
integer width = 1202
integer height = 1616
integer taborder = 10
string title = "Select Columns To Use In View"
string dataobject = "d_conv_view_fields"
boolean hscrollbar = true
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
//$<modify> 05.15.2008 by Andy
//$<reason> add if statement
IF Isvalid(w_custom_report) THEN
	choose case gs_dbtype
		case 'ASA'
			ls_sqlsyntax =   "  SELECT systable.table_name, "+&  
										"systable.table_id, "+&
										"sys.syscolumns.cname, "+&  
										"sys.syscolumns.colno, "+&  
										"sys.syscolumns.coltype, "+&  
										"sys.syscolumns.length, "+&
										"systable.table_name + '.' + sys.syscolumns.cname dbname "+& 
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
											"v_syscolumns.length, "+&
											"v_systable.table_name + '.' + v_syscolumns.cname dbname "+&
									 "FROM v_syscolumns, "+&  
											"v_systable "+& 
									"WHERE ( v_syscolumns.tname = v_systable.table_name ) and "+&  
										  " ( ( v_syscolumns.tname in ( :table_name ) ) ) " 
	end choose
ELSE
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
END IF
//this.modify("DataWindow.Table.Select='"+ls_sqlsyntax+"'")
this.modify("DataWindow.Table.Select=~""+ls_sqlsyntax+"~"")
//end 05.15.2008
//---------------------------- APPEON END ----------------------------

end event

event doubleclicked;IF row > 0 THEN
	String ls_field
	String ls_table
	String ls_calc_fld
	String ls_calc_Data
	Integer li_pos,li_length
	
	ls_field = This.GetItemString( row, "field_name" ) 
	ls_table = This.GetItemString( row, "table_name" ) 
	
	
	li_pos = mle_cal_fld.Position()
	li_length = mle_cal_fld.selectedlength( )
	
	ls_calc_data = mle_cal_fld.Text
	
	ls_calc_fld = ls_table + "." + ls_field
	
	ls_calc_data = MidA( ls_calc_data, 1, li_pos -1 ) + ls_calc_fld + MidA( ls_calc_data, li_pos+li_length, 1000 )
	
	mle_cal_fld.Text = ls_calc_data
	
	//This.DeleteRow( row )
end if




end event

