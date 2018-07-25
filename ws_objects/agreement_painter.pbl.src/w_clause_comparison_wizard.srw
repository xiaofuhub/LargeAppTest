$PBExportHeader$w_clause_comparison_wizard.srw
forward
global type w_clause_comparison_wizard from w_popup
end type
type ole_source from u_email_edit within w_clause_comparison_wizard
end type
type ole_1 from u_email_edit within w_clause_comparison_wizard
end type
type st_step from statictext within w_clause_comparison_wizard
end type
type st_source from statictext within w_clause_comparison_wizard
end type
type st_splitbar from u_st_splitbar within w_clause_comparison_wizard
end type
type st_title from statictext within w_clause_comparison_wizard
end type
type dw_clause from u_dw within w_clause_comparison_wizard
end type
type cb_close from commandbutton within w_clause_comparison_wizard
end type
type st_alert from statictext within w_clause_comparison_wizard
end type
type cb_cancel from commandbutton within w_clause_comparison_wizard
end type
type cb_next from commandbutton within w_clause_comparison_wizard
end type
type st_prompt from statictext within w_clause_comparison_wizard
end type
type gb_source from groupbox within w_clause_comparison_wizard
end type
type ln_1 from line within w_clause_comparison_wizard
end type
type ln_2 from line within w_clause_comparison_wizard
end type
type gb_clause from groupbox within w_clause_comparison_wizard
end type
end forward

global type w_clause_comparison_wizard from w_popup
integer width = 1833
integer height = 804
string title = "Clause Comparison Wizard"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
boolean ib_isupdateable = false
event ue_postactivate ( )
ole_source ole_source
ole_1 ole_1
st_step st_step
st_source st_source
st_splitbar st_splitbar
st_title st_title
dw_clause dw_clause
cb_close cb_close
st_alert st_alert
cb_cancel cb_cancel
cb_next cb_next
st_prompt st_prompt
gb_source gb_source
ln_1 ln_1
ln_2 ln_2
gb_clause gb_clause
end type
global w_clause_comparison_wizard w_clause_comparison_wizard

type variables
n_cst_clause_comparison inv_clause_comparison
n_cst_word_utility inv_word_utility

Long il_source_clause,il_last_clause_id
String is_call_from


DataStore ids_clauses
DataWindowChild idwc_clauses //alfee 12.10.2008
DataWindowChild idwc_rev
OleObject iole_word //10.31.2007

Constant long wdFormatDocument = 0 //10.31.2007
string is_sourcefile
String is_sourcefile_org //Added By Ken.Guo 2010-02-04.
string is_clausename_source
n_cst_clause inv_clause //Added By Ken.Guo 2010-01-30.
decimal idec_source_clause_revision //Added By Ken.Guo 2010-01-30.


end variables

forward prototypes
public function string of_get_call_from ()
public subroutine of_adjust_ui ()
public function integer of_prepare_comparison_bak ()
public function integer of_prepare_comparison ()
end prototypes

event ue_postactivate();
//Added By Ken.Guo 2011-11-30. Workaround Office OCX's bug
If isvalid(ole_1 ) Then
	//ole_1.object.activate(true)
	If isvalid(ole_1.object) Then ole_1.object.activate(true)  //(Appeon)Harry 06.30.2014 - Bug 4093
End If
If isvalid(ole_source ) Then
	//ole_source.object.activate(true)
	If isvalid(ole_source.object) Then ole_source.object.activate(true)   //(Appeon)Harry 06.30.2014 - Bug 4093
End If
end event

public function string of_get_call_from ();RETURN is_call_from
end function

public subroutine of_adjust_ui ();st_title.visible = FALSE
st_prompt.visible = FALSE
st_alert.visible = FALSE
cb_next.visible = FALSE
cb_cancel.visible = FALSE
ln_1.visible = FALSE
ln_2.visible = FALSE

gb_clause.visible = TRUE
dw_clause.visible = TRUE
ole_1.visible = TRUE
cb_close.visible = TRUE
gb_source.visible = true
st_source.visible = true


//Modify by jervis 01.13.2010
This.width = 4060
This.Height = 2150
gb_source.x = 20
gb_source.y = 20
st_source.x = gb_source.x + 30
st_source.y = 80


