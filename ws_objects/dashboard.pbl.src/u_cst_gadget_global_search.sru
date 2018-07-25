$PBExportHeader$u_cst_gadget_global_search.sru
forward
global type u_cst_gadget_global_search from u_cst_gadget
end type
type sle_content from singlelineedit within u_cst_gadget_global_search
end type
type st_2 from statictext within u_cst_gadget_global_search
end type
type cb_search from commandbutton within u_cst_gadget_global_search
end type
end forward

global type u_cst_gadget_global_search from u_cst_gadget
string tag = "u_gadget_10.Global Search"
integer width = 1691
integer height = 372
sle_content sle_content
st_2 st_2
cb_search cb_search
end type
global u_cst_gadget_global_search u_cst_gadget_global_search

forward prototypes
public subroutine of_set_bg_color (long al_color_value)
end prototypes

public subroutine of_set_bg_color (long al_color_value);This.backcolor = al_color_value
st_2.backcolor = al_color_value
end subroutine

on u_cst_gadget_global_search.create
int iCurrent
call super::create
this.sle_content=create sle_content
this.st_2=create st_2
this.cb_search=create cb_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_content
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.cb_search
end on

on u_cst_gadget_global_search.destroy
call super::destroy
destroy(this.sle_content)
destroy(this.st_2)
destroy(this.cb_search)
end on

event resize;call super::resize;//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget_global_search::resize()
// $<arguments>
//		unsignedlong	sizetype 		
//		integer     	newwidth 		
//		integer     	newheight		
// $<returns> long
// $<description>
// $<description> User-define resize function for fixed gadget 'Contract Global Search'.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-05 by Ken.Guo
//////////////////////////////////////////////////////////////////////

cb_search.x = This.width - 28 - cb_search.width 
sle_content.width = This.width - sle_content.x - cb_search.width - 3 * 14 
end event

type dw_content from u_cst_gadget`dw_content within u_cst_gadget_global_search
boolean visible = false
integer x = 110
integer y = 496
end type

type ln_split from u_cst_gadget`ln_split within u_cst_gadget_global_search
end type

type st_1 from u_cst_gadget`st_1 within u_cst_gadget_global_search
end type

type st_title from u_cst_gadget`st_title within u_cst_gadget_global_search
end type

type pb_close from u_cst_gadget`pb_close within u_cst_gadget_global_search
end type

type pb_max from u_cst_gadget`pb_max within u_cst_gadget_global_search
end type

type pb_edit from u_cst_gadget`pb_edit within u_cst_gadget_global_search
integer taborder = 30
end type

type sle_content from singlelineedit within u_cst_gadget_global_search
event keyup pbm_keyup
integer x = 14
integer y = 196
integer width = 1289
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event keyup;//////////////////////////////////////////////////////////////////////
// $<event>keyupsle_content()
// $<arguments>
//		value	keycode     	key     		
//		value	unsignedlong	keyflags		
// $<returns> long
// $<description> Use user-define Keyup event. 
// $<description> Don't use cb_search.default property.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-08 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If Key = KeyEnter! Then
	cb_search.Trigger Event Clicked()
End If
end event

type st_2 from statictext within u_cst_gadget_global_search
integer x = 14
integer y = 132
integer width = 526
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Contract Global Search:"
boolean focusrectangle = false
end type

type cb_search from commandbutton within u_cst_gadget_global_search
integer x = 1326
integer y = 196
integer width = 343
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Search"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>cb_search::clicked()
// $<arguments>(None)
// $<returns> long
// $<description> Input search text, Then trigger CTX global search function.
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> 08/05/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Str_global_search lstr_global_search
PowerObject lpo_NullParm

If sle_content.text = '' Then Return 1
lstr_global_search.as_search_content = sle_content.text

//OpenSheet(w_contract, w_mdi, 4, original!)
gf_OpenContractFolder(lpo_NullParm)

If Not Isvalid(w_contract_globalsearch) Then
	POST OpenWithParm(w_contract_globalsearch,lstr_global_search)
Else
	w_contract_globalsearch.SetFocus()	
	w_contract_globalsearch.istr_global_search.as_search_content = sle_content.text
	w_contract_globalsearch.Trigger Event ue_auto_search()
End If
end event

