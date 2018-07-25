$PBExportHeader$w_image_correct.srw
forward
global type w_image_correct from window
end type
type cb_about from commandbutton within w_image_correct
end type
type cb_cancel from commandbutton within w_image_correct
end type
type dw_doc from datawindow within w_image_correct
end type
type cb_select from commandbutton within w_image_correct
end type
type st_name from statictext within w_image_correct
end type
type cb_prac from commandbutton within w_image_correct
end type
type dw_data from u_dw within w_image_correct
end type
type dw_image_list from u_dw within w_image_correct
end type
end forward

global type w_image_correct from window
integer width = 3529
integer height = 1692
boolean titlebar = true
string title = "Document Association Correction"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_about cb_about
cb_cancel cb_cancel
dw_doc dw_doc
cb_select cb_select
st_name st_name
cb_prac cb_prac
dw_data dw_data
dw_image_list dw_image_list
end type
global w_image_correct w_image_correct

type variables
pfc_cst_nv_data_entry_functions inv_dw
long il_prac_id
long il_image_id
long il_org_prac
long  ii_verifiying_facility_id
end variables

forward prototypes
public function integer of_select_for_scanning ()
public function string of_get_reference (integer ai_row)
public function integer of_get_records (integer ai_row)
end prototypes

public function integer of_select_for_scanning ();//Start Code Change ----03.28.2011 #V11 maha - copied from original code modified for facility-specific functionality

//try
//tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  ) //maha 061201
//catch (runtimeerror rte)
//end try

Boolean lb_append = False
Boolean lb_ver_doc = False
Integer li_screen_id
Integer li_ans
Integer li_rec_cnt  
Integer i
Integer d
integer li_rcdel
Integer li_delrow
Integer li_start_page
Integer li_num_page
Integer li_start_check
Integer li_new_row
Integer li_retval
Integer li_cr
long li_found  //maha 12/01/2011 - changed from integer
long li_facility_id //maha 12/01/2011 - changed from integer
integer li_success  
Integer li_image_type
integer li_lastfound  //maha 04.01.2011
integer li_currow  //maha 09.01.2011
Long ll_seq_no,ll_image_id
long li_ref_field_id 
Long ll_rec_id
Long ll_prac_id
long ll_imgid[]
long ll_id
String ls_doc_id
String ls_reference
String ls_ref_field_name
String ls_field_type
String ls_data
string ref_type 
string ls_lu_field_type 
String ls_find 
string ls_ow_type
string ls_mes //maha 09.30.2014
DataWindowChild dwchild,ldw_child
//Datawindow dw_data, dw_image_list, dw_image_data, dw_browse
Blob lb_null_image
gs_variable_array ls_array

