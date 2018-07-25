$PBExportHeader$w_peer_reference_edit.srw
forward
global type w_peer_reference_edit from window
end type
type dw_edit from u_dw within w_peer_reference_edit
end type
type cb_cancel from commandbutton within w_peer_reference_edit
end type
type cb_save from commandbutton within w_peer_reference_edit
end type
end forward

global type w_peer_reference_edit from window
integer x = 553
integer y = 388
integer width = 2322
integer height = 1324
boolean titlebar = true
string title = "Edit Peer"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
dw_edit dw_edit
cb_cancel cb_cancel
cb_save cb_save
end type
global w_peer_reference_edit w_peer_reference_edit

type variables
DataWindow idw_data
end variables

forward prototypes
public function integer of_dataexchange (boolean ab_flag)
public function integer of_filldddw ()
public function boolean of_datachanged ()
public function integer of_promptsave ()
public function integer of_save ()
end prototypes

public function integer of_dataexchange (boolean ab_flag);//////////////////////////////////////////////////////////////////////
// $<event>of_dataexchange
// $<arguments>
// $<returns> integer
// $<description> Exchanges data between dw_search and dw_edit
//////////////////////////////////////////////////////////////////////
// $<add> 03.09.2009 by Evan
//////////////////////////////////////////////////////////////////////

long ll_Row

if ab_Flag then	
	ll_Row = idw_data.GetRow()
	if ll_Row <= 0 then Return -1
	dw_edit.InsertRow(0)
	dw_edit.object.id[1] = idw_data.object.id[ll_Row]
	dw_edit.object.title[1] = idw_data.object.title[ll_Row]
	dw_edit.object.first_middle_name[1] = idw_data.object.first_middle_name[ll_Row]
	dw_edit.object.last_name[1] = idw_data.object.last_name[ll_Row]
	dw_edit.object.name_suffix[1] = idw_data.object.name_suffix[ll_Row]
	dw_edit.object.prof_suffix[1] = idw_data.object.prof_suffix[ll_Row]
	dw_edit.object.street[1] = idw_data.object.street[ll_Row]
	dw_edit.object.cust_1[1] = idw_data.object.street1[ll_Row]
	dw_edit.object.cust_2[1] = idw_data.object.street2[ll_Row]
	dw_edit.object.cust_3[1] = idw_data.object.street3[ll_Row]
	dw_edit.object.cust_4[1] = idw_data.object.ext[ll_Row]
	dw_edit.object.cust_5[1] = idw_data.object.phone[ll_Row]
	dw_edit.object.city[1] = idw_data.object.city[ll_Row]
	dw_edit.object.state[1] = idw_data.object.state[ll_Row]
	dw_edit.object.zip[1] = idw_data.object.zip[ll_Row]
	dw_edit.object.country[1] = idw_data.object.country[ll_Row]
	dw_edit.object.fax[1] = idw_data.object.fax[ll_Row]
	dw_edit.object.e_mail_address[1] = idw_data.object.e_mail_address[ll_Row]
	dw_edit.ResetUpdate()
else
	if idw_data.tag = "add!" then
		ll_Row = idw_data.InsertRow(0)
		idw_data.object.peer_type[ll_Row] = 1
		idw_data.ScrollToRow(ll_Row)
	else
		ll_Row = idw_data.GetRow()
		if ll_Row <= 0 then Return -1
	end if
	dw_edit.AcceptText()
	idw_data.object.id[ll_Row] = dw_edit.object.id[1]
	idw_data.object.title[ll_Row] = dw_edit.object.title[1]
	idw_data.object.first_middle_name[ll_Row] = dw_edit.object.first_middle_name[1]
	idw_data.object.last_name[ll_Row] = dw_edit.object.last_name[1]
	idw_data.object.name_suffix[ll_Row] = dw_edit.object.name_suffix[1]
	idw_data.object.prof_suffix[ll_Row] = dw_edit.object.prof_suffix[1]
	idw_data.object.street[ll_Row] = dw_edit.object.street[1]
	idw_data.object.street1[ll_Row] = dw_edit.object.cust_1[1]
	idw_data.object.street2[ll_Row] = dw_edit.object.cust_2[1]
	idw_data.object.street3[ll_Row] = dw_edit.object.cust_3[1]
	idw_data.object.ext[ll_Row] = dw_edit.object.cust_4[1]
	idw_data.object.phone[ll_Row] = dw_edit.object.cust_5[1]
	idw_data.object.city[ll_Row] = dw_edit.object.city[1]
	idw_data.object.state[ll_Row] = dw_edit.object.state[1]
	idw_data.object.zip[ll_Row] = dw_edit.object.zip[1]
	idw_data.object.country[ll_Row] = dw_edit.object.country[1]
	idw_data.object.fax[ll_Row] = dw_edit.object.fax[1]
	idw_data.object.e_mail_address[ll_Row]	= dw_edit.object.e_mail_address[1]
	idw_data.ResetUpdate()
end if

Return 1
end function

public function integer of_filldddw ();//////////////////////////////////////////////////////////////////////
// $<function>of_filldddw
// $<arguments>
// $<returns> integer
// $<description> Fill dddw data with dw_search
//////////////////////////////////////////////////////////////////////
// $<add> 03.09.2009 by Evan
//////////////////////////////////////////////////////////////////////

DataWindowChild ldwc_child1
DataWindowChild ldwc_child2

dw_edit.GetChild("title", ldwc_child1)
ldwc_child1.Reset()
idw_data.GetChild("title", ldwc_child2)
ldwc_child2.RowsCopy(1, ldwc_child2.RowCount(), Primary!, ldwc_child1, 1, Primary!)

