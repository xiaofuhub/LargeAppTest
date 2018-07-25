$PBExportHeader$w_app_sertifi_view.srw
forward
global type w_app_sertifi_view from w_response
end type
type cb_1 from commandbutton within w_app_sertifi_view
end type
type dw_1 from u_dw within w_app_sertifi_view
end type
end forward

global type w_app_sertifi_view from w_response
integer x = 214
integer y = 221
integer width = 2569
integer height = 1600
cb_1 cb_1
dw_1 dw_1
end type
global w_app_sertifi_view w_app_sertifi_view

on w_app_sertifi_view.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
end on

on w_app_sertifi_view.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;Long ll_rec_id
String ls_parm
Long ll_pos
long ll_prac_id
datawindowchild dwchild
ls_parm = message.stringparm

If isnull(ls_parm) or ls_parm = "" Then Return

ll_pos = Pos(ls_parm, "#")

if ll_pos > 0 then
	ll_rec_id = long(mid(ls_parm,1, ll_pos - 1))
	ll_prac_id = long(mid(ls_parm, ll_pos + 1))
end if


dw_1.getchild( "gp_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve( ll_prac_id )

dw_1.getchild( "facility_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve( gs_user_id )

if gi_intelliapp_type = 0 or gi_intelliapp_type = 3 then  //(Appeon) Modified by Harry 06.27.2016 for BugL062302
	dw_1.modify("gp_id_t.visible='0' gp_id.visible='0'")
end if
	
//Refresh data
dw_1.retrieve(ll_rec_id )

//dw_1.Object.DataWindow.ReadOnly="Yes"   //(Appeon) Modified by Harry 06.27.2016 for BugL062201
end event

type cb_1 from commandbutton within w_app_sertifi_view
integer x = 1051
integer y = 1404
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;close(parent)
end event

type dw_1 from u_dw within w_app_sertifi_view
integer x = 9
integer y = 16
integer width = 2537
integer height = 1368
integer taborder = 10
string dataobject = "dw_app_sertifi_view"
boolean vscrollbar = false
end type