//dw_data = tab_view.tabpage_setup.dw_data
//dw_image_list = tab_view.tabpage_setup.dw_image_list
//dw_image_data = tab_view.tabpage_setup.dw_image_data
//dw_browse = tab_view.tabpage_browse.dw_browse
//
//if of_check_add("SELECT") = 1 then //Start Code Change ----04.02.2012 #V12 maha
//	return -1 
//end if
//
////Get image storage type
//IF ii_image_storage_type = 1 THEN
//	//don't need to test if image comes from database
//else //trap to see if file exists
//	if is_image_file_name <> "" then
//		if not fileexists(is_image_file_name) and dw_browse.rowcount( ) > 0 then 
//			messagebox(iw_parent_window.title, 'Image ' + is_image_file_name + ' does not exist. Please check to see if the image folder has been moved.' )
//			return -1
//		end  if
//	end if
//END IF
//
////Start Code Change ----08.31.2011 #V11 maha - as the sort is needed only the single file storage, only use it for that
//IF ii_image_storage_type = 0 THEN
////set the sort if changed (primarily for stored on hard drive)
//dw_browse.setsort("start_page")
//dw_browse.sort()
//end if
////End Code Change ----08.31.2011 
//
//
//SetNull( lb_null_image )
//
//li_cr = dw_data.GetRow()
//li_image_type = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "image_type_id" ) 
//
//IF li_cr = 0 then return -1
//
//li_screen_id = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "link_to_screen" )
////Verification image type?
//IF dw_image_list.GetItemNumber( dw_image_list.GetRow(), "image_type_id" ) = 99 THEN
//	lb_ver_doc = True
//END IF
//	
////Test to see if image exists
////Verification images
//IF lb_ver_doc THEN	//verification
//	li_screen_id = dw_data.GetItemNumber( li_cr, "screen_id" )
//	ls_reference = dw_data.GetItemString( dw_data.GetRow(), "reference_value" )
//	ref_type = "V"
//	ls_doc_id = dw_data.GetItemString( dw_data.GetRow(), "doc_id" )
//	//check for image in browse list
//	ls_find =  "doc_id = '" + ls_doc_id + "'"
//	
//	for i = 1 to dw_browse.rowcount( )
//		if dw_browse.getitemstring(i,"doc_id") = ls_doc_id and dw_browse.getitemnumber(i,"active_status") = 1 then
//			ll_imgid[upperbound(ll_imgid) + 1] = dw_browse.getitemnumber(i,"image_pk")
//		end if
//	next
//	//Basic Info Connected images
//ELSEIF li_screen_id = 1 THEN 
//	ls_reference = dw_image_list.GetItemString( dw_image_list.GetRow(), "image_type_description" ) 		
//	ref_type = "I"
//	
//	ls_find =  "image_type_id = " + string(li_image_type) //maha changed search to image type from reference
//	li_rec_cnt =  tab_view.tabpage_browse.dw_browse.find( ls_find, 1, 10000) 
//	
//	for i = 1 to dw_browse.rowcount( )
//		if dw_browse.getitemnumber(i,"image_type_id") = li_image_type and dw_browse.getitemnumber(i,"active_status") = 1 then
//			ll_imgid[upperbound(ll_imgid) + 1] = dw_browse.getitemnumber(i,"image_pk")
//			li_lastfound = i
//		end if
//	next
//	
//	//get the recid if there are existing records else set the recid
//	if upperbound(ll_imgid[]) > 0 then
//		ll_rec_id = dw_browse.getitemnumber(li_lastfound, /*"rec_id"*/"pd_images_rec_id") //Modify by Stephen 04.06.2011 --- column name error
//	else
//		ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")
//	end if
//		
//	//Connected to data entry records
//ELSE	
//	ref_type = "R"
//	ll_rec_id = dw_data.GetItemNumber( dw_data.GetRow(), "rec_id" ) 	
//	
//	for i = 1 to dw_browse.rowcount( )
//		if dw_browse.getitemnumber(i,"pd_images_rec_id") = ll_rec_id and dw_browse.getitemnumber(i,"active_status") = 1 then
//			ll_imgid[upperbound(ll_imgid) + 1] = dw_browse.getitemnumber(i,"image_pk")
//		end if
//	next
//
//END IF
//
//li_rec_cnt = upperbound(ll_imgid[])
//	
////If records found open options window and process as selected
//IF li_rec_cnt > 0 THEN
//	ls_array.as_number = ll_imgid
//	Openwithparm( w_overwrite_msg, ls_array )
//	//handle results C, O,F,A,P
//
//	//messagebox("",Message.StringParm)
//	 ls_ow_type = mid(Message.StringParm,1,1)
//	Choose case  ls_ow_type
//		Case "C"  //Cancel
//			Return -1
//		Case "P"  //Append to existing record
//			//will be coded for V11.3.  
//			if dw_image_data.rowcount() > 0 then
//				messagebox("Append","Append to existing Image cannot be selected when other records have been selected.")
//				return -1
//			end if
//			// as no additional records are added this option should open a window for get from file or Scan, get additional image and step out of this function
//			//the scan date and user should be updated
//			//----------------APPEON BEGIN------------------------
//			//$<add> long.zhang 10.13.2011
//			//$<reason> append Existing image
//				ll_id = long(mid(Message.StringParm,2))
//				li_delrow = tab_view.tabpage_browse.dw_browse.find( "image_pk = " + string(ll_id) , 1, dw_browse.rowcount() )
//				if li_delrow < 1 then return -1
//				if of_insert_pages(li_delrow) = -1 then return -1	
//			//----------------APPEON END--------------------------	
//		Case Else //O,F,A
//			ll_id = long(mid(Message.StringParm,2))
//			li_delrow = tab_view.tabpage_browse.dw_browse.find( "image_pk = " + string(ll_id) , 1, dw_browse.rowcount() )
//			debugbreak()
//			If ls_ow_type = "A" and li_delrow > 0 then  //add send org to history
//				dw_browse.setitem(li_delrow,"active_status",0)
//				li_facility_id =  tab_view.tabpage_browse.dw_browse.getitemnumber(li_delrow, "pd_images_facility_id")  //Add by Stephen 05.04.2011 --- Fixed a bug.
//				dw_browse.update()
//			Elseif ls_ow_type = "F" then  //Add additional for another facility
//				//do nothing here
//			ElseIF  ls_ow_type = "O" THEN  //Overwrite ***************************
//				li_rcdel = dw_browse.rowcount()
//				if li_delrow < 1 then 
//					return -1
//				end if
//				li_start_page = dw_browse.GetItemNumber( li_delrow, "start_page" )
//				li_num_page = dw_browse.GetItemNumber( li_delrow, "num_pages" )
//				li_facility_id =  tab_view.tabpage_browse.dw_browse.getitemnumber(li_delrow, "pd_images_facility_id") //Add by Stephen 05.04.2011 --- Fixed a bug.
//
//				dw_browse.DeleteRow( li_delrow )			
//				IF ii_image_storage_type = 1 THEN			
//					//IF stored in db then do nothing because when you delete the pd_image row you delete the image
//				ELSE
//					//reset page numbers for storage in hard drive
//					tab_view.tabpage_browse.ole_admin.Object.Image( is_image_file_name )
//	
//					if of_check_page_count(li_start_page, tab_view.tabpage_browse.ole_admin.Object.PageCount ,li_num_page) = -1 then
//						return -1
//					end if
//	
//					if li_start_page > 0 then // trap 
//						tab_view.tabpage_browse.ole_admin.Object.DeletePages( li_start_page, li_num_page )
//					end if
//					//reset page numbers
//					li_start_check = 1
//					for d = 1 to dw_browse.rowcount() //reset all start pages 
//						tab_view.tabpage_browse.dw_browse.setItem( d, "start_page",li_start_check )
//						li_start_check = li_start_check + dw_browse.GetItemNumber( d ,"num_pages")	
//					next
//				END IF
//
//			dw_browse.update()  //Start Code Change ---- 05.03.2007 #V7 maha 
//			//*******************end of overwrite
//		End if
//	END Choose
//END IF
//
////Get Reference value
//Choose case ref_type
//	case "I", "V", "P"
//		//already got above or don't need
//	case else //"O","A"
//		//GET REFERENCE FIELD 1 DATA
//		li_ref_field_id = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "reference_field_1" )
//		if isnull(li_ref_field_id) or li_ref_field_id = 0 then  //Start Code Change ---- 06.11.2007 #V7 maha
//			ls_mes = "There is no Reference Field 1 set up for this data screen.~r"
//			ls_mes+= "This can be set in the Screen View Utility from the Administrative Utilities.  Select the Data screen.  For Reference Field 1, select a field that will always be entered in the data record.~r"
//			ls_mes+= "For assistance, please contact IntelliSoft Group support."
//			MessageBox("Select Data error", ls_mes)
//			return -1
//		end if
//
//		ls_ref_field_name = gnv_data.of_getitem( "sys_fields","field_name", "field_id = "+String(li_ref_field_id))
//		ls_field_type = gnv_data.of_getitem( "sys_fields","field_type", "field_id = "+String(li_ref_field_id))
//		
//		if dw_data.Describe(ls_ref_field_name + ".ColType") = "!" then  //Start Code Change ---- 06.11.2007 #V7 maha trap
//			MessageBox("Select Data error", "Required field, "  + ls_ref_field_name +  ", is not a valid Field on this data screen.  Please contact IntelliSoft Group support for assistance before adding image items for this screen. ")
//			return -1
//		end if
//		
//		dw_data.SetTabOrder( ls_ref_field_name, 1 )
//		dw_data.SetColumn( ls_ref_field_name )
//		dw_data.setrow(li_cr)//maha 071701
//
//		li_retval = dw_data.GetChild(ls_ref_field_name, dwchild)
//		debugbreak()
//		ls_data =  dw_data.GetText()
//		IF li_retval = -1 THEN
//			ls_data =  dw_data.GetText()				
//		ELSE	
//			li_found = dwchild.Find( "lookup_code = " + ls_data,1,1000000 )	
//			if li_found < 1 then
//				messagebox("Find lookup Error","Lookup record not found for " + ls_ref_field_name + ".  Check for missing data.")
//				return -1
//			end if
//	
//			IF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "code" or  dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "description" THEN //maha 071401 changed from code only
//				ls_data = dw_data.GetText() //trap for null lookup data
//				IF IsNull( ls_data ) THEN
//					ls_data = ""
//				else
//					ls_data = dwchild.GetItemString( li_found, "code" )
//				end if
//			ELSEIF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "entity_name" THEN
//				ls_data = dw_data.GetText()//trap for null lookup data
//				IF IsNull( ls_data ) THEN
//					ls_data = ""
//				else
//					if dwchild.rowcount() > 0 then  
//						ls_data = dwchild.GetItemString( li_found, "entity_name_original" )
//					else
//						ls_data = ""
//					end if
//				end if
//			ELSE
//				ls_data = dw_data.GetText()				
//			END IF
//		END IF
//
//		IF IsNull( ls_data ) THEN
//			ls_reference = ""
//		ELSE 
//			ls_reference = ls_data
//		END IF
//
//		//GET REFERENCE FIELD 2 DATA
//		li_ref_field_id = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "reference_field_2" )
//
//		ls_ref_field_name = gnv_data.of_getitem( "sys_fields","field_name", "field_id = "+String(li_ref_field_id))
//		ls_field_type = gnv_data.of_getitem( "sys_fields","field_type", "field_id = "+String(li_ref_field_id))
//
//		if dw_data.Describe(ls_ref_field_name + ".ColType") <> "!" then  // trap for bad reference 2
//			dw_data.SetTabOrder( ls_ref_field_name, 1 )
//			dw_data.SetColumn( ls_ref_field_name )
//			dw_data.setrow(li_cr)
//			li_retval = dw_data.GetChild(ls_ref_field_name, dwchild)
//			ls_data = dw_data.GetText()
//			
//			IF IsNull( ls_data ) THEN //trap for null lookup 062805
//				ls_data = ""
//			else
//				IF li_retval = -1 THEN
//					ls_data =  dw_data.GetText()				
//					ELSE
//					li_found = dwchild.Find( "lookup_code = " + dw_data.GetText(), 1, 1000000 )
//					if li_found < 1 then //maha 061501
//						ls_data = ""
//					else
//						IF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "code" THEN
//							ls_data = dwchild.GetItemString( li_found, "code" )
//						ELSEIF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "description" THEN  //Start Code Change ----09.02.2010 #V10 maha - added description option
//							ls_data = dwchild.GetItemString( li_found, "description" )
//						ELSEIF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "entity_name" THEN
//							ls_data = dwchild.GetItemString( li_found, "entity_name_original" )
//						ELSE
//							ls_data = dw_data.GetText()				
//						END IF
//					end if
//				END IF
//			end if
//		else
//			ls_data = ""
//		end if
//
//		IF NOT IsNull( ls_reference ) THEN
//			ls_reference = ls_reference + " - " + ls_data
//		END IF	
//End choose
//	
////trap for overlong values
//ls_reference = MidA(ls_reference,1,100)
//	
//IF dw_image_data.GetItemStatus( 1, 0, Primary! ) = New! THEN
//	dw_image_data.DeleteRow( 0 )	
//END IF
//
//li_success = dw_image_data.getchild('facility_id',ldw_child)
//IF li_success = 1 THEN
//	ldw_child.settransobject(SQLCA)
//	ldw_child.retrieve(gs_user_id)   
//	ldw_child.insertrow(1)
//	ldw_child.setitem(1,'facility_id',0)
//	ldw_child.setitem(1,'facility_name','ALL')
//END IF
//	  
//If ls_ow_type = "P" then //	
//	
//else 
//	//Start Code Change ----04.01.2011 #V11 maha - readded to set seq_no
//	IF ref_type = "V" THEN //for verifs seq no based on doc id
//		SELECT Max( seq_no )  
//		INTO :ll_seq_no  
//		FROM pd_images  
//		WHERE pd_images.doc_id = :ls_doc_id ;
//		IF SQLCA.SQLCODE = -1 THEN
//			MessageBox("Database Error", SQLCA.SQLERRTEXT )
//		END IF
//	else //seq no based on recid
//		SELECT Max( seq_no )  
//		INTO :ll_seq_no  
//		FROM pd_images  
//		WHERE pd_images.rec_id = :ll_rec_id ;
//		IF SQLCA.SQLCODE = -1 THEN
//			MessageBox("Database Error", SQLCA.SQLERRTEXT )
//		END IF
//	End If
//	
//	IF IsNull( ll_seq_no ) THEN
//		ll_seq_no = 0
//	END IF
//	
//	ll_seq_no++
//	//Start Code Change ----04.01.2011
//	
//	li_new_row = dw_image_data.InsertRow( 0 )
//	dw_image_data.ScrollToRow( li_new_row )
//	dw_image_data.SetRow( li_new_row )
//	dw_image_data.SetItem( li_new_row, "image_type_id",li_image_type )
//	dw_image_data.SetItem( li_new_row, "prac_id", il_prac_id )
//	dw_image_data.SetItem( li_new_row, "seq_no", ll_seq_no ) //Start Code Change ----04.01.2011 maha readded set of seq (from 1)
//	dw_image_data.SetItem( li_new_row, "rec_id", ll_rec_id  )
//	//------------------- APPEON BEGIN -------------------
//	//$<modify> Stephen 05.04.2011
//	//$<reason> N/A
//	/*
//	dw_image_data.SetItem( li_new_row, "facility_id", 0  )
//	*/
//	if isnull(li_facility_id) then li_facility_id = 0
//	dw_image_data.SetItem( li_new_row, "facility_id", li_facility_id) 
//	//------------------- APPEON END -------------------
//	
//	dw_image_data.SetItem( li_new_row, "screen_id", li_screen_id )	
//	dw_image_data.SetItem( li_new_row, "reference_name", ls_reference )
//	dw_image_data.SetItem( li_new_row, "active_status", 1 )	
//	dw_image_data.SetItem( li_new_row, "num_pages", dw_image_list.GetItemNumber( dw_image_list.GetRow(), "default_pages" ) )
//
//	IF ref_type = "V" THEN //for verification set doc_id
//		dw_image_data.SetItem( li_new_row, "doc_id", ls_doc_id )	
//	END IF
//END IF
//
//dw_image_data.SetColumn( "notes" )
//dw_image_data.SetFocus( )
//	
//dw_image_data.SetItem( li_new_row, "date_scanned", DateTime( Today(), Now()) )
//dw_image_data.SetItem( li_new_row, "user_name", gnv_app.of_GetUserId() )
//
//dw_image_data.SetItem(  li_new_row , "de_queue", 0 ) 
//
//tab_view.tabpage_setup.cb_scan.Enabled = True
//tab_view.tabpage_setup.cb_from_file.Enabled = True
//tab_view.tabpage_setup.cb_remove.Enabled = True
//

