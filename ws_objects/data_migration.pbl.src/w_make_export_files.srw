$PBExportHeader$w_make_export_files.srw
forward
global type w_make_export_files from window
end type
type cb_1 from commandbutton within w_make_export_files
end type
type cbx_e from checkbox within w_make_export_files
end type
type cbx_a from checkbox within w_make_export_files
end type
type cbx_f from checkbox within w_make_export_files
end type
type cbx_t from checkbox within w_make_export_files
end type
type st_1 from statictext within w_make_export_files
end type
type dw_code from datawindow within w_make_export_files
end type
type dw_auto from datawindow within w_make_export_files
end type
type dw_fac from datawindow within w_make_export_files
end type
type dw_app from datawindow within w_make_export_files
end type
type cb_13 from commandbutton within w_make_export_files
end type
type dw_table from datawindow within w_make_export_files
end type
type cb_3 from commandbutton within w_make_export_files
end type
end forward

global type w_make_export_files from window
integer x = 613
integer y = 64
integer width = 2743
integer height = 2228
boolean titlebar = true
string title = "Import Export data"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
cb_1 cb_1
cbx_e cbx_e
cbx_a cbx_a
cbx_f cbx_f
cbx_t cbx_t
st_1 st_1
dw_code dw_code
dw_auto dw_auto
dw_fac dw_fac
dw_app dw_app
cb_13 cb_13
dw_table dw_table
cb_3 cb_3
end type
global w_make_export_files w_make_export_files

type variables
string is_dwname
integer ii_exp
end variables

on w_make_export_files.create
this.cb_1=create cb_1
this.cbx_e=create cbx_e
this.cbx_a=create cbx_a
this.cbx_f=create cbx_f
this.cbx_t=create cbx_t
this.st_1=create st_1
this.dw_code=create dw_code
this.dw_auto=create dw_auto
this.dw_fac=create dw_fac
this.dw_app=create dw_app
this.cb_13=create cb_13
this.dw_table=create dw_table
this.cb_3=create cb_3
this.Control[]={this.cb_1,&
this.cbx_e,&
this.cbx_a,&
this.cbx_f,&
this.cbx_t,&
this.st_1,&
this.dw_code,&
this.dw_auto,&
this.dw_fac,&
this.dw_app,&
this.cb_13,&
this.dw_table,&
this.cb_3}
end on

on w_make_export_files.destroy
destroy(this.cb_1)
destroy(this.cbx_e)
destroy(this.cbx_a)
destroy(this.cbx_f)
destroy(this.cbx_t)
destroy(this.st_1)
destroy(this.dw_code)
destroy(this.dw_auto)
destroy(this.dw_fac)
destroy(this.dw_app)
destroy(this.cb_13)
destroy(this.dw_table)
destroy(this.cb_3)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	//MESSAGEBOX("","LOGIN OK")
//END IF

 is_dwname = "None"
 
 dw_fac.settransobject(sqlca)
 dw_fac.retrieve()
 dw_fac.insertrow(1)
end event

event close;//disCONNECT USING SQLCA;
end event

type cb_1 from commandbutton within w_make_export_files
integer x = 2327
integer y = 168
integer width = 247
integer height = 108
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "About"
end type

event clicked;messagebox("About Importing","Browse to and select previously created import files. Clinking Import will add the files to the database resetting app_ids to next number.  A new facility with the day's date will be created.")
end event

type cbx_e from checkbox within w_make_export_files
integer x = 791
integer y = 472
integer width = 411
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32891346
string text = "Equiv Codes"
end type

type cbx_a from checkbox within w_make_export_files
integer x = 791
integer y = 388
integer width = 430
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32891346
string text = "Auto Exports"
end type

type cbx_f from checkbox within w_make_export_files
integer x = 791
integer y = 312
integer width = 434
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32891346
string text = "Export Fields"
end type

type cbx_t from checkbox within w_make_export_files
integer x = 791
integer y = 228
integer width = 462
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32891346
string text = "Export Header"
end type

type st_1 from statictext within w_make_export_files
integer x = 617
integer y = 16
integer width = 366
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32891346
boolean enabled = false
string text = "Select export"
boolean focusrectangle = false
end type

type dw_code from datawindow within w_make_export_files
integer x = 37
integer y = 1744
integer width = 2565
integer height = 316
integer taborder = 50
string dataobject = "d_export_eqivcode_for_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type dw_auto from datawindow within w_make_export_files
integer x = 37
integer y = 1384
integer width = 2565
integer height = 348
integer taborder = 40
string dataobject = "d_export_auto_for_imp"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type dw_fac from datawindow within w_make_export_files
integer x = 603
integer y = 100
integer width = 864
integer height = 104
integer taborder = 60
string dataobject = "d_exp_select"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;ii_exp = integer(data)
//messagebox("",ii_exp)
end event

type dw_app from datawindow within w_make_export_files
integer x = 37
integer y = 1020
integer width = 2565
integer height = 348
integer taborder = 30
string dataobject = "d_export_fields_for_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type cb_13 from commandbutton within w_make_export_files
integer x = 73
integer y = 552
integer width = 375
integer height = 108
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Create Files"
end type

event clicked;string object
string filedate
string filefields
string fileauto
string fileecodes
string mes
long ll_code
long ll_exp_id
long ll_auto
long ll_fld
long i
integer a
long tc = 0
long ac = 0
long cc = 0
long fc = 0
integer ck = 1

//dw_table.dataobject = is_dwname
//if is_dwname = "None" then return
dw_table.settransobject(sqlca)
dw_table.reset()
dw_app.settransobject(sqlca)
dw_app.reset()
dw_auto.settransobject(sqlca)
dw_auto.reset()
dw_code.settransobject(sqlca)
dw_code.reset()

filedate = string(month(today())) + "-" + string(day(today())) + "-" + string(year(today()))

filefields = "C:\intellicred\Export file HDR " + string(ii_exp) + " " + string(today()) + ".txt"
messagebox("",filefields)

if ii_exp < 1 then 
	messagebox("Select Error","Please select an export")
	return
else

	if cbx_t.checked = true then
		dw_table.retrieve(ii_exp)
		dw_table.SaveAs (  "c:\intellicred\Export file HDR " + string(ii_exp) + " " + filedate + ".txt", text!, false )
	end if
	if cbx_f.checked = true then
		dw_app.retrieve(ii_exp)
		//filefields = 
		i = dw_app.SaveAs (  "C:\intellicred\Export file FIELDS " + string(ii_exp) + " " + filedate + ".txt", text!, false )

	end if
	if cbx_a.checked = true then
		dw_auto.retrieve(ii_exp)
		dw_auto.SaveAs (  "c:\intellicred\Export file AUTO " + string(ii_exp) + " " + filedate + ".txt", text!, false )
	end if
	if cbx_e.checked = true then
		dw_code.retrieve(ii_exp)
		dw_code.SaveAs (  "c:\intellicred\Export file EQCODES " + string(ii_exp) + " " + filedate + ".txt", text!, false )
	end if
end if


		if i < 1 then messagebox("Save Failed","Failed")

messagebox("Export complete","Files saved as c:\intellicred\Export file . . .")
end event

type dw_table from datawindow within w_make_export_files
integer x = 37
integer y = 704
integer width = 2565
integer height = 300
integer taborder = 20
string dataobject = "d_export_hdr_for_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type cb_3 from commandbutton within w_make_export_files
integer x = 2313
integer y = 44
integer width = 274
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

