$PBExportHeader$w_app_select.srw
forward
global type w_app_select from w_response
end type
type cb_3 from commandbutton within w_app_select
end type
type cb_2 from commandbutton within w_app_select
end type
type cb_1 from commandbutton within w_app_select
end type
type dw_1 from u_dw within w_app_select
end type
end forward

global type w_app_select from w_response
integer width = 1605
integer height = 1868
string title = "Select Application"
long backcolor = 33551856
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_app_select w_app_select

on w_app_select.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_app_select.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;//$<add> 07.14.2008 by Andy
dw_1.retrieve( )
end event

type cb_3 from commandbutton within w_app_select
integer x = 37
integer y = 1672
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &All"
end type

event clicked;Integer 	li_rc
Integer 	i
integer	li_Value

if This.Text = "Select &All" then
	li_Value = 1
	This.Text = "Deselect &All"
else
	li_Value = 0
	This.Text = "Select &All"
end if

li_rc = dw_1.RowCount( )
for I = 1 to li_rc
	dw_1.SetItem( i, "selected", li_Value )
next


end event

type cb_2 from commandbutton within w_app_select
integer x = 1211
integer y = 1672
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;Close(Parent)
end event

type cb_1 from commandbutton within w_app_select
integer x = 841
integer y = 1672
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;//$<add> 07.14.2008 by Andy
Long ll_Num=0,ll_Cnt,ll_Row
Long ll_app_id
dec{0} ldec_app_image_id

if Not IsValid(w_image_type_painter) THEN return

//Get max(app_image_id)+1
SELECT max(app_image_id) INTO :ldec_app_image_id from app_image_defaults;
if IsNull(ldec_app_image_id) or ldec_app_image_id = 0 then 
	ldec_app_image_id = 1
else
	ldec_app_image_id ++
end if
		
ll_Cnt = dw_1.rowcount( )
DO WHILE (1=1)
	ll_Num = dw_1.Find("selected=1",ll_Num,ll_Cnt)
	if ll_Num < 1 then EXIT
	
	ll_app_id = dw_1.GetItemNumber(ll_Num,"app_id")
	ll_Row = w_image_type_painter.dw_image_defaults.InsertRow(0)
	w_image_type_painter.dw_image_defaults.SetItem(ll_Row,"app_image_id",ldec_app_image_id)
	w_image_type_painter.dw_image_defaults.SetItem(ll_Row,"app_id",ll_app_id)
	w_image_type_painter.dw_image_defaults.SetItem(ll_Row,"image_type",w_image_type_painter.il_new_image_type)
	ldec_app_image_id ++
	
	ll_Num ++
	if ll_Num > ll_Cnt then EXIT
LOOP

Close(Parent)


end event

type dw_1 from u_dw within w_app_select
integer x = 37
integer y = 28
integer width = 1518
integer height = 1624
integer taborder = 10
string dataobject = "d_app_select"
boolean livescroll = false
end type

event constructor;call super::constructor;this.of_setupdateable( false)
end event

