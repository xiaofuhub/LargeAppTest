$PBExportHeader$w_multiple_versions.srw
forward
global type w_multiple_versions from w_response
end type
type cb_2 from u_cb within w_multiple_versions
end type
type cb_ok from u_cb within w_multiple_versions
end type
type dw_1 from u_dw within w_multiple_versions
end type
type gb_1 from u_gb within w_multiple_versions
end type
end forward

global type w_multiple_versions from w_response
integer width = 1728
integer height = 1236
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
cb_2 cb_2
cb_ok cb_ok
dw_1 dw_1
gb_1 gb_1
end type
global w_multiple_versions w_multiple_versions

on w_multiple_versions.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_multiple_versions.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;






dw_1.retrieve(Message.DoubleParm)
end event

type cb_2 from u_cb within w_multiple_versions
integer x = 841
integer y = 1120
integer taborder = 30
string text = "&Cancel"
end type

event clicked;call super::clicked;



CloseWithReturn(Parent, 0)
end event

type cb_ok from u_cb within w_multiple_versions
integer x = 402
integer y = 1120
integer taborder = 20
string text = "&Ok"
end type

event clicked;call super::clicked;
long ll_row

ll_row = dw_1.GetSelectedRow (0)

if ll_row > 0 then
	ll_row = dw_1.object.npdb_hdr_id[ll_row]
	CloseWithReturn(Parent, ll_row)
else
	messagebox(parent.title, 'Please select a row')
end if
end event

type dw_1 from u_dw within w_multiple_versions
integer x = 37
integer y = 64
integer taborder = 10
string dataobject = "d_npdb_version"
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;

This.SelectRow(0, FALSE)

This.SelectRow(row, TRUE)
end event

type gb_1 from u_gb within w_multiple_versions
integer width = 1682
integer height = 1088
integer taborder = 10
long backcolor = 33551856
string text = "Please select a version of the report to view."
end type

