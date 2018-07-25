$PBExportHeader$pfc_cst_nvo_gen_app.sru
forward
global type pfc_cst_nvo_gen_app from nonvisualobject
end type
end forward

global type pfc_cst_nvo_gen_app from nonvisualobject
end type
global pfc_cst_nvo_gen_app pfc_cst_nvo_gen_app

forward prototypes
public function integer of_gen_app (pfc_cst_u_create_app2 ai_obj, integer ai_app_id, integer ai_to_page, integer ai_from_page, integer facility_id)
end prototypes

public function integer of_gen_app (pfc_cst_u_create_app2 ai_obj, integer ai_app_id, integer ai_to_page, integer ai_from_page, integer facility_id);//////Start Code Change ----01.25.2008 #V8 maha - this function not called from the program
//
//integer set3
//
////select set_3 into :set3 from icred_settings;
//set3 = of_get_app_setting("set_3","I")
//
//if set3 = 1 then
//	ai_obj.SetRedraw( False )
//end if
//
//Integer li_billing_flag
//Integer i
//Integer t
//Integer li_sort_data_cnt
//Integer li_delete_p
//Integer ap
//Integer li_count
//Integer li_add_page[]
//Integer li_special_fld_cnt
//Integer sf
//Integer li_cal_field_id	
//Integer li_new_calc_field = 0
//Integer li_font
//Integer li_array
//Integer p
//Integer li_query_years
//Integer li_height
//Integer li_width
//Integer li_current_page = 1
//Integer li_retval
//Integer li_page
//Integer li_screen_cnt
//long li_app_fld_cnt //modified 071802 maha
//Integer li_table_id
//Integer li_x
//Integer li_y
//Integer li_screen_fld_cnt
//Integer s
//Integer li_fld_loop
//Integer li_de_row_cnt
//Integer li_screen_id
//integer li_trap
//long li_app_field_id //modified 071802 maha
//Integer li_record_number
//Integer li_font_size
//Integer ck1
//Long ll_billing_address_id
//Long ll_last_data_value
//Long ll_data
//Long ll_found
//String ls_add_pages
//String ls_query_value
//String ls_new_val
//String ls_sort_syntax
//String ls_val
//String ls_special_field
//String ls_data_value[100,100]
//String ls_data_dummy[100,100]
//String ls_format
//String ls_past_filter
//String ls_year
//String ls_true_value
//String ls_false_value
//String ls_object_type
//String ls_font_name
//String ls_field_type
//String ls_field_name
//String ls_screen_name
//String ls_data
//String ls_link_type
//String ls_link_field
//String ls_query
//String ls_last_query
//DateTime ldt_data
//date ld_pastdate
//Boolean lb_page_populated[]
//pfc_cst_nv_data_entry_functions de_functions
//DatawindowChild dwchild
//
//SELECT app_hdr.additional_info_pages  
//INTO :ls_add_pages  
//FROM app_hdr  
//WHERE app_hdr.app_id = :ai_obj.ii_app_id   ;
//IF ai_obj.tr_app_data.SQLCODE = -1 THEN
//	MessageBox( "Database Error", ai_obj.tr_app_data.SQLERRTEXT )
//END IF
//
//IF Len( ls_add_pages ) > 0 THEN
//	IF Pos( ls_add_pages, "," ) = 0 THEN
//		li_add_page[ 1 ] = Integer( ls_add_pages )
//	ELSE
//		DO WHILE TRUE
//			li_count++
//			li_add_page[li_count] = Integer( Mid( ls_add_pages, 1, Pos( ls_add_pages, "," ) -1) )
//			ls_add_pages = Mid( ls_add_pages, Pos( ls_add_pages, "," ) +1, 1000 )				
//			IF Pos( ls_add_pages, "," ) = 0 THEN
//				li_count++
//				li_add_page[li_count] = Integer( ls_add_pages )
//				Exit
//			END IF
//		LOOP
//	END IF
//END IF
//
//String ls_save_as
//ls_save_as = gs_dir_path + "intellicred\" + String( ai_obj.ii_app_id ) +"-" + String(ai_obj.ii_prac_id) + ".tif" //modified maha 072604
//ai_obj.ole_edit.Object.SaveAs( ls_save_as,1,1,1,0,false  )
//ai_obj.ole_edit.Object.ClearDisplay()
//ai_obj.ole_edit.Object.Image( ls_save_as )
////ole_edit.Object.Page(1)
//ai_obj.ole_edit.Object.FitTo(3)
////ole_edit.Object.Display()
//ai_obj.ole_edit.Object.Annotationtype(11)	
//
////messagebox("", "mem check 1" )
//
//n_ds lds_app
//n_ds lds_app_fld_data
//n_ds lds_screen_list
//n_ds lds_screen_fields
//n_ds lds_de_detail
//
//lds_screen_list = CREATE n_ds
////lds_screen_list.DataObject = "d_data_view_screens_list"
//lds_screen_list.DataObject = "d_app_screen_ids_in_page_ranges"
//lds_screen_list.of_SetTransObject( ai_obj.tr_app_data)
//
//lds_app_fld_data = CREATE n_ds
//lds_app_fld_data.DataObject = "d_app_data_page_ranges"
//lds_app_fld_data.of_SetTransObject( ai_obj.tr_app_data)
//
//lds_screen_fields = CREATE n_ds
//lds_screen_fields.DataObject = "d_screen_fields"
//lds_screen_fields.of_SetTransObject( ai_obj.tr_app_data)
//
//lds_app = CREATE n_ds
//lds_app.DataObject = "d_app_detail"
//lds_app.of_SetTransObject( ai_obj.tr_app_data)
//
//lds_de_detail = CREATE n_ds
//lds_de_detail.DataObject = ""
//
//de_functions = CREATE pfc_cst_nv_data_entry_functions
//
////messagebox("", "mem check 2" )
//
//lds_app.Retrieve( ai_app_id )
//
//lds_app_fld_data.of_SetTransObject( ai_obj.tr_app_data )
//
//IF ai_to_page = 99 THEN
//	ai_from_page = 1
//	ai_to_page = ai_obj.ole_edit.Object.PageCount()
//END IF
//
//FOR p = ai_from_page TO ai_to_page
//
//	ai_obj.ole_edit.Object.Page( p )
//	ai_obj.ole_edit.Object.Display()
//	ai_obj.ii_current_page = p
//	lb_page_populated[ p ] = False
//	IF ai_obj.ib_sever_started THEN
//		//w_iapply_status_window.st_status.Text = "Processing Page " + String( p )
//
//	ELSE
//		ai_obj.st_page_num.Text = "Page " + String( ai_obj.ii_current_page ) + " of " + String( ai_obj.ole_edit.Object.PageCount()	)
//	END IF
//	li_screen_cnt = lds_screen_list.Retrieve( ai_app_id, p )
//	//special fields processing
//	li_special_fld_cnt = lds_app_fld_data.Retrieve( ai_app_id, 99, p, p, "N" )
//	FOR sf = 1 TO li_special_fld_cnt
//		ls_val = ""
//		li_app_field_id = lds_app_fld_data.GetItemNumber( sf, "app_field_id" )
//		li_x = lds_app_fld_data.GetItemNumber( sf, "x_pos" )
//		li_y = lds_app_fld_data.GetItemNumber( sf, "y_pos" )		
//		ls_special_field = lds_app_fld_data.GetItemString( sf, "field_description" )		
//		IF Pos( ls_special_field, "Todays Date" ) > 0 THEN
//			ls_val = String( Today(), "mm/dd/yyyy" )
//		ELSEIF Pos( ls_special_field, "Current Time" ) > 0 THEN			
//			ls_val = String( Now(), "hh:mm am/pm" )
//		ELSEIF Pos( ls_special_field, "User Id" ) > 0 THEN			
//			ls_val = gs_user_id
//		ELSE
//			ls_val = ls_special_field
//		END IF
//		IF ls_val <> ""  THEN
//			ai_obj.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) )			
//			IF Upper(Mid( ls_val, 1, 6 )) = "LABEL-" THEN
//				ls_val = Mid( ls_val, 7, 100 )
//			END IF			
//			ai_obj.ole_edit.object.AnnotationStampText( ls_val )
//			ai_obj.ole_edit.object.AnnotationFontColor( RGB(0,0,128) ) //RGB(0,0,128) )255 //maha101101
//			ai_obj.ole_edit.object.Annotationtype(8)
//			CHOOSE CASE lds_app_fld_data.GetItemNumber( sf, "font_size" )
//				CASE 1
//					ai_obj.ole_edit.Object.AnnotationFont.Name = "MS Serif"
//					ai_obj.ole_edit.Object.AnnotationFont.Size = 7
//				CASE 2
//					ai_obj.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
//					ai_obj.ole_edit.Object.AnnotationFont.Size = 8				
//				CASE 3
//					ai_obj.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
//					ai_obj.ole_edit.Object.AnnotationFont.Size = 12				
//			END CHOOSE
//			IF lds_app_fld_data.GetItemNumber( sf, "font_bold" ) = 1 THEN
//				ai_obj.ole_edit.Object.AnnotationFont.Bold = True
//			ELSE
//				ai_obj.ole_edit.Object.AnnotationFont.Bold = False
//			END IF					
//			ai_obj.ole_edit.object.Draw(li_x, li_y, 0, 0 )
//		END IF
//	END FOR
////messagebox("", "mem check 3" )	
//FOR s = 1 TO li_screen_cnt
//	li_screen_id =lds_screen_list.GetItemNumber( s, "screen_id" )
//	ls_screen_name = lds_screen_list.GetItemString( s, "screen_name" )
//	ai_obj.st_1.Text = ls_screen_name
//	lds_screen_fields.of_SetTransObject( ai_obj.tr_app_data )
//	li_screen_fld_cnt = lds_screen_fields.Retrieve( 1, li_screen_id )	
//	IF li_screen_fld_cnt = 0 THEN
//		CONTINUE
//	END IF
//	li_table_id = lds_screen_fields.GetItemNumber( 1, "table_id" )
//	lds_app_fld_data.of_SetTransObject( ai_obj.tr_app_data)
//	IF li_screen_id = 27 THEN
//		li_app_fld_cnt = lds_app_fld_data.Retrieve( ai_app_id, li_table_id, p, p, "Y" )
//	ELSE
//		li_app_fld_cnt = lds_app_fld_data.Retrieve( ai_app_id, li_table_id, p, p, "N" )		
//	END IF
//	IF li_app_fld_cnt = 0 THEN
//		CONTINUE
//	END IF
//	lds_app_fld_data.SetSort( "record_number A, y_pos A" )
//	lds_app_fld_data.Sort()	
//	de_functions.of_create_dynamic_ds( ai_obj.ii_prac_id, 1, li_screen_id, lds_de_detail, facility_id, sqlca )
//	//lds_de_detail.of_SetTransObject( SQLCA )
//	//li_de_row_cnt = lds_de_detail.Retrieve()
//	li_de_row_cnt = lds_de_detail.RowCount()
//	
//	
////	//do filter if its a past years query
//	li_query_years = lds_app_fld_data.GetItemNumber( 1, "past_years_query" )
//	ls_past_filter = ""
//
//	IF li_query_years > 0 THEN //if set to past years query ///yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
//		//debugbreak()
//		ck1 = 0
//		li_trap = 0
//		if lds_de_detail.Describe("year_thru.ColType") <> "!" then //check for year_thru field
//			ls_year =  String( Year( RelativeDate(Today(), (li_query_years * 365)* -1 )) )
//			ls_past_filter = "year_thru >= " + ls_year
//			ck1 = 1
//		elseif lds_de_detail.Describe("end_date.ColType") <> "!" then //check for end_date field
//			ld_pastdate = RelativeDate(Today(), (li_query_years * 365)* -1 )
//			ls_past_filter = "date(end_date) >= " + string(ld_pastdate)
//			ck1 = 1
//		else //year_thru or start_date not available
//			messagebox("Invalid filter","There is no year_thru or end_date field to filter.  The 'Data from last X years' filter is intended only for data screens with year_thru or end_date fields (Hosp Affil, Professional Exp. etc.).  If one of these fields does not exist or is not visible on the default view, then this filter cannot be used.")
//		end if
//		if ck1 = 1 then 
//			li_trap = lds_de_detail.SetFilter( ls_past_filter )
//			if li_trap = 1 then //maha 090705
//				lds_de_detail.Filter()
//			else
//				messagebox("Invalid past years filter",ls_past_filter)
//			end if
//		end if
//		li_de_row_cnt = lds_de_detail.RowCount()
//	END IF
//	
//	IF li_de_row_cnt = 0 THEN
//		CONTINUE
//	END IF
//
//	
//	ll_last_data_value = 0
//	
//	FOR li_fld_loop = 1 TO li_app_fld_cnt
//		ai_obj.st_2.text = ""
//		SetNull( ls_format )
//		SetNull( ls_data )
//		SetNull( ll_data )		
//		li_app_field_id = lds_app_fld_data.GetItemNumber( li_fld_loop, "app_field_id" )
//		ls_field_type = lds_app_fld_data.GetItemString( li_fld_loop, "field_type" )
//		ls_link_type = lds_app_fld_data.GetItemString( li_fld_loop, "lookup_link_type" )
//		ls_link_field = Lower( lds_app_fld_data.GetItemString( li_fld_loop, "lookup_link_field" ) )
//		ls_field_name = lds_app_fld_data.GetItemString( li_fld_loop, "field_name")		
//		IF li_screen_id = 2 THEN
//			ls_field_name = "pd_address_" + ls_field_name
//		END IF		
//		li_record_number = lds_app_fld_data.GetItemNumber( li_fld_loop, "record_number")		
//		ai_obj.st_rec.text = String( li_record_number)
//		//if there is a record query involved filter the records
//
//		IF Upper( lds_app_fld_data.GetItemString( li_fld_loop, "query_field") ) = "ADDRESS_TYPE" THEN			
//			CHOOSE CASE Upper (lds_app_fld_data.GetItemString( li_fld_loop, "query_value") )
//				//primary office
//				CASE "647"
//					ls_query = "pd_address_link_primary_office = 1"
//				//additional office
//				CASE "256"
//					ls_query = "pd_address_link_additional_office = 1"
//				//home addrss
//				CASE "648"
//					ls_query = "pd_address_link_home_address =  1"
//				CASE "24472"
//					ls_query = "pd_address_link_billing =  1"					
//				CASE "24477"
//					ls_query = "pd_address_link_mailing =  1"					
//				CASE ELSE
//					MessageBox("Error", "Unknown address type. (" + Upper (lds_app_fld_data.GetItemString( li_fld_loop, "query_value") )  )
//			END CHOOSE
//			ls_query_value = ""
//		ELSE
//			ls_query = lds_app_fld_data.GetItemString( li_fld_loop, "query_field") +&
//						  lds_app_fld_data.GetItemString( li_fld_loop, "query_operator")
//			ls_query_value =  lds_app_fld_data.GetItemString( li_fld_loop, "query_value")
//			IF ls_link_type = "A" OR ls_link_type = "C" THEN //maha added 112101 put query values in quotes for char fields
//				if mid(ls_query,1,4) = "cust" then
//					ls_query_value = "'" + ls_query_value + "'"
//				end if
//			end if
//		END IF
//		IF  Pos( Upper(ls_query_value), "TODAY")  > 0 THEN
//			ls_query_value = "Date('"+ String( Today() ) + "')"
//		END IF
//// query for nulls
//		IF  Pos( Upper(ls_query_value), "NOT NULL")  > 0 THEN
//			ls_query_value = ""
//			ls_query = " not isnull(" + ls_query + ")"
//			//ls_query_value = " Is Null('"+ ls_query_value + "')"
//		elseif Pos( Upper(ls_query_value), "NULL")  > 0 THEN
//			ls_query_value = ""
//			ls_query = "isnull(" + ls_query + ")"
//		END IF
//
//		ls_query = ls_query + ls_query_value
//		//messagebox("ls_query",ls_query)
//		li_billing_flag = lds_app_fld_data.GetItemNumber( li_fld_loop, "billing_address_flag" )
//		
//		IF Len( ls_query ) > 0 THEN
//			IF ls_last_query <> ls_query OR li_billing_flag = 1 THEN
//				IF ls_past_filter <> "" THEN
//					lds_de_detail.SetFilter( ls_query + " AND " + ls_past_filter )													
//				ELSE
//					lds_de_detail.SetFilter( ls_query )
//				END IF
//			//	messagebox("ls_query",ls_query)
//				lds_de_detail.Filter( )		
//				ls_last_query = ls_query				
//				li_de_row_cnt = lds_de_detail.RowCount()
//						//messagebox("1st",li_de_row_cnt)
//				//new billing code		JAD 11/9/01
//				IF lds_app_fld_data.GetItemNumber( li_fld_loop, "billing_address_flag" ) = 1 THEN
//					IF li_record_number > lds_de_detail.RowCount() THEN
//						MessageBox( "Population Error", "There is no primary address setup for this practitioner." )
//						CONTINUE
//					END IF
//					ll_billing_address_id = lds_de_detail.GetItemNumber( li_record_number, "pd_address_billing_address_id" )
//					IF ll_billing_address_id > 0 THEN
//						ls_last_query = "billing_address_id = " + String( ll_billing_address_id )					
//						lds_de_detail.SetFilter( "pd_address_rec_id = " + String( ll_billing_address_id ) )
//						lds_de_detail.Filter( )				
//						li_record_number = 1
//					END IF
//				END IF
//				
//			END IF			
//		ELSE
//			ls_query = ""
//			ls_last_query = ""
//			IF ls_past_filter = "" THEN	
//				lds_de_detail.SetFilter( "" )
//				lds_de_detail.Filter( )
//			ELSE
//				lds_de_detail.SetFilter( ls_past_filter )
//				lds_de_detail.Filter()				
//			END IF
//		END IF
//		li_de_row_cnt = lds_de_detail.RowCount()
//		IF li_record_number > li_de_row_cnt THEN
//			CONTINUE
//		END IF		
//		//lds_de_detail.Sort()
//		ls_object_type = lds_app_fld_data.GetItemString( li_fld_loop, "box_type")		
//		ai_obj.st_2.text = ls_field_name + " (" + String( li_app_field_id ) + ")"
//
//		IF ls_link_type = "A" OR ls_link_type = "C" THEN
//			//messagebox("",ls_field_type)
//			if ls_field_type = "C" THEN
//				ll_data = Long( lds_de_detail.GetItemString( li_record_number, ls_field_name ) )
//			ELSE
//				ll_data = lds_de_detail.GetItemNumber( li_record_number, ls_field_name )
//			end if
////			IF Upper( Left( ls_field_name, 4 ) ) = "CUST" THEN
////				ll_data = Long( lds_de_detail.GetItemString( li_record_number, ls_field_name ) )
////			elseif Upper( Left( ls_field_name, 9 ) ) = "ADMITTING" THEN
////				ll_data = Long( lds_de_detail.GetItemString( li_record_number, ls_field_name ) )
////			//elseif Upper( Left( ls_field_name, 9 ) ) = "TITLE_DUT" THEN
////			//	ll_data = Long( lds_de_detail.GetItemString( li_record_number, ls_field_name ) )	
////			elseif Upper( Left( ls_field_name, 13 ) ) = "PROVIDER_NAME" THEN
////				ll_data = Long( lds_de_detail.GetItemString( li_record_number, ls_field_name ) )
////			ELSE
////				ll_data = lds_de_detail.GetItemNumber( li_record_number, ls_field_name )					
////			END IF
//			li_retval = lds_de_detail.GetChild( ls_field_name, dwchild )
//			DEBUGBREAK()
//			IF NOT IsNull( ll_data ) THEN
//				IF ls_link_type = "A" THEN
//					IF ll_last_data_value <> ll_data THEN
//						ll_found = dwchild.Retrieve( ll_data )		
//						ll_last_data_value = ll_data									
//					END IF
//				ELSE
//					ll_last_data_value = 0
//					ll_found = dwchild.Find( "lookup_code = " + String(ll_data), 1, dwchild.RowCount() )
//				END IF
//				IF ll_found = 0 THEN
//					MessageBox("Error", "Could not find dwchild data" )
//					CONTINUE
//				END IF
//				ls_data = dwchild.GetItemString( ll_found, ls_link_field )
//			END IF
//		ELSE
//			ls_format =	lds_app_fld_data.GetItemString( li_fld_loop, "format" ) 
//			lds_app_fld_data.GetItemString( li_fld_loop, "lookup_link_type" ) 
//			CHOOSE CASE Upper( ls_field_type )
//			CASE "C"	//string
//				ls_data = lds_de_detail.GetItemString( li_record_number, ls_field_name )		
//			CASE "D"	//date
//				ldt_data = lds_de_detail.GetItemDateTime( li_record_number, ls_field_name )						
//				CHOOSE CASE Upper(ls_format)
//					CASE "DATE(MM/DD/YYYY)"
//						ls_data = String( ldt_data, 'mm/dd/yyyy')
//					CASE "DATE(MM/DD/YY)"
//						ls_data = String( ldt_data, 'mm/dd/yy')
//					CASE "DATE(MM-DD-YYYY)"
//						ls_data = String( ldt_data, 'mm-dd-yyyy')
//					CASE "DATE(MM-DD-YY)"
//						ls_data = String( ldt_data, 'mm-dd-yy')
//					CASE "DATE(MM/YYYY)"
//						ls_data = String( ldt_data, 'mm/yyyy')																		
//					CASE ELSE
//						ls_data = String( ldt_data, 'mm/dd/yyyy')
//				END CHOOSE						
//			CASE "N", "I" //number
//				IF Upper( ls_format ) = "MONEY" THEN
//					ls_data = String(lds_de_detail.GetItemNumber( li_record_number, ls_field_name ), '$0,000,000')															
//				ELSE
//					ls_data = String(lds_de_detail.GetItemNumber( li_record_number, ls_field_name ))										
//				END IF
//			END CHOOSE
//		END IF		
//		IF ( IsNull( ls_data ) OR Trim( ls_data ) = "" ) AND ls_object_type <> "C" THEN
//			//ai_obj.ole_edit.Object.SelectAnnotationGroup( String( li_app_field_id ) )
//			//ai_obj.ole_edit.Object.DeleteAnnotationGroup( String( li_app_field_id ) )
//			CONTINUE
//		END IF				
//		CHOOSE CASE Upper( ls_object_type )
//			CASE "T"//text
//				CHOOSE CASE Upper(ls_format)
//					CASE "PHONE"
//						//messagebox("format","phone")
//						IF Pos( ls_data, "-" ) = 0 AND Pos( ls_data, "(" ) = 0 THEN
//							IF len( ls_data) = 10 THEN
//								ls_data = "(" + Mid( ls_data, 1,3 ) + ")" + Mid( ls_data, 4,3 ) + "-" + Mid( ls_data, 7, 4 )
//							ELSE
//								ls_data = Mid( ls_data, 1,3 ) + "-" + Mid( ls_data, 4, 4 )							
//							END IF
//						END IF
//					CASE "SS#"
//						//messagebox("format","ssn")
//						ls_data = Mid( ls_data, 1,3 ) + "-" + Mid( ls_data, 4, 2 ) + "-" + Mid( ls_data, 6, 4 )							
//				END CHOOSE
//				li_width = lds_app_fld_data.GetItemNumber( li_fld_loop, "width" )			
//				ls_data = Mid( ls_data, 1, li_width )
//				//ai_obj.ole_edit.Object.SelectAnnotationGroup( String( li_app_field_id ) )
//				//ai_obj.ole_edit.Object.DeleteAnnotationGroup( String( li_app_field_id ) )
//				li_x = lds_app_fld_data.GetItemNumber( li_fld_loop, "x_pos" )
//				li_y = lds_app_fld_data.GetItemNumber( li_fld_loop, "y_pos" )
//				ai_obj.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) )
//				li_cal_field_id = lds_app_fld_data.GetItemNumber( li_fld_loop, "connect_field_id" )
//				IF li_cal_field_id > 0 THEN
//					li_array = lds_app_fld_data.GetItemNumber( li_fld_loop, "connect_field_sort" )
//					ls_data_value[ li_cal_field_id, li_array ] = ls_data
//				END IF
//				IF IsNull( ls_data ) THEN
//					ls_data = ""
//				END IF
//
//				ai_obj.ole_edit.object.AnnotationStampText( ls_data + "    " )
//				ai_obj.ole_edit.object.AnnotationFontColor( RGB(0,0,128) )
//				ai_obj.ole_edit.object.Annotationtype(8)
//				CHOOSE CASE lds_app_fld_data.GetItemNumber( li_fld_loop, "font_size" )
//					CASE 1
//						ai_obj.ole_edit.Object.AnnotationFont.Name = "MS Serif"
//						ai_obj.ole_edit.Object.AnnotationFont.Size = 7
//					CASE 2
//						ai_obj.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
//						ai_obj.ole_edit.Object.AnnotationFont.Size = 8				
//					CASE 3
//						ai_obj.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
//						ai_obj.ole_edit.Object.AnnotationFont.Size = 12				
//				END CHOOSE
//				IF lds_app_fld_data.GetItemNumber( 1, "font_bold" ) = 1 THEN
//					ai_obj.ole_edit.Object.AnnotationFont.Bold = True
//				ELSE
//					ai_obj.ole_edit.Object.AnnotationFont.Bold = False
//				END IF					
//				li_width = lds_app_fld_data.GetItemNumber( li_fld_loop, "annotation_width" )			
//				li_height = lds_app_fld_data.GetItemNumber( li_fld_loop, "height" )	
//
//				ai_obj.ole_edit.object.Draw(li_x, li_y, li_width, li_height)
//				lb_page_populated[ p ] = True
//			CASE "Y1"
//				ls_true_value = lds_app_fld_data.GetItemString( li_fld_loop, "box_yes_value")		
//				ls_false_value = lds_app_fld_data.GetItemString( li_fld_loop, "box_no_value")		
//				IF ls_true_value = ls_data THEN
//					ai_obj.ole_edit.Object.ShowAnnotationGroup( String( li_app_field_id ) + "YesBox")					
//				ELSEIF ls_false_value = ls_data THEN
//					ai_obj.ole_edit.Object.ShowAnnotationGroup( String( li_app_field_id ) + "NoBox")															
//				END IF
//			CASE "C" //checkbox
//				ls_true_value = lds_app_fld_data.GetItemString( li_fld_loop, "box_yes_value")	
//				IF ( ls_true_value = ls_data ) OR ( POS( Upper(ls_true_value), "NOT NULL") > 0 AND Len(ls_data) >0) OR +&
//				   ( (Len(ls_data) = 0 OR IsNull( ls_data ) ) AND POS( Upper(ls_true_value), "IS NULL") > 0 ) THEN 
//					li_x = lds_app_fld_data.GetItemNumber( li_fld_loop, "x_pos" )
//					li_y = lds_app_fld_data.GetItemNumber( li_fld_loop, "y_pos" )					
//					ai_obj.ole_edit.object.AnnotationStampText( "X" )
//					ai_obj.ole_edit.object.AnnotationFontColor( RGB(0,0,128) )
//					ai_obj.ole_edit.object.Annotationtype(8)
//					CHOOSE CASE lds_app_fld_data.GetItemNumber( li_fld_loop, "font_size" )
//						CASE 1
//							ai_obj.ole_edit.Object.AnnotationFont.Name = "MS Serif"
//							ai_obj.ole_edit.Object.AnnotationFont.Size = 7
//						CASE 2
//							ai_obj.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
//							ai_obj.ole_edit.Object.AnnotationFont.Size = 8				
//						CASE 3
//							ai_obj.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
//							ai_obj.ole_edit.Object.AnnotationFont.Size = 12				
//					END CHOOSE
//					IF lds_app_fld_data.GetItemNumber( 1, "font_bold" ) = 1 THEN
//						ai_obj.ole_edit.Object.AnnotationFont.Bold = True
//					ELSE
//						ai_obj.ole_edit.Object.AnnotationFont.Bold = False
//					END IF					
//					li_width = lds_app_fld_data.GetItemNumber( li_fld_loop, "annotation_width" )			
//					li_height = lds_app_fld_data.GetItemNumber( li_fld_loop, "height" )	
//
//					ai_obj.ole_edit.object.Draw(li_x, li_y, li_width, li_height)					
//					//ai_obj.ole_edit.Object.ShowAnnotationGroup( String( li_app_field_id ) + "Check")															
//				END IF				
//		END CHOOSE
//	END FOR
//	//messagebox("", "mem check 4" )
//	
//	Integer li_sort_cnt	
//	Integer li_field_cnt
//	Integer c
//	Integer li_anc_calc_field
//	Integer li_temp_calc_field
//	Integer li_ancor_field
//	String ls_calc_field
//	lds_app_fld_data.SetFilter( "connect_field_id > 0" )
//	lds_app_fld_data.Filter( )
//	li_field_cnt = lds_app_fld_data.RowCount()
//	IF li_field_cnt > 0 THEN
//		lds_app_fld_data.SetSort( "connect_field_id, connect_field_sort" )
//		lds_app_fld_data.Sort()
//		li_temp_calc_field = 0
//		FOR c = 1 TO li_field_cnt
//			li_cal_field_id = lds_app_fld_data.GetItemNumber( c, "connect_field_id" )			
//	
//			IF li_temp_calc_field <> li_cal_field_id THEN
//				IF c <> 1 THEN
//					ai_obj.ole_edit.Object.AddAnnotationGroup( String(li_anc_calc_field) )
//					ai_obj.ole_edit.object.AnnotationStampText( ls_calc_field )
//					ai_obj.ole_edit.object.AnnotationFontColor( RGB(0,0,128) )
//					ai_obj.ole_edit.object.Annotationtype(8)
//					CHOOSE CASE li_font
//						CASE 1
//							ai_obj.ole_edit.Object.AnnotationFont.Name = "MS Serif"
//							ai_obj.ole_edit.Object.AnnotationFont.Size = 7
//						CASE 2
//							ai_obj.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
//							ai_obj.ole_edit.Object.AnnotationFont.Size = 8				
//						CASE 3
//							ai_obj.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
//							ai_obj.ole_edit.Object.AnnotationFont.Size = 12				
//					END CHOOSE
//					IF lds_app_fld_data.GetItemNumber( 1, "font_bold" ) = 1 THEN
//						ai_obj.ole_edit.Object.AnnotationFont.Bold = True
//					ELSE
//						ai_obj.ole_edit.Object.AnnotationFont.Bold = False
//					END IF
//					ai_obj.ole_edit.object.Draw(li_x, li_y, li_width, li_height)					
//					lb_page_populated[ p ] = True					
//				END IF
//				li_anc_calc_field = lds_app_fld_data.GetItemNumber( c, "app_field_id" )
//				li_ancor_field = 1
//				li_temp_calc_field = li_cal_field_id
//				ls_calc_field = ""
//				li_x = lds_app_fld_data.GetItemNumber( c, "x_pos" ) - 5
//				li_y = lds_app_fld_data.GetItemNumber( c, "y_pos" )				
//				li_font = lds_app_fld_data.GetItemNumber( c, "font_size" )				
//				li_width = lds_app_fld_data.GetItemNumber( c, "annotation_width" )			
//				li_height = lds_app_fld_data.GetItemNumber( c, "height" )							
//				li_sort_cnt = 0
//			END IF
//			li_sort_cnt ++
//			li_app_field_id = lds_app_fld_data.GetItemNumber( c, "app_field_id" )			
//			ai_obj.ole_edit.Object.SelectAnnotationGroup( "" )
//			ai_obj.ole_edit.Object.SelectAnnotationGroup( String( li_app_field_id ) )
//			ai_obj.ole_edit.Object.DeleteAnnotationGroup( String( li_app_field_id ) )						
//			ls_calc_field = ls_calc_field + " " + ls_data_value[ li_cal_field_id, li_sort_cnt ]
//			IF c = li_field_cnt OR li_temp_calc_field <> li_cal_field_id THEN
//				ai_obj.ole_edit.Object.AddAnnotationGroup( String(li_anc_calc_field) )
//				ai_obj.ole_edit.object.AnnotationStampText( ls_calc_field )
//				ai_obj.ole_edit.object.AnnotationFontColor( RGB(0,0,128) )
//				ai_obj.ole_edit.object.Annotationtype(8)
//				CHOOSE CASE li_font
//					CASE 1
//						ai_obj.ole_edit.Object.AnnotationFont.Name = "MS Serif"
//						ai_obj.ole_edit.Object.AnnotationFont.Size = 7
//					CASE 2
//						ai_obj.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
//						ai_obj.ole_edit.Object.AnnotationFont.Size = 8				
//					CASE 3
//						ai_obj.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
//						ai_obj.ole_edit.Object.AnnotationFont.Size = 12
//				END CHOOSE
//				IF lds_app_fld_data.GetItemNumber( 1, "font_bold" ) = 1 THEN
//					ai_obj.ole_edit.Object.AnnotationFont.Bold = True
//				ELSE
//					ai_obj.ole_edit.Object.AnnotationFont.Bold = False
//				END IF
//				ai_obj.ole_edit.object.Draw(li_x, li_y, li_width, li_height)
//				lb_page_populated[ p ] = True				
//			END IF			
//		END FOR
//		
//	END IF
//	lds_app_fld_data.SetFilter( "" )
//	lds_app_fld_data.Filter( )	
//
//END FOR
//
////messagebox("", "mem check 5" )
//
////starts here
////FOR ap = 1 TO UpperBound( li_add_page )
////	IF li_add_page[ ap ] = p AND NOT lb_page_populated[] THEN
////		//messagebox("", gs_app_image_path + "blankpage.tif" )
////		ai_obj.ole_edit.Object.Image( gs_app_image_path + "blankpage.tif" ) 
////		ai_obj.ole_edit.Object.Page(1)
////		ai_obj.ole_edit.Object.Display(  )
////		
////		ole_admin.object.image( "c:\printtemp" + String(ii_prac_id) + ".tif" )
////		ole_admin.object.DeletePages( p, 1 )
////		
////		ai_obj.ole_edit.Object.Image( "c:\printtemp" + String(ii_prac_id) + ".tif" )
////		ai_obj.ole_edit.Object.Page(1)
////		ai_obj.ole_edit.Object.FitTo(3)		
////		ai_obj.ole_edit.Object.Display(  )		
////	END IF
////END FOR
////
//
//ai_obj.ole_edit.object.Annotationtype(11)			
//
//ai_obj.ole_edit.Object.Save()
//
//END FOR
//
////messagebox("", "mem check 6" )
//
//IF Len( ls_add_pages ) > 0 THEN
//	ai_obj.ole_edit.Object.Image( gs_app_image_path + "blankpage.tif" ) 
//	ai_obj.ole_edit.Object.Page(1)
//	ai_obj.ole_edit.Object.Display(  )	
//	ai_obj.ole_admin.object.image( ls_save_as )
//
//	li_delete_p = 0
//
//	FOR p = 1 TO ai_to_page
//		FOR ap = 1 TO UpperBound( li_add_page )
//			IF p = li_add_page[ ap ] AND NOT lb_page_populated[ p ] THEN
//				ai_obj.ole_admin.object.DeletePages( p - li_delete_p, 1 )
//				li_delete_p ++
//			END IF
//		END FOR
//	END FOR
//
//	ai_obj.ole_edit.Object.Image( ls_save_as )
//	ai_obj.ole_edit.Object.Page(1)
//	ai_obj.ole_edit.Object.FitTo(3)		
//	ai_obj.ole_edit.Object.Display(  )		
//END IF
//
////messagebox("", "mem check 7" )
//
//ai_obj.ole_edit.Object.Page( ai_from_page )
//ai_obj.ole_edit.Object.FitTo(3)		
//ai_obj.ole_edit.Object.Display(  )		
//ai_obj.ii_current_page = ai_from_page
//ai_obj.st_page_num.Text = "Page " + String( ai_from_page ) + " of " + String( ai_obj.ole_edit.Object.PageCount() )
//IF ai_obj.ii_current_page > 1 THEN
//	ai_obj.cb_prior.Enabled = True
//ELSE
//	ai_obj.cb_prior.Enabled = False
//END IF
//
//IF ai_obj.ii_current_page < ai_obj.ole_edit.Object.PageCount( ) THEN
//	ai_obj.cb_next.Enabled = True
//END IF
//
//DESTROY lds_screen_list
//DESTROY lds_app_fld_data
//DESTROY lds_screen_fields
//DESTROY lds_app
//DESTROY lds_de_detail
//DESTROY de_functions
//
////messagebox("", "mem check 8" )
//
//ai_obj.SetRedraw( True )
//
RETURN 0
end function

on pfc_cst_nvo_gen_app.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pfc_cst_nvo_gen_app.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

