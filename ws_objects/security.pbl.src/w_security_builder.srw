$PBExportHeader$w_security_builder.srw
forward
global type w_security_builder from window
end type
type cb_filter from commandbutton within w_security_builder
end type
type cb_sort from commandbutton within w_security_builder
end type
type dw_1 from datawindow within w_security_builder
end type
type cb_7 from commandbutton within w_security_builder
end type
type cb_6 from commandbutton within w_security_builder
end type
type sle_4 from singlelineedit within w_security_builder
end type
type st_4 from statictext within w_security_builder
end type
type dw_6 from datawindow within w_security_builder
end type
type dw_5 from datawindow within w_security_builder
end type
type sle_3 from singlelineedit within w_security_builder
end type
type st_3 from statictext within w_security_builder
end type
type cb_5 from commandbutton within w_security_builder
end type
type st_2 from statictext within w_security_builder
end type
type st_1 from statictext within w_security_builder
end type
type dw_4 from datawindow within w_security_builder
end type
type sle_2 from singlelineedit within w_security_builder
end type
type sle_1 from singlelineedit within w_security_builder
end type
type cb_4 from commandbutton within w_security_builder
end type
type cb_3 from commandbutton within w_security_builder
end type
type cb_2 from commandbutton within w_security_builder
end type
type cb_1 from commandbutton within w_security_builder
end type
type dw_3 from datawindow within w_security_builder
end type
type dw_2 from datawindow within w_security_builder
end type
type dw_7 from datawindow within w_security_builder
end type
end forward

global type w_security_builder from window
integer x = 73
integer y = 12
integer width = 3483
integer height = 2504
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
cb_filter cb_filter
cb_sort cb_sort
dw_1 dw_1
cb_7 cb_7
cb_6 cb_6
sle_4 sle_4
st_4 st_4
dw_6 dw_6
dw_5 dw_5
sle_3 sle_3
st_3 st_3
cb_5 cb_5
st_2 st_2
st_1 st_1
dw_4 dw_4
sle_2 sle_2
sle_1 sle_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_3 dw_3
dw_2 dw_2
dw_7 dw_7
end type
global w_security_builder w_security_builder

type variables

end variables

on w_security_builder.create
this.cb_filter=create cb_filter
this.cb_sort=create cb_sort
this.dw_1=create dw_1
this.cb_7=create cb_7
this.cb_6=create cb_6
this.sle_4=create sle_4
this.st_4=create st_4
this.dw_6=create dw_6
this.dw_5=create dw_5
this.sle_3=create sle_3
this.st_3=create st_3
this.cb_5=create cb_5
this.st_2=create st_2
this.st_1=create st_1
this.dw_4=create dw_4
this.sle_2=create sle_2
this.sle_1=create sle_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_7=create dw_7
this.Control[]={this.cb_filter,&
this.cb_sort,&
this.dw_1,&
this.cb_7,&
this.cb_6,&
this.sle_4,&
this.st_4,&
this.dw_6,&
this.dw_5,&
this.sle_3,&
this.st_3,&
this.cb_5,&
this.st_2,&
this.st_1,&
this.dw_4,&
this.sle_2,&
this.sle_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_3,&
this.dw_2,&
this.dw_7}
end on

on w_security_builder.destroy
destroy(this.cb_filter)
destroy(this.cb_sort)
destroy(this.dw_1)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.sle_4)
destroy(this.st_4)
destroy(this.dw_6)
destroy(this.dw_5)
destroy(this.sle_3)
destroy(this.st_3)
destroy(this.cb_5)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_4)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_7)
end on

event open;integer sub
integer act
integer mod
integer rit

//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=dba;PWD=sql',DelimitIdentifier='No'"
//SQLCA.AutoCommit = false
//
////--------------------------- APPEON BEGIN ---------------------------
////$< Add  > 2007-09-14 By: Scofield
////$<Reason> Set the connection cache dynamically on Web
//if AppeonGetClientType() = 'WEB' then
//	SQLCA.DBMS = gs_CacheType
//	SQLCA.DBParm = gs_CacheSet
//end if
////---------------------------- APPEON END ----------------------------
//
//CONNECT USING SQLCA;

