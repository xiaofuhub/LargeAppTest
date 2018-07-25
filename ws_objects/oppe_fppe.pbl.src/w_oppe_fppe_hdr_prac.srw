$PBExportHeader$w_oppe_fppe_hdr_prac.srw
forward
global type w_oppe_fppe_hdr_prac from w_master
end type
type uo_oppe from uo_oppe_fppe_evals within w_oppe_fppe_hdr_prac
end type
end forward

global type w_oppe_fppe_hdr_prac from w_master
integer width = 3671
integer height = 2016
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 32891346
uo_oppe uo_oppe
end type
global w_oppe_fppe_hdr_prac w_oppe_fppe_hdr_prac

type variables
long il_prac
long il_parent
end variables

event open;call super::open;string s
string ls_name //maha 04.23.2010
integer p

s = message.stringparm
p = PosA(s,"*",1)
il_prac = long(MidA(s,1, p - 1))
il_parent = long(MidA(s, p + 1))

//Start Code Change ----04.23.2010 #V10 maha - add name to title bar
select full_name into :ls_name from v_full_name where prac_id = :il_prac;
this.title+= " for " + ls_name
//End Code Change---04.23.2010

uo_oppe.of_setup(il_prac,il_parent)
uo_oppe.of_set_security( )
uo_oppe.cb_close.visible =  true  //Start Code Change ----08.30.2011 #V11 maha 
end event

on w_oppe_fppe_hdr_prac.create
int iCurrent
call super::create
this.uo_oppe=create uo_oppe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_oppe
end on

on w_oppe_fppe_hdr_prac.destroy
call super::destroy
destroy(this.uo_oppe)
end on

type uo_oppe from uo_oppe_fppe_evals within w_oppe_fppe_hdr_prac
integer height = 2156
integer taborder = 30
end type

on uo_oppe.destroy
call uo_oppe_fppe_evals::destroy
end on

