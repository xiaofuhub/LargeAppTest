$PBExportHeader$w_dm_email_browse.srw
forward
global type w_dm_email_browse from w_popup
end type
type cb_1 from commandbutton within w_dm_email_browse
end type
type cb_2 from commandbutton within w_dm_email_browse
end type
type cb_3 from commandbutton within w_dm_email_browse
end type
type uo_1 from u_tabpg_dm_email within w_dm_email_browse
end type
end forward

global type w_dm_email_browse from w_popup
integer width = 3753
integer height = 2112
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean toolbarvisible = false
boolean ib_isupdateable = false
event ue_postactivate ( )
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
uo_1 uo_1
end type
global w_dm_email_browse w_dm_email_browse

type variables
String is_filter,is_doc_ext
String is_path
Long il_doc_id
Decimal idc_revision
Boolean ib_retrieving
boolean ib_retrieved 

n_cst_filesrvwin32 inv_filesrv 

Datastore ids_docname
DataStore ids_expid

n_cst_ovole_utils inv_ole_utils_doc

end variables

forward prototypes
public function integer of_filegenerate (boolean ab_all, ref long al_doc_id[], ref string as_pathname[], ref string as_filename[])
public subroutine of_check_doc (integer ai_ctx_id, long al_doc_id[], string as_filename[])
end prototypes

event ue_postactivate();
//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
cpu()
If gs_imageview_version = '5.0' and isvalid(This.uo_1.tab_1.tabpage_preview.ole_doc ) Then
	This.uo_1.tab_1.tabpage_preview.ole_doc.object.activate(true)
End If
end event

public function integer of_filegenerate (boolean ab_all, ref long al_doc_id[], ref string as_pathname[], ref string as_filename[]);//////////////////////////////////////////////////////////////////// //
// $<function>of_filegenerate()
// $<arguments>
//		value	boolean 	ab_all  :	 Indicator of all or selected records
//		ref	long	al_doc_id[] :  Document ids
//		ref	string	as_pathname[] : File names with full path
//		ref	string	as_filename[] : File names
// $<returns> integer: Count of seleted records
// $<description> Get files from DB according to selected documnents 
//////////////////////////////////////////////////////////////////////
// $<add> 03.19.2007 by Alfee
//////////////////////////////////////////////////////////////////////
Long i, j, ll_count, ll_found, ll_doc_id[]
Long li_ctx_id
Decimal ldc_revision[]
String ls_fullname[]

j = 0
ll_count = uo_1.tab_1.tabpage_browse.dw_browse.RowCount()
IF ll_count < 1 THEN RETURN 0

//Get all selected document revison records
FOR i = 1 TO ll_count
	IF NOT ab_all AND uo_1.tab_1.tabpage_browse.dw_browse.GetItemNumber(i,"select_flag") <> 1 THEN 
		CONTINUE
	END IF
	j ++	
	ll_doc_id[j] = uo_1.tab_1.tabpage_browse.dw_browse.GetItemNumber(i, "doc_id" )
	ldc_revision[j] = uo_1.tab_1.tabpage_browse.dw_browse.GetItemDecimal(i, "revision" )		
NEXT

if j <= 0 then Return 0				//Added by Scofield on 2008-05-26

Openwithparm( w_appeon_gifofwait, "Getting selected document(s)..." )
//Get files from DB and return the full name
//uo_1.inv_dm_utils.of_download_multi_files(ll_doc_id, ldc_revision, ls_fullname) //08.29.2007
IF uo_1.inv_dm_utils.of_download_multi_files(ll_doc_id, ldc_revision, ls_fullname) = -1 THEN
	MessageBox("Download File","Download file(s) failed!")
	RETURN 0
END IF

//Copy files according to the specified filename properties
//Remark: file name can include: \ / : * ? " < > | 

//Get file names according the doc_name properties
ll_count = ids_docname.Retrieve(ll_doc_id)
If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
IF ll_count < 0 THEN
	IF IsValid(w_appeon_gifofwait) THEN CLOSE(w_appeon_gifofwait)
	RETURN 0
