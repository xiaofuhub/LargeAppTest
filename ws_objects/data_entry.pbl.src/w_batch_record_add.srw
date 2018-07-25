$PBExportHeader$w_batch_record_add.srw
forward
global type w_batch_record_add from window
end type
type dw_items from datawindow within w_batch_record_add
end type
type st_1 from statictext within w_batch_record_add
end type
type dw_record from datawindow within w_batch_record_add
end type
type st_2 from statictext within w_batch_record_add
end type
type dw_select from datawindow within w_batch_record_add
end type
type cb_cancel from commandbutton within w_batch_record_add
end type
type cb_1 from commandbutton within w_batch_record_add
end type
end forward

global type w_batch_record_add from window
integer width = 2341
integer height = 2488
boolean titlebar = true
string title = "Select Record Types"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
event ue_syscommand pbm_syscommand
dw_items dw_items
st_1 st_1
dw_record dw_record
st_2 st_2
dw_select dw_select
cb_cancel cb_cancel
cb_1 cb_1
end type
global w_batch_record_add w_batch_record_add

type variables
long il_temp_id
long il_rec[]

end variables

forward prototypes
public function integer of_checkrows (integer ai_tab)
end prototypes

event ue_syscommand;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06/17/2008 By: Ken.Guo
//$<reason> Fixed BugG061105
//$Need run cb_cancel.clicked() Event When click 'Close' button on ControlMenu.  
If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If
//---------------------------- APPEON END ----------------------------

end event

public function integer of_checkrows (integer ai_tab);long i
long ic
integer a = 0


ic =  dw_record.rowcount()
if ic < 1 then
	//messagebox("Records","No  to select.  Add in Question Painter")
	return -1
else
	for i = 1 to ic
		if dw_record.getitemnumber(i,"selected") = 1 then
			a++
			il_rec[a] = dw_record.getitemnumber(i,"lookup_code")
		end if
	next
	if upperbound(il_rec) < 1 then
		messagebox("Record Types","No record Types selected. Select the Types you wish to add.")	
		return -1
	end if
end if


return 1
end function

on w_batch_record_add.create
this.dw_items=create dw_items
this.st_1=create st_1
this.dw_record=create dw_record
this.st_2=create st_2
this.dw_select=create dw_select
this.cb_cancel=create cb_cancel
this.cb_1=create cb_1
this.Control[]={this.dw_items,&
this.st_1,&
this.dw_record,&
this.st_2,&
this.dw_select,&
this.cb_cancel,&
this.cb_1}
end on

on w_batch_record_add.destroy
destroy(this.dw_items)
destroy(this.st_1)
destroy(this.dw_record)
destroy(this.st_2)
destroy(this.dw_select)
destroy(this.cb_cancel)
destroy(this.cb_1)
end on

event open;//Start Code Change ----11.28.2012 #V12 maha - created for adding multiple records at one time.
//called from pfc_cst_u_data_entry.dw_detail.pfc_addrow

DataWindowChild dwchild
integer s
integer q
integer t
integer li_temp
string ls_type
string ls_table
string ls_field


//table@field
ls_type = message.stringparm
ls_table = mid(ls_type, 1,pos(ls_type,"@") - 1)
ls_field = mid(ls_type, pos(ls_type,"@") + 1)
ls_type = gnv_data.of_getitem("sys_fields", "lookup_code", "field_id = " + ls_field)


//setup templates
dw_select.settransobject(sqlca)
dw_select.retrieve(0)
dw_select.GetChild( "temp_id", dwchild )
dwchild.settransobject(sqlca)
q = dwchild.retrieve(integer(ls_table))
if q = 0 then
	dw_select.visible = false
elseif q = 1 then
	li_temp = dwchild.getitemnumber(1,"temp_id")
	dw_items.settransobject(sqlca)
	t = dw_items.retrieve(li_temp)
else
	dwchild.insertrow(1)
	dwchild.setitem(1,"temp_name", "")
	dwchild.setitem(1,"temp_id", 0)
	dwchild.setrow(1)
	dwchild.scrolltorow( 1)
	dwchild.selectrow(0,false)
	dwchild.selectrow(1,true)
	dw_select.insertrow(1)
	dw_select.setitem(1,"temp_id",0)
	il_temp_id = 0
end if

