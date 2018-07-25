$PBExportHeader$w_invisiblefieldlist_rpt.srw
$PBExportComments$(Appeon)Toney 06.11.2013 - V141 ISG-CLX
forward
global type w_invisiblefieldlist_rpt from w_response
end type
type cb_select from commandbutton within w_invisiblefieldlist_rpt
end type
type cb_cancel from commandbutton within w_invisiblefieldlist_rpt
end type
type cb_ok from commandbutton within w_invisiblefieldlist_rpt
end type
type dw_fieldlist from u_dw within w_invisiblefieldlist_rpt
end type
end forward

global type w_invisiblefieldlist_rpt from w_response
integer width = 2437
integer height = 1412
string title = "Add Field"
long backcolor = 33551856
cb_select cb_select
cb_cancel cb_cancel
cb_ok cb_ok
dw_fieldlist dw_fieldlist
end type
global w_invisiblefieldlist_rpt w_invisiblefieldlist_rpt

type variables
String			is_FieldList

Boolean			ib_Select = true

u_cst_dw_design inv_data_design

CONSTANT STRING TABCHAR = "~t"
CONSTANT STRING ENTERCHAR = "~r~n"

end variables

on w_invisiblefieldlist_rpt.create
int iCurrent
call super::create
this.cb_select=create cb_select
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_fieldlist=create dw_fieldlist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_select
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.dw_fieldlist
end on

on w_invisiblefieldlist_rpt.destroy
call super::destroy
destroy(this.cb_select)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_fieldlist)
end on

event open;call super::open;String	ls_FieldList,ls_FieldName,ls_FieldLabel
long		ll_EnterPos,ll_Row

Inv_Data_Design = Message.PowerObjectParm

ls_FieldList = Inv_Data_Design.of_Get_InVisible_Field()
if RightA(ls_FieldList,LenA(ENTERCHAR)) <> ENTERCHAR then ls_FieldList += ENTERCHAR

do 
	ll_EnterPos  = PosA(ls_FieldList,ENTERCHAR)
	ls_FieldName = Trim(LeftA(ls_FieldList,ll_EnterPos - 1))
	ls_FieldList = Trim(MidA(ls_FieldList,ll_EnterPos + LenA(ENTERCHAR)))
	
	if ls_FieldName <> "" then
		ls_FieldLabel = Inv_Data_Design.uo_band.dw_Syntax.Describe(ls_FieldName + "_t.Text")
		if IsNull(ls_FieldLabel) or Trim(ls_FieldLabel) = "" or ls_FieldLabel = "!" or ls_FieldLabel = "?" then 
			ls_FieldLabel = ls_FieldName
		end if
		
		ll_Row = dw_FieldList.InsertRow(0)
		dw_FieldList.SetItem(ll_Row,"FieldName",ls_FieldName)
		dw_FieldList.SetItem(ll_Row,"FieldLabel",ls_FieldLabel)
	end if
loop while ll_EnterPos > 0 and Trim(ls_FieldList) <> ""

dw_FieldList.SetSort("Lower(FieldLabel) Asc")
dw_FieldList.Sort()

end event

type cb_select from commandbutton within w_invisiblefieldlist_rpt
integer x = 2002
integer y = 268
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;long	ll_Cycle,ll_RowCnts

ll_RowCnts = dw_FieldList.RowCount()
for ll_Cycle = 1 to ll_RowCnts
	dw_FieldList.SelectRow(ll_Cycle,ib_Select)
next

ib_Select = Not ib_Select

if ib_Select then
	This.Text = "Select All"
else
	This.Text = "Unselect All"
end if

end event

type cb_cancel from commandbutton within w_invisiblefieldlist_rpt
integer x = 2002
integer y = 144
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
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,"")

end event

type cb_ok from commandbutton within w_invisiblefieldlist_rpt
integer x = 2002
integer y = 20
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
boolean default = true
end type

event clicked;long		ll_SelRow
String	ls_FieldName

ll_SelRow = dw_FieldList.GetSelectedRow(0)
do while ll_SelRow > 0
	ls_FieldName = dw_FieldList.GetItemString(ll_SelRow,"FieldName")
	is_FieldList += ls_FieldName + ENTERCHAR
	ll_SelRow = dw_FieldList.GetSelectedRow(ll_SelRow)
loop

CloseWithReturn(Parent,is_FieldList)

end event

type dw_fieldlist from u_dw within w_invisiblefieldlist_rpt
integer x = 32
integer y = 84
integer width = 1920
integer height = 1212
integer taborder = 40
string dataobject = "d_screen_field_list"
boolean hscrollbar = true
end type

event clicked;call super::clicked;if Row > 0 and Row <= This.RowCount() then
	This.SelectRow(Row,Not This.IsSelected(Row))
end if

end event

event doubleclicked;call super::doubleclicked;This.Trigger Event Clicked(XPos,YPos,Row,Dwo)

end event

event constructor;call super::constructor;This.of_SetUpdateAble(false)

of_SetSort(True)
inv_Sort.of_SetColumnHeader(True)

if AppeonGetClientType() = "WEB" then This.Height = This.Height + 6

end event