END IF
FOR i = 1 to j
	ll_found = ids_docname.Find("doc_id = " + String(ll_doc_id[i]), 1, ll_count)
	IF ll_found > 0 THEN
		//as_pathname[i] = is_path + ids_docname.GetItemString(ll_found, "doc_name") + "." + ids_docname.GetItemString(ll_found, "doc_ext") 
		as_pathname[i] = is_path + gf_merge_file_name(ids_docname.GetItemString(ll_found, "doc_name"),ids_docname.GetItemString(ll_found, "doc_ext") ,ll_doc_id[i],ldc_revision[i])
	ELSE
		as_pathname[i] = ""
	END IF
NEXT

//Get all selected documents' id, file name and full name		
If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
FOR i = 1 to j
	IF Not IsNull(ls_fullname[i]) and Len(Trim(ls_fullname[i])) > 0 THEN 
		IF as_pathname[i] <> "" THEN 
			FileCopy(ls_fullname[i],as_pathname[i],TRUE)
		ELSE
			as_pathname[i] = ls_fullname[i]
		END IF
	END IF
	al_doc_id[i] = ll_doc_id[i]	
	as_filename[i] = Mid(as_pathname[i], LastPos(as_pathname[i],"\") + 1)
NEXT

// Check auto numbering & merge fields
If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()

//Commented By Ken.Guo 2009-06-19
//IF IsValid(gw_contract) THEN 
//	li_ctx_id = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_contract_details.of_get_ctx_id( )		
//END IF	
li_ctx_id = uo_1.il_ctx_id //Added By Ken.Guo 2009-06-19.

IF NOT IsNull(li_ctx_id) and li_ctx_id > 0 THEN 
	of_check_doc(li_ctx_id,al_doc_id, as_pathname)
END IF

IF IsValid(w_appeon_gifofwait) THEN CLOSE(w_appeon_gifofwait)

RETURN j;
end function

public subroutine of_check_doc (integer ai_ctx_id, long al_doc_id[], string as_filename[]);//////////////////////////////////////////////////////////////////// //
// $<function>of_check_doc()
// $<arguments>
//		value	integer	ai_ctx_id[] 
//		value	long	al_doc_id[]
//		value	string	as_filename[]
// $<returns> (None)
// $<description> Check auto numbering and merging data 
//////////////////////////////////////////////////////////////////////
// $<add> 03.20.2007 by Alfee
//////////////////////////////////////////////////////////////////////
Long ll_doc_id[], ll_export_id[]
Long i, j, ll_cnt, ll_found
String ls_filename[]

ll_cnt = UpperBound(al_doc_id)
IF ll_cnt < 1 THEN RETURN

//Filter to get Word file records
j = 1
FOR i = 1 to ll_cnt
	IF NOT IsNull(as_filename[i]) and Len(Trim(as_filename[i])) > 0 THEN
		IF Lower(Right(Trim(as_filename[i]),3)) = 'doc' THEN
			ll_doc_id[j] = al_doc_id[i]
			ls_filename[j] = as_filename[i]	
			j ++ ;
		END IF
	END IF		
NEXT
IF UpperBound(ll_doc_id) < 1 THEN RETURN 

//Get export ids according to document
If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
ll_cnt = ids_expid.Retrieve(ll_doc_id) 
IF ll_cnt < 1 THEN RETURN
FOR i = 1 to UpperBound(ll_doc_id)
	ll_found = ids_expid.Find("doc_id = " +String(ll_doc_id[i]), 1, ll_cnt)
	IF ll_found <> 0 THEN 
		ll_export_id[i] = ids_expid.GetItemNumber(ll_found,"export_id")
	ELSE
		ll_export_id[i] = 0
	END IF
NEXT
	
//Merging data on word documents
If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
//inv_ole_utils_doc.of_check_doc(ai_ctx_id, ll_doc_id, ll_export_id, as_filename)
inv_ole_utils_doc.of_check_doc(ai_ctx_id, ll_doc_id, ll_export_id, ls_filename) //Alfee 05.14.2007

end subroutine

on w_dm_email_browse.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.uo_1
end on

on w_dm_email_browse.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.uo_1)
end on

event open;call super::open;If isvalid(gw_contract) Then
	uo_1.inv_contract_details = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_contract_details
	uo_1.of_set_default() //Added By Ken.Guo 2009-06-19.
	//inv_ole_utils_doc = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_ole_utils_doc
End If	
inv_filesrv = Create n_cst_filesrvwin32
inv_ole_utils_doc = Create n_cst_ovole_utils //adde by alfee 04.26.2007

ids_docname = Create DataStore
ids_docname.DataObject = 'd_dm_doc_name'
ids_docname.SetTransObject(SQLCA)

ids_expid = Create DataStore
ids_expid.DataObject = 'd_dm_doc_expid'
ids_expid.SetTransObject(SQLCA)

uo_1.tab_1.tabpage_browse.dw_browse.event pfc_retrieve()

is_path = gs_dir_path + gs_DefDirName + "\Agreement\Manager\"
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.05.2007 By: Jack
//$<reason> Fix a defect.
string ls_company_name
Select facility_name into :ls_company_name from app_facility where facility_id = :gl_Company_id;
this.title = ls_company_name + ' - Select Document' 
//---------------------------- APPEON END ----------------------------




end event

event close;call super::close;IF uo_1.tab_1.tabpage_preview.ole_doc.object.doctype = 1 THEN // Alfee 05.13.2008
	uo_1.tab_1.tabpage_preview.ole_doc.object.Close()
END IF	

Destroy inv_filesrv
Destroy ids_docname
Destroy ids_expid
Destroy inv_ole_utils_doc //added by alfee 04.26.2007
end event

event activate;call super::activate;//
////Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
//If gs_imageview_version = '5.0' and isvalid(This.uo_1.tab_1.tabpage_preview.ole_doc ) Then
//	This.uo_1.tab_1.tabpage_preview.ole_doc.object.activate(true)
//End If

//This.Post Event ue_postactivate()
end event

event deactivate;call super::deactivate;//
////Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
//If gs_imageview_version = '5.0' and isvalid(This.uo_1.tab_1.tabpage_preview.ole_doc ) Then
//	This.uo_1.tab_1.tabpage_preview.ole_doc.object.activate(false)
//End If
end event

type cb_1 from commandbutton within w_dm_email_browse
integer x = 3392
integer y = 1892
integer width = 343
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;str_doc_search lstr_return


lstr_return.l_count = 0
closewithreturn(parent,lstr_return)
end event

type cb_2 from commandbutton within w_dm_email_browse
integer x = 3049
integer y = 1892
integer width = 343
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select"
boolean default = true
end type

event clicked;string ls_pathname[],ls_filename[]
string ls_return
str_doc_search lstr_return
n_cst_string lnv_string

lstr_return.l_count = of_filegenerate(false,lstr_return.doc_id,lstr_return.s_pathname,lstr_return.s_filename) 
closewithreturn(parent,lstr_return)
end event

type cb_3 from commandbutton within w_dm_email_browse
integer x = 2706
integer y = 1892
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &All"
end type

event clicked;string ls_pathname[],ls_filename[]
string ls_return
str_doc_search lstr_return
n_cst_string lnv_string

lstr_return.l_count = of_filegenerate(true,lstr_return.doc_id,lstr_return.s_pathname,lstr_return.s_filename) 
closewithreturn(parent,lstr_return)
end event

type uo_1 from u_tabpg_dm_email within w_dm_email_browse
event destroy ( )
integer width = 3785
integer height = 2032
integer taborder = 31
end type

on uo_1.destroy
call u_tabpg_dm_email::destroy
end on

