$PBExportHeader$w_storage_docs.srw
forward
global type w_storage_docs from window
end type
type st_1 from statictext within w_storage_docs
end type
type dw_1 from datawindow within w_storage_docs
end type
type cb_3 from commandbutton within w_storage_docs
end type
type cb_1 from commandbutton within w_storage_docs
end type
end forward

global type w_storage_docs from window
integer width = 2286
integer height = 844
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_storage_docs w_storage_docs

type variables
Boolean ib_new
Boolean ib_save
Long il_area_id
String is_doc_fullname
end variables

on w_storage_docs.create
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_storage_docs.destroy
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event open;Long ll_row
Datetime ldt_today

ldt_today = Datetime( Today(), Now() )

dw_1.settransobject( SQLCA )

il_area_id = Message.Doubleparm
IF il_area_id > 0 THEN
	ll_row = dw_1.Insertrow( 0 )

	dw_1.Setitem( ll_row, "area_id", il_area_id)
	dw_1.Setitem( ll_row, "last_edit_date", ldt_today)
	dw_1.Setitem( ll_row, "user_id", gs_user_id)

END IF

//---------Begin Added by (Appeon)Toney 10.12.2013 for V141 ISG-CLX--------
//$Reason:Fix Reintegration BugT100901,limit the document type items
//reset the document type options
IF IsValid(w_area_painter) THEN
	IF w_area_painter.cbx_onlycontract.checked THEN
		dw_1.Modify("doc_type.values='Verification~tV/Expiring~tE/Correspondence~tC/'")
	END IF
END IF
//---------End Added ------------------------------------------------------------------
end event

type st_1 from statictext within w_storage_docs
integer x = 777
integer y = 16
integer width = 640
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Add Document"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_storage_docs
integer x = 18
integer y = 124
integer width = 2240
integer height = 584
integer taborder = 10
string title = "none"
string dataobject = "d_sys_storage_docs"
boolean livescroll = true
end type

event buttonclicked;string docname, named

integer value

value = GetFileOpenName("Select File",&
	+ docname, named, "DOC", &
	+ "Doc Files (*.DOC; *.DOCX),*.DOC; *.DOCX")	//V12.2 usage of docx - alfee 07.05.2012
//	+ "Doc Files (*.DOC),*.DOC")
		
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF value = 1 THEN
	IF Right(Upper(named), 5) = ".DOCX" THEN named = Left (named, len(named) - 1) //V12.2 usage of docx - alfee 07.05.2012	
	This.SetItem( row, "doc_name", named )
	is_doc_fullname = docname
END IF
end event

type cb_3 from commandbutton within w_storage_docs
integer x = 1938
integer y = 720
integer width = 265
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;IF ib_save THEN
	CloseWithReturn( PARENT, dw_1.GetItemString(1, "doc_name") )
ELSE
	CLOSE( PARENT )
END IF
end event

type cb_1 from commandbutton within w_storage_docs
integer x = 1623
integer y = 720
integer width = 265
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;String 	ls_doc_name
String 	ls_doc_type
Integer 	li_cnt
long		ll_Rtn

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-07-13 By: Scofield
//$<Reason> Remove the leading and the hind space of the document name
dw_1.accepttext( )
ls_doc_name = Trim(dw_1.GetItemString(1, "doc_name"))
dw_1.SetItem(1, "doc_name",ls_doc_name)
//---------------------------- APPEON END ----------------------------

dw_1.accepttext( )

ls_doc_name = dw_1.GetItemString(1, "doc_name")
IF Isnull(ls_doc_name) OR Trim(ls_doc_name) = "" THEN
	Messagebox("Error", "Required value information for Document Name.")
	Return
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-04-17 By: Scofield
//$<Reason> if the document content doesn't in the database,then upload the document.

SELECT count(*) 
  INTO :li_cnt
  FROM sys_storage_docs
 WHERE area_id = :il_area_id AND LTrim(RTrim(doc_name)) = :ls_doc_name AND doc_data is Not Null;
//---------------------------- APPEON END ----------------------------

IF li_cnt > 0  THEN
	//Messagebox("Error", "The new document cannot has the same name to the one exists in database already.")
	Messagebox("Error", "A document with this name already exists in the database.")
	Return
END IF


ls_doc_type = dw_1.GetItemString(1, "doc_type")
IF Isnull(ls_doc_type) OR Trim(ls_doc_type) = "" THEN
	Messagebox("Error", "Please select a document type.")
	Return
END IF

//----------------------------APPEON BEGIN----------------------------
//$<add> Letter Storage I : 06.10.2011 By:long.zhang
//$<Reason> Check whether the document name contains special character
IF  Match(ls_doc_name,'[\/:*?"<>|]') THEN
	Messagebox("Error", 'The document name can not contain any of the following character:~r~n \ / : * ? " < > |')
	Return
END IF
//----------------------------APPEON END------------------------------

If dw_1.update( ) = 1 THen
	COMMIT;
	
	// Upload Document
	IF LenA( is_doc_fullname ) > 0 THEN
		n_appeon_storage_area lnv_storage_area
		ll_Rtn = lnv_storage_area.of_upload_file( il_area_id, ls_doc_name, is_doc_fullname)
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-04-17 By: Scofield
		//$<Reason> Popup a tip message.

		if ll_Rtn = -1 then
			MessageBox(gnv_app.iapp_object.DisplayName,'Failed to upload ' + is_doc_fullname)
		end if
		//---------------------------- APPEON END ----------------------------
	END IF
ELSE
	ROLLBACK;
	Return;
End if
	
ib_save = TRUE

end event

