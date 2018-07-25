$PBExportHeader$w_get_attach.srw
$PBExportComments$Get Attach for email
forward
global type w_get_attach from window
end type
type cb_3 from commandbutton within w_get_attach
end type
type cb_2 from commandbutton within w_get_attach
end type
type cb_1 from commandbutton within w_get_attach
end type
type dw_1 from datawindow within w_get_attach
end type
end forward

global type w_get_attach from window
integer width = 3122
integer height = 1384
boolean titlebar = true
string title = "Get Attach"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_get_attach w_get_attach

type variables
String is_Attach	//Store file from select file

mailMessage mMsg	//Store Mail Message
end variables

on w_get_attach.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_get_attach.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;Long ll_ctx_id

ll_ctx_id = Message.DoubleParm

dw_1.SetTransObject(Sqlca)
dw_1.Retrieve(ll_ctx_id)
end event

type cb_3 from commandbutton within w_get_attach
integer x = 1888
integer y = 1180
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &File"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-16 By: Liu Hongxin
//$<reason> Get File to Attachment.
string docpath, docname[]
integer li_cnt, li_rtn, li_filenum
Long    i, j
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
li_rtn = GetFileOpenName("Select File", &
   docpath, docname[], "DOC", &
   + "Doc Files (*.DOC),*.DOC," &
   + "All Files (*.*), *.*") 
gf_save_dir_path(docpath) //Added by Ken.Guo on 2009-03-10
//ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF li_rtn < 1 THEN RETURN
li_cnt = Upperbound(docname)

j = UpperBound(mMsg.AttachmentFile)
// path and file name
IF li_cnt = 1 THEN
	IF is_Attach = "" THEN
		is_Attach = docname[1]
	ELSE
		is_Attach += "," + docname[1]
	END IF
	mMsg.AttachmentFile[j + 1].FileType = MailAttach!
	mMsg.AttachmentFile[j + 1].FileName = docname[1]
	mMsg.AttachmentFile[j + 1].PathName = docpath
	mMsg.AttachmentFile[j + 1].position = j + 1
ELSE
	FOR i=1 TO li_cnt
		//IF Pos(docpath + "\" + string(docname[i]), is_Attach) > 0 THEN Continue
		IF is_Attach = "" THEN
			is_Attach = docpath + "\" + string(docname[i])
		ELSE
			//is_Attach += "," + docpath + "\" + string(docname[i])
			is_Attach += "," + string(docname[i])
		END IF
		j++
		mMsg.AttachmentFile[j].FileType = MailAttach!
		mMsg.AttachmentFile[j].FileName = string(docname[i])
		mMsg.AttachmentFile[j].PathName = docpath + "\" + string(docname[i])
		mMsg.AttachmentFile[j].position = j
	NEXT
END IF
//---------------------------- APPEON END ----------------------------

end event

type cb_2 from commandbutton within w_get_attach
integer x = 2309
integer y = 1180
integer width = 343
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-17 By: Liu Hongxin
//$<reason> Get Attachment from Documents area.
Long ll_RowCount
Long i, j
Long ll_image_id, ll_image_version
String ls_Attach, ls_FileName

n_cst_contract ln_cst_contract

ln_cst_contract = Create n_cst_contract
IF IsNull(ln_cst_contract.of_Get_ctx_id()) THEN
	ln_cst_contract.of_Set_ctx_id(w_get_email_message.il_ctx_id)
END IF
ln_cst_contract.is_mode = "attach"	//Change to fit this

j = UpperBound(mMsg.AttachmentFile)

ll_RowCount = dw_1.RowCount()
FOR i = 1 TO ll_RowCount
	IF dw_1.GetItemString(i, "Sel") = "1" THEN
		ls_FileName = dw_1.GetItemString(i, "file_name")
		IF IsNull(ls_FileName) THEN ls_FileName = ""
		IF ls_FileName <> "" THEN
			IF ls_Attach = "" THEN
				ls_Attach = ls_FileName
			ELSE
				ls_Attach += "," + ls_FileName
			END IF

			//Set Attachment to mMsg
			j ++
			mMsg.AttachmentFile[j].FileType = MailAttach!
			mMsg.AttachmentFile[j].FileName = ls_FileName
			mMsg.AttachmentFile[j].PathName = gs_dir_path + gs_DefDirName + "\" + ls_FileName
			mMsg.AttachmentFile[j].position = j
			
			//Store information of the Download file
			IF NOT FileExists(gs_dir_path + gs_DefDirName + "\" + ls_FileName) THEN
				ll_image_id = dw_1.GetItemNumber(i, "image_id")
				ll_image_version = dw_1.GetItemNumber(i, "image_version")
				ln_cst_contract.of_get_image(ll_image_id, ll_image_version)
			END IF
		END IF
	END IF
NEXT

IF ls_Attach <> "" THEN ls_Attach += ","
ls_Attach += is_Attach
//w_get_email_message.sle_attach.text = ls_Attach

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 08.22.2007 By: Evan
//$<Reason> Need to destroy object.
//DESTROY n_cst_contract
if IsValid(ln_cst_contract) then Destroy ln_cst_contract
//---------------------------- APPEON END ----------------------------

CloseWithReturn(Parent, mMsg)
//---------------------------- APPEON END ----------------------------

end event

type cb_1 from commandbutton within w_get_attach
integer x = 2729
integer y = 1180
integer width = 343
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, "Close")
end event

type dw_1 from datawindow within w_get_attach
integer x = 23
integer y = 20
integer width = 3049
integer height = 1120
integer taborder = 10
string title = "none"
string dataobject = "d_cntx_images_mail_attach"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;LONG LL_COLUMN_COUNT , LL_I
string ls_dddw_name
string ls_colname
String ls_coltag
Integer li_value
Integer ll_lookup_code

DataWindowChild dwchild
n_ds lnds_user

LL_COLUMN_COUNT = LONG(This.Describe("DataWindow.Column.Count"))
IF LL_COLUMN_COUNT = 0 THEN RETURN

FOR LL_I = 1 TO LL_COLUMN_COUNT
	IF Describe("#" +STRING(LL_I) + ".Edit.Style") = 'dddw' then
		ls_colname = Describe("#" +STRING(LL_I) + ".Name")
		ls_dddw_name = lower(Describe("#" +STRING(LL_I) + ".DDDW.Name"))

		IF ls_dddw_name = "d_dddw_code_lookup" OR ls_dddw_name = "d_dddw_code_lookup_action_type" THEN
			ls_coltag = Lower(Describe("#" +STRING(LL_I) + ".TAG"))
			li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
				
			IF li_value <> 1 THEN
				gnv_app.of_setcontraccache_code_lookup( ls_coltag )
				li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
			END IF
		ELSE
			li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_dddw_name,lnds_user)
		END IF

		IF li_value = 1 THEN
			getchild( ls_colname, dwchild)
			lnds_user.ShareData ( dwchild )
		END IF
	END IF
NEXT

Return
end event

event clicked;IF row < 1 THEN RETURN

IF Lower(dwo.name) <> "sel" THEN
	IF dw_1.GetItemString(row, "Sel") = "1" THEN
		dw_1.setItem(row, "Sel", "0")
	ELSE
		dw_1.setItem(row, "Sel", "1")
	END IF
END IF
end event

