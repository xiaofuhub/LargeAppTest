$PBExportHeader$w_extended_search_app.srw
forward
global type w_extended_search_app from w_response
end type
type uo_1 from pfc_cst_u_extended_search_sk within w_extended_search_app
end type
end forward

global type w_extended_search_app from w_response
integer x = 9
integer y = 336
integer width = 4101
integer height = 1944
string title = "Practitioner Search"
boolean controlmenu = false
long backcolor = 32891346
uo_1 uo_1
end type
global w_extended_search_app w_extended_search_app

type variables
Integer ii_dashboard_macro = 0
end variables

on w_extended_search_app.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_extended_search_app.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;call super::open;gs_search lstr_search
lstr_search = Message.PowerObjectParm
uo_1.of_set_transaction( lstr_search.stran_transaction )
uo_1.of_set_open_for( lstr_search.ls_open_for )

//Start Code Change ----09.03.2008 #V85 maha - Removed because it caused an application error
//This.uo_1.cb_new.visible = False //Added By Ken.Guo 05.28.2008. Fix BugN050703, Only w_prac_data_1 can show this button.
end event

type uo_1 from pfc_cst_u_extended_search_sk within w_extended_search_app
integer taborder = 30
end type

on uo_1.destroy
call pfc_cst_u_extended_search_sk::destroy
end on

