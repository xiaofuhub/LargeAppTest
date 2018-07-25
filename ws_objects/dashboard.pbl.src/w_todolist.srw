$PBExportHeader$w_todolist.srw
forward
global type w_todolist from w_sheet
end type
type uo_todolist from u_cst_todolist within w_todolist
end type
end forward

global type w_todolist from w_sheet
integer width = 2871
integer height = 1708
string title = "To Do List"
long backcolor = 33551856
event ue_refresh_unread_email ( )
uo_todolist uo_todolist
end type
global w_todolist w_todolist

event ue_refresh_unread_email();uo_todolist.event ue_refresh_unread_email()
end event

on w_todolist.create
int iCurrent
call super::create
this.uo_todolist=create uo_todolist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_todolist
end on

on w_todolist.destroy
call super::destroy
destroy(this.uo_todolist)
end on

event open;call super::open;String 	ls_Scale
Long 	  	ll_Cycle

//APB bug on XP Style - jervis 02.14.2011
if AppeonGetClientType() = 'WEB' then uo_todolist.height = uo_todolist.height - 20//(Appeon)Eugene 06.04.2013 - V141 ISG-CLX

This.of_SetResize(True)

This.inv_resize.of_SetOrigSize(This.WorkSpaceWidth(),This.WorkSpaceHeight())
ls_Scale = This.inv_resize.scale

FOR ll_Cycle = 1 To UpperBound(This.Control)
	This.inv_resize.of_Register(This.Control[ll_Cycle],ls_Scale)
NEXT

uo_todolist.Post Event ue_retrieve_todolist() //Added by Scofield on 2008-11-20
this.Resize(3612, 2000) //Added by Evan on 2008-12-29

This.Event ue_refresh_unread_email()//(Appeon)Eugene 06.04.2013 - V141 ISG-CLX
end event

event activate;call super::activate;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-12-05 By: Scofield
//$<Reason> Switch MDI menu while to do list window get the focus.

if w_mdi.MenuName <> "m_pfe_cst_mdi_menu" then
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	w_mdi.of_menu_security(w_mdi.MenuName)
end if
//---------------------------- APPEON END ----------------------------

end event

type uo_todolist from u_cst_todolist within w_todolist
integer taborder = 30
end type

on uo_todolist.destroy
call u_cst_todolist::destroy
end on

event constructor;call super::constructor;Event ue_ini()
end event