//get lookup records
dw_record.settransobject(sqlca)
s = dw_record.retrieve(ls_type)

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09/18/2007 By: Ken.Guo
//$<reason> For Performance
/*
for q = 1 to s
	dw_quest.setitem(q,"selected",1)
next
*/
Long i
Int li_value[]
//For i = 1 To s
//	li_value[i] = 1
//Next
//dw_record.object.selected[1,s] = li_value[]
//---------------------------- APPEON END ----------------------------


end event

type dw_items from datawindow within w_batch_record_add
boolean visible = false
integer x = 1541
integer y = 2284
integer width = 686
integer height = 104
integer taborder = 60
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_batch_record_add
boolean visible = false
integer x = 786
integer y = 28
integer width = 462
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "No templates exist"
boolean focusrectangle = false
end type

type dw_record from datawindow within w_batch_record_add
integer y = 172
integer width = 2331
integer height = 2224
integer taborder = 50
string title = "none"
string dataobject = "d_batch_type_add_code"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;integer i


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09/18/2007 By: Ken.Guo
//$<reason> For Performance
/*
if this.object.b_1.text = "Unselect All" then 
	for i = 1 to this.rowcount()
		this.setitem(i,"selected",0)
	next
	this.object.b_1.text = "Select All"
else
	for i = 1 to this.rowcount()
		this.setitem(i,"selected",1)
	next
	this.object.b_1.text = "Unselect All"
end if
*/	
Long ll_rowcount
Integer li_value_0[],li_value_1[]
If dwo.name = 'b_1' Then
	ll_rowcount = this.rowcount( )
	For i = 1 To ll_rowcount
		li_value_0[i] = 0
		li_value_1[i] = 1	
	Next
	If This.object.b_1.text = "Unselect All" Then 
		This.object.selected[1,ll_rowcount] = li_value_0[]
		This.object.b_1.text = "Select All"
	Else
		This.object.selected[1,ll_rowcount] = li_value_1[]
		This.object.b_1.text = "Unselect All"	
	End If
End If
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09/18/2007 By: Ken.Guo
//$<reason> For b_detail button
String ls_details
If dwo.name = 'b_details' and row > 0 Then
	Openwithparm(w_detail_information,This.GetItemString(row,'full_quest'))
End If
//---------------------------- APPEON END ----------------------------

	
end event

type st_2 from statictext within w_batch_record_add
boolean visible = false
integer x = 59
integer y = 24
integer width = 832
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Template"
boolean focusrectangle = false
end type

type dw_select from datawindow within w_batch_record_add
boolean visible = false
integer x = 59
integer y = 80
integer width = 1015
integer height = 84
integer taborder = 30
string title = "none"
string dataobject = "d_quest_templates"
boolean border = false
boolean livescroll = true
end type

event itemchanged;integer i


il_temp_id = long(data)

//if il_temp_id = 0 then
//	dw_record.dataobject = "d_question_select"
//	dw_record.settransobject(sqlca)
//	dw_record.retrieve()
//else
//	dw_record.dataobject = "d_quest_temp_select"
//	dw_record.settransobject(sqlca)
//	dw_record.retrieve(il_temp_id)
//end if
//tab_1.tabpage_templates.dw_items.insertrow(1)


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09/18/2007 By: Ken.Guo
//$<reason> For Performance
/*
for i = 1 to dw_record.rowcount()
	dw_record.setitem(i,"selected",1)
next
*/
Long ll_rowcount
Integer ll_value[]
ll_rowcount = dw_record.Rowcount()
For i = 1 To ll_rowcount
	ll_value[i] = 1
Next

//------------ APPEON BEGIN ------------
//$<modify> 07.24.2009 By: Evan
//$<reason> Trap datawindow row count
//dw_record.object.selected[1,ll_rowcount] = ll_value[]
if ll_RowCount > 0 then
	dw_record.object.selected[1,ll_rowcount] = ll_value[]
end if
//------------ APPEON BEGIN ------------

//---------------------------- APPEON END ----------------------------


//dw_record.object.b_1.text = "Unselect All"
end event

type cb_cancel from commandbutton within w_batch_record_add
integer x = 1883
integer y = 68
integer width = 343
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn( parent,"Cancel")

end event

type cb_1 from commandbutton within w_batch_record_add
integer x = 1298
integer y = 68
integer width = 567
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Selected records"
end type

event clicked;integer i
integer res
string ls_quest
gs_variable_array ls_struct



res = of_checkrows(1)


if res = -1 then
	return
else
	ls_struct.as_number = il_rec[]
	closewithreturn(parent ,ls_struct)
end if
end event