select max(sub_module_id)
into :sub
from security_sub_module;

select max(action_id)
into :act
from security_rights_action;

select max(module_id)
into :mod
from security_modules;

select max(rights_id)
into :rit
from security_roles_rights;

sle_1.text = string(sub)
sle_2.text = string(act)
sle_3.text = string(mod)
sle_4.text = string(rit)

dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

event close;

//disCONNECT USING SQLCA;

end event

type cb_filter from commandbutton within w_security_builder
integer x = 416
integer y = 36
integer width = 311
integer height = 88
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.Setfilter(null_str)

dw_1.filter( )
end event

type cb_sort from commandbutton within w_security_builder
integer x = 41
integer y = 36
integer width = 311
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.SetSort(null_str)

dw_1.Sort( )
end event

type dw_1 from datawindow within w_security_builder
integer x = 32
integer y = 164
integer width = 1271
integer height = 1616
integer taborder = 170
string dataobject = "d_role_security_treeview"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer r





r = this.getclickedrow()
this.setrow(r)
this.selectrow(0,false) 
this.selectrow(r,true) 
end event

event rowfocuschanged;long subid
long modd

subid = this.getitemnumber(currentrow,"sub_module_id")
modd = this.getitemnumber(currentrow,"module_id")
dw_2.settransobject(sqlca)
dw_2.retrieve(subid)
dw_3.settransobject(sqlca)
dw_3.retrieve(modd)
end event

type cb_7 from commandbutton within w_security_builder
integer x = 837
integer y = 1808
integer width = 311
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset"
end type

event clicked;dw_3.reset()
dw_4.reset()
dw_5.reset()
dw_6.reset()
end event

type cb_6 from commandbutton within w_security_builder
integer x = 2062
integer y = 32
integer width = 311
integer height = 88
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save Rights"
end type

event clicked;		dw_6.settransobject(sqlca)
		dw_6.update()
		commit using sqlca;
end event

type sle_4 from singlelineedit within w_security_builder
integer x = 421
integer y = 2196
integer width = 247
integer height = 92
integer taborder = 90
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

type st_4 from statictext within w_security_builder
integer x = 178
integer y = 2216
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Rights id"
boolean focusrectangle = false
end type

type dw_6 from datawindow within w_security_builder
integer x = 1358
integer y = 1832
integer width = 1467
integer height = 460
integer taborder = 110
string dataobject = "d_newrole_rights"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_5 from datawindow within w_security_builder
integer x = 1358
integer y = 980
integer width = 1024
integer height = 384
integer taborder = 160
string dataobject = "d_new_mod"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type sle_3 from singlelineedit within w_security_builder
integer x = 416
integer y = 1816
integer width = 247
integer height = 92
integer taborder = 70
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

type st_3 from statictext within w_security_builder
integer x = 119
integer y = 1840
integer width = 256
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Module id"
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_security_builder
integer x = 864
integer y = 2120
integer width = 311
integer height = 88
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add action"
end type

event clicked;integer r
integer actid

actid = integer(sle_2.text)
actid= actid + 10

r = dw_4.insertrow(0)
dw_4.setrow(r)
dw_4.setfocus()
dw_4.setcolumn("action_name")
dw_4.setitem(r,"action_id",actid)
if dw_3.rowcount() >0 then
	dw_4.setitem(r,"module_id",dw_3.getitemnumber(dw_3.getrow(),"module_id"))
	dw_4.setitem(r,"sub_module_id",dw_3.getitemnumber(dw_3.getrow(),"sub_module_id"))
end if

sle_2.text = string(actid)
end event

type st_2 from statictext within w_security_builder
integer x = 174
integer y = 2092
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Action id"
boolean focusrectangle = false
end type

type st_1 from statictext within w_security_builder
integer x = 119
integer y = 1964
integer width = 265
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Sub_mod id"
boolean focusrectangle = false
end type

