$PBExportHeader$w_section_requirements.srw
forward
global type w_section_requirements from w_popup
end type
type cb_save from commandbutton within w_section_requirements
end type
type cb_close from commandbutton within w_section_requirements
end type
type dw_detail from u_dw within w_section_requirements
end type
type dw_browse from u_dw within w_section_requirements
end type
end forward

global type w_section_requirements from w_popup
integer x = 214
integer y = 221
integer width = 3744
integer height = 1616
string title = "Privilege Section Requirements"
long backcolor = 33551856
cb_save cb_save
cb_close cb_close
dw_detail dw_detail
dw_browse dw_browse
end type
global w_section_requirements w_section_requirements

on w_section_requirements.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.dw_detail
this.Control[iCurrent+4]=this.dw_browse
end on

on w_section_requirements.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_detail)
destroy(this.dw_browse)
end on

event open;call super::open;long ca

ca = message.doubleparm

dw_browse.of_settransobject(sqlca)
dw_detail.of_settransobject(sqlca)

dw_browse.retrieve(ca)

dw_browse.sharedata( dw_detail)

end event

type cb_save from commandbutton within w_section_requirements
integer x = 2880
integer y = 4
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//needs audit code
dw_detail.update()
end event

type cb_close from commandbutton within w_section_requirements
integer x = 3291
integer y = 4
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close "
end type

event clicked;close(parent)
end event

type dw_detail from u_dw within w_section_requirements
integer x = 14
integer y = 908
integer width = 3680
integer height = 588
integer taborder = 10
string dataobject = "d_priv_section_req_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

type dw_browse from u_dw within w_section_requirements
integer x = 14
integer y = 104
integer width = 3680
integer height = 792
integer taborder = 10
string dataobject = "d_priv_section_req_browse"
end type

event constructor;call super::constructor;this.of_setupdateable( false)
end event

event clicked;call super::clicked;integer r

r = this.getclickedrow()

if r = 0 then return

this.setrow(r)

end event

event rowfocuschanged;call super::rowfocuschanged;this.selectrow(0,false)
this.selectrow(currentrow, true)

dw_detail.scrolltorow(currentrow)
end event

