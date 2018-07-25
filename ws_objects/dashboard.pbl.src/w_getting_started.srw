$PBExportHeader$w_getting_started.srw
forward
global type w_getting_started from w_popup
end type
type cb_view from commandbutton within w_getting_started
end type
type st_tips from statictext within w_getting_started
end type
type cbx_use_template from checkbox within w_getting_started
end type
type pb_2 from u_picturebutton_started within w_getting_started
end type
type pb_1 from u_picturebutton_started within w_getting_started
end type
type pb_10 from u_picturebutton_started within w_getting_started
end type
type pb_9 from u_picturebutton_started within w_getting_started
end type
type pb_8 from u_picturebutton_started within w_getting_started
end type
type pb_7 from u_picturebutton_started within w_getting_started
end type
type pb_6 from u_picturebutton_started within w_getting_started
end type
type pb_5 from u_picturebutton_started within w_getting_started
end type
type pb_4 from u_picturebutton_started within w_getting_started
end type
type pb_3 from u_picturebutton_started within w_getting_started
end type
type cbx_start from checkbox within w_getting_started
end type
type st_back from statictext within w_getting_started
end type
type p_backgroup from picture within w_getting_started
end type
end forward

global type w_getting_started from w_popup
integer width = 3671
integer height = 1988
string title = "IntelliContract Getting Started"
boolean maxbox = false
boolean resizable = false
boolean center = true
event ue_mousemove ( u_picturebutton_started lpb_module )
cb_view cb_view
st_tips st_tips
cbx_use_template cbx_use_template
pb_2 pb_2
pb_1 pb_1
pb_10 pb_10
pb_9 pb_9
pb_8 pb_8
pb_7 pb_7
pb_6 pb_6
pb_5 pb_5
pb_4 pb_4
pb_3 pb_3
cbx_start cbx_start
st_back st_back
p_backgroup p_backgroup
end type
global w_getting_started w_getting_started

type variables
n_cst_getting_started inv_getting_started
Integer ii_getting_started
Picturebutton ipb_module[]
end variables

event ue_mousemove(u_picturebutton_started lpb_module);st_back.move(lpb_module.x - 12,lpb_module.y - 12)
st_back.resize(lpb_module.width + 24,lpb_module.height + 20  )

st_tips.text = inv_getting_started.of_get_tips(lpb_module.tag)
end event

on w_getting_started.create
int iCurrent
call super::create
this.cb_view=create cb_view
this.st_tips=create st_tips
this.cbx_use_template=create cbx_use_template
this.pb_2=create pb_2
this.pb_1=create pb_1
this.pb_10=create pb_10
this.pb_9=create pb_9
this.pb_8=create pb_8
this.pb_7=create pb_7
this.pb_6=create pb_6
this.pb_5=create pb_5
this.pb_4=create pb_4
this.pb_3=create pb_3
this.cbx_start=create cbx_start
this.st_back=create st_back
this.p_backgroup=create p_backgroup
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_view
this.Control[iCurrent+2]=this.st_tips
this.Control[iCurrent+3]=this.cbx_use_template
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.pb_10
this.Control[iCurrent+7]=this.pb_9
this.Control[iCurrent+8]=this.pb_8
this.Control[iCurrent+9]=this.pb_7
this.Control[iCurrent+10]=this.pb_6
this.Control[iCurrent+11]=this.pb_5
this.Control[iCurrent+12]=this.pb_4
this.Control[iCurrent+13]=this.pb_3
this.Control[iCurrent+14]=this.cbx_start
this.Control[iCurrent+15]=this.st_back
this.Control[iCurrent+16]=this.p_backgroup
end on

on w_getting_started.destroy
call super::destroy
destroy(this.cb_view)
destroy(this.st_tips)
destroy(this.cbx_use_template)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.pb_10)
destroy(this.pb_9)
destroy(this.pb_8)
destroy(this.pb_7)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.cbx_start)
destroy(this.st_back)
destroy(this.p_backgroup)
end on

event open;call super::open;Integer i

//Start Code Change ----07.24.2014 #V14.2 maha - changed backcolor to match the modified picture
cbx_start.backcolor = RGB(41 ,38, 109)
st_tips.backcolor = RGB(41 ,38, 109)
//cbx_start.backcolor = RGB(43,51,162)
//st_tips.backcolor = RGB(43,51,162)
//End Code Change ----07.24.2014

ipb_module[] = {pb_1,pb_2,pb_3,pb_4,pb_5,pb_6,pb_7,pb_8,pb_9,pb_10}

inv_getting_started.of_set_picture(ipb_module[])
inv_getting_started.of_set_access(ipb_module[])