type dw_4 from datawindow within w_security_builder
integer x = 2418
integer y = 980
integer width = 978
integer height = 816
integer taborder = 150
string dataobject = "d_new_act"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type sle_2 from singlelineedit within w_security_builder
integer x = 416
integer y = 2072
integer width = 247
integer height = 92
integer taborder = 80
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

type sle_1 from singlelineedit within w_security_builder
integer x = 416
integer y = 1940
integer width = 247
integer height = 92
integer taborder = 60
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

type cb_4 from commandbutton within w_security_builder
integer x = 846
integer y = 1908
integer width = 311
integer height = 88
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add module"
end type

event clicked;integer r
integer modid

modid = integer(sle_3.text)
modid++

r = dw_5.insertrow(0)
dw_5.setrow(r)
dw_5.setfocus()
dw_5.setcolumn("module_name")
dw_5.setitem(r,"module_id",modid)

sle_3.text = string(modid)
end event

type cb_3 from commandbutton within w_security_builder
integer x = 864
integer y = 2016
integer width = 311
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add sub"
end type

event clicked;integer r
integer subid

subid = integer(sle_1.text)
subid = subid + 10

r = dw_3.insertrow(0)
dw_3.setrow(r)
dw_3.setfocus()
dw_3.setcolumn("sub_module_name")
dw_3.setitem(r,"sub_module_id",subid)
if dw_5.rowcount() >0 then
	dw_3.setitem(r,"module_id",dw_5.getitemnumber(dw_5.getrow(),"module_id"))
end if

sle_1.text = string(subid)
end event

type cb_2 from commandbutton within w_security_builder
integer x = 3077
integer y = 40
integer width = 311
integer height = 88
integer taborder = 30
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

type cb_1 from commandbutton within w_security_builder
integer x = 1742
integer y = 32
integer width = 311
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;		integer r
		integer ritid
		integer i
		integer rc
		integer actid
		integer crow
		integer a


dw_5.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)

if dw_5.update() = 1 and dw_3.update() = 1 and dw_4.update() = 1 then
	commit using sqlca;	
		
	dw_1.retrieve()
	
	if dw_4.rowcount() > 0 then
		dw_7.settransobject(sqlca)
		rc = dw_7.retrieve()
		ritid = integer(sle_4.text)
		ritid= ritid + 1
	//	crow  = dw_5.getrow()
		for a = 1 to dw_4.rowcount()		
			actid = dw_4.getitemnumber(a,"action_id")
			for r = 1 to rc
				ritid= ritid + 1
				i = dw_6.insertrow(0)
				dw_6.setitem(i,"role_id",dw_7.getitemnumber(r,"role_id"))
				dw_6.setitem(i,"rights_id",ritid)
				dw_6.setitem(i,"action_id",actid)
				dw_6.setitem(i,"value_id",0)
				
				sle_4.text = string(ritid)
			next
		next
	//		dw_6.settransobject(sqlca)
	//		dw_6.update()
	//		commit using sqlca;
	end if

end if
end event

type dw_3 from datawindow within w_security_builder
integer x = 1358
integer y = 1384
integer width = 1019
integer height = 416
integer taborder = 170
string dataobject = "d_new_sub"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_security_builder
integer x = 1358
integer y = 172
integer width = 2034
integer height = 776
integer taborder = 10
string dataobject = "d_scrty_actions"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long	ll_Row,ll_Actid

if This.RowCount() < 1 then Return

ll_Row = This.GetClickedRow()
if Not (ll_Row > 0 and ll_Row <= This.RowCount()) then Return

This.SetRow(ll_Row)
This.SelectRow(0,false) 
This.SelectRow(ll_Row,true) 

ll_Actid = This.GetItemNumber(ll_Row,"action_id")
dw_4.SetTransObject(sqlca)
dw_4.Retrieve(ll_Actid)
dw_6.SetTransObject(sqlca)
dw_6.Retrieve(ll_Actid)

end event

type dw_7 from datawindow within w_security_builder
integer x = 2866
integer y = 1824
integer width = 494
integer height = 280
integer taborder = 100
string dataobject = "d_roles"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

