$PBExportHeader$w_get_new_checklist.srw
forward
global type w_get_new_checklist from window
end type
type cb_ok from commandbutton within w_get_new_checklist
end type
type cb_close from commandbutton within w_get_new_checklist
end type
type dw_1 from datawindow within w_get_new_checklist
end type
end forward

global type w_get_new_checklist from window
integer width = 2523
integer height = 416
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_ok cb_ok
cb_close cb_close
dw_1 dw_1
end type
global w_get_new_checklist w_get_new_checklist

type variables
long il_temp = 0
string is_name_org
end variables

on w_get_new_checklist.create
this.cb_ok=create cb_ok
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={this.cb_ok,&
this.cb_close,&
this.dw_1}
end on

on w_get_new_checklist.destroy
destroy(this.cb_ok)
destroy(this.cb_close)
destroy(this.dw_1)
end on

event open;long ll_id
string ls_mes

//Start Code Change ----06.20.2016 #V152 maha - rewrote; rename now done in properties
//new message for App recruitment
//ll_id = message.doubleparm 

//if ll_id > 0 then
//	dw_1.retrieve(ll_id)
//	if dw_1.rowcount() > 0 then
//		is_name_org = dw_1.getitemstring(1,"template_name")
//	end if
//else
//	dw_1.insertrow(1)
//	is_name_org = "NEW"
//end if

ls_mes = message.stringparm

dw_1.insertrow(1)
is_name_org = "NEW"

if ls_mes = "R" then
	dw_1.setitem(1, "temp_type",  2)
	dw_1.modify( "temp_type.protect = 1")
else
	dw_1.setitem(1, "temp_type",  1)
end if
end event

type cb_ok from commandbutton within w_get_new_checklist
integer x = 850
integer y = 240
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;String ls_retval
string ls_name
long li_id

dw_1.accepttext()
ls_retval =dw_1.getitemstring(1,"template_name")
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Frank.Gui
//$<reason> 
IF ls_retval='' THEN
	messagebox('Alert','Please enter a template name.')
	return
END IF
//---------------------------- APPEON END ----------------------------

if ls_retval = is_name_org then
	closewithreturn(parent,"Cancel")
else
	select template_name 
	into :ls_name
	from data_view_app_audit_template
	where template_name = :ls_retval;
end if

if LenA (ls_name) > 0 THEN 
	MESSAGEBOX(PARENT.TITLE, 'A template with this name currently exists. Please add a new one.')
	return
else
	if is_name_org = "NEW" then
		select max(template_id) into :li_id from data_view_app_audit_template;
		if isnull(li_id) then li_id = 0
		li_id++
		dw_1.setitem(1,"template_id", li_id)
	else
		li_id = il_temp
	end if
	dw_1.update()
	CloseWithReturn(Parent,li_id )
END IF

end event

type cb_close from commandbutton within w_get_new_checklist
integer x = 1211
integer y = 240
integer width = 343
integer height = 92
integer taborder = 20
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

type dw_1 from datawindow within w_get_new_checklist
integer x = 32
integer y = 72
integer width = 2354
integer height = 104
integer taborder = 10
string title = "none"
string dataobject = "d_checklist_template_detail"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

