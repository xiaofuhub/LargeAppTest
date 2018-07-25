$PBExportHeader$u_cst_gadget_getting_started.sru
forward
global type u_cst_gadget_getting_started from u_cst_gadget
end type
type uo_1 from u_cst_getting_started within u_cst_gadget_getting_started
end type
type st_tutorial from statictext within u_cst_gadget_getting_started
end type
end forward

global type u_cst_gadget_getting_started from u_cst_gadget
integer width = 1445
integer height = 1664
event ue_refresh ( )
uo_1 uo_1
st_tutorial st_tutorial
end type
global u_cst_gadget_getting_started u_cst_gadget_getting_started

type variables
integer ii_columns
string is_sort
end variables

forward prototypes
public function integer of_settings ()
public function integer of_get_columns ()
public subroutine of_set_columns (integer al_col)
public subroutine of_refresh_height ()
public function integer of_set_property (string as_property_name, long al_value)
end prototypes

event ue_refresh();ii_columns = Integer(gnv_data.of_getitem('dashboard_gadgets_getting_started','display_columns',False))
If ii_columns = 0 or isnull(ii_columns) Then ii_columns = 2

uo_1.of_set_picture( )
uo_1.of_set_pos(ii_columns)

Return
end event

public function integer of_settings ();integer li_columns

li_columns = ii_columns
Openwithparm(w_dashboard_gadget_getting_start_config,This)
If li_columns <> ii_columns Then
	iuo_tabpge_gadget.of_refresh_ui( )
End If

Return 1
end function

public function integer of_get_columns ();Return ii_columns
end function

public subroutine of_set_columns (integer al_col);ii_columns = al_col
end subroutine

public subroutine of_refresh_height ();uo_1.of_set_pos( ii_columns )
uo_1.event ue_set_height( )

end subroutine

public function integer of_set_property (string as_property_name, long al_value);Super::of_set_property(as_property_name,al_value) 

//Set st_tutorial Properties. //Added By Ken.Guo 2010-12-22.
If isnull(al_value) Then Return 1
Choose Case Upper(as_property_name)
	Case Upper(CONST_TITLE_COLOR)
		st_tutorial.backcolor = al_value
	Case Upper(CONST_TITLE_FONT_SIZE)
		If al_value = 0 or isnull(al_value) Then al_value = 10
		st_tutorial.textsize = al_value
	Case Upper(CONST_TITLE_FONT_COLOR)
		If isnull(al_value) Then al_value = 0
		st_tutorial.textcolor = al_value
	Case Else
		Return -100
End Choose
Return 1
end function

on u_cst_gadget_getting_started.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.st_tutorial=create st_tutorial
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.st_tutorial
end on

on u_cst_gadget_getting_started.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.st_tutorial)
end on

event resize;call super::resize;If newheight < 100 Then Return 1
uo_1.resize(newwidth - 10 , newheight - 100 - 10)

ii_columns = Integer(gnv_data.of_getitem('dashboard_gadgets_getting_started','display_columns',False))
If ii_columns = 0 or isnull(ii_columns) Then ii_columns = 2
uo_1.of_set_pos(ii_columns)


end event

event ue_do;call super::ue_do;//uo_1.of_set_picture()
This.event ue_refresh( )
Return 1
end event

event ue_resize_ini;call super::ue_resize_ini;st_tutorial.x = pb_edit.x - st_tutorial.width - 25

end event

type dw_content from u_cst_gadget`dw_content within u_cst_gadget_getting_started
boolean visible = false
integer x = 46
integer y = 988
end type

type ln_split from u_cst_gadget`ln_split within u_cst_gadget_getting_started
end type

type st_1 from u_cst_gadget`st_1 within u_cst_gadget_getting_started
end type

type st_title from u_cst_gadget`st_title within u_cst_gadget_getting_started
end type

type pb_close from u_cst_gadget`pb_close within u_cst_gadget_getting_started
end type

type pb_max from u_cst_gadget`pb_max within u_cst_gadget_getting_started
end type

type pb_edit from u_cst_gadget`pb_edit within u_cst_gadget_getting_started
end type

type uo_1 from u_cst_getting_started within u_cst_gadget_getting_started
integer y = 92
integer width = 1449
integer height = 1576
integer taborder = 20
boolean bringtotop = true
borderstyle borderstyle = styleraised!
end type

on uo_1.destroy
call u_cst_getting_started::destroy
end on

event ue_set_height;call super::ue_set_height;il_fixed_height = This.height + 100
If Parent.height <> il_fixed_height Then
	Parent.height = il_fixed_height
End If
end event

type st_tutorial from statictext within u_cst_gadget_getting_started
integer x = 443
integer y = 4
integer width = 526
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 12632256
string text = "View Tutorials"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;If isvalid(m_pfe_cst_master_menu) Then
	m_pfe_cst_master_menu.m_help.m_viewlets.event clicked()
End If
end event