gb_clause.x = 20 
gb_clause.y = 20

dw_clause.x = 40 
dw_clause.y = 80

ole_source.x = gb_clause.x 
ole_source.y = 220
ole_source.width = 2000
ole_source.height = This.height - ole_source.y - 240

ole_1.x = ole_source.x + ole_source.width + 20
ole_1.y = 220
ole_1.width = 2000
ole_1.height = This.height - ole_1.y - 240

st_splitbar.x = ole_source.x + ole_source.width
st_splitbar.y = ole_source.y
st_splitbar.height = ole_source.height

cb_close.x = ole_1.x + ole_1.width - cb_close.width
cb_close.y = ole_1.y + ole_1.height + 20

//Set window resizable
THIS.Title = "Clause Comparison"
THIS.ControlMenu = TRUE
This.Maxbox = TRUE
THIS.Minbox = TRUE
THIS.Resizable = TRUE
THIS.Center = TRUE
this.windowstate = Maximized!
//Register the controls for resize 
//This.of_SetResize(True)
////this.inv_resize.of_register( dw_clause,inv_resize.scaleright)
////this.inv_resize.of_register( gb_clause,inv_resize.scaleright)
//this.inv_resize.of_register( ole_1,inv_resize.scalerightbottom)
//this.inv_resize.of_register( cb_close,inv_resize.scalerightbottom)

//string ls_scale
//
//This.of_SetResize(True)
//This.inv_resize.of_SetOrigSize (This.workspacewidth(),This.workspaceheight())
//ls_scale = this.inv_resize.scale
//this.inv_resize.of_register( ole_1,inv_resize.scalerightbottom)
//This.inv_resize.of_Register (cb_close,ls_scale)

//long ll_i
//string ls_scale
//
//This.of_SetResize(True)
//
//This.inv_resize.of_SetOrigSize (This.workspacewidth(),This.workspaceheight())
//ls_scale = this.inv_resize.scale
//
//For ll_i =  1 To upperbound(This.CONTrol)
//   This.inv_resize.of_Register (This.CONTrol[ll_i],ls_scale)
//Next
//
//dw_clause.of_setresize( TRUE)
//dw_clause.inv_Resize.of_register( "ctx_acp_clause_id", dw_clause.inv_Resize.scalerightbottom )
//


end subroutine

public function integer of_prepare_comparison_bak ();Long i, ll_cnt, ll_clauseid[]
DataWindowChild dwc_clauses

SetReDraw(FALSE)

//Adjust the UI for clauses comparison
of_adjust_ui()

//Get the source clause
il_source_clause = inv_clause_comparison.il_source_clause

//initilize the dddw for target clauses 
ll_cnt = inv_clause_comparison.ids_target_clauses.RowCount()
dw_clause.GetChild("ctx_acp_clause_id", dwc_clauses)
dwc_clauses.InsertRow(0)
dwc_clauses.SetItem(1, "ctx_acp_clause_id", inv_clause_comparison.il_source_clause)
dwc_clauses.SetItem(1, "clause_name", inv_clause_comparison.is_source_clausename)
inv_clause_comparison.ids_target_clauses.RowsCopy(1, ll_cnt, Primary!, dwc_clauses, 2, Primary!)

//Get the modify dates for target clauses
ll_cnt = dwc_clauses.RowCount()
FOR i = 1 TO ll_cnt
	ll_clauseid[i] = dwc_clauses.GetItemNumber(i, "ctx_acp_clause_id")
NEXT	
ids_clauses.Retrieve(ll_clauseid)

dwc_clauses.InsertRow(1)
dw_clause.InsertRow(0)

idwc_clauses = dwc_clauses //Alfee 12.10.2008

SetReDraw(TRUE)

return 1
end function

public function integer of_prepare_comparison ();Long i, ll_cnt,ll_clause_id,ll_row
DataWindowChild ldwc_clauses,ldwc_revision
long ll_found
String ls_clause_name
datetime ldt_lastmodify

SetReDraw(FALSE)

//Adjust the UI for clauses comparison
of_adjust_ui()

If isvalid(inv_clause_comparison.idw_browse) Then
	inv_clause_comparison.idw_browse.dynamic Event ue_hide_tip()
End If