return 1
end function

public function string of_get_reference (integer ai_row);//Start Code Change ----06.21.2016 #V152 maha - added
//Get Reference value

integer li_retval
integer li_found
integer li_cr
long li_ref_field_id

string ls_mes
string ls_ref_field_name
string ls_field_type
string ls_data
string ls_reference
datawindowchild dwchild

li_cr = ai_row

//GET REFERENCE FIELD 1 DATA
li_ref_field_id = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "reference_field_1" )
		
if isnull(li_ref_field_id) or li_ref_field_id = 0 then  //Start Code Change ---- 06.11.2007 #V7 maha
//			ls_mes = "There is no Reference Field 1 set up for this data screen.~r"
//			ls_mes+= "This can be set in the Screen View Utility from the Administrative Utilities.  Select the Data screen.  For Reference Field 1, select a field that will always be entered in the data record.~r"
//			ls_mes+= "For assistance, please contact IntelliSoft Group support."
//			MessageBox("Select Data error", ls_mes)
//			return -1
	ls_data = ""
else
	ls_ref_field_name = gnv_data.of_getitem( "sys_fields","field_name", "field_id = "+String(li_ref_field_id))
	ls_field_type = gnv_data.of_getitem( "sys_fields","field_type", "field_id = "+String(li_ref_field_id))
			
	if dw_data.Describe(ls_ref_field_name + ".ColType") = "!" then  //Start Code Change ---- 06.11.2007 #V7 maha trap
		MessageBox("Select Data error", "Required field, "  + ls_ref_field_name +  ", is not a valid Field on this data screen.  Please contact IntelliSoft Group support for assistance before adding image items for this screen. ")
		return ""
	end if
	
	dw_data.SetTabOrder( ls_ref_field_name, 1 )
	dw_data.SetColumn( ls_ref_field_name )
	dw_data.setrow(li_cr)//maha 071701

	li_retval = dw_data.GetChild(ls_ref_field_name, dwchild)
	debugbreak()
	ls_data =  dw_data.GetText()
	IF li_retval = -1 THEN
		ls_data =  dw_data.GetText()				
	ELSE	
		li_found = dwchild.Find( "lookup_code = " + ls_data,1,1000000 )	
		if li_found < 1 then
			messagebox("Find lookup Error","Lookup record not found for " + ls_ref_field_name + ".  Check for missing data.")
			return ""
		end if

		IF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "code" or  dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "description" THEN //maha 071401 changed from code only
			ls_data = dw_data.GetText() //trap for null lookup data
			IF IsNull( ls_data ) THEN
				ls_data = ""
			else
				ls_data = dwchild.GetItemString( li_found, "code" )
			end if
		ELSEIF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "entity_name" THEN
			ls_data = dw_data.GetText()//trap for null lookup data
			IF IsNull( ls_data ) THEN
				ls_data = ""
			else
				if dwchild.rowcount() > 0 then  
					ls_data = dwchild.GetItemString( li_found, "entity_name_original" )
				else
					ls_data = ""
				end if
			end if
		ELSE
			ls_data = dw_data.GetText()				
		END IF
	END IF
	
	IF IsNull( ls_data ) THEN
		ls_reference = ""
	ELSE 
		ls_reference = ls_data
	END IF
