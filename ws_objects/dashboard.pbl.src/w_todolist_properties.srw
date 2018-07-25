$PBExportHeader$w_todolist_properties.srw
$PBExportComments$Edit window of To Do List Painter
forward
global type w_todolist_properties from w_response
end type
type cb_cancel from commandbutton within w_todolist_properties
end type
type cb_ok from commandbutton within w_todolist_properties
end type
type dw_dashboard from datawindow within w_todolist_properties
end type
end forward

global type w_todolist_properties from w_response
integer width = 2350
integer height = 1100
string title = "To Do List Properties "
boolean controlmenu = false
long backcolor = 33551856
boolean ib_isupdateable = false
cb_cancel cb_cancel
cb_ok cb_ok
dw_dashboard dw_dashboard
end type
global w_todolist_properties w_todolist_properties

type variables
String is_edit_type	//Add Copy Edit

String is_FileName	//include the path
end variables

on w_todolist_properties.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_dashboard=create dw_dashboard
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_dashboard
end on

on w_todolist_properties.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_dashboard)
end on

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-28 By: Allen
//$<reason> Prepare data
String ls_TDL_id
dw_dashboard.SetTransObject(Sqlca)

is_edit_type = Message.StringParm
ls_TDL_id = MidA(is_edit_type, PosA(is_edit_type, ":") + 1)
IF LeftA(is_edit_type, 3) = "Add" THEN
	dw_dashboard.InsertRow(0)
	IF ls_TDL_id <> "00" THEN
		dw_dashboard.SetItem(1, "module", ls_TDL_id)
	END IF
ELSEIF LeftA(is_edit_type, 4) = "Copy" THEN
	dw_dashboard.InsertRow(0)
	
	String ls_Module, ls_Notes
	SELECT Module, Notes
	INTO :ls_Module, :ls_Notes
	FROM TDL_Basic_info
	WHERE TDL_id = :ls_TDL_id;
	dw_dashboard.SetItem(1, "Module", ls_Module)
	dw_dashboard.SetItem(1, "Notes", ls_Notes)
	
	dw_dashboard.Modify("Module.Protect=1")
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Add> 2007-08-21 By: Evan
	//$<Reason> Set disabled color.	
	dw_dashboard.Modify("Module.BackGround.Color = 67108864")
	//--------------------------- APPEON BEGIN ---------------------------
ELSE
	dw_dashboard.Retrieve(Long(ls_TDL_id))
	dw_dashboard.Modify("Module.Protect = 1")
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Add> 2007-08-21 By: Evan
	//$<Reason> Set disabled color.
	dw_dashboard.Modify("Module.BackGround.Color = 67108864")
	//--------------------------- APPEON BEGIN ---------------------------
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 2007-08-21 By: Evan
//$<Reason> Focus locate.
if dw_dashboard.RowCount() > 0 then
	if LenA(dw_dashboard.GetItemString(1, "module")) > 0 then
		dw_dashboard.SetColumn("tdl_name")
		dw_dashboard.SetFocus()
	end if
end if
//---------------------------- APPEON END ----------------------------

//Filter Module
n_cst_tdl_function ln_cst_tdl_function
ln_cst_tdl_function.of_filter_module(dw_dashboard)

this.Title += "("+ MidA(is_edit_type, 1, PosA(is_edit_type, ":") - 1) + ")"
//---------------------------- APPEON END ----------------------------
end event

type cb_cancel from commandbutton within w_todolist_properties
integer x = 1966
integer y = 880
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

event clicked;CloseWithReturn(Parent, "Cancel")
end event

type cb_ok from commandbutton within w_todolist_properties
integer x = 1600
integer y = 880
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

event clicked;Long rtn, ll_Max_ID, ll_TDL_ID
String ls_err
String ls_TDL_name, ls_Module

IF dw_dashboard.ModifiedCount() < 1 THEN 
	cb_cancel.event clicked()//Added by Frank, 2007-08-13. If no change is made, close window.
	RETURN
END IF

ll_TDL_ID = Long(MidA(is_edit_type, PosA(is_edit_type, ":") + 1))
ls_TDL_name = dw_dashboard.GetItemString(1, "TDL_name")
ls_Module = dw_dashboard.GetItemString(1, "Module")

IF IsNull(ls_TDL_name) OR ls_TDL_name = "" THEN
	MessageBox(gnv_app.iapp_object.DisplayName, "Input a To Do List name, please")
	dw_dashboard.SetColumn("TDL_name")
	dw_dashboard.SetFocus()
	RETURN -1
END IF

IF IsNull(ls_Module) OR ls_Module = "" THEN
	MessageBox(gnv_app.iapp_object.DisplayName, "Choose a module, please")
	dw_dashboard.SetColumn("Module")
	dw_dashboard.SetFocus()
	RETURN -1
END IF

//Set max ID
IF LeftA(is_edit_type, 4) <> "Edit" THEN
	Select IsNull(Max(TDL_id)+1, 1) INTO :ll_Max_ID FROM TDL_basic_info;
	dw_dashboard.SetItem(dw_dashboard.GetRow(), "TDL_id", ll_Max_ID)
END IF

rtn = dw_dashboard.Update()
IF Sqlca.SqlCode = 0 THEN
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
END IF

IF ll_Max_ID = 0 THEN ll_Max_ID = ll_TDL_ID
CloseWithReturn(Parent, ll_Max_ID)
end event

type dw_dashboard from datawindow within w_todolist_properties
integer x = 41
integer y = 28
integer width = 2258
integer height = 812
integer taborder = 10
string title = "none"
string dataobject = "d_dashboard"
boolean livescroll = true
end type

event losefocus;this.AcceptText( )
end event