//Get the source clause
il_source_clause = inv_clause_comparison.il_source_clause
is_clausename_source = inv_clause_comparison.is_source_clausename
idec_source_clause_revision = inv_clause_comparison.idec_source_revision
st_source.text = is_clausename_source + " Ver " + string(idec_source_clause_revision) //jervis 01.25.2010

//initilize the dddw for target clauses 
ll_cnt = inv_clause_comparison.ids_target_clauses.RowCount()
dw_clause.GetChild("ctx_acp_clause_id", ldwc_clauses)
dw_clause.GetChild("revision", ldwc_revision)
FOR i = 1 to ll_cnt
	ll_clause_id = inv_clause_comparison.ids_target_clauses.GetItemNumber(i, "ctx_acp_clause_id")
   ls_clause_name = inv_clause_comparison.ids_target_clauses.GetItemString(i, "clause_name")
	IF ldwc_clauses.Find("ctx_acp_clause_id = " + String(ll_clause_id),1, ldwc_clauses.RowCount()) > 0 THEN 
		CONTINUE
	END IF
	ll_row = ldwc_clauses.Insertrow(0)
	ldwc_clauses.SetItem(ll_row, "ctx_acp_clause_id", ll_clause_id)
	ldwc_clauses.SetItem(ll_row, "clause_name", ls_clause_name)	
NEXT
inv_clause_comparison.ids_target_clauses.RowsCopy(1, ll_cnt, Primary!, ldwc_revision, 2, Primary!)

ldwc_clauses.InsertRow(1)
dw_clause.InsertRow(0)

ldwc_revision.SetSort('revision Asc')
ldwc_revision.Sort()

idwc_clauses = ldwc_clauses 

SetReDraw(TRUE)

//Download and display source document
IF not isnull(il_source_clause)  and il_source_clause >= 0  THEN
	If isvalid(inv_clause_comparison.idw_browse) Then
		inv_clause.of_download_file(il_source_clause, idec_source_clause_revision, is_sourcefile)
	Else
		inv_clause.of_download_file(il_source_clause, is_sourcefile)
	End If
	//Begin - Added By Mark Lee 05/29/2013
	IF 	inv_word_utility.of_unprotect_doc_file(is_sourcefile) < 0 Then 
		Messagebox(gnv_app.iapp_object.DisplayName,"You cannot compare  the document("+st_source.text+") ~r~nbecause document protection is in effect.")
		Return 0
	End IF 
	//End - Added By Mark Lee 05/29/2013

	//Open source document
	is_sourcefile_org = gs_dir_path + gs_DefDirName + "\Agreement\" + '_clauses_compare_org_copy.doc'
	FileCopy(is_sourcefile,is_sourcefile_org,True) //Added By Ken.Guo 2010-02-04.
	Try
		Ole_source.object.OpenLocalFile(is_sourcefile_org,true)
		gnv_word_utility.of_modify_word_property( Ole_source.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
	CATCH (Throwable th) 
		IF OLE_1.Object.doctype = 1 THEN OLE_1.Object.Close()
	end try
END IF

//Comparison
if ll_cnt > 0 then 
	dw_Clause.SetItem(1,'ctx_acp_clause_id',inv_clause_comparison.ids_target_clauses.GetItemNumber(1, "ctx_acp_clause_id"))
	dw_Clause.event itemchanged(1, dw_clause.object.ctx_acp_clause_id, String(inv_clause_comparison.ids_target_clauses.GetItemNumber(1, "ctx_acp_clause_id")))
end if


return 1
end function

event open;call super::open;//Initilize variables and datastore

This.visible = False

gnv_reg_ocx.of_check_ocx( 1,'', True) //1: office //Added by Ken.Guo on 2008-11-06

IF IsValid(Message.PowerObjectParm) THEN 
	inv_clause_comparison = Message.PowerObjectParm
END IF

IF IsValid(inv_clause_comparison) THEN is_call_from = inv_clause_comparison.is_call_from

inv_word_utility = Create n_cst_word_utility
inv_clause = Create n_cst_clause
ids_clauses = Create DataStore
ids_clauses.dataobject = 'd_clause_comparison_md'
ids_clauses.SetTransObject(SQLCA)

//Set the 1st step's prompt message
st_title.text = "Select a Source Clause"

//Begin - Modified By Ken.Guo 2010-01-30
//st_prompt.text = "Click the Clause in the left tree view that you want to compare other clauses to (Compare to Clause), then click Next." //03.24.2008
If isvalid(inv_clause_comparison.idw_browse) Then
	st_prompt.text = "Highlight the Clause that you want to compare other Clause to (Compare to Clause), then click Next.~r~n~r~nYou can compare different versions of the same clause OR compare different clauses."
Else
	st_prompt.text = "Click the Clause in the left tree view that you want to compare other clauses to (Compare to Clause), then click Next." 
End If
//End - Modified By Ken.Guo 2010-01-30 


If Not isvalid(inv_clause_comparison.idw_browse ) Then
	dw_clause.Modify("revision.visible = '0' ")
End If
end event

on w_clause_comparison_wizard.create
int iCurrent
call super::create
this.ole_source=create ole_source
this.ole_1=create ole_1
this.st_step=create st_step
this.st_source=create st_source
this.st_splitbar=create st_splitbar
this.st_title=create st_title
this.dw_clause=create dw_clause
this.cb_close=create cb_close
this.st_alert=create st_alert
this.cb_cancel=create cb_cancel
this.cb_next=create cb_next
this.st_prompt=create st_prompt
this.gb_source=create gb_source
this.ln_1=create ln_1
this.ln_2=create ln_2
this.gb_clause=create gb_clause
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_source
this.Control[iCurrent+2]=this.ole_1
this.Control[iCurrent+3]=this.st_step
this.Control[iCurrent+4]=this.st_source
this.Control[iCurrent+5]=this.st_splitbar
this.Control[iCurrent+6]=this.st_title
this.Control[iCurrent+7]=this.dw_clause
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.st_alert
this.Control[iCurrent+10]=this.cb_cancel
this.Control[iCurrent+11]=this.cb_next
this.Control[iCurrent+12]=this.st_prompt
this.Control[iCurrent+13]=this.gb_source
this.Control[iCurrent+14]=this.ln_1
this.Control[iCurrent+15]=this.ln_2
this.Control[iCurrent+16]=this.gb_clause
end on

on w_clause_comparison_wizard.destroy
call super::destroy
destroy(this.ole_source)
destroy(this.ole_1)
destroy(this.st_step)
destroy(this.st_source)
destroy(this.st_splitbar)
destroy(this.st_title)
destroy(this.dw_clause)
destroy(this.cb_close)
destroy(this.st_alert)
destroy(this.cb_cancel)
destroy(this.cb_next)
destroy(this.st_prompt)
destroy(this.gb_source)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.gb_clause)
end on

