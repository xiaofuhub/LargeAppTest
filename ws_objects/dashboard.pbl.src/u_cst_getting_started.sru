$PBExportHeader$u_cst_getting_started.sru
forward
global type u_cst_getting_started from userobject
end type
type cbx_use_template from checkbox within u_cst_getting_started
end type
type st_ref from statictext within u_cst_getting_started
end type
type pb_10 from u_picturebutton_started within u_cst_getting_started
end type
type pb_9 from u_picturebutton_started within u_cst_getting_started
end type
type pb_8 from u_picturebutton_started within u_cst_getting_started
end type
type pb_7 from u_picturebutton_started within u_cst_getting_started
end type
type pb_6 from u_picturebutton_started within u_cst_getting_started
end type
type pb_5 from u_picturebutton_started within u_cst_getting_started
end type
type pb_4 from u_picturebutton_started within u_cst_getting_started
end type
type pb_3 from u_picturebutton_started within u_cst_getting_started
end type
type pb_2 from u_picturebutton_started within u_cst_getting_started
end type
type pb_1 from u_picturebutton_started within u_cst_getting_started
end type
end forward

global type u_cst_getting_started from userobject
integer width = 1513
integer height = 1272
boolean vscrollbar = true
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event command pbm_syscommand
event ue_set_height ( )
cbx_use_template cbx_use_template
st_ref st_ref
pb_10 pb_10
pb_9 pb_9
pb_8 pb_8
pb_7 pb_7
pb_6 pb_6
pb_5 pb_5
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
end type
global u_cst_getting_started u_cst_getting_started

type variables
n_cst_getting_started inv_getting_started
u_picturebutton_started ipb_module[]
Long il_width_org = 667,il_height_org = 584
end variables

forward prototypes
public function integer of_set_pos (integer ai_cols)
public subroutine of_set_picture ()
public subroutine of_set_height ()
end prototypes

event ue_set_height();This.height = ipb_module[UpperBound(ipb_module[])].y - ipb_module[1].y + 24 + ipb_module[UpperBound(ipb_module[])].height + 24
Return
end event

public function integer of_set_pos (integer ai_cols);integer i,row = 1,col = 1
Long ll_spacew = 24,ll_spaceh = 24,ll_scrollbar_space = 80
Long ll_width,ll_height

//Get width
//ll_width = (This.width - ll_scrollbar_space - ll_spacew)/ai_cols - ll_spacew
ll_width = (This.width - ll_scrollbar_space - ll_spacew*(ai_cols + 1))/ai_cols
If ll_width > il_width_org Then
	ll_width = il_width_org
	ll_height = il_height_org
	//ll_spacew = (This.width - ll_scrollbar_space - ll_spacew)/ai_cols - ll_width
	ll_spacew = (This.width -  ll_scrollbar_space - ai_cols*ll_width)/(ai_cols + 1)
Else
	ll_height = il_height_org*(ll_width/il_width_org)
End If

For i = 1 To UpperBound(ipb_module[])
	If i <> 1 and mod(i,ai_cols) = 1 Then 
		row++
		col = 1
	End If
	ipb_module[i].Move(ll_spacew*col + (col - 1)*ll_width  + st_ref.x, ll_spaceh*row + (row - 1)*ll_height + st_ref.y)
	ipb_module[i].Resize(ll_width,ll_height)
	
	If ipb_module[i].tag = '1' or ipb_module[i].tag = '1,0' or ipb_module[i].tag = '1,1' Then //Add new contract
		If w_mdi.of_security_access( 6955 ) = 0 Then
			//Added By Ken.Guo 2010-12-03.
			cbx_use_template.checked = False
			cbx_use_template.visible = False
			ipb_module[i].tag = '1,0'
		Else
			cbx_use_template.move(ipb_module[i].x + 50, ipb_module[i].y + ipb_module[i].height - cbx_use_template.height - 20 )
			cbx_use_template.width = ipb_module[i].width - 60
			cbx_use_template.visible = True
			cbx_use_template.tag = String(i)
			If Not ipb_module[i].enabled Then cbx_use_template.enabled = False
			cbx_use_template.Event clicked()
			
			//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
			If w_mdi.of_security_access( 6988 ) = 0 Then //New CTX //Added By Ken.Guo 08/28/2013 only template
				cbx_use_template.checked = True
				cbx_use_template.visible = True
				cbx_use_template.enabled = False
				ipb_module[i].tag = '1,1'
			End If
			//---------End Added ------------------------------------------------------
		End If
	End If

	col++
