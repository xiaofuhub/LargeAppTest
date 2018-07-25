$PBExportHeader$u_cst_fonts_list.sru
forward
global type u_cst_fonts_list from userobject
end type
type dw_fonts from datawindow within u_cst_fonts_list
end type
end forward

global type u_cst_fonts_list from userobject
integer width = 741
integer height = 96
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_fonts dw_fonts
end type
global u_cst_fonts_list u_cst_fonts_list

type variables
datawindowchild idwc_fonts
end variables

forward prototypes
public subroutine of_set_font (string as_font)
public function string of_get_font ()
end prototypes

public subroutine of_set_font (string as_font);dw_fonts.SetItem(1,1,as_font)
end subroutine

public function string of_get_font ();Return dw_fonts.GetItemString(1,1)
end function

on u_cst_fonts_list.create
this.dw_fonts=create dw_fonts
this.Control[]={this.dw_fonts}
end on

on u_cst_fonts_list.destroy
destroy(this.dw_fonts)
end on

event constructor;//////////////////////////////////////////////////////////////////////
// $<event>u_cst_fonts_list::constructor()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description> Get Fonts List from Local System.
//////////////////////////////////////////////////////////////////////
// $<add> 09.27.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_fonts[]
int i,j
n_cst_appeondll lnv_appeon_dll


dw_fonts.getchild("fonts_face",idwc_fonts)

lnv_appeon_dll.of_getfonts(ls_fonts)

For i = 1 To UpperBound(ls_fonts[])
	If Trim(ls_fonts[i]) = '' Then Continue
	If i > 1 Then
		If ls_fonts[i - 1] = ls_fonts[i] Then Continue
	End If
	j = idwc_fonts.InsertRow(0)
	idwc_fonts.SetItem(j,1,ls_fonts[i])
Next

If idwc_fonts.RowCount() = 0 Then
	idwc_fonts.InsertRow(1)
	idwc_fonts.SetItem(1,1,'MS Sans Serif')
End If

idwc_fonts.SetSort('fonts_face A')
idwc_fonts.Sort()
dw_fonts.InsertRow(0)

end event

type dw_fonts from datawindow within u_cst_fonts_list
integer width = 736
integer height = 92
integer taborder = 10
string title = "none"
string dataobject = "d_fonts"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