event close;call super::close;//Close the opened document
ole_1.Object.Close()
ole_source.object.close()

//Reset the comparison variable 
IF IsValid(inv_clause_comparison) THEN 
	inv_clause_comparison.is_step = ''

	//Added By Ken.Guo 2009-05-07	
	inv_clause_comparison.of_ini_info( ) 
	If isvalid(inv_clause_comparison.idw_browse) Then
		inv_clause_comparison.of_clear_dw_flag( )
		inv_clause_comparison.idw_browse.dynamic Event ue_hide_tip() 
	Else
		inv_clause_comparison.of_clear_flag( ) 
	End If
End If

FileDelete(is_sourcefile_org) //Added By Ken.Guo 2010-02-04.

//Destroy instance variables	
IF IsValid(inv_word_utility) THEN Destroy inv_word_utility
IF IsValid(ids_clauses) THEN Destroy ids_clauses
If IsValid(inv_clause) Then Destroy inv_clause

//Quit and destroy word instance for Word 2007 - Alfee 07.24.2008
IF gs_word_version = 'word2007' and IsValid(iole_word) THEN
	iole_word.Quit(0)
	iole_word.DisconnectObject()
	Destroy iole_word
END IF

end event

event resize;call super::resize;//Modify by jervis 01.13.2010
ole_source.width = (This.width - 130) / 2
ole_source.height = This.height - ole_source.y - 260
gb_source.width = ole_source.width
st_source.width = ole_source.width - 70


ole_1.x = ole_source.x + ole_source.width + 20
ole_1.width = ole_source.width 
ole_1.height = ole_source.height
dw_clause.width = ole_1.width - 50
If Not Isvalid(inv_clause_comparison.idw_browse) Then
	dw_clause.Modify("ctx_acp_clause_id.width = " +String(dw_clause.width - 40) )
