$PBExportHeader$w_other_verification_select.srw
forward
global type w_other_verification_select from window
end type
type dw_select from datawindow within w_other_verification_select
end type
type cb_cancel from commandbutton within w_other_verification_select
end type
type cb_1 from commandbutton within w_other_verification_select
end type
end forward

global type w_other_verification_select from window
integer width = 3031
integer height = 2324
boolean titlebar = true
string title = "Select Verification types"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
event ue_syscommand pbm_syscommand
dw_select dw_select
cb_cancel cb_cancel
cb_1 cb_1
end type
global w_other_verification_select w_other_verification_select

type variables
long il_temp_id
long il_quest[]
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
gs_pass_ids lst_ids
debugbreak()
ic =  dw_select.rowcount()
if ic < 1 then
	messagebox("Select","No records to select.  Add in Lookup Lists for Verification Entity")
	return -1
else
	for i = 1 to ic
		if dw_select.getitemnumber(i,"selected") = 1 then
			a++
			lst_ids.sl_action_type[a] = dw_select.getitemnumber(i,"lookup_code")
			lst_ids.l_ids[a] = dw_select.getitemnumber(i,"verif_method")
		end if
	next
	if a < 1 then
		messagebox("Select","No Records selected. Select questions you wish to add.")	
		return -1
	end if
	
	closewithreturn( w_other_verification_select, lst_ids)
end if


return 1
end function

on w_other_verification_select.create
this.dw_select=create dw_select
this.cb_cancel=create cb_cancel
this.cb_1=create cb_1
this.Control[]={this.dw_select,&
this.cb_cancel,&
this.cb_1}
end on

on w_other_verification_select.destroy
destroy(this.dw_select)
destroy(this.cb_cancel)
destroy(this.cb_1)
end on

event open;DataWindowChild dwchild
integer s
integer q


dw_select.settransobject(sqlca)
dw_select.getchild( "entity_name", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve("Verification Entity")
s = dw_select.retrieve()


end event

type dw_select from datawindow within w_other_verification_select
integer x = 5
integer y = 132
integer width = 3008
integer height = 2104
integer taborder = 50
string title = "none"
string dataobject = "d_other_verif_select"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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

type cb_cancel from commandbutton within w_other_verification_select
integer x = 2587
integer y = 36
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

event clicked;closewithreturn(parent,"Cancel")

end event

type cb_1 from commandbutton within w_other_verification_select
integer x = 2002
integer y = 36
integer width = 567
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Selected Records"
end type

event clicked;integer i
integer res
string ls_quest
gs_variable_array ls_struct



res = of_checkrows(1)

//
//if res = -1 then
//	return
//else
//	ls_struct.as_number = il_quest[]
//	if cbx_no.checked  then  //Start Code Change ----06.17.2009 #V92 maha - added to allow users to set no answers in batch
//		ls_struct.as_string[1] = "NO"
//	else
//		ls_struct.as_string[1] = "Yes"
//	end if
//	closewithreturn(w_question_select,ls_struct)
//end if
end event

