$PBExportHeader$w_actionitem_status_track.srw
forward
global type w_actionitem_status_track from w_response
end type
type cb_close from commandbutton within w_actionitem_status_track
end type
type dw_status_track from u_dw within w_actionitem_status_track
end type
end forward

global type w_actionitem_status_track from w_response
string tag = "Action Items Status Track"
integer x = 0
integer y = 0
integer width = 2386
integer height = 1200
string title = "Action Items Status Track"
long backcolor = 33551856
cb_close cb_close
dw_status_track dw_status_track
end type
global w_actionitem_status_track w_actionitem_status_track

type variables
long		il_CtxID
end variables

on w_actionitem_status_track.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.dw_status_track=create dw_status_track
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.dw_status_track
end on

on w_actionitem_status_track.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.dw_status_track)
end on

event open;call super::open;Str_ctx_info lstr_ctx


//Modified By Ken.Guo 2010-02-25
//il_CtxID = Message.DoubleParm
lstr_ctx = Message.powerobjectparm

if lstr_ctx.as_type = 'dm_ai' then
	dw_status_track.dataobject = 'd_dm_actionitem_status_track'
end if
dw_Status_Track.SetTransObject(SQLCA)
dw_Status_Track.Retrieve(lstr_ctx.al_ctx_id,lstr_ctx.al_ai_id )


end event

type cb_close from commandbutton within w_actionitem_status_track
integer x = 2053
integer y = 1004
integer width = 288
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;CloseWithReturn(Parent,"")
end event

type dw_status_track from u_dw within w_actionitem_status_track
integer x = 23
integer y = 20
integer width = 2318
integer height = 944
integer taborder = 10
string dataobject = "d_actionitem_status_track"
boolean hscrollbar = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

