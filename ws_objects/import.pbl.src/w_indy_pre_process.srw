$PBExportHeader$w_indy_pre_process.srw
forward
global type w_indy_pre_process from window
end type
type cb_close from commandbutton within w_indy_pre_process
end type
type sle_1 from singlelineedit within w_indy_pre_process
end type
type dw_data from datawindow within w_indy_pre_process
end type
type dw_file from datawindow within w_indy_pre_process
end type
type cb_go from commandbutton within w_indy_pre_process
end type
end forward

global type w_indy_pre_process from window
integer width = 3854
integer height = 2276
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
sle_1 sle_1
dw_data dw_data
dw_file dw_file
cb_go cb_go
end type
global w_indy_pre_process w_indy_pre_process

on w_indy_pre_process.create
this.cb_close=create cb_close
this.sle_1=create sle_1
this.dw_data=create dw_data
this.dw_file=create dw_file
this.cb_go=create cb_go
this.Control[]={this.cb_close,&
this.sle_1,&
this.dw_data,&
this.dw_file,&
this.cb_go}
end on

on w_indy_pre_process.destroy
destroy(this.cb_close)
destroy(this.sle_1)
destroy(this.dw_data)
destroy(this.dw_file)
destroy(this.cb_go)
end on

type cb_close from commandbutton within w_indy_pre_process
integer x = 3301
integer y = 56
integer width = 343
integer height = 92
integer taborder = 20
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

type sle_1 from singlelineedit within w_indy_pre_process
integer x = 1742
integer y = 56
integer width = 622
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "c:\GL0002.y"
borderstyle borderstyle = stylelowered!
end type

type dw_data from datawindow within w_indy_pre_process
integer x = 110
integer y = 1112
integer width = 3543
integer height = 876
integer taborder = 20
string title = "none"
string dataobject = "d_indy_pre_process"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_file from datawindow within w_indy_pre_process
integer x = 119
integer y = 276
integer width = 3547
integer height = 756
integer taborder = 10
string title = "none"
string dataobject = "d_indy_pre_process"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_go from commandbutton within w_indy_pre_process
integer x = 2729
integer y = 52
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Process"
end type

event clicked;string sfile
string ls_val
string skipval
integer ck
long r
long rc
long datarow = 0


dw_file.settransobject(sqlca)
dw_data.settransobject(sqlca)

sfile = sle_1.text

rc = dw_file.importfile(csv!,sfile)
//messagebox("",rc)

ck = 3
for r = 3 to rc  //skip lines 1 & 2
	//on row 3 the value should be 2 then 3 then 2 then 3 ect.
	if ck = 3 then 
		ck = 2
	elseif ck = 2 then
		ck = 3
	end if
	if ck <> integer(dw_file.getitemstring(r,1))  then
		messagebox("Process error","Check value failed at line " + string(r))
		return
	end if
debugbreak()	
	if ck = 2 then 
		ls_val = trim(dw_file.getitemstring(r,2))
		skipval = trim(MidA(ls_val, LenA(ls_val) - 4))
		if skipval = "2001" or skipval = "2999" then //skip this row and the next
			r++
			ck = 3
			continue
		else
			datarow = dw_data.insertrow(0)
			dw_data.setitem(datarow,1,ls_val)
		end if
	else //3
		ls_val = dw_file.getitemstring(r,2)
		dw_data.setitem(datarow,2,trim(dw_file.getitemstring(r,2)))
		dw_data.setitem(datarow,3,trim(dw_file.getitemstring(r,3)))
		dw_data.setitem(datarow,4,trim(dw_file.getitemstring(r,4)))
		dw_data.setitem(datarow,5,trim(dw_file.getitemstring(r,5)))
		dw_data.setitem(datarow,6,trim(dw_file.getitemstring(r,6)))
	end if



next
end event

