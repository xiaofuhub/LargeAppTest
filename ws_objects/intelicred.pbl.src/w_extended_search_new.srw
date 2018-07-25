$PBExportHeader$w_extended_search_new.srw
forward
global type w_extended_search_new from w_response
end type
type uo_1 from pfc_cst_u_extended_search within w_extended_search_new
end type
type cb_1 from commandbutton within w_extended_search_new
end type
end forward

global type w_extended_search_new from w_response
integer x = 9
integer y = 336
integer width = 3959
integer height = 2104
string title = "Provider Search"
boolean controlmenu = false
long backcolor = 33551856
uo_1 uo_1
cb_1 cb_1
end type
global w_extended_search_new w_extended_search_new

type variables
Integer ii_dashboard_macro = 0
end variables

on w_extended_search_new.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_extended_search_new.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.cb_1)
end on

event open;call super::open;gs_search lstr_search
lstr_search = Message.PowerObjectParm

uo_1.of_set_transaction( lstr_search.stran_transaction )
uo_1.of_set_open_for( lstr_search.ls_open_for )
uo_1.of_bg_color(16774640)


//Start Code Change ----09.03.2008 #V85 maha - Removed because it caused an application error
//This.uo_1.cb_new.visible = False //Added By Ken.Guo 05.28.2008. Fix BugN050703, Only w_prac_data_1 can show this button.
end event

type uo_1 from pfc_cst_u_extended_search within w_extended_search_new
integer x = 37
integer y = 28
integer height = 1948
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call pfc_cst_u_extended_search::destroy
end on

type cb_1 from commandbutton within w_extended_search_new
boolean visible = false
integer x = 768
integer y = 1068
integer width = 247
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Test"
end type

event clicked;long i

i = 1 / 0
end event