Next

//of_set_height()
this.event ue_set_height( )

Return 1
end function

public subroutine of_set_picture ();inv_getting_started.of_set_picture(ipb_module[])
inv_getting_started.of_set_access(ipb_module[])
end subroutine

public subroutine of_set_height ();This.height = ipb_module[UpperBound(ipb_module[])].y - ipb_module[1].y + 24 + ipb_module[UpperBound(ipb_module[])].height + 24
Return
end subroutine

on u_cst_getting_started.create
this.cbx_use_template=create cbx_use_template
this.st_ref=create st_ref
this.pb_10=create pb_10
this.pb_9=create pb_9
this.pb_8=create pb_8
this.pb_7=create pb_7
this.pb_6=create pb_6
this.pb_5=create pb_5
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.Control[]={this.cbx_use_template,&
this.st_ref,&
this.pb_10,&
this.pb_9,&
this.pb_8,&
this.pb_7,&
this.pb_6,&
this.pb_5,&
this.pb_4,&
this.pb_3,&
this.pb_2,&
this.pb_1}
end on

on u_cst_getting_started.destroy
destroy(this.cbx_use_template)
destroy(this.st_ref)
destroy(this.pb_10)
destroy(this.pb_9)
destroy(this.pb_8)
destroy(this.pb_7)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
end on

event constructor;ipb_module[] = {pb_1, pb_2,pb_3, pb_4,pb_5, pb_6,pb_7, pb_8,pb_9, pb_10}

end event

type cbx_use_template from checkbox within u_cst_getting_started
boolean visible = false
integer x = 59
integer y = 1096
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Use Template"
end type

event clicked;Integer li_index
li_index = Integer(cbx_use_template.tag)
If Integer(cbx_use_template.tag) > 0 Then
	If This.Checked Then
		ipb_module[li_index].tag = '1,1'
	Else
		ipb_module[li_index].tag = '1,0'
	End If
End If

end event

type st_ref from statictext within u_cst_getting_started
boolean visible = false
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type pb_10 from u_picturebutton_started within u_cst_getting_started
integer x = 795
integer y = 616
integer width = 667
integer height = 584
integer taborder = 10
end type

type pb_9 from u_picturebutton_started within u_cst_getting_started
integer x = 741
integer y = 524
integer width = 667
integer height = 584
integer taborder = 10
end type

type pb_8 from u_picturebutton_started within u_cst_getting_started
integer x = 654
integer y = 452
integer width = 667
integer height = 584
integer taborder = 10
end type

type pb_7 from u_picturebutton_started within u_cst_getting_started
integer x = 526
integer y = 380
integer width = 667
integer height = 584
integer taborder = 10
end type

type pb_6 from u_picturebutton_started within u_cst_getting_started
integer x = 407
integer y = 292
integer width = 667
integer height = 584
integer taborder = 10
end type

type pb_5 from u_picturebutton_started within u_cst_getting_started
integer x = 334
integer y = 212
integer width = 667
integer height = 584
integer taborder = 10
end type

type pb_4 from u_picturebutton_started within u_cst_getting_started
integer x = 274
integer y = 164
integer width = 667
integer height = 584
integer taborder = 10
end type

type pb_3 from u_picturebutton_started within u_cst_getting_started
integer x = 165
integer y = 112
integer width = 667
integer height = 584
integer taborder = 10
end type

type pb_2 from u_picturebutton_started within u_cst_getting_started
integer x = 82
integer y = 56
integer width = 667
integer height = 584
integer taborder = 10
end type

type pb_1 from u_picturebutton_started within u_cst_getting_started
integer x = 14
integer y = 12
integer width = 667
integer height = 584
integer taborder = 10
end type

