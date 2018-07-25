$PBExportHeader$w_image_from_de.srw
forward
global type w_image_from_de from w_popup
end type
type uo_1 from pfc_cst_u_imaging within w_image_from_de
end type
end forward

global type w_image_from_de from w_popup
integer x = 214
integer y = 221
integer width = 3611
integer height = 2212
long backcolor = 33551856
uo_1 uo_1
end type
global w_image_from_de w_image_from_de

type variables
long il_screen
long il_type
long il_prac
long il_rec_id

end variables

forward prototypes
public function integer of_hide ()
end prototypes

public function integer of_hide ();datawindow dw_list
long t

dw_list = uo_1.tab_view.tabpage_setup.dw_image_list

uo_1.tab_view.tabpage_browse.visible = false
uo_1.tab_view.tabpage_image.visible = false



dw_list.dataobject = "d_image_type_per_screen"
dw_list.settransobject(sqlca)
t = dw_list.retrieve(gs_user_id, il_screen)

if t = 0 then
	messagebox("Document Add","There are no Document types set up for this data screen.")
	close(w_image_from_de)
elseif t = 1 then
	dw_list.enabled = false
	dw_list.selectrow(1,true)
end if









return 1
end function

on w_image_from_de.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_image_from_de.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from pfc_cst_u_imaging within w_image_from_de
integer x = 9
integer y = 8
integer taborder = 40
end type

on uo_1.destroy
call pfc_cst_u_imaging::destroy
end on

