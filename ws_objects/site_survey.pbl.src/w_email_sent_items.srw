$PBExportHeader$w_email_sent_items.srw
forward
global type w_email_sent_items from w_sheet
end type
type ole_mail_view from u_email_edit within w_email_sent_items
end type
type dw_from from u_dw within w_email_sent_items
end type
type st_sent from statictext within w_email_sent_items
end type
type st_1 from statictext within w_email_sent_items
end type
type cb_clear from commandbutton within w_email_sent_items
end type
type cb_filter from commandbutton within w_email_sent_items
end type
type st_split from u_st_splitbar within w_email_sent_items
end type
type cb_delete from commandbutton within w_email_sent_items
end type
type cb_close from commandbutton within w_email_sent_items
end type
type dw_browse from u_dw within w_email_sent_items
end type
type gb_filter from groupbox within w_email_sent_items
end type
type st_2 from statictext within w_email_sent_items
end type
type dw_to from u_dw within w_email_sent_items
end type
type dw_sent from u_dw within w_email_sent_items
end type
end forward

global type w_email_sent_items from w_sheet
integer width = 3835
integer height = 2256
string title = "Email Sent Items"
long backcolor = 33551856
ole_mail_view ole_mail_view
dw_from dw_from
st_sent st_sent
st_1 st_1
cb_clear cb_clear
cb_filter cb_filter
st_split st_split
cb_delete cb_delete
cb_close cb_close
dw_browse dw_browse
gb_filter gb_filter
st_2 st_2
dw_to dw_to
dw_sent dw_sent
end type
global w_email_sent_items w_email_sent_items

type variables
string is_OrgSql
string is_OpenFrom // Administrator! Personal!
end variables

forward prototypes
public function blob of_downloadfile (long al_id)
public function integer of_setstate (string as_from)
end prototypes

public function blob of_downloadfile (long al_id);blob lb_data
blob lb_all_data
long ll_data_length
long ll_start
long ll_counter
long ll_loops

If gs_dbtype = "ASA" Or appeongetclienttype() <> 'PB' Then
	SELECTBLOB mail_content INTO :lb_all_data
	FROM em_sent_items
	WHERE id = :al_id;
Else
	SELECT DataLength(mail_content) INTO :ll_data_length
	FROM em_sent_items
	WHERE id = :al_id;
	
	If isnull(ll_data_length) Then ll_data_length = 0
	
	If ll_data_length > 8000 Then 
		If Mod(ll_data_length,8000) = 0 Then
			ll_loops = ll_data_length / 8000 
		Else
			ll_loops = (ll_data_length / 8000) + 1
		End If 
	ElseIf ll_data_length > 0 Then 
		ll_loops = 1 
	End If 
	
	For ll_counter = 1 To ll_loops			
		ll_start = (ll_counter - 1) * 8000 + 1
		SELECTBLOB substring(mail_content,:ll_start,8000) INTO :lb_data
		FROM em_sent_items
		WHERE id = :al_id;
		lb_all_data += lb_data
	Next
End If
If isnull(lb_all_data) Then lb_all_data = blob('')

Return lb_all_data
end function

public function integer of_setstate (string as_from);//////////////////////////////////////////////////////////////////////
// $<function> of_setstate
// $<arguments>
//		string	as_from
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 06.18.2012 by Evan
//////////////////////////////////////////////////////////////////////

if as_From = "Personal!" then
	dw_sent.Hide()
	st_sent.Hide()
	dw_sent.SetItem(1, "user_id", gs_user_id)
	gb_filter.Width = 2135
	cb_filter.X = 1422
	cb_clear.X = 1774
	cb_delete.X = 2432
	cb_close.X = 2789
	dw_browse.modify("user_id.visible='0'")     //add by stephen 08.10.2012 --BugC062603
	dw_browse.modify("mail_from.visible='0'") //add by stephen 08.10.2012 --BugC062603
end if

Return 1
end function

on w_email_sent_items.create
int iCurrent
call super::create
this.ole_mail_view=create ole_mail_view
this.dw_from=create dw_from
this.st_sent=create st_sent
this.st_1=create st_1
this.cb_clear=create cb_clear
this.cb_filter=create cb_filter
this.st_split=create st_split
this.cb_delete=create cb_delete
this.cb_close=create cb_close
this.dw_browse=create dw_browse
this.gb_filter=create gb_filter
this.st_2=create st_2
this.dw_to=create dw_to
this.dw_sent=create dw_sent
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_mail_view
this.Control[iCurrent+2]=this.dw_from
this.Control[iCurrent+3]=this.st_sent
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_clear
this.Control[iCurrent+6]=this.cb_filter
this.Control[iCurrent+7]=this.st_split
this.Control[iCurrent+8]=this.cb_delete
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.dw_browse
this.Control[iCurrent+11]=this.gb_filter
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.dw_to
this.Control[iCurrent+14]=this.dw_sent
end on

