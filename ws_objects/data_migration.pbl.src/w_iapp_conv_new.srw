$PBExportHeader$w_iapp_conv_new.srw
forward
global type w_iapp_conv_new from window
end type
type st_3 from statictext within w_iapp_conv_new
end type
type cb_4 from commandbutton within w_iapp_conv_new
end type
type cb_2 from commandbutton within w_iapp_conv_new
end type
type cb_1 from commandbutton within w_iapp_conv_new
end type
type cb_8 from commandbutton within w_iapp_conv_new
end type
type cb_7 from commandbutton within w_iapp_conv_new
end type
type cb_6 from commandbutton within w_iapp_conv_new
end type
type dw_4 from datawindow within w_iapp_conv_new
end type
type dw_list from datawindow within w_iapp_conv_new
end type
type dw_1 from datawindow within w_iapp_conv_new
end type
type cb_3 from commandbutton within w_iapp_conv_new
end type
type dw_3 from datawindow within w_iapp_conv_new
end type
end forward

global type w_iapp_conv_new from window
integer x = 251
integer y = 64
integer width = 3730
integer height = 2544
boolean titlebar = true
string title = "Create text file for IApp rows"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
st_3 st_3
cb_4 cb_4
cb_2 cb_2
cb_1 cb_1
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
dw_4 dw_4
dw_list dw_list
dw_1 dw_1
cb_3 cb_3
dw_3 dw_3
end type
global w_iapp_conv_new w_iapp_conv_new

type variables
integer ii_appid
end variables

on w_iapp_conv_new.create
this.st_3=create st_3
this.cb_4=create cb_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.dw_4=create dw_4
this.dw_list=create dw_list
this.dw_1=create dw_1
this.cb_3=create cb_3
this.dw_3=create dw_3
this.Control[]={this.st_3,&
this.cb_4,&
this.cb_2,&
this.cb_1,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.dw_4,&
this.dw_list,&
this.dw_1,&
this.cb_3,&
this.dw_3}
end on

on w_iapp_conv_new.destroy
destroy(this.st_3)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.dw_4)
destroy(this.dw_list)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.dw_3)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=Iapp;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	//MESSAGEBOX("","LOGIN OK")
//END IF

dw_1.settransobject(sqlca)
dw_1.retrieve()
//dw_1.insertrow(1)

dw_list.settransobject(sqlca)

end event

event close;//disCONNECT USING SQLCA;
end event

type st_3 from statictext within w_iapp_conv_new
integer x = 841
integer y = 40
integer width = 754
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32891346
boolean enabled = false
string text = "1) Check the apps you want"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_iapp_conv_new
integer x = 46
integer y = 36
integer width = 311
integer height = 88
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Select All"
end type

event clicked;integer i 
integer ic

for i = 1 to ic
	dw_1.setitem(i,"selected",1)
next
end event

type cb_2 from commandbutton within w_iapp_conv_new
integer x = 2834
integer y = 36
integer width = 416
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print App List"
end type

event clicked;dw_1.print()
end event

type cb_1 from commandbutton within w_iapp_conv_new
integer x = 2427
integer y = 36
integer width = 384
integer height = 84
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Go to Import"
end type

event clicked;

open(w_open_migration_type)
close(parent)
end event

type cb_8 from commandbutton within w_iapp_conv_new
integer x = 2121
integer y = 36
integer width = 274
integer height = 84
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "3) Save"
end type

event clicked;
string f
string h
string docname 
string named
integer value

//value = GetFileSaveName("Select File", docname, named, "DOC", 	"Text Files (*.TXT),*.TXT," ,	" TXT Files (*.txt)", "*.txt")
value = GetFileSaveName ( "Save AS", docname, named  )
IF value = 1 THEN

	 f = docname + "-import_app_rows.txt"
	 h = docname + "-import_hdr_rows.txt"
	 //h = "c:\intellicred\hdr_rows " + string(today()) + ".txt" 
	 //messagebox("",h)
	//messagebox("",f)
	dw_4.saveas(f,text!,false)
	dw_list.saveas(h,text!,false)
	
	 messagebox("Saved","Saved as " + f + " and " + h)
end if
end event

type cb_7 from commandbutton within w_iapp_conv_new
integer x = 1618
integer y = 36
integer width = 466
integer height = 84
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "2) Retrieve data"
end type

event clicked;long i
long rc
long app
long ac
long r
long ic
integer fe

//apphdr
dw_list.reset()
debugbreak()

rc = dw_1.rowcount()
dw_1.accepttext()
for r = 1 to rc
	if dw_1.getitemnumber(r,"selected") = 1 then
		//messagebox("",r)
		fe = dw_1.RowsCopy (r,r, primary!, dw_list, 100000, primary!)
	end if
next

//app field props
dw_4.settransobject(sqlca)
dw_4.reset()

ic = dw_list.rowcount()
for i = 1 to ic
	dw_3.settransobject(sqlca)
	dw_3.reset()
	app = dw_list.getitemnumber(i,"app_id")
	ac = dw_3.retrieve(app)
	dw_3.RowsCopy (1,ac, primary!, dw_4, 10000000, primary!)	
next
end event

type cb_6 from commandbutton within w_iapp_conv_new
integer x = 389
integer y = 36
integer width = 279
integer height = 84
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sort"
end type

event clicked;string nu

setnull(nu)

dw_1.setsort(nu)
dw_1.sort()
end event

type dw_4 from datawindow within w_iapp_conv_new
integer x = 1637
integer y = 792
integer width = 1970
integer height = 1548
integer taborder = 70
string dataobject = "d_app_prop_app"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_list from datawindow within w_iapp_conv_new
integer x = 1646
integer y = 164
integer width = 1961
integer height = 612
integer taborder = 30
string dataobject = "d_app_hdr_ids"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)

end event

event clicked;integer r


r = this.getclickedrow()
this.setrow(r)
this.scrolltorow(r)
this.selectrow(0,false)
this.selectrow(r,true)
end event

type dw_1 from datawindow within w_iapp_conv_new
integer x = 50
integer y = 144
integer width = 1559
integer height = 2212
integer taborder = 10
string dataobject = "d_app_checklist"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;
//integer r
//
//ii_appid = integer(data)
//
//r = dw_1.Find ( "app_id = " + string(ii_appid), 1, dw_1.rowcount() )
//
//dw_1.RowsCopy (r,r, primary!, dw_list, 100000, primary!)
end event

type cb_3 from commandbutton within w_iapp_conv_new
integer x = 3323
integer y = 36
integer width = 274
integer height = 84
integer taborder = 20
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

type dw_3 from datawindow within w_iapp_conv_new
integer x = 1577
integer y = 2340
integer width = 192
integer height = 88
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_app_prop_app"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

