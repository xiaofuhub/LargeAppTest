$PBExportHeader$w_agreement_doc_search.srw
forward
global type w_agreement_doc_search from w_sheet_ctx_doc_painter
end type
type cb_1 from commandbutton within w_agreement_doc_search
end type
type cb_2 from commandbutton within w_agreement_doc_search
end type
type cb_3 from commandbutton within w_agreement_doc_search
end type
end forward

global type w_agreement_doc_search from w_sheet_ctx_doc_painter
integer width = 3995
integer height = 2124
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
windowstate windowstate = normal!
long backcolor = 33551856
long il_handle_rightclicked = 53380412
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_agreement_doc_search w_agreement_doc_search

forward prototypes
public function integer of_filegenerate (boolean ab_all, ref string as_pathname[], ref string as_filename[])
end prototypes

public function integer of_filegenerate (boolean ab_all, ref string as_pathname[], ref string as_filename[]);integer li_FileNo, li_Writes, li_Cnt, li_return, li_loops
long ll_i, ll_doc_id, ll_length, ll_start,ll_count,ll_j
long ll_BlobLen, ll_CurrentPos
string ls_type, ls_lastopen, ls_fullname,ls_name ,ls_to_open, ls_now
datetime ldt_lastmodify
blob lblb_Data, lblb_doc

ll_count = tab_1.tabpage_browse.dw_browse.RowCount()
openwithparm( w_appeon_gifofwait, "Opening selected document..." )