End if

		//GET REFERENCE FIELD 2 DATA
		li_ref_field_id = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "reference_field_2" )

		ls_ref_field_name = gnv_data.of_getitem( "sys_fields","field_name", "field_id = "+String(li_ref_field_id))
		ls_field_type = gnv_data.of_getitem( "sys_fields","field_type", "field_id = "+String(li_ref_field_id))

		if dw_data.Describe(ls_ref_field_name + ".ColType") <> "!" then  // trap for bad reference 2
			dw_data.SetTabOrder( ls_ref_field_name, 1 )
			dw_data.SetColumn( ls_ref_field_name )
			dw_data.setrow(li_cr)
			li_retval = dw_data.GetChild(ls_ref_field_name, dwchild)
			ls_data = dw_data.GetText()
			
			IF IsNull( ls_data ) THEN //trap for null lookup 062805
				ls_data = ""
			else
				IF li_retval = -1 THEN
					ls_data =  dw_data.GetText()				
					ELSE
					li_found = dwchild.Find( "lookup_code = " + dw_data.GetText(), 1, 1000000 )
					if li_found < 1 then //maha 061501
						ls_data = ""
					else
						IF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "code" THEN
							ls_data = dwchild.GetItemString( li_found, "code" )
						ELSEIF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "description" THEN  //Start Code Change ----09.02.2010 #V10 maha - added description option
							ls_data = dwchild.GetItemString( li_found, "description" )
						ELSEIF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "entity_name" THEN
							ls_data = dwchild.GetItemString( li_found, "entity_name_original" )
						ELSE
							ls_data = dw_data.GetText()				
						END IF
					end if
				END IF
			end if
		else
			ls_data = ""
		end if

		IF NOT IsNull( ls_reference ) THEN
			ls_reference = ls_reference + " - " + ls_data
		END IF	
	
