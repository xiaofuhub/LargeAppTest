$PBExportHeader$u_saml_idpserver_config.sru
forward
global type u_saml_idpserver_config from userobject
end type
type cb_upload from commandbutton within u_saml_idpserver_config
end type
type cb_close from commandbutton within u_saml_idpserver_config
end type
type cb_refresh from commandbutton within u_saml_idpserver_config
end type
type cb_save from commandbutton within u_saml_idpserver_config
end type
type cb_del from commandbutton within u_saml_idpserver_config
end type
type cb_add from commandbutton within u_saml_idpserver_config
end type
type dw_detail from u_dw within u_saml_idpserver_config
end type
type dw_browse from u_dw within u_saml_idpserver_config
end type
end forward

global type u_saml_idpserver_config from userobject
integer width = 3954
integer height = 1672
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_upload cb_upload
cb_close cb_close
cb_refresh cb_refresh
cb_save cb_save
cb_del cb_del
cb_add cb_add
dw_detail dw_detail
dw_browse dw_browse
end type
global u_saml_idpserver_config u_saml_idpserver_config

type variables
string is_Type
string is_UserID
string is_ErrInfo
DataStore ids_User
TreeViewItem itvi_User
boolean ib_DoFilter = true

n_cst_encrypt in_Encrypt

n_cst_string inv_string

window iw_parent
end variables

forward prototypes
public function integer of_filter (string as_userid)
public subroutine of_completetrans (boolean ab_iscommit)
public function blob of_readfile (string as_file)
end prototypes

public function integer of_filter (string as_userid);if Len(as_UserID) > 0 then
	dw_browse.SetFilter("map_user_id = '" + as_UserID + "'")
else
	dw_browse.SetFilter("")
end if

dw_browse.Filter()
dw_browse.SetRow(1)
dw_browse.Event RowFocusChanged(1)

Return 1
end function

public subroutine of_completetrans (boolean ab_iscommit);if SQLCA.AutoCommit = true then Return

if ab_IsCommit then
	Commit;
else
	Rollback;
end if
end subroutine

public function blob of_readfile (string as_file);blob lblb_Data
blob lblb_Buf
long ll_Byte
integer li_FileNum

li_FileNum = FileOpen(as_File, StreamMode!, Read!, Shared!)
if li_FileNum = -1 then 
	SetNull(lblb_Data)
	Return lblb_Data
end if

do
	ll_Byte = FileRead(li_FileNum, lblb_Buf)
	if ll_Byte > 0 then
		lblb_Data += lblb_Buf
	else
		Exit
	end if
loop while true
FileClose(li_FileNum)

Return lblb_Data
end function

on u_saml_idpserver_config.create
this.cb_upload=create cb_upload
this.cb_close=create cb_close
this.cb_refresh=create cb_refresh
this.cb_save=create cb_save
this.cb_del=create cb_del
this.cb_add=create cb_add
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.Control[]={this.cb_upload,&
this.cb_close,&
this.cb_refresh,&
this.cb_save,&
this.cb_del,&
this.cb_add,&
this.dw_detail,&
this.dw_browse}
end on

on u_saml_idpserver_config.destroy
destroy(this.cb_upload)
destroy(this.cb_close)
destroy(this.cb_refresh)
destroy(this.cb_save)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.dw_detail)
destroy(this.dw_browse)
end on

type cb_upload from commandbutton within u_saml_idpserver_config
boolean visible = false
integer x = 1646
integer y = 1528
integer width = 613
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Upload Certificate File..."
end type

event clicked;//
long row = 0 , ll_ImportID
int li_Return
string errinfo = ""
blob lblb_Data 
string ls_DocPath, ls_DocName

row = dw_browse.getrow()
if row < 0 then return

gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
//li_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "*", &
//									 "All Files (*.*),*.*" )			//Added By Mark Lee 08/15/2014
n_getfilename     ln_getfilename
li_Return = ln_getfilename.of_getopenfilename("Select File", ls_DocPath, ls_DocName, "*", &
                  "All Files (*.*),*.*" )	

gf_save_dir_path(ls_DocPath) //Added by Ken.Guo on 2009-03-10
if li_Return <> 1 then Return

dw_browse.object.CentificateName[row] = ls_DocName

if dw_browse.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Error", is_ErrInfo, StopSign!)
	Return
end if


ll_ImportID = dw_browse.object.idp_sno[row]
if ll_ImportID < 0 then return 

lblb_Data = parent.of_ReadFile(ls_DocPath)
UPDATEBLOB idp_servers SET CertificateFile = :lblb_Data WHERE idp_sno = :ll_ImportID;		
if SQLCA.SQLCode = 0 then
	parent.of_CompleteTrans(true)
	MessageBox("Success","Upload Completed.")
else
	errinfo = SQLCA.SQLErrText
	parent.of_CompleteTrans(false)
	MessageBox("Error", errinfo, StopSign!)
end if
end event