For i = 1 to UpperBound(ipb_module[])
	If ipb_module[i].tag = '1' or ipb_module[i].tag = '1,0' or ipb_module[i].tag = '1,1' Then
		cbx_use_template.move(ipb_module[i].x + 50, ipb_module[i].y + ipb_module[i].height - cbx_use_template.height - 20 )
		cbx_use_template.visible = True
		cbx_use_template.tag = String(i)
		If Not ipb_module[i].enabled Then cbx_use_template.enabled = False

		//Added By Ken.Guo 2010-12-03.
		If w_mdi.of_security_access( 6955 ) = 0 Then
			cbx_use_template.checked = False
			cbx_use_template.visible = False
			ipb_module[i].tag = '1,0'
		//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
		ElseIf w_mdi.of_security_access( 6988 ) = 0 Then //New CTX //Added By Ken.Guo 08/28/2013 only template
			cbx_use_template.checked = True
			cbx_use_template.visible = True
			cbx_use_template.enabled = False
			ipb_module[i].tag = '1,1'
		//---------End Added ------------------------------------------------------
		End If
		
		Exit
	End If
Next

Select getting_started into :ii_getting_started From security_users where user_id = :gs_user_id;

If isnull(ii_getting_started) or ii_getting_started = 0 Then
	cbx_start.checked = True
Else
	cbx_start.checked = False
End If




end event

event close;call super::close;Integer li_getting_started

If cbx_start.checked Then
	li_getting_started = 0
Else
	li_getting_started = 1
End If

If isnull(ii_getting_started) or (ii_getting_started <> li_getting_started) Then
	Update security_users Set getting_started = :li_getting_started where user_id = :gs_user_id;
End If


end event

type cb_view from commandbutton within w_getting_started
boolean visible = false
integer x = 2510
integer y = 1880
integer width = 352
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Tutorials"
end type

event clicked;If isvalid(m_pfe_cst_master_menu) Then
	m_pfe_cst_master_menu.m_help.m_viewlets.event clicked()
End If
end event

type st_tips from statictext within w_getting_started
integer x = 133
integer y = 1768
integer width = 2409
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 8388608
boolean focusrectangle = false
end type

type cbx_use_template from checkbox within w_getting_started
boolean visible = false
integer x = 197
integer y = 1000
integer width = 457
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

type pb_2 from u_picturebutton_started within w_getting_started
integer x = 814
integer y = 504
integer width = 667
integer height = 584
integer taborder = 30
end type

type pb_1 from u_picturebutton_started within w_getting_started
integer x = 123
integer y = 504
integer width = 667
integer height = 584
integer taborder = 10
end type

type pb_10 from u_picturebutton_started within w_getting_started
integer x = 2885
integer y = 1108
integer width = 667
integer height = 584
integer taborder = 20
end type

type pb_9 from u_picturebutton_started within w_getting_started
integer x = 2194
integer y = 1108
integer width = 667
integer height = 584
integer taborder = 20
end type

type pb_8 from u_picturebutton_started within w_getting_started
integer x = 1504
integer y = 1108
integer width = 667
integer height = 584
integer taborder = 20
end type

type pb_7 from u_picturebutton_started within w_getting_started
integer x = 814
integer y = 1108
integer width = 667
integer height = 584
integer taborder = 20
end type

type pb_6 from u_picturebutton_started within w_getting_started
integer x = 123
integer y = 1108
integer width = 667
integer height = 584
integer taborder = 20
end type

type pb_5 from u_picturebutton_started within w_getting_started
integer x = 2885
integer y = 504
integer width = 667
integer height = 584
integer taborder = 20
end type

type pb_4 from u_picturebutton_started within w_getting_started
integer x = 2194
integer y = 504
integer width = 667
integer height = 584
integer taborder = 20
end type

type pb_3 from u_picturebutton_started within w_getting_started
integer x = 1504
integer y = 504
integer width = 667
integer height = 584
integer taborder = 20
end type

type cbx_start from checkbox within w_getting_started
integer x = 2935
integer y = 1768
integer width = 617
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 8388608
string text = "Don~'t Show At Startup"
boolean checked = true
end type

type st_back from statictext within w_getting_started
integer x = 4000
integer y = 488
integer width = 699
integer height = 612
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32768
boolean border = true
long bordercolor = 32768
boolean focusrectangle = false
end type

type p_backgroup from picture within w_getting_started
event mousemove pbm_mousemove
integer width = 3666
integer height = 2008
string picturename = "background.jpg"
boolean focusrectangle = false
end type