Else
	dw_clause.Modify("ctx_acp_clause_id.width = " +String(dw_clause.width - 40 - 350) )	
	dw_clause.Modify("revision.x = " + String(dw_clause.width -40 - 350 + 50))
End If


gb_clause.x = ole_1.x
dw_clause.x = gb_clause.x + 20
gb_clause.width = ole_1.width
//dw_clause.width = ole_1.width - 40

st_splitbar.x = ole_source.x + ole_source.width
st_splitbar.height = ole_source.height

cb_close.x = ole_1.x + ole_1.width - cb_close.width
cb_close.y = ole_1.y + ole_1.height + 15
end event

event pfc_postopen;call super::pfc_postopen;This.y = This.y + 200
This.visible = True
end event

event activate;call super::activate;//This.Post Event ue_PostActivate() //Modified By Ken.Guo 08/06/2012
This.Event ue_PostActivate() //(Appeon)Harry 06.30.2014 - Bug 4093

end event

type ole_source from u_email_edit within w_clause_comparison_wizard
integer x = 1733
integer y = 612
integer width = 347
integer height = 264
integer taborder = 30
string binarykey = "w_clause_comparison_wizard.win"
end type

event constructor;call super::constructor;this.object.filesaveas = true
end event

type ole_1 from u_email_edit within w_clause_comparison_wizard
boolean visible = false
integer x = 55
integer y = 616
integer width = 347
integer height = 264
integer taborder = 10
string binarykey = "w_clause_comparison_wizard.win"
integer binaryindex = 1
end type

event constructor;call super::constructor;this.object.filesaveas = true

end event

type st_step from statictext within w_clause_comparison_wizard
integer x = 1019
integer y = 16
integer width = 741
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Step 1 of 2"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_source from statictext within w_clause_comparison_wizard
boolean visible = false
integer x = 1819
integer y = 976
integer width = 1449
integer height = 84
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_splitbar from u_st_splitbar within w_clause_comparison_wizard
integer x = 759
integer y = 620
integer width = 18
integer height = 264
end type

event constructor;call super::constructor;this.of_register( ole_1,this.right )
this.of_register( ole_source, this.left )
end event

type st_title from statictext within w_clause_comparison_wizard
integer x = 14
integer y = 16
integer width = 741
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean focusrectangle = false
end type

type dw_clause from u_dw within w_clause_comparison_wizard
boolean visible = false
integer x = 37
integer y = 976
integer width = 1691
integer height = 96
integer taborder = 10
string dataobject = "d_clause_comparison"
boolean vscrollbar = false
boolean ib_isupdateable = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;Long ll_found
String  ls_targetfile, ls_comparefile,ls_comparefile_copy 
String  ls_clausename_target, ls_title 
DateTime ldt_lastmodify
Decimal ldec_revision,ldec_null
long ll_clause_id

SetPointer(HourGlass!)


ls_title = "Clause Comparison" 
Parent.title = ls_title

IF IsNull(data) THEN 
	ole_1.Object.Close() 
	RETURN
END IF
if not FileExists(is_sourcefile) then Return 

IF Not IsValid(inv_clause_comparison) THEN RETURN

SetNull(ldec_null)

If dwo.name = 'ctx_acp_clause_id' Then
	//close document and clear revision field if document changed
	If isvalid(inv_clause_comparison.idw_browse) Then
		this.SetItem(row, "revision", ldec_null)
		ole_1.Object.Close()
		This.SetColumn('revision') //It will trigger ItemFocusChanged() Event, then trigger ItemChange(row,"Revision",data) event.
		RETURN 		
	End If
End If

If dwo.name = 'revision' Then
	ldec_revision = Dec(data)
	ll_clause_id = This.GetItemNumber(row, "ctx_acp_clause_id")
Else
	ll_clause_id = Long(data)