on w_email_sent_items.destroy
call super::destroy
destroy(this.ole_mail_view)
destroy(this.dw_from)
destroy(this.st_sent)
destroy(this.st_1)
destroy(this.cb_clear)
destroy(this.cb_filter)
destroy(this.st_split)
destroy(this.cb_delete)
destroy(this.cb_close)
destroy(this.dw_browse)
destroy(this.gb_filter)
destroy(this.st_2)
destroy(this.dw_to)
destroy(this.dw_sent)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event> open()
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 06.19.2012 by Evan
//////////////////////////////////////////////////////////////////////

is_OpenFrom = Message.StringParm
of_SetState(is_OpenFrom)

dw_from.of_SetDropDownCalendar(true)
dw_to.of_SetDropDownCalendar(true)

// Set resize
this.of_SetResize(true)
inv_resize.of_setorigsize( this.workspacewidth(), this.workspaceheight())
inv_resize.of_setminsize( this.workspacewidth(),this.workspaceheight())

inv_resize.of_Register(dw_browse, inv_resize.SCALERIGHT)
inv_resize.of_Register(ole_mail_view, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(st_split, inv_resize.SCALERIGHT)
st_split.of_Register(dw_browse, st_split.ABOVE)
st_split.of_Register(ole_mail_view , st_split.BELOW)

// Retrieve data
cb_filter.Event Clicked()
end event

event close;call super::close;ole_mail_view.of_Close()
end event

type ole_mail_view from u_email_edit within w_email_sent_items
integer x = 23
integer y = 944
integer width = 3721
integer height = 1168
integer taborder = 100
string binarykey = "w_email_sent_items.win"
end type

type dw_from from u_dw within w_email_sent_items
integer x = 416
integer y = 84
integer width = 485
integer height = 80
integer taborder = 10
string dataobject = "d_esi_date_sel"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<evant> constructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 06.14.2012 by Evan
//////////////////////////////////////////////////////////////////////

this.InsertRow(0)
this.of_SetUpdateable(false)
end event

event itemerror;Return 1
end event

type st_sent from statictext within w_email_sent_items
integer x = 1449
integer y = 96
integer width = 215
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Sent by:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_email_sent_items
integer x = 55
integer y = 96
integer width = 370
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Sent time from:"
boolean focusrectangle = false
end type

type cb_clear from commandbutton within w_email_sent_items
integer x = 2487
integer y = 76
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Clear"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> Clear filter criteria
//////////////////////////////////////////////////////////////////////
// $<add> 06.14.2012 by Evan
//////////////////////////////////////////////////////////////////////

date ld_Null
string ls_Null

SetNull(ld_Null)
SetNull(ls_Null)

dw_from.SetItem(1, "date_value", ld_Null)
dw_to.SetItem(1, "date_value", ld_Null)

if is_OpenFrom = "Administrator!" then
	//dw_sent.SetItem(1, "user_id", ls_Null)
	dw_sent.SetItem(1, "user_id", "All")	//long.zhang 09.17.2012
end if

cb_filter.Event Clicked()
end event

type cb_filter from commandbutton within w_email_sent_items
integer x = 2135
integer y = 76
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> Filter sent items
//////////////////////////////////////////////////////////////////////
// $<add> 06.14.2012 by Evan
//////////////////////////////////////////////////////////////////////

date ld_To
date ld_From
string ls_user_id
string ls_Where
string ls_NewSql
long ll_old_id
long ll_new_id
boolean lb_FirstRow

// Check filter criteria
if dw_from.AcceptText() = -1 then
	MessageBox("Prompt", "Please type correct format of FROM date.")
	dw_from.SetFocus()
	Return
end if
if dw_to.AcceptText() = -1 then
	MessageBox("Prompt", "Please type correct format of TO date.")
	dw_to.SetFocus()
	Return
end if
ld_From = dw_from.GetItemDate(1, "date_value")
ld_To = dw_to.GetItemDate(1, "date_value")
ls_user_id = dw_sent.GetItemString(1, "user_id")

if (IsNull(ld_From)) and (not IsNull(ld_To)) then
	MessageBox("Prompt", "Please type the FROM date.")
	dw_from.SetFocus()
	Return
end if
if (not IsNull(ld_From)) and (IsNull(ld_To)) then
	MessageBox("Prompt", "Please type the TO date.")
	dw_to.SetFocus()
	Return
end if
if ld_From > ld_To then
	MessageBox("Prompt", "The FROM date should be less or equal than the TO date.")
	dw_from.SetFocus()
	Return
end if

// Build filter criteria
if (not IsNull(ld_From)) and (not IsNull(ld_To)) then
	ls_Where =  "(sent_time >= '" + String(ld_From, "yyyy-mm-dd") + " 00:00:00') AND "
	ls_Where += "(sent_time <= '" + String(ld_To, "yyyy-mm-dd") + " 23:59:59') "
end if
//if not IsNull(ls_user_id) then
if not IsNull(ls_user_id) and ls_user_id <> "All" then	//long.zhang 09.17.2012
	if Len(ls_Where) > 0 then ls_Where += " AND "
	ls_Where += "(user_id = '" + ls_user_id + "')"
elseif isNull(ls_user_id)	then//added by long.zhang 09.17.2012
	if Len(ls_Where) > 0 then ls_Where += " AND "
	ls_Where += "(user_id is null or user_id = '')"
end if
if Len(ls_Where) > 0 then
	ls_NewSql = is_OrgSql + " WHERE " + ls_Where
	dw_browse.SetSQLSelect(ls_NewSql)
else
	dw_browse.SetSQLSelect(is_OrgSql)
end if

// Retrieve data
if dw_browse.GetRow() = 1 then
	lb_FirstRow = true
	ll_old_id = dw_browse.object.id[1]
end if

if dw_browse.Retrieve() > 0 then
	ll_new_id = dw_browse.object.id[1]
	if lb_FirstRow and ll_old_id <> ll_new_id then
		dw_browse.Event RowFocusChanged(1)
	end if
end if
dw_browse.Object.DataWindow.Table.UpdateTable = "em_sent_items"	//added by long.zhang 09.17.2012
end event

type st_split from u_st_splitbar within w_email_sent_items
integer x = 23
integer y = 920
integer width = 3721
end type

type cb_delete from commandbutton within w_email_sent_items
integer x = 2962
integer y = 76
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete Email"
end type

event clicked;long ll_Row

ll_Row = dw_browse.GetRow()
if ll_Row > 0 then
	if MessageBox("Delete",  "Are you sure that you want to permanently delete the selected email?", Question!, YesNo!) = 2 then Return
else
	Return
end if	
dw_browse.DeleteRow(ll_Row)

if ll_Row = 1 and dw_browse.GetRow() > 0 then
	dw_browse.Event RowFocusChanged(dw_browse.GetRow())
end if
dw_browse.SelectRow(0, false)
dw_browse.SelectRow(dw_browse.GetRow(), true)

if dw_browse.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Error", "Failed to delete email.", StopSign!)
end if
end event

type cb_close from commandbutton within w_email_sent_items
integer x = 3319
integer y = 76
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type dw_browse from u_dw within w_email_sent_items
integer x = 23
integer y = 220
integer width = 3721
integer height = 700
integer taborder = 80
string dataobject = "d_email_sent_items"
boolean hscrollbar = true
end type

event clicked;call super::clicked;//inherit
long ll_Row

ll_Row = this.GetSelectedRow(1)
this.SetRow(ll_Row)
end event

event constructor;call super::constructor;//inherit
this.of_SetSort(true)
inv_sort.of_SetColumnHeader(true)
this.SetTransObject(SQLCA)
this.Modify("DataWindow.ReadOnly='yes'")
is_OrgSql = this.GetSQLSelect()
end event

event rowfocuschanged;call super::rowfocuschanged;//inherit
long ll_id
blob lblb_MailContent

if CurrentRow <= 0 then
	ole_mail_view.of_Open()
	Return
end if

// Open content of mail
ll_id = this.object.id[CurrentRow]
//BEGIN---Modify by Evan 10/24/2008
//SELECTBLOB mail_content INTO :lblb_MailContent FROM em_sent_items WHERE id = :ll_id;
lblb_MailContent = of_DownloadFile(ll_id)
//END---Modify by Evan 10/24/2008

ole_mail_view.SetRedraw(false)
if LenA(lblb_MailContent) > 0 then
	ole_mail_view.of_Open(lblb_MailContent)
else
	ole_mail_view.of_Open()
end if
ole_mail_view.SetRedraw(true)

// Select row
this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
this.Post SetFocus()
end event

type gb_filter from groupbox within w_email_sent_items
integer x = 23
integer y = 16
integer width = 2848
integer height = 176
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Filter Criteria"
end type

type st_2 from statictext within w_email_sent_items
integer x = 882
integer y = 96
integer width = 78
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "to"
boolean focusrectangle = false
end type

type dw_to from u_dw within w_email_sent_items
integer x = 942
integer y = 84
integer width = 485
integer height = 80
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_esi_date_sel"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<evant> constructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 06.14.2012 by Evan
//////////////////////////////////////////////////////////////////////

this.InsertRow(0)
this.of_SetUpdateable(false)
end event

event itemerror;Return 1
end event

type dw_sent from u_dw within w_email_sent_items
integer x = 1637
integer y = 84
integer width = 485
integer height = 80
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_esi_user_sel"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<evant> constructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 06.14.2012 by Evan
//////////////////////////////////////////////////////////////////////

datawindowchild ldwc_child

this.InsertRow(0)
this.GetChild("user_id", ldwc_child)
ldwc_child.InsertRow(1)
//--------appeon begin----------
//<$>added:long.zhang 09.17.2012
//<$>reason:replace blank with all -Alpha id 3266
ldwc_child.insertrow( 1)
ldwc_child.setitem( 1,"user_id", "All")
this.setitem( 1,"user_id","All")
//--------appeon end------------
this.of_SetUpdateable(false)
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Fw_email_sent_items.bin 
2A00000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000fc73a72001d175c500000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d300000000fc73a72001d175c5fc73a72001d175c50000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Cffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd0000542100001e2e00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd0000542100001e2e00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Fw_email_sent_items.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