type cb_close from commandbutton within u_saml_idpserver_config
integer x = 3589
integer y = 1528
integer width = 311
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;If isvalid(iw_parent) Then
	Close(iw_parent)
End If
end event

type cb_refresh from commandbutton within u_saml_idpserver_config
integer x = 3259
integer y = 1528
integer width = 311
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;
long ll_Handle
parent.dw_browse.retrieve()

end event

type cb_save from commandbutton within u_saml_idpserver_config
integer x = 2930
integer y = 1528
integer width = 311
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
boolean default = true
end type

event clicked;boolean 	lb_AutoCommit
String	ls_UserId, ls_idp_server_name
long		ll_Row, ll_Count, i, ll_find


dw_detail.AcceptText()
dw_browse.AcceptText()
if dw_browse.ModifiedCount() + dw_browse.DeletedCount() <= 0 then Return

//Added By Ken.Guo 04/21/2014
For i = 1 To dw_browse.RowCount()
	ls_idp_server_name = dw_browse.GetItemString(i, 'idp_name')	
	If ls_idp_server_name = '' or isnull(ls_idp_server_name) Then
		Messagebox('Validation','IdP Server Name cannot be empty.')
		Return 
	End If
	If i <> dw_browse.RowCount() Then
		ll_find = dw_browse.Find('idp_name = "'+ls_idp_server_name+ '"', i+1, dw_browse.RowCount())
		If ll_find > 0 Then
			Messagebox('Validation','The existence of duplicate IdP Server Name "'+ls_idp_server_name+'" , please check it.')
			dw_browse.ScrolltoRow(i)
			dw_browse.SetRow(i)
			dw_detail.SetFocus()
			dw_detail.SetColumn('idp_name')
			Return
		End If
	End If
Next


if dw_browse.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Error", is_ErrInfo, StopSign!)
end if

//iw_parent.Dynamic Event ue_refresh_idp_server_dddw()
iw_parent.Dynamic Event ue_do("refresh_servername_dddw")


end event

type cb_del from commandbutton within u_saml_idpserver_config
integer x = 2601
integer y = 1528
integer width = 311
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;long ll_FindRow
long ll_DefaultRow
string ls_UserID
Long ll_cnt,ll_idp_sno


if dw_browse.GetRow() <= 0 then Return
ll_idp_sno = dw_browse.GetItemNumber(dw_browse.GetRow(),'idp_sno')

SELECT Count(1)
Into :ll_cnt
From idp_users
Where idp_server_id = :ll_idp_sno;

If ll_cnt >= 1 Then
	Messagebox('Warning','Delete failed. There are user(s) associated with this IdP Server. ')
	Return -1
End If

if MessageBox("Delete", "Are you sure you want to delete the selected record?", Question!, YesNo!) = 2 then
	Return
end if	

// Delete row
dw_browse.DeleteRow(0)
dw_browse.Event RowFocusChanged(dw_browse.GetRow())

end event

type cb_add from commandbutton within u_saml_idpserver_config
integer x = 2272
integer y = 1528
integer width = 311
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;long ll_FindRow
long ll_InsertRow
string ls_UserID
string ls_Email

ll_InsertRow = dw_browse.InsertRow(0)
dw_browse.ScrollToRow(ll_InsertRow)

dw_detail.SetFocus()
dw_detail.SetColumn('idp_name')
end event

type dw_detail from u_dw within u_saml_idpserver_config
event ue_keydown pbm_dwnkey
integer x = 37
integer y = 704
integer width = 3881
integer height = 776
integer taborder = 30
string title = "none"
string dataobject = "d_saml_idpserver_detail"
boolean vscrollbar = false
end type

event ue_keydown;if Key = KeyDownArrow! or Key = KeyUpArrow! or Key = KeyPageUp! or Key = KeyPageDown! then 
	Return 1
else
	Return 0
end if
end event

event buttonclicked;if dwo.name = "b_browse" then 
	cb_upload.Event Clicked()
end if
end event

event itemerror;Return 1
end event

event other;if Message.Number = 522 then // Add by Evan on 2008-03-24
	Return 1
end if
end event

event itemchanged;call super::itemchanged;Integer		li_FR

IF row > 0 Then 
	If dwo.Name = 'current_saml' Then
		If data = '1' Then
			li_FR = dw_browse.Find( "current_saml = '1'", 1, dw_browse.Rowcount( ) )
			If li_FR > 0 Then
				dw_browse.SetItem( li_FR, 'current_saml', '0' )
			End If
		End If		
	End If	
End If
end event

type dw_browse from u_dw within u_saml_idpserver_config
integer x = 32
integer y = 12
integer width = 3886
integer height = 668
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_idp_servers_browse"
boolean hscrollbar = true
end type

event constructor;this.SetTransObject(SQLCA)
dw_detail.Settransobject(SQLCA)
this.Retrieve()
dw_browse.ShareData(dw_detail)
end event

event dberror;is_ErrInfo = SQLErrText
Return 1
end event

event rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
dw_detail.ScrollToRow(CurrentRow)
end event