//trap for overlong values
ls_reference = MidA(ls_reference,1,100)

return ls_reference
end function

public function integer of_get_records (integer ai_row);//Start Code Change ----07.05.2016 #V152 maha - added
IF ai_row > 0 THEN
	dw_image_list.SelectRow( 0, False )
	dw_image_list.SelectRow( ai_row, True )
	//verification image processing
	dw_data.of_SetUpdateAble( False )
	IF dw_image_list.GetItemNumber( ai_row, "image_type_id" ) = 99 THEN		
		dw_data.DataObject = "d_image_ver_summary_record_view"
		//dw_data.of_SetDropDownCalendar( True )
		//dw_data.iuo_calendar.of_Register( dw_data.iuo_calendar.DDLB)
		dw_data.of_SetUpdateAble( True )
		dw_data.of_SetTransObject( SQLCA )		

		Integer li_facility_id[1]
		li_facility_id[1] = ii_verifiying_facility_id
		DataWindowChild dwchild
		dw_data.Retrieve( 1, il_prac_id, li_facility_id )
		dw_data.GetChild( "response_code", dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve("credentials verification response")
		dwchild.InsertRow( 1 )
	ELSEIF dw_image_list.GetItemNumber( ai_row, "link_to_screen" ) = 0 THEN
		dw_data.Visible = False
		dw_data.Reset()
	ELSE
		dw_data.Visible = True
		inv_dw.of_create_dynamic_dw_browse( il_prac_id , 1, dw_image_list.GetItemNumber( ai_row, "link_to_screen" ), dw_data )

	//	ib_list_retrieved = false
	END IF
//	
END IF

return 1


end function

on w_image_correct.create
this.cb_about=create cb_about
this.cb_cancel=create cb_cancel
this.dw_doc=create dw_doc
this.cb_select=create cb_select
this.st_name=create st_name
this.cb_prac=create cb_prac
this.dw_data=create dw_data
this.dw_image_list=create dw_image_list
this.Control[]={this.cb_about,&
this.cb_cancel,&
this.dw_doc,&
this.cb_select,&
this.st_name,&
this.cb_prac,&
this.dw_data,&
this.dw_image_list}
end on

on w_image_correct.destroy
destroy(this.cb_about)
destroy(this.cb_cancel)
destroy(this.dw_doc)
destroy(this.cb_select)
destroy(this.st_name)
destroy(this.cb_prac)
destroy(this.dw_data)
destroy(this.dw_image_list)
end on

event open; //Start Code Change ----09.10.2015 #V15.2 maha - added
 string ls_prac
 long ll_type
 integer r
 integer rc
 gs_pass_ids lst_ids
 datawindowchild dw_child
 
 //use a structure to pass pracid and pkid 
  inv_dw = create pfc_cst_nv_data_entry_functions
lst_ids = message.powerobjectparm
il_prac_id = lst_ids.prac_id
il_org_prac = il_prac_id
il_image_id = lst_ids.l_app_id
ll_type = lst_ids.committee_id
ii_verifiying_facility_id = lst_ids.facility_id 

dw_image_list.settransobject(sqlca)
rc = dw_image_list.retrieve(gs_user_id)

r = dw_image_list.find("image_type_id = " + string(ll_type) , 1, rc )
if r > 0 then
	dw_image_list.scrolltorow( r)
	dw_image_list.selectrow( 0, false)
	dw_image_list.selectrow( r,true)
	dw_image_list.setrow( r)
end if

dw_doc.settransobject(sqlca)

dw_doc.getchild('pd_images_facility_id',dw_child)
dw_child.settransobject(SQLCA)
dw_child.retrieve(gs_user_id) 
dw_child.insertrow(1)
dw_child.setitem(1,'facility_id',0)
dw_child.setitem(1,'facility_name','ALL')

dw_doc.retrieve(il_image_id)
select full_name into :ls_prac from v_full_name where prac_id = :il_prac_id;
st_name.text = ls_prac






 

end event

event close;destroy  inv_dw
end event

type cb_about from commandbutton within w_image_correct
integer x = 2679
integer y = 32
integer width = 402
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;//Start Code Change ----07.05.2016 #V152 maha
string s

s = "This utility will allow you to correct an Image that may have been added incorrectly."

messagebox("About Association Correction", s)
end event

type cb_cancel from commandbutton within w_image_correct
integer x = 3099
integer y = 32
integer width = 402
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type dw_doc from datawindow within w_image_correct
integer x = 5
integer y = 148
integer width = 3497
integer height = 240
integer taborder = 10
string title = "none"
string dataobject = "d_pd_image_record_4_correct"
boolean hscrollbar = true
boolean livescroll = true
end type

type cb_select from commandbutton within w_image_correct
integer x = 1765
integer y = 32
integer width = 891
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Connect to Selected Data Record"
end type

event clicked;//Start Code Change ----06.21.2016 #V152 maha
integer r
integer cnt
integer res
long ll_type
long ll_screen
long ll_rec
string ls_type
string ls_ref
string ls_doc

debugbreak()
ll_screen = dw_image_list.getitemnumber(dw_image_list.getrow(), "link_to_screen")
ll_type = dw_image_list.getitemnumber(dw_image_list.getrow(), "image_type_id")

if ll_type = 99 then //verifs
	r = dw_data.getrow()
	ll_rec = dw_data.getitemnumber(r, "rec_id")
	ls_doc = dw_data.getitemstring(r, "doc_id")
	ls_ref = dw_data.getitemstring(r, "reference_value")
	ll_screen = dw_data.getitemnumber(r, "screen_id")
	ls_type = dw_image_list.getitemstring(dw_image_list.getrow(), "image_type_description")	
else
	if ll_screen = 1 then 
		ls_ref = dw_image_list.getitemstring(dw_image_list.getrow(), "image_type_description")
		ls_type = ls_ref
	else
		//get reference val
		r = dw_data.getrow()
		ll_rec = dw_data.getitemnumber(r, "rec_id")
		ls_ref = of_get_reference( r)
		select screen_name into :ls_type from data_view_screen where screen_id = :ll_screen and data_view_id = 1;
	end if
end if

		
	
	//CHECK TO SEE IF A RECORD EXISTS FOR THAT REC ID
	
	if ll_type = 99 then
		select count(doc_id) into :cnt from pd_images where prac_id = :il_prac_id and image_type_id = :ll_type and active_status = 1 and doc_id = :ls_doc;
	else
		if ll_screen = 1 then
			select count(rec_id) into :cnt from pd_images where prac_id = :il_prac_id and image_type_id = :ll_type and active_status = 1;
		else 
			select count(rec_id) into :cnt from pd_images where prac_id = :il_prac_id and image_type_id = :ll_type and rec_id = :ll_rec and active_status = 1;
		end if
	end if
	
	if cnt > 0 then
		res = messagebox("Image Exists","There is already an existing active Document for the selected data record.  Do you wish to make the current record historical?", question!,yesno!, 2)
		if res = 1 then
			if ll_screen = 1 then
				Update pd_images  set active_status = 0 where prac_id = :il_prac_id and image_type_id = :ll_type and active_status = 1;
			elseif ll_screen = 999 then
				Update pd_images  set active_status = 0 where prac_id = :il_prac_id and image_type_id = :ll_type and active_status = 1 and doc_id = :ls_doc;
			else
				Update pd_images  set active_status = 0 where prac_id = :il_prac_id and image_type_id = :ll_type and rec_id = :ll_rec and active_status = 1;
			end if
		else
			messagebox("Cancel","Reassociation canceled.")
			return
		end if
	end if
		


dw_doc.setitem(1, "reference_name", ls_ref)
dw_doc.setitem(1, "image_type_description", ls_type)
dw_doc.setitem(1, "pd_images_screen_id", ll_screen)
dw_doc.setitem(1, "image_type_id", ll_type)
dw_doc.setitem(1, "pd_images_prac_id", il_prac_id)
	
if ll_screen > 1 then
	dw_doc.setitem(1, "pd_images_rec_id", ll_rec)
end if

//for verifs also set the doc_id
if ll_type = 99 then 
	dw_doc.setitem(1, "doc_id", ll_rec)
end if

//CREATE AND SET THE  DOC ID if a verification image
//ls_doc = 
//dw_doc.setitem(1, "doc_id", ls_doc)

dw_doc.update()

close(parent)









end event

type st_name from statictext within w_image_correct
integer x = 521
integer y = 52
integer width = 1019
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Provider Name"
boolean focusrectangle = false
end type

type cb_prac from commandbutton within w_image_correct
integer x = 46
integer y = 32
integer width = 457
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Change Provider"
end type

event clicked;gs_search lstr_search

long ll_pracs[]
string ls_prac
integer r

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "ACTIONITEMS"

OpenWithParm( w_extended_search_new , lstr_search )
IF Message.DoubleParm = -1 THEN 
	Return -1
else
	ll_pracs[1] = long(Message.stringParm)
end if

il_prac_id = ll_pracs[1]
select full_name into :ls_prac from v_full_name where prac_id = :il_prac_id;
st_name.text = ls_prac

r = dw_image_list.getrow()

of_get_records(r)





end event

type dw_data from u_dw within w_image_correct
event ue_after_retrieve ( )
integer x = 933
integer y = 412
integer width = 2578
integer height = 1188
integer taborder = 20
boolean titlebar = true
string title = "Select Data Record"
boolean hscrollbar = true
end type

event ue_after_retrieve();//IF This.RowCount() > 0 THEN
//	This.SetRow( 1 )		
//	IF tab_view.tabpage_setup.dw_data.DataObject <> "d_image_ver_summary_record_view"	THEN
//		This.SelectRow( 1, True )
//	END IF
//END IF
end event

event clicked;call super::clicked;Integer li_row

li_row = GetClickedRow()

IF li_row > 0 THEN
	This.SetRow( li_row )		
	IF this.DataObject <> "d_image_ver_summary_record_view"	THEN
		This.SelectRow( 0, False )
		This.SelectRow( li_row, True )
	END IF	

END IF
end event

event doubleclicked;//cb_select.TriggerEvent( Clicked! )
end event

event retrieveend;call super::retrieveend;PostEvent( "ue_after_retrieve" )

//This.Modify( "datawindow.color = '79741120'" ) - commented by alfee 11.18.2010


end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2006-08-29 By: Liu HongXin
//$<reason> It hasn't save, so not to delete.
return 1
//---------------------------- APPEON END ----------------------------
end event

type dw_image_list from u_dw within w_image_correct
integer x = 5
integer y = 412
integer width = 914
integer height = 1188
integer taborder = 10
boolean titlebar = true
string title = "Select Image Type"
string dataobject = "d_image_image_type_list"
boolean hscrollbar = true
end type

event clicked;call super::clicked;IF row > 0 THEN
	This.SetRow( row )
END IF
end event

event retrieveend;call super::retrieveend;IF rowcount > 0 THEN
	This.SelectRow( 1, True )
	This.SetFocus()
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;of_get_records(currentrow)

//IF currentrow > 0 THEN
//	This.SelectRow( 0, False )
//	This.SelectRow( currentrow, True )
//	//verification image processing
//	dw_data.of_SetUpdateAble( False )
//	IF This.GetItemNumber( currentrow, "image_type_id" ) = 99 THEN		
//		dw_data.DataObject = "d_image_ver_summary_record_view"
//		//dw_data.of_SetDropDownCalendar( True )
//		//dw_data.iuo_calendar.of_Register( dw_data.iuo_calendar.DDLB)
//		dw_data.of_SetUpdateAble( True )
//		dw_data.of_SetTransObject( SQLCA )		
//
//		Integer li_facility_id[1]
//		li_facility_id[1] = ii_verifiying_facility_id
//		DataWindowChild dwchild
//		dw_data.Retrieve( 1, il_prac_id, li_facility_id )
//		dw_data.GetChild( "response_code", dwchild )
//		dwchild.SetTransObject( SQLCA )
//		dwchild.Retrieve("credentials verification response")
//		dwchild.InsertRow( 1 )
//	ELSEIF This.GetItemNumber( currentrow, "link_to_screen" ) = 0 THEN
//		dw_data.Visible = False
//		dw_data.Reset()
//	ELSE
//		dw_data.Visible = True
//		inv_dw.of_create_dynamic_dw_browse( il_prac_id , 1, This.GetItemNumber( currentrow, "link_to_screen" ), dw_data )
//
//	//	ib_list_retrieved = false
//	END IF
////	
//END IF

//of_set_alert_text("F") //Start Code Change ----08.04.2010 #V10 maha
end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2006-08-29 By: Liu HongXin
//$<reason> It hasn't save, so not to delete.
return 1
//---------------------------- APPEON END ----------------------------
end event