End If
	
	//********Get target clause file************//
	IF IsValid(inv_word_utility) THEN 
		If isvalid(inv_clause_comparison.idw_browse) Then
			inv_clause.of_download_file(ll_clause_id,ldec_revision,ls_targetfile)
		Else
			inv_clause.of_download_file(ll_clause_id,ls_targetfile)
		End If
		//Begin - Added By Mark Lee 05/29/2013
		IF 	inv_word_utility.of_unprotect_doc_file(ls_targetfile) < 0 Then 
			//Generate and set windows title 
			ll_found = idwc_clauses.Find("ctx_acp_clause_id = " + String(ll_clause_id), 1, idwc_clauses.rowcount())
			IF ll_found > 0 THEN ls_clausename_target = idwc_clauses.GetItemString(ll_found, "clause_name")
			Messagebox(gnv_app.iapp_object.DisplayName,"You cannot compare  the document("+ls_clausename_target+") ~r~nbecause document protection is in effect.")
			Return 
		End IF 
		//End - Added By Mark Lee 05/29/2013	
	END IF	
	
	//Comments by jervis 01.25.2010
	/*
	//Get Source File
	IF Long(data) <> il_source_clause and il_source_clause > 0  THEN
		//Get last modify date for the source clause
		ll_found = ids_clauses.Find("ctx_acp_clause_id = " + String(il_source_clause), 1, ids_clauses.RowCount())	
		IF ll_found > 0 THEN ldt_lastmodify = ids_clauses.GetItemDateTime(ll_found, "modify_date")
		//Get the selected clause's file 
		IF IsValid(inv_word_utility) THEN 
			ls_sourcefile = inv_word_utility.of_get_clause_file(il_source_clause, ldt_lastmodify)
		END IF		
	END IF
	*/
	
	TRY //Alfee 01.17.2008
	//-------Begin Modified by Alfee 10.31.2007 -----------------------
	//<$Reason>Word 2007 doesn't support compare funcation under OLE mode
	//********Compare Clause Files *************//
	ls_comparefile = gs_dir_path + gs_DefDirName + "\Agreement\" + '_clauses_compare.doc'
	ls_comparefile_copy = gs_dir_path + gs_DefDirName + "\Agreement\" + '_clauses_compare_copy.doc'
	//Copy target file to a temporary compare file 
	IF FileExists(ls_targetfile) and FileCopy(ls_targetfile, ls_comparefile, TRUE) <> 1 THEN 
		MessageBox("Clause Comparison","Please make sure the file of '" + ls_comparefile + "' can be deleted!" )
		RETURN
	END IF
	ole_1.Object.Close() //(Appeon)Stephen 2013-06-18 - IntelliContracts Compare function not working properly
	
	//IF FileCopy(ls_targetfile, ls_comparefile_copy, TRUE) <> 1 THEN
	IF FileCopy(is_sourcefile, ls_comparefile_copy, TRUE) <> 1 THEN //Alfee 07.24.2008
		MessageBox("Clause Comparison","Please make sure the file of '" + ls_comparefile_copy + "' can be deleted!" )
		RETURN 
	END IF
	
	//Added By Ken.Guo 2010-02-04. Accept ALL changes for two file 
	n_cst_ovole_utils lnv_ole_utils_doc
	lnv_ole_utils_doc = Create n_cst_ovole_utils
	lnv_ole_utils_doc.of_acceptall(ls_comparefile)		
	lnv_ole_utils_doc.of_acceptall(ls_comparefile_copy)	
	Destroy lnv_ole_utils_doc	
	
	IF Len(ls_comparefile) > 0 and FileExists(ls_comparefile) THEN
		//IF Len(ls_sourcefile) > 0 and FileExists(ls_sourcefile) THEN
			//Compare and saveas the document under a new Word2007 application
			IF gs_word_version = 'word2007' THEN
				IF NOT IsValid(iole_word) THEN
					iole_word = Create OleObject
					IF iole_word.Connecttonewobject("word.application") <> 0 THEN
						Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
						Destroy iole_word					
						RETURN 
					END IF
				END IF

				iole_word.Visible = FALSE
				iole_word.Application.NormalTemplate.Saved = TRUE  //Alfee 01.17.2008
				iole_word.Application.Documents.Open(ls_comparefile_copy, False, True) 	
				gnv_word_utility.of_modify_word_property( iole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
				gnv_shell.of_delete_recent( ls_comparefile_copy, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
				//iole_word.ActiveDocument.Compare(ls_sourcefile, "External", 1, True, True, False)
				iole_word.ActiveDocument.Compare(ls_targetfile, "External", 1, True, True, False) //Alfee 07.24.2008
				gnv_shell.of_delete_recent( ls_targetfile, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
				iole_word.ActiveDocument.SaveAs(ls_comparefile, wdFormatDocument,false,'',false)
				gnv_shell.of_delete_recent( ls_comparefile, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
				iole_word.ActiveDocument.Close(0)
			END IF	
			//Open the file to be compared
			OLE_1.Object.OpenLocalFile(ls_comparefile, TRUE) 		
			gnv_word_utility.of_modify_word_property( OLE_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
			//Compare with the source document if under non Word 2007 environment
			IF gs_word_version <> 'word2007' THEN 
				IF gs_word_version = 'word2003' or gs_word_version = 'wordxp' THEN
					ole_1.object.ActiveDocument.Compare(ls_comparefile_copy, "External", 1, True, True, False )
				ELSE
					ole_1.object.ActiveDocument.Compare(ls_comparefile_copy)
				END IF
			END IF	
			gnv_shell.of_delete_recent( ls_comparefile_copy, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
			
			//Open source file - jervis 01.13.2010
			//ole_source.object.OpenLocalFile(ls_sourcefile,true)
		/*
		ELSE
			OLE_1.Object.OpenLocalFile(ls_comparefile, TRUE)
			OLE_source.Object.OpenLocalFile(ls_comparefile, TRUE)	//Jervis 01.13.2010
		END IF
		*/
	END IF
	
	//Generate and set windows title - alfee 12.10.2008
	ll_found = idwc_clauses.Find("ctx_acp_clause_id = " + String(ll_clause_id), 1, idwc_clauses.rowcount())
	IF ll_found > 0 THEN ls_clausename_target = idwc_clauses.GetItemString(ll_found, "clause_name")

	ls_title += " - [ " + ls_clausename_target  
	IF Long(data) <> il_source_clause THEN ls_title += " vs. " + is_clausename_source 
	ls_title += " ]" 
	Parent.title = ls_title
	
	CATCH (Throwable th) //Alfee 01.17.2008
		IF OLE_1.Object.doctype = 1 THEN OLE_1.Object.Close()
		if ole_source.object.doctype = 1 then ole_source.object.close()
		f_word_destroy(iole_word, "")
	END TRY
	
	/*
	IF Len(ls_targetfile) > 0 and FileExists(ls_targetfile) THEN
		OLE_1.Object.OpenLocalFile(ls_targetfile, TRUE) 
		IF Len(ls_sourcefile) > 0 and FileExists(ls_sourcefile) THEN
			IF gs_word_version = 'word2003' or gs_word_version = 'wordxp' THEN
				ole_1.object.ActiveDocument.Compare(ls_sourcefile, "External", 1, True, True, False )
			ELSE
				ole_1.object.ActiveDocument.Compare(ls_sourcefile)
			END IF
		END IF
	END IF 
	*/
	//-------End Modified ------------------------------------------------


end event

event constructor;call super::constructor;//alfee 12.10.2008

This.GetChild("ctx_acp_clause_id", idwc_clauses)
This.GetChild("revision", idwc_rev)

idwc_clauses.SetTransObject(SQLCA)
idwc_rev.SetTransObject(SQLCA)
end event

event itemfocuschanged;call super::itemfocuschanged;//Set DDDW of Revision Field  
long ll_clause_id

SetPointer(HourGlass!)

IF Lower(dwo.Name) <> 'revision' THEN RETURN

//Reset dddw of revision field if no document selected
ll_clause_id = This.GetItemNumber(row, "ctx_acp_clause_id")
IF IsNull(ll_clause_id) OR (NOT ll_clause_id > 0) THEN 
	idwc_rev.SetFilter("IsNull(ctx_acp_clause_id)")
	idwc_rev.Filter()
	il_last_clause_id = ll_clause_id //Set last doc id
	RETURN
END IF

//Do nothing if document not changed
IF ll_clause_id = il_last_clause_id THEN return
	
//Refersh dddw of revision field if document changed
idwc_rev.SetFilter("ctx_acp_clause_id = " + String(ll_clause_id))
idwc_rev.Filter()
il_last_clause_id = ll_clause_id  //Set last doc id

//Comparison - jervis 01.23.2010
if idwc_rev.Rowcount( ) > 0 then
	this.SetItem( row,'revision',idwc_rev.getitemdecimal( 1, 'revision') )
	this.event itemchanged(row,this.object.revision, string(idwc_rev.getitemnumber( 1, 'revision')))
end if







end event

type cb_close from commandbutton within w_clause_comparison_wizard
boolean visible = false
integer x = 1179
integer y = 716
integer width = 343
integer height = 92
integer taborder = 30
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

type st_alert from statictext within w_clause_comparison_wizard
integer x = 73
integer y = 476
integer width = 1687
integer height = 104
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_clause_comparison_wizard
integer x = 933
integer y = 616
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;Close(Parent)
end event

type cb_next from commandbutton within w_clause_comparison_wizard
integer x = 590
integer y = 616
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Next"
end type

event clicked;
IF Not IsValid(inv_clause_comparison) THEN RETURN 

//First Step - Select source clause
IF inv_clause_comparison.is_step = 'source' THEN
	IF NOT inv_clause_comparison.il_source_clause > 0 THEN
		Beep(1)
		st_alert.text = "Please select a Clause (Compare to Clause) first!"
	ELSE
		st_title.text = "Select Target Clause(s) "
		st_step.text = "Step 2 of 2"
		
		//Begin - Modified By Ken.Guo 2010-01-30
		//st_prompt.Text = "Click the Clause(s) in the left tree view that you want to compare against the Compare to Clause then click Next" //03.24.2008
		If isvalid(inv_clause_comparison.idw_browse) Then
			st_prompt.Text = "Highlight the Clause(s) that you want to compare against the Compare to Clause then click Next" 
		Else
			st_prompt.Text = "Click the Clause(s) in the left tree view that you want to compare against the Compare to Clause then click Next" 
		End If
		//End - Modified By Ken.Guo 2010-01-30
		
		inv_clause_comparison.is_step = 'target'
		st_alert.text = ""
	END IF
//Second Step - Select targe clause(s)
ELSEIF inv_clause_comparison.is_step = 'target'THEN
	IF NOT inv_clause_comparison.ids_target_clauses.RowCount() > 0 THEN
		Beep(1)
		
		//Begin - Modified By Ken.Guo 2010-01-30
		//st_alert.text = "Please select the Clause(s) in the left tree view that you want to compare against the Compare to Clause first!"  //03.24.2008
		If isvalid(inv_clause_comparison.idw_browse) Then
			st_alert.text = "Please select the Clause(s) that you want to compare against the Compare to Clause first!" 
		Else
			st_alert.text = "Please select the Clause(s) in the left tree view that you want to compare against the Compare to Clause first!"  //03.24.2008
		End If
		//End - Modified By Ken.Guo 2010-01-30
		
	ELSE
		inv_clause_comparison.is_step = 'compare'
		st_alert.text = ""
		st_title.text = ""
		st_step.text = ""
		//Prepare for the comparison
		of_prepare_comparison()		
	END IF
END IF	


end event

type st_prompt from statictext within w_clause_comparison_wizard
integer x = 73
integer y = 144
integer width = 1687
integer height = 308
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_source from groupbox within w_clause_comparison_wizard
boolean visible = false
integer x = 1778
integer y = 916
integer width = 1559
integer height = 176
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Clause To Compare Against"
end type

type ln_1 from line within w_clause_comparison_wizard
long linecolor = 134217746
integer linethickness = 5
integer beginy = 588
integer endx = 2002
integer endy = 588
end type

type ln_2 from line within w_clause_comparison_wizard
long linecolor = 134217746
integer linethickness = 5
integer beginy = 84
integer endx = 2002
integer endy = 84
end type

type gb_clause from groupbox within w_clause_comparison_wizard
boolean visible = false
integer x = 18
integer y = 916
integer width = 1746
integer height = 176
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Compare To Clause"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
04w_clause_comparison_wizard.bin 
2600000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000098a2eed001d1312900000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000098a2eed001d1312998a2eed001d131290000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd000007db000006d200dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd000007db000006d200dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Bfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000098a2eed001d1312900000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000098a2eed001d1312998a2eed001d131290000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd000007db000006d200dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff
2D000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd000007db000006d200dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14w_clause_comparison_wizard.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