//--------Begin Modified by Alfee 05.18.2007-----------
IF Not DirectoryExists( gs_dir_path + gs_DefDirName + "\Agreement\" ) THEN
	CreateDirectory( gs_dir_path + gs_DefDirName + "\Agreement\" )
END IF
//--------End Modified----------------------------------
	
for ll_i = 1 to ll_count
	if not ab_all and tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_i,"select_flag") <> 1 then continue
		
	ls_type = tab_1.tabpage_browse.dw_browse.GetItemString( ll_i, "document_type" )
	ll_doc_id = tab_1.tabpage_browse.dw_browse.GetItemNumber( ll_i, "ctx_acp_document_id" )
	ldt_lastmodify = tab_1.tabpage_browse.dw_browse.GetItemDatetime( ll_i, "modify_date" )
	//ls_now = String( Today() , "yyyy-mm-dd hh:mm:ss" ) //by alfee 05.10.2007
	
	ls_name = tab_1.tabpage_browse.dw_browse.GetItemString(ll_i,"document_name") + "." + ls_type
	ls_fullname = gs_dir_path + gs_DefDirName + "\Agreement\" + ls_name //by alfee 05.18.2007
	//Modified By Mark Lee 04/18/12
//	li_return = gnv_appeondll.of_Registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'Document-' + string( ll_doc_id ), regstring!, ls_lastopen)
	li_return = gnv_appeondll.of_Registryget("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Agreement", 'Document-' + string( ll_doc_id ), regstring!, ls_lastopen)
	
	//-------Begin Modified by Alfee 05.10.2007---------------	
	//IF li_return = -1 or ls_lastopen = "" THEN
	//		gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'Document-'+string( ll_doc_id), regstring!, ls_now )
	//ELSEIF string( ldt_lastmodify, "yyyy-mm-dd hh:mm:ss" ) <= ls_lastopen THEN
	IF string( ldt_lastmodify, "mm/dd/yyyy hh:mm:ss" ) = ls_lastopen THEN		
	//-------End Modified-------------------------------------
		IF fileexists( ls_fullname ) THEN 
			ll_j++
			as_filename[ll_j] = ls_name
			as_pathname[ll_j] = ls_fullname
			continue
		end if
	ELSE
		//-------Begin Modified by Alfee 05.10.2007---------------		
		//Modified By Mark Lee 04/18/12
//		gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'Document-'+string( ll_doc_id), regstring!, string( ldt_lastmodify, "mm/dd/yyyy hh:mm:ss" ))
		gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Agreement", 'Document-'+string( ll_doc_id), regstring!, string( ldt_lastmodify, "mm/dd/yyyy hh:mm:ss" ))
		//gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'Document-'+string( ll_doc_id), regstring!, ls_now )
		//-------End Modified-------------------------------------		
	End If
	
	SELECT DataLength( image_file )
	INTO :ll_length
	FROM ctx_acp_document
	WHERE ctx_acp_document_id = :ll_doc_id;
	
	IF ll_length > 0 THEN
		IF gs_dbtype = "SQL" and appeongetclienttype() = "PB" and ll_length > 8000 THEN
			li_loops = ( ll_length / 8000 ) + 1
	
			For li_Cnt = 1 To li_loops				
				ll_start = (li_Cnt - 1) * 8000 + 1
				
				SELECTBLOB substring( image_file, :ll_start, 8000 ) 
				INTO :lblb_data 
				FROM ctx_acp_document WHERE ctx_acp_document_id = :ll_doc_id; 
				
				IF SQLCA.SQLCode <> 0 THEN
					//Messagebox( "IntelliSoft", "Read file data from database failed." )
   				Messagebox( "IntelliSoft", "Failed to read file data from database." )
					continue
				END IF
				lblb_doc += lblb_data
			Next 
		ELSE
			SELECTBLOB image_file 
			INTO :lblb_doc 
			FROM ctx_acp_document
			WHERE ctx_acp_document_id = :ll_doc_id;
	
			IF SQLCA.SQLCode <> 0 THEN
				//Messagebox( "IntelliSoft", "Read file data from database failed." )
   			Messagebox( "IntelliSoft", "Failed to read file data from database." )
				continue
			END IF
		END IF
			
		IF fileexists( ls_fullname ) THEN
			FileDelete( ls_fullname );
		END IF
		
		li_FileNo = FileOpen( ls_fullname, StreamMode!, Write!, LockReadWrite!, Append!)
		If li_FileNo < 0 Then
			//Messagebox( "IntelliSoft", "Create temporary file failed." )
   		Messagebox( "IntelliSoft", "Failed to create temporary file." )
			continue
		End If
		
		ll_BlobLen = Len(lblb_doc)
		
		If ll_BlobLen > 32765 Then
			If Mod(ll_BlobLen, 32765) = 0 Then
				li_Writes = ll_BlobLen / 32765
			Else
				li_Writes = (ll_BlobLen / 32765) + 1
			End if
		Else
			li_Writes = 1
		End if
		
		ll_CurrentPos = 1
		For li_Cnt = 1 To li_Writes
			lblb_Data = BlobMid(lblb_doc, ll_CurrentPos, 32765)
			ll_CurrentPos += 32765
			If FileWrite(li_FileNo, lblb_Data) = -1 Then
				//Messagebox( "IntelliSoft", "Write temporary file failed." )
   			Messagebox( "IntelliSoft", "Failed to write temporary file." )
				continue
			End if
		Next
		
		FileClose(li_FileNo)
		ll_j++
		as_filename[ll_j] = ls_name
		as_pathname[ll_j] = ls_fullname
	ELSE
		Messagebox( "IntelliSoft", "Attached file not stored in database." )
		continue
	END IF
next

if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
Return ll_j;
end function

on w_agreement_doc_search.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
end on

on w_agreement_doc_search.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event activate;//Over
end event

event resize;tab_1.x = 15
tab_1.y = 0
tab_1.width = newwidth - 30
tab_1.height = newheight - 138

tab_1.tabpage_browse.tv_category.height = newheight - tab_1.tabpage_browse.tv_category.y - 138*2
tab_1.tabpage_browse.gb_1.width = newwidth - tab_1.tabpage_browse.gb_1.x - 65

tab_1.tabpage_browse.st_split_bar.x = tab_1.tabpage_browse.tv_category.x + tab_1.tabpage_browse.tv_category.width
tab_1.tabpage_browse.st_split_bar.y = tab_1.tabpage_browse.tv_category.y
tab_1.tabpage_browse.st_split_bar.height = tab_1.tabpage_browse.tv_category.height

tab_1.tabpage_browse.dw_browse.x = tab_1.tabpage_browse.st_split_bar.x + tab_1.tabpage_browse.st_split_bar.width
tab_1.tabpage_browse.dw_browse.y = tab_1.tabpage_browse.tv_category.y
tab_1.tabpage_browse.dw_browse.width = tab_1.width - tab_1.tabpage_browse.dw_browse.x - 65
tab_1.tabpage_browse.dw_browse.height = tab_1.tabpage_browse.tv_category.height
//---------Begin Modified by (Appeon)Toney 09.05.2013 for V141 ISG-CLX--------
//$Reason:Fix Reintegration BugH082302
  /*
tab_1.tabpage_document.ole_word.width = tab_1.width - 70
tab_1.tabpage_document.ole_word.height = newheight - 138*2      
  */
//---------End Modfiied ------------------------------------------------------------------


//-----------------Begin Modified by Alfee om 05.19.2008----------------------------
//tab_1.tabpage_document.uo_1.x = tab_1.tabpage_document.ole_word.x
//tab_1.tabpage_document.uo_1.y = tab_1.tabpage_document.ole_word.y
//tab_1.tabpage_document.uo_1.width = tab_1.tabpage_document.ole_word.width
//tab_1.tabpage_document.uo_1.height = tab_1.tabpage_document.ole_word.height
tab_1.tabpage_document.uo_2.x = tab_1.tabpage_document.ole_word.x
tab_1.tabpage_document.uo_2.y = tab_1.tabpage_document.ole_word.y
tab_1.tabpage_document.uo_2.width = tab_1.tabpage_document.ole_word.width
tab_1.tabpage_document.uo_2.height = tab_1.tabpage_document.ole_word.height
/* tab_1.tabpage_document.ole_tif_edit.x = tab_1.tabpage_document.ole_word.x
tab_1.tabpage_document.ole_tif_edit.y = tab_1.tabpage_document.ole_word.y
tab_1.tabpage_document.ole_tif_edit.width = tab_1.tabpage_document.ole_word.width
tab_1.tabpage_document.ole_tif_edit.height = tab_1.tabpage_document.ole_word.height */
//------------------End Modified ------------------------------------------------------


end event

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-16 By: Rodger Wu (doc painter)
//$<reason> This window is designed by Rodger Wu for Contract Logix
//$<reason> Document Painter.
//---------------------------- APPEON END ----------------------------

//Commented and changed to extend ancestor script by alfee 06.12.2007
/*tab_1.tabpage_browse.dw_browse.settransobject( SQLCA )
is_syntax = tab_1.tabpage_browse.dw_browse.Describe( "datawindow.table.select" )

of_build_tree()
ib_disableclosequery = True

if gs_dbtype = "SQL" and gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' then//Full Text Search;
	tab_1.tabpage_browse.dw_search.modify( "document_name_t.text='Full Text Search'" )
end if*/



end event

type st_msg from w_sheet_ctx_doc_painter`st_msg within w_agreement_doc_search
end type

type tab_1 from w_sheet_ctx_doc_painter`tab_1 within w_agreement_doc_search
integer height = 1904
long backcolor = 33551856
end type

type tabpage_browse from w_sheet_ctx_doc_painter`tabpage_browse within tab_1
integer height = 1776
long backcolor = 33551856
end type

type st_split_bar from w_sheet_ctx_doc_painter`st_split_bar within tabpage_browse
end type

type dw_browse from w_sheet_ctx_doc_painter`dw_browse within tabpage_browse
string dataobject = "d_ctx_document_search"
end type

type gb_1 from w_sheet_ctx_doc_painter`gb_1 within tabpage_browse
long backcolor = 33551856
end type

type dw_search from w_sheet_ctx_doc_painter`dw_search within tabpage_browse
end type

type pb_clear from w_sheet_ctx_doc_painter`pb_clear within tabpage_browse
end type

type pb_search from w_sheet_ctx_doc_painter`pb_search within tabpage_browse
integer x = 3333
end type

type tv_category from w_sheet_ctx_doc_painter`tv_category within tabpage_browse
end type

type cb_go from w_sheet_ctx_doc_painter`cb_go within tabpage_browse
integer x = 3328
integer width = 274
end type

type cb_clear from w_sheet_ctx_doc_painter`cb_clear within tabpage_browse
integer x = 3607
integer width = 274
end type

type tabpage_document from w_sheet_ctx_doc_painter`tabpage_document within tab_1
integer height = 1776
long backcolor = 33551856
end type

type ole_word from w_sheet_ctx_doc_painter`ole_word within tabpage_document
integer x = 0
integer y = 8
integer width = 3936
integer height = 1772
end type

type uo_2 from w_sheet_ctx_doc_painter`uo_2 within tabpage_document
end type

type cb_1 from commandbutton within w_agreement_doc_search
integer x = 3621
integer y = 1928
integer width = 343
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;str_doc_search lstr_return


lstr_return.l_count = 0
closewithreturn(parent,lstr_return)
end event

type cb_2 from commandbutton within w_agreement_doc_search
integer x = 3255
integer y = 1928
integer width = 343
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Selected"
end type

event clicked;string ls_pathname[],ls_filename[]
string ls_return
str_doc_search lstr_return
n_cst_string lnv_string

lstr_return.l_count = of_filegenerate(false,lstr_return.s_pathname,lstr_return.s_filename) 
closewithreturn(parent,lstr_return)
end event

type cb_3 from commandbutton within w_agreement_doc_search
integer x = 2889
integer y = 1928
integer width = 343
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;string ls_pathname[],ls_filename[]
string ls_return
str_doc_search lstr_return
n_cst_string lnv_string

lstr_return.l_count = of_filegenerate(true,lstr_return.s_pathname,lstr_return.s_filename) 
closewithreturn(parent,lstr_return)
end event