dw_edit.GetChild("name_suffix", ldwc_child1)
ldwc_child1.Reset()
idw_data.GetChild("name_suffix", ldwc_child2)
ldwc_child2.RowsCopy(1, ldwc_child2.RowCount(), Primary!, ldwc_child1, 1, Primary!)

dw_edit.GetChild("prof_suffix", ldwc_child1)
ldwc_child1.Reset()
idw_data.GetChild("prof_suffix", ldwc_child2)
ldwc_child2.RowsCopy(1, ldwc_child2.RowCount(), Primary!, ldwc_child1, 1, Primary!)

dw_edit.GetChild("state", ldwc_child1)
ldwc_child1.Reset()
idw_data.GetChild("state", ldwc_child2)
ldwc_child2.RowsCopy(1, ldwc_child2.RowCount(), Primary!, ldwc_child1, 1, Primary!)

dw_edit.GetChild("country", ldwc_child1)
ldwc_child1.Reset()
idw_data.GetChild("country", ldwc_child2)
ldwc_child2.RowsCopy(1, ldwc_child2.RowCount(), Primary!, ldwc_child1, 1, Primary!)

Return 1
end function

public function boolean of_datachanged ();//////////////////////////////////////////////////////////////////////
// $<function>of_datachanged
// $<arguments>
// $<returns> boolean
// $<description> Determines data if changed
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2009 by Evan
//////////////////////////////////////////////////////////////////////

dw_edit.AcceptText()

if dw_edit.ModifiedCount() > 0 then
	Return true	
else
	Return false
end if
end function

public function integer of_promptsave ();//////////////////////////////////////////////////////////////////////
// $<function>of_promptsave
// $<arguments>
// $<returns> integer
// $<description> Prompt save data if data was changed.
//////////////////////////////////////////////////////////////////////
// $<add> 05.19.2009 by Evan
//////////////////////////////////////////////////////////////////////

integer li_Result

if of_DataChanged() then
	li_Result = MessageBox("Save", "Do you want to save changes?", Question!, YesNoCancel!)
	choose case li_Result
		case 1
			if of_Save() = 1 then
				Return 0
			else
				Return 1
			end if
		case 2
			Return 0
		case 3
			Return 1
	end choose
end if

Return 0
end function

public function integer of_save ();//////////////////////////////////////////////////////////////////////
// $<event>of_save
// $<arguments>
// $<returns> integer
// $<description> Save data
//////////////////////////////////////////////////////////////////////
// $<add> 05.19.2009 by Evan
//////////////////////////////////////////////////////////////////////

// Checks data if changed
if idw_data.tag = "add!" and not of_DataChanged() then
	MessageBox("Prompt", "Please type peer information.")
	dw_edit.SetFocus()
	Return -1
end if

// Update data
if of_DataChanged() then
	if dw_edit.Update() = 1 then
		Commit;
		of_DataExchange(false)
	else
		Rollback;
		MessageBox("Error", "Failed to save data.", StopSign!)
		Return -1
	end if
end if

Return 1
end function

on w_peer_reference_edit.create
this.dw_edit=create dw_edit
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.Control[]={this.dw_edit,&
this.cb_cancel,&
this.cb_save}
end on

on w_peer_reference_edit.destroy
destroy(this.dw_edit)
destroy(this.cb_cancel)
destroy(this.cb_save)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event>open
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 03.09.2009 by Evan
//////////////////////////////////////////////////////////////////////

idw_data = Message.PowerObjectParm
of_FillDDDW()

choose case idw_data.tag
	case "add!"		
		this.Title = "Add Peer"
		dw_edit.InsertRow(0)
	case "edit!"
		this.Title = "Edit Peer"
		of_DataExchange(true)
	case else
		Close(this)
		Return
end choose
end event

event closequery;//////////////////////////////////////////////////////////////////////
// $<event>closequery
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 05.19.2009 by Evan
//////////////////////////////////////////////////////////////////////

Return of_PromptSave()
end event

type dw_edit from u_dw within w_peer_reference_edit
integer x = 14
integer y = 16
integer width = 2272
integer height = 1076
integer taborder = 20
string dataobject = "d_peer_reference_edit"
boolean vscrollbar = false
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<event>constructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2009 by Evan
//////////////////////////////////////////////////////////////////////

this.SetTransObject(SQLCA)
end event

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////
// $<event>doubleclicked
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 05.19.2009 by Evan
//////////////////////////////////////////////////////////////////////

this.of_ShowPhoneNumberDlg(dwo.name)
end event

event itemchanged;call super::itemchanged; //Start Code Change ----04.07.2015 #V15 maha - zip autofill
if dwo.name = "zip" then
	string val
	this.accepttext( )
	val = this.getitemstring(this.getrow(),"zip")
	of_zip_fill(val, "REF", this)
end if
end event

type cb_cancel from commandbutton within w_peer_reference_edit
integer x = 1275
integer y = 1124
integer width = 389
integer height = 84
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

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clicked
// $<arguments>
// $<returns> long
// $<description> Close window
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2009 by Evan
//////////////////////////////////////////////////////////////////////

Close(Parent)
end event

type cb_save from commandbutton within w_peer_reference_edit
integer x = 832
integer y = 1124
integer width = 416
integer height = 84
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

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clicked
// $<arguments>
// $<returns> long
// $<description> Save data and close window
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2009 by Evan
//////////////////////////////////////////////////////////////////////

if of_Save() = 1 then
	Close(Parent)
end if
end event

