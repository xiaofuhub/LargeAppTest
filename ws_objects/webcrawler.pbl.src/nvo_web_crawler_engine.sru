$PBExportHeader$nvo_web_crawler_engine.sru
forward
global type nvo_web_crawler_engine from nonvisualobject
end type
end forward

global type nvo_web_crawler_engine from nonvisualobject autoinstantiate
end type

type variables
boolean ib_image_saved = false
boolean ib_verif_ext
boolean ib_test = false
boolean ib_from_batch_verif = false  //maha 07.21.2015

string is_url
string is_no_results_message
string is_path
string is_saved_file
string is_verif_search_val
string is_iim_path  //maha 05.15.07
string is_varmod

integer ii_type
integer ii_resp_step
integer ii_macro_ver = 6 //maha 06.16.2014

long il_prac  //maha 07.21.2015
long il_recid  //maha 07.21.2015
long il_screen  //maha 07.21.2015

n_ds ids_prac
n_ds ids_wc
n_ds ids_steps
n_ds ids_screen_data
n_ds ids_ref_data
n_ds ids_table_data

n_cst_message inv_message //scheduler - alfee 02.06.2010
n_cst_filesrvwin32 inv_filesrv //(Appeon)Stephen 2013-07-13 - Feature request #3602
Boolean ib_schedule = false //scheduler - alfee 02.25.2010
DataStore ids_wc_ret //scheduler - alfee - 03.25.2010
boolean ib_extract = false  //V12.2 WebCrawler extract data -stephen 06.29.2012
string    is_extract             //V12.2 WebCrawler extract data -stephen 06.29.2012
OLEObject myoleobject  //maha 12.16.2015 made instance from of_crawl_new
end variables

forward prototypes
public function integer of_crawl (integer ai_wc_id, integer facility_id, long al_prac_id, string as_doc_id, boolean ab_show_macro_running)
public function integer of_build_crawl (integer ai_start, integer ai_end, integer ai_loop)
public function string of_spaces (string as_val)
public function long of_image_save (string as_doc_id, integer ai_update)
public function string of_format_value (integer ai_type, string as_value)
public function string of_format_date (integer ai_type, datetime adt_date)
public function long of_verif_response (integer ai_wcid, integer ai_step, string as_extract)
public function string of_get_data_value (string as_data, long al_step)
public function string of_get_sched_msg ()
public function integer of_get_sched_cnt ()
public function string of_error_message (integer ai_mes)
public function integer of_set_verifs_aftercrawl (datawindow adw_verif_list, string as_crawl_res, long al_row)
public function integer of_set_verifs (datawindow adw_verif_list, boolean ab_crawler)
public function string of_parse_status (integer ai_status)
public function integer of_set_sched_flag (boolean ab_flag)
public function integer of_set_crawl_value (integer ai_wc_id, string as_wc_ret)
public function string of_get_crawl_value (integer ai_wc_id)
public function string of_crawl_new (integer ai_wc_id, long al_prac_id, string as_doc_id, boolean ab_show_crawler, long al_rec_id, long al_facility_id)
public function integer of_save_extracted_data (string as_extract, long al_screen_id, string as_field_id, long al_prac_id, string as_doc_id, long al_rec_id, long al_facility_id)
public function integer of_delete_craw_file (string as_type)
public function string of_get_reference_data (long al_prac, long al_rec, integer ai_screen, string as_ref_field)
public function integer of_get_macro_directory (string as_test)
end prototypes

public function integer of_crawl (integer ai_wc_id, integer facility_id, long al_prac_id, string as_doc_id, boolean ab_show_macro_running);//@@@ this function NO LONGER USED -- use of_crawl_new
Blob lb_our_blob
Blob lb_tot_b
Blob blob_temp
Blob total_blob
Blob blank_blob 
Blob lb_verif_picture
Boolean lb_image_saved = False
Boolean lb_extract_verif_result = False
Boolean 	lb_check_for_no_results = False
Long fh
Long ll_retval  // -100 = no data found page came up  -200 = macro error
Long ll_rec_id
Long ll_verif_response_cd
Long ll_filelen
Long ll_bytes_read
Long ll_new_pos 
Long ll_cnt
String ls_sql
String ls_file_type
String ls_no_results_message
String ls_ic_ver_cd
String ls_ic_vef_cd
String ls_response_code
String ls_html_search_val
String ls_line
String ls_web_site_data
String ls_content
String ls_char
string ls_path //maha 111605
string ls_saved_file //maha 012907
string ls_form_val //maha020607
string ls_obj_pos //maha020607
string ls_obj_name //maha020607
string ls_var_name
string ls_actno 
string ls_userid
string ls_pass
string ls_macro_object //031510
integer li_type //012907
Integer li_filenum
Integer li_loops
Integer li_counter 
Integer li_retval
Integer li_result
Integer c
Integer li_found_pos
Integer li_step_order
Integer li_ver_extract_step
Integer li_len
Integer li_rc
Integer i
Integer li_FileNum2
integer li_key_test //maha 031510
String ls_value
String ls_step_action
String ls_data_from
String ls_url
String ls_tag
String ls_f_name
String ls_m_name
String ls_l_name
String ls_prof_suffix
String ls_ssn
String ls_reference
String ls_ref_1
String ls_ref_2
DateTime ldt_exp_dt
DateTime ldt_dob
n_ds lds_steps
n_ds lds_web_verif_rsp_mapping

ls_path = gs_temp_path //maha111605
//maha 111605 modifed from storing directly on the gs_dir_path which typically is C:\ 
FileDelete( ls_path + "_ResultPage.htm" )
FileDelete( ls_path + "_ResultPage.bmp" )
FileDelete( ls_path + "_ResultPage.pdf" )

SELECT v_full_name.first_name,   
       v_full_name.middle_name,   
       v_full_name.last_name,   
       v_full_name.prof_suffix,   
       v_full_name.date_of_birth,   
       v_full_name.ssn,   
       v_verif_info.reference_value,   
       v_verif_info.expiration_date  
INTO :ls_f_name, :ls_m_name, :ls_l_name, :ls_prof_suffix, :ldt_dob, :ls_ssn, :ls_reference, :ldt_exp_dt
FROM v_full_name,   
     v_verif_info  
WHERE ( v_full_name.prac_id = v_verif_info.prac_id ) AND
      ( v_verif_info.doc_id = :as_doc_id);
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
	RETURN -1
END IF

ls_ref_1 = MidA( ls_reference, 1, PosA( ls_reference, "-" ) -1 )
ls_ref_2 = MidA( ls_reference, PosA( ls_reference, "-" ) + 2, 100 )

SELECT wc_web_address
	INTO: ls_url
	FROM wc_hdr
	WHERE wc_id = :ai_wc_id;
IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
		FileClose( li_fileNum)
		RETURN -1
END IF									
IF Upper( MidA( ls_url, 1, 4 ))  <> "HTTP" THEN
	ls_url = "HTTP://" + ls_url
END IF
//maha 021307
SELECT web_site_account_number,
web_site_user_id,
web_site_password
into :ls_actno, :ls_userid, :ls_pass
from wc_hdr
where wc_id = :ai_wc_id  ;

lds_steps = CREATE n_ds
lds_steps.DataObject = "d_wc_steps_browse"
lds_steps.of_SetTransObject( SQLCA )
lds_steps.Retrieve( ai_wc_id )
li_rc = lds_steps.RowCount( )
lds_steps.Sort( )

li_FileNum = FileOpen("C:\Program Files\InternetMacros\Macros\WebCrawl.iim",  LineMode!, Write!, LockWrite!, Replace!)
FileWrite( li_FileNum, "TAB T=1" )
FileWrite( li_FileNum, "TAB CLOSEALLOTHERS" )
FileWrite( li_FileNum, "SIZE X=800 Y=600" )

//Start Code Change ----10.18.2006 #1 maha
// modified path references to use ls_path.  Also added some error traps for the InternetMacros functions.
FOR i = 1 TO li_rc
	
	//messagebox("",i)
	ls_content = ""
	ls_step_action = lds_steps.GetItemString( i, "step_action" )
	li_step_order = lds_steps.GetItemNumber( i, "step_order" )
	ls_obj_pos = String(lds_steps.GetItemNumber( i, "object_pos" ))
	if isnull(ls_obj_pos) then ls_obj_pos = "1"
	ls_content = lds_steps.GetItemString( i, "content_or_value" )
	if isnull(ls_content) then ls_content = ""
	choose case ls_content //variable used in extract of data
		case "VAR1","VAR2","VAR3"
			//debugbreak()	
			ls_var_name = "{{!" + ls_content + "}}"
	end choose
	ls_obj_name = lds_steps.GetItemstring( i, "object_name" )
	ls_form_val = lds_steps.GetItemString( i, "form_handler" )

	CHOOSE CASE ls_step_action
			
		CASE "Save PDF File"     	
			ls_file_type = "pdf"
			li_type = 2
			lb_image_saved = True
			ls_saved_file = ls_path + "_ResultPage.pdf"
			//ls_tag = "ONDOWNLOAD FOLDER=FOLDER=" + ls_path + " FILE=_ResultPage"
			ls_tag = "ONDOWNLOAD FOLDER=" + ls_path + " FILE=_ResultPage"
			FileWrite( li_FileNum, ls_tag  )
			ls_tag = "SAVEAS TYPE=HTM FOLDER=" + ls_path + " FILE=_ResultPage.htm"
			FileWrite( li_FileNum, ls_tag  )
			ls_tag = "SAVEITEM"           			
			FileWrite( li_FileNum, ls_tag  )		
		CASE "Go To Web Site URL"
//			SELECT wc_web_address //maha moved up 02.06.07
//			INTO: ls_url
//			FROM wc_hdr
//			WHERE wc_id = :ai_wc_id;
//			IF SQLCA.SQLCODE = -1 THEN
//					MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
//					FileClose( li_fileNum)
//					RETURN -1
//			END IF									
//			IF Upper( Mid( ls_url, 1, 4 ))  <> "HTTP" THEN
//				ls_url = "HTTP://" + ls_url
//			END IF
			FileWrite( li_FileNum, "URL GOTO=" + ls_url  )			
			
		CASE "Fill In Edit Box"
			//  TAG POS=1 TYPE=INPUT:TEXT FORM=ACTION:licensetypecode.asp ATTR=NAME:License CONTENT=9107 
			ls_tag = "TAG POS=" + ls_obj_pos
			
			
			IF PosA( ls_form_val, ".asp" ) > 0 THEN  //maha 021207
				ls_tag = ls_tag + " TYPE=INPUT:TEXT FORM=NAME:" + ls_form_val
			elseIF PosA( ls_form_val, "." ) > 0 THEN //if a dot exists set as action ; otherwise as name
				ls_tag = ls_tag + " TYPE=INPUT:SUBMIT FORM=ACTION:" + ls_form_val
			ELSE
				ls_tag = ls_tag + " TYPE=INPUT:TEXT FORM=NAME:" + ls_form_val		//was submit changed to text 021306
			END IF
			
			ls_tag = ls_tag + " ATTR=NAME:" + ls_obj_name
			ls_data_from = ls_content
			
			CHOOSE CASE Upper(ls_data_from)
				CASE "VERIF REFERENCE 1"
					ls_value = ls_ref_1
				CASE "VERIF REFERENCE 2"					
					ls_value = ls_ref_2	
				case "LAST NAME"
					ls_value = ls_l_name
				case "FIRST NAME"
					ls_value = ls_f_name
				case "ACCOUNT NUMBER"
					ls_value = ls_actno
				case "USER NAME"
					ls_value = ls_userid
				case "PASSWORD"
					ls_value = ls_pass
				CASE ELSE					
					ls_value = ls_data_from
			END CHOOSE
			

			li_len = LenA( ls_value )
			FOR c = 1 TO li_len			
				ls_char = MidA( ls_value, c, 1 )
				IF ls_char = " " THEN
					ls_value = MidA( ls_value, 1, c -1 ) + "<SP>" + MidA( ls_value, c + 1, 1000 )
				END IF
			END FOR			
			
			ls_tag = ls_tag + " CONTENT=" + ls_value
			FileWrite( li_FileNum, ls_tag  )						
			
		CASE "Click Submit"									
			//TAG POS=1 TYPE=INPUT:SUBMIT FORM=ACTION:licensecode.asp ATTR=NAME:Accept&&VALUE:Accept  
			ls_tag = "TAG POS=" + ls_obj_pos
			
			IF PosA( ls_form_val, ".asp" ) > 0 THEN  //maha 021207
				ls_tag = ls_tag + " TYPE=INPUT:SUBMIT FORM=NAME:" + ls_form_val
			elseIF PosA( ls_form_val, "." ) > 0 THEN //if a dot exists set as action ; otherwise as name
				ls_tag = ls_tag + " TYPE=INPUT:SUBMIT FORM=ACTION:" + ls_form_val
			ELSE
				ls_tag = ls_tag + " TYPE=INPUT:SUBMIT FORM=NAME:" + ls_form_val				
			END IF
			
			ls_value = ls_content
			
			li_len = LenA( ls_value )
			FOR c = 1 TO li_len			// this adds a <sp> tag for existing spaces
				ls_char = MidA( ls_value, c, 1 )
				IF ls_char = " " THEN
					ls_value = MidA( ls_value, 1, c -1 ) + "<SP>" + MidA( ls_value, c + 1, 1000 )
				END IF
			END FOR			
						 
			ls_tag = ls_tag + " ATTR=NAME:" + ls_obj_name + "&&" + "VALUE:" + ls_value
			lds_steps.SetItem( i, "notes", ls_tag )
			FileWrite( li_FileNum, ls_tag  )	
			IF lds_steps.GetItemNumber( i, "no_data_found_check" ) = 1 THEN			
				lb_check_for_no_results = True
				ls_no_results_message = Upper(lds_steps.GetItemString( i, "no_data_found_text" ))
			END IF
			IF lds_steps.GetItemNumber( i, "search_opens_seperate_win" ) = 1 THEN
				FileWrite( li_FileNum,  "TAB CLOSE"  )	
			END IF
		CASE	"Click on Image Submit" //maha 02.13.07 //created for 'board certified docs'  crawler
			//debugbreak()
			ls_tag = "TAG TYPE=INPUT:IMAGE FORM=NAME:"  + ls_form_val 
			ls_tag = ls_tag + " ATTR=NAME:" + ls_obj_name + "&&VALUE:"
			FileWrite( li_FileNum, ls_tag  )
		CASE "Save Page as Image"	
			ls_file_type = "bmp"
			li_type = 4
			lb_image_saved = True
			ls_saved_file = ls_path + "_ResultPage.bmp"
			ls_tag = "SAVEAS TYPE=BMP FOLDER=" + ls_path + " FILE=_ResultPage.bmp"
			FileWrite( li_FileNum, ls_tag  )								
			ls_tag = "SAVEAS TYPE=HTM FOLDER=" + ls_path + " FILE=_ResultPage.htm"
			FileWrite( li_FileNum, ls_tag  )			
			//FileWrite( li_FileNum, "WAIT SECONDS=5"  )	
	
		CASE "Extract Single Piece Of Data"
		//@@@@@@@@@@@@@@@@@@@2
			ls_tag = "EXTRACT POS=" + ls_obj_pos  //extract tag
			ls_tag = ls_tag + " TYPE=TXT ATTR=" +  ls_form_val	
			FileWrite( li_FileNum, ls_tag  )
			ls_tag = "SET !" + ls_content +  " {{!EXTRACT}} "  //set variable from extracted value
			FileWrite( li_FileNum, ls_tag  )
		CASE "Extract Verification Result"	
			lb_extract_verif_result = True
			ls_html_search_val = lds_steps.GetItemString( i, "macro_extract_tag" )
			li_ver_extract_step = lds_steps.GetItemNumber( i, "step_order" )
		CASE "Select From List Box"
			//TAG POS=1 TYPE=SELECT FORM=ACTION:http://www.nysed.gov/COMS/OP001/OPSCR2 ATTR=NAME:profcd CONTENT=$Mental<SP>Health<SP>Counselor						
			ls_tag = "TAG POS=" + ls_obj_pos
			ls_tag = ls_tag + " TYPE=SELECT FORM=ACTION:" + ls_form_val			
			ls_tag = ls_tag + " ATTR=NAME:" + ls_obj_name
						
			ls_content = ls_content

			IF ls_content = "Professional Suffix" THEN
				ls_content = ""
				IF lds_steps.GetItemNumber( i, "web_data_comparison_yes_no" ) = 1 THEN
					//messagebox("", ls_prof_suffix)
					SELECT wc_web_data_comparison.web_site_data  
					INTO :ls_content
					FROM wc_web_data_comparison  
					WHERE ( wc_web_data_comparison.wc_id = :ai_wc_id ) AND  
				         ( wc_web_data_comparison.step_order = :li_step_order ) AND  
				         ( wc_web_data_comparison.intellicred_data = :ls_prof_suffix )  ;
					IF SQLCA.SQLCODE = -1 THEN
						MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
						RETURN -1
					END IF
					IF ls_content = "" THEN
						MessageBox( "No Data", "There is no Web Page List Box Value mapped to the Selection physicians Professional Suffix for: "  + ls_prof_suffix + ".  Go to Web Crawler Painter to correct.")
						Return -1
					END IF
				ELSE
					ls_content = ls_prof_suffix
				END IF
			END IF
			
			li_len = LenA( ls_content )
			FOR c = 1 TO li_len			
				ls_char = MidA( ls_content, c, 1 )
				IF ls_char = " " THEN
					ls_content = MidA( ls_content, 1, c -1 ) + "<SP>" + MidA( ls_content, c + 1, 1000 )
				END IF
			END FOR
			ls_content = "$" + ls_content
			ls_tag = ls_tag + " CONTENT=" + ls_content
			FileWrite( li_FileNum, ls_tag  )	
			
		CASE "Select From Drop Down"
			messagebox("Crawl Setup error", "There is no code for processing " + ls_step_action)
			return -1
		CASE "Select From Check Box"
			messagebox("Crawl Setup error", "There is no code for processing " + ls_step_action)
			return -1
		CASE "Select From Radio Button"			
			messagebox("Crawl Setup error", "There is no code for processing " + ls_step_action)
			return -1
		CASE "Select From Table List"			
			messagebox("Crawl Setup error", "There is no code for processing " + ls_step_action)
			return -1
		CASE	"Click on Image Hyperlink" //maha 02.06.07
			//ls_tag = "WAIT seconds=1"
			//FileWrite( li_FileNum, ls_tag  )
			if isnull(ls_form_val)  then ls_form_val = ls_url
			ls_tag = "TAG TYPE=IMG ATTR=TXT:" + ls_form_val  + ls_obj_name
			FileWrite( li_FileNum, ls_tag  )
//			ls_tag = "TAB T=2"
//			FileWrite( li_FileNum, ls_tag  )
		CASE	"Click on Hyperlink" //maha 02.06.07
//			TAG POS=1 TYPE=A ATTR=HREF:http://webpages.charter.net/sunsetcrossing/kitchenthumbs.html  
			ls_tag = "WAIT seconds=1"
			FileWrite( li_FileNum, ls_tag  )
			ls_tag = "TAG TYPE=A ATTR=TXT:" + ls_obj_name
			FileWrite( li_FileNum, ls_tag  )
			
			//ls_tag = "ATTR=HREF:" + ls_content
			//FileWrite( li_FileNum, ls_tag  )
		CASE	"Click on Variable Link" //maha 02.13.07
//			TAG POS=1 TYPE=A ATTR=HREF:http://webpages.charter.net/sunsetcrossing/kitchenthumbs.html  
			//ls_tag = "WAIT seconds=1"
			//FileWrite( li_FileNum, ls_tag  )
			ls_tag = "TAG TYPE=A ATTR=TXT:" + ls_var_name
			//messagebox("",ls_tag)
			FileWrite( li_FileNum, ls_tag  )

		CASE "Save Page as HTML"						
			ls_file_type = "htm"
			li_type = 3
			lb_image_saved = True
			ls_saved_file = ls_path + "_ResultPage.htm"
			//ls_tag = "SAVEAS TYPE=BMP FOLDER=" + ls_path + " FILE=_ResultPage.bmp"
			//FileWrite( li_FileNum, ls_tag  )								
			ls_tag = "SAVEAS TYPE=HTM FOLDER=" + ls_path + " FILE=_ResultPage.htm"
			FileWrite( li_FileNum, ls_tag  )	
			
	END CHOOSE

END FOR
//end if crawler creation

lds_steps.Update( )

FileClose( li_filenum )




OLEObject myoleobject
myoleobject = CREATE OLEObject
li_result = myoleobject.ConnectToNewObject( ls_macro_object )
IF li_result < 0 THEN
		messagebox("of_Crawl failure","Failed to connect to InternetMacros.iim.  Check installation.")
		Return - 900
END IF
debugbreak()
IF ab_show_macro_running THEN
	myoleobject.iimInit() 
ELSE
	myoleobject.iimInit("-tray")		
END IF
//Run the web crawl
li_result = myoleobject.iimPlay ("WebCrawl")
IF li_result < 0 THEN
		messagebox("of_Crawl failure","iimplay failed")
		Return - 900
END IF

IF NOT ab_show_macro_running THEN
	myoleobject.iimExit() 
END IF

//if check for no results
IF lb_extract_verif_result OR lb_check_for_no_results THEN
	if not fileexists(  ls_path + "_ResultPage.htm") then //check to see if file was created
		messagebox("Crawl Error",  ls_path + "_ResultPage.htm" + " file does not exist.")
		return -900 //maha
	end if
	li_filenum2 = FileOpen( ls_saved_file , StreamMode!)
	ls_html_search_val = Upper( ls_html_search_val )	
	DO WHILE  FileRead( li_filenum2, ls_line ) >=  0
		ls_line = Upper( ls_line)
		//check for no results
		IF lb_check_for_no_results THEN
			li_found_pos = PosA( ls_line, ls_no_results_message )  //if the no results text is found return a failure
			IF li_found_pos > 0 THEN
				myoleobject.DisconnectObject()				
				ll_retval = -100
				EXIT
			END IF
		END IF
		If  lb_extract_verif_result  then //if looking for verif result value
			li_found_pos = PosA( ls_line, ls_html_search_val ) //search current line for the tage containing the verif result
			IF li_found_pos > 0 THEN
				li_found_pos = li_found_pos + LenA( ls_html_search_val ) //???
				ls_response_code = Upper( MidA( ls_line, li_found_pos, 30 ) ) //?? substring starts at the end of where the verif value would be??
							
				lds_web_verif_rsp_mapping = CREATE n_ds
				lds_web_verif_rsp_mapping.DataObject = "d_web_data_comparison"
				lds_web_verif_rsp_mapping.of_SetTransObject( SQLCA )
				lds_web_verif_rsp_mapping.Retrieve( ai_wc_id, li_ver_extract_step )			
				lds_web_verif_rsp_mapping.SetSort( "word_len D" )
				lds_web_verif_rsp_mapping.Sort( )
				li_rc = lds_web_verif_rsp_mapping.RowCount( )
				
				FOR i = 1 TO li_rc
					ls_web_site_data = lds_web_verif_rsp_mapping.GetItemString( i, "web_site_data" )		
					IF PosA( ls_response_code, ls_web_site_data  ) > 0 THEN
						ls_ic_ver_cd = lds_web_verif_rsp_mapping.GetItemString( i, "intellicred_data" )
						SELECT lookup_code
						INTO :ll_verif_response_cd
						FROM code_lookup
						WHERE description = :ls_ic_ver_cd;
						IF SQLCA.SQLCODE = -1 THEN
							MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
							RETURN -1
						END IF		
						ll_retval = ll_verif_response_cd
						Exit
					END IF
				END FOR			
				EXIT
			END IF  //if value found
		end if   //if verif extract 
	LOOP	
END IF

IF ll_verif_response_cd = 0 THEN
	ll_retval = 1
END IF

FileClose( li_filenum2 )		
FileClose( li_filenum )
myoleobject.DisconnectObject()	


IF lb_image_saved THEN
	//Put image into db
//	ll_filelen = FileLength( ls_path + "_ResultPage." + ls_file_type ) 
	ll_filelen = FileLength( ls_saved_file ) 


	//messagebox("file",  ls_saved_file )
	
 	li_filenum = FileOpen(ls_saved_file, StreamMode!,READ!,LOCKREAD!)

	IF li_filenum <> -1 THEN	
		//Determine how many FileReads will be necessary to read all of the file ... 
		
		//You can't read in more than 32K at a time 
		IF ll_filelen > 32765 THEN 
   			IF Mod(ll_filelen,32765) = 0 THEN 
	   		  	   li_loops = ll_filelen/32765 
			 ELSE 
   				   li_loops = (ll_filelen/32765) + 1 
	   	 	 END IF 
		ELSE 
   			 li_loops = 1 
		END IF 

		//read the file ... 
		FOR li_counter = 1 to li_loops 
   		 ll_bytes_read = FileRead( li_filenum, blob_temp) 
			 IF ll_bytes_read = -1 THEN
				MessageBox("Error", "Error with FileRead command.  Return -1." )
				Return -1
			 END IF
		    lb_tot_b = lb_tot_b + blob_temp 
   		 ll_new_pos = ll_new_pos + ll_bytes_read 
	   	 FileSeek(li_filenum, ll_new_pos, FROMBEGINNING!) 
	
   		 if LenA(lb_tot_b) > 1000000 then 
	   	     total_blob = total_blob + lb_tot_b 
   	   	  lb_tot_b = blank_blob 
		    end if 
		NEXT 

		total_blob = total_blob + lb_tot_b 
	
		lb_verif_picture = total_blob

		FileClose(li_filenum) 
		
		//messagebox("blob length", len( total_blob) )
		
		UPDATEBLOB verif_info
		SET verification_picture = :lb_verif_picture
		WHERE doc_id = :as_doc_id
		USING SQLCA;
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox("Error", SQLCA.SQLERRTEXT )
			Return -1
		END IF
//messagebox("type", li_type)
		UPDATE verif_info
		SET verification_picture_flag = :li_type
		WHERE doc_id = :as_doc_id
		USING SQLCA;	
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox("Error", SQLCA.SQLERRTEXT )
			Return -1
		END IF		
		
	ELSE
		MessageBox("Web Crawler", "File Open Error.  Could not open " + ls_saved_file + " for StreamMode!" )
		Return -1
	END IF

	IF SQLCA.SQLNRows > 0 THEN
		COMMIT USING SQLCA ;
	ELSEIF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
		Return -1
	ELSEIF SQLCA.SQLNRows = 0 THEN	
		MessageBox( "SQL Error", "No rows effected." )
	END IF
END IF
//End Code Change---10.18.2006

Return ll_retval

end function

public function integer of_build_crawl (integer ai_start, integer ai_end, integer ai_loop);//Start Code Change ---- 02.20.2007 #V7 maha  function created - this creates the crawl steps

Boolean lb_extract_verif_result = False
Boolean 	lb_check_for_no_results = False
Integer li_filenum
Integer c
integer li_wc_id
Integer li_step_order
Integer li_ver_extract_step
Integer li_len
Integer li_rc
Integer i
integer li_wait
long ll_psufx_code
string ls_prosufx_code
String ls_file_type
String ls_file_name
String ls_no_results_message
String ls_html_search_val
String ls_content
String ls_char
string ls_form_val 
string ls_obj_pos 
string ls_obj_name 
string ls_var_name
string ls_actno 
string ls_userid
string ls_pass
String ls_value
String ls_step_action
String ls_data_from
String ls_tag
String ls_f_name
String ls_m_name
String ls_l_name
String ls_prof_suffix
String ls_ssn
String ls_reference
String ls_ref_1
String ls_ref_2
string ls_temp
string ls_type_f
string ls_type_i
string ls_type_a
string ls_path //maha 081808
string ls_crawl_path //maha 090208

//Start Code Change ----08.18.2008 #V85 maha - added path variable to strip spaces; changed code to use the new variable
ls_crawl_path = of_strip_char(" ", is_path,"<SP>") //replace spaces //Start Code Change ----08.28.2008 #V85 maha - changed to uppercase SP
ls_path = is_path
//End Code Change---08.18.2008

ls_file_name =  is_iim_path +   "WebCrawl" + string(ai_loop) + ".iim" //for each segment a separate crawler is written //maha modified 5.15.07 to use registry setting
//ls_file_name = "C:\Program Files\InternetMacros\Macros\WebCrawl" + string(ai_loop) + ".iim" //version 4 location

li_FileNum = FileOpen(ls_file_name,  LineMode!, Write!, LockWrite!, Replace!)
		
//debugbreak()
FOR i = ai_start TO ai_end

	if i = 1 then //if the beginning of the first segment
		//Start Code Change ----05.30.2014 #V14.2 maha
		if ii_macro_ver = 10 then
			FileWrite( li_FileNum, "VERSION BUILD=10002738")
		else
			FileWrite( li_FileNum, "VERSION BUILD=6861208") 
		End if
		//FileWrite( li_FileNum, "VERSION BUILD=5220125")
		//Start Code Change ----05.30.2014
		FileWrite( li_FileNum, "TAB T=1" )
		FileWrite( li_FileNum, "TAB CLOSEALLOTHERS" )
		//FileWrite( li_FileNum, "SIZE X=800 Y=600" ) //Start Code Change ----06.16.2014 #V14.2 maha
		FileWrite( li_FileNum, "SIZE X=1024 Y=600" ) //Start Code Change ----11.19.2016 #V15.2 maha
	end if
	
	ls_step_action = ids_steps.GetItemString( i, "step_action" )
	li_step_order = ids_steps.GetItemNumber( i, "step_order" )
	ls_obj_pos = String(ids_steps.GetItemNumber( i, "object_pos" ))
	if isnull(ls_obj_pos) then ls_obj_pos = "1"
	
	ls_content = ids_steps.GetItemString( i, "content_or_value" )
	if isnull(ls_content) then ls_content = ""
	choose case ls_content //variable used in extract of data
		case "VAR1","VAR2","VAR3"
			ls_var_name = "{{!" + ls_content + "}}"
	end choose
	
	ls_obj_name = ids_steps.GetItemstring( i, "object_name" )
	if isnull(ls_obj_name) then ls_obj_name = "" //040307
	ls_form_val = ids_steps.GetItemString( i, "form_handler" )
	if isnull(ls_form_val) then ls_form_val = "" //040307
	li_wait = ids_steps.GetItemnumber( i, "wait_val" )
	if li_wait > 0 then //if a wait setting write it
		ls_tag = "WAIT seconds=" + string(li_wait)
		FileWrite( li_FileNum, ls_tag  )
	end if
	
	//Start Code Change ----12.17.2007 #V8 maha  -- added here and removed duplications in the cases
	//Add the Trim - alfee 09.13.2012
	ls_type_i = Trim(ids_steps.GetItemString( i, "input_type" ))
	ls_type_f = Trim(ids_steps.GetItemString( i, "form_type" ))
	ls_type_a = Trim(ids_steps.GetItemString( i, "attr_type" ))
			
	if isnull(ls_step_action) then ls_step_action = "" //alfee 03.17.2010
	CHOOSE CASE ls_step_action
		CASE "Break for User Input"
			FileClose( li_filenum ) //Added by Evan 05.24.2012
			return 999
			
		CASE	"Click on Hyperlink" //maha 02.06.07
			ls_tag = "TAG POS=" + ls_obj_pos
			if LenA (ls_type_a) < 1 or isnull(ls_type_a) then ls_type_a = "NAME"
			ls_tag = ls_tag + " TYPE=A ATTR=" + ls_type_a + ":" + ls_obj_name   //Start Code Change ----01.04.2010 #V10 maha - added pos value
			FileWrite( li_FileNum, ls_tag  )
			
		CASE	"Click on Image Hyperlink"
			ls_tag = "TAG POS=" + ls_obj_pos
			if ls_form_val = "URL" then ls_form_val = is_url //maha41607
			ls_tag =  ls_tag + " TYPE=IMG ATTR=TXT:" + ls_form_val  + ls_obj_name
			FileWrite( li_FileNum, ls_tag  )		
			
		CASE	"Click on Image Submit" //maha 02.13.07 //created for 'board certified docs'  crawler
			ls_tag = "TAG POS=" + ls_obj_pos
			if LenA (ls_type_a) < 1 or isnull(ls_type_a) then ls_type_a = "NAME"
			ls_tag =  ls_tag + " TYPE=INPUT:IMAGE FORM=NAME:"  + ls_form_val 
			ls_tag = ls_tag + " ATTR=" + ls_type_a +  ":" + ls_obj_name + "&&VALUE:" + ls_content //maha 50207
			FileWrite( li_FileNum, ls_tag  )
			
		CASE "Click on Name Link"   //Start Code Change ----12.15.2015 #V15 maha
			ls_tag = "TAG POS=" + ls_obj_pos
			ls_tag = ls_tag + " TYPE=A ATTR=" + ls_type_a + ":"
			ls_data_from = of_get_data_value( ls_content, i)
			ls_tag = ls_tag + ls_data_from
			FileWrite( li_FileNum, ls_tag  )
			
		CASE	"Click on Variable Link" //maha 02.13.07
			ls_tag = "TAG POS=" + ls_obj_pos  //Start Code Change ----01.04.2010 #V10 maha
			ls_tag = ls_tag + " TYPE=A ATTR=TXT:" + ls_var_name   //Start Code Change ----01.04.2010 #V10 maha - added pos value
			//messagebox("",ls_tag)
			FileWrite( li_FileNum, ls_tag  )	
			
		CASE "Click Other" //maha 01012010 - this should be removed from the dropdown
			ls_tag = "TAG POS=" + ls_obj_pos
			ls_tag = ls_tag + " TYPE=" + ids_steps.GetItemString( i, "input_type" )
			ls_type_a = ids_steps.GetItemString( i, "attr_type" )		
			ls_type_i = ids_steps.GetItemString( i, "input_type" )		
			ls_type_f = ids_steps.GetItemString( i, "form_type" )
			
			if LenA (ls_type_i) > 0  then
				ls_tag = ls_tag + "TYPE=" + ls_type_i
			end if
			if LenA (ls_type_a) >0 then
				ls_tag = ls_tag + " ATTR=" + ls_type_a +  ":"
			end if
			
			//if len (ls_type_i) < 1 or isnull(ls_type_i) then

			//ls_tag = ls_tag + " ATTR=" +  ls_obj_name
			FileWrite( li_FileNum, ls_tag  )
			
		CASE "Click Other Data Link"  //Start Code Change ---- 08.08.2007 #V7 maha

			ls_tag = "TAG POS=" + ls_obj_pos
			if LenA (ls_type_i) >0 then
				ls_tag = ls_tag + " TYPE=" + ls_type_i
			end if
			
			//---------Begin Added by (Appeon)Stephen 06.16.2015 for Allegheny Web crawl to PA License Case# 54966--------
			if not(LenA (ls_form_val) < 1 or isnull(ls_form_val)) then
				if LenA (ls_type_f) < 1 or isnull(ls_type_f)  then ls_type_f = "NAME"
				ls_tag = ls_tag + " FORM=" + ls_type_f +":" + ls_form_val
			end if
			//---------End Added ------------------------------------------------------
			if LenA (ls_type_a) < 1 or isnull(ls_type_a) then ls_type_a = "NAME"
			if LenA (ls_content) > 0  then
				ls_data_from = of_get_data_value( ls_content, i)
				ls_tag = ls_tag + " ATTR=" + ls_type_a +  ":" +  ls_data_from
			end if
			FileWrite( li_FileNum, ls_tag  )

		CASE "Click Submit"									
			//TAG POS=1 TYPE=INPUT:SUBMIT FORM=ACTION:licensecode.asp ATTR=NAME:Accept&&VALUE:Accept  
			ls_tag = "TAG POS=" + ls_obj_pos
			
			if LenA (ls_type_i) < 1 or isnull(ls_type_i) then ls_type_i = "SUBMIT"
			if LenA (ls_type_f) < 1 or isnull(ls_type_f)  then ls_type_f = "NAME"
			if LenA (ls_type_a) < 1 or isnull(ls_type_a) then ls_type_a = "NAME"
			
			ls_tag = ls_tag + " TYPE=INPUT:" + ls_type_i + " FORM=" + ls_type_f + ":" + ls_form_val

			ls_value = ls_content
			
			ls_value = of_spaces( ls_value)		
			//------------------- APPEON BEGIN -------------------
			//$<modify> Stephen 08.03.2012
			//$<reason> submit error
			/*
			ls_tag = ls_tag + " ATTR=" + ls_type_a  + ":" + ls_obj_name + "&&" + "VALUE:" + ls_value
			*/
			if not(isnull(ls_value) or ls_value='') then
				ls_tag = ls_tag + " ATTR=" + ls_type_a  + ":" + ls_obj_name + "&&" + "VALUE:" + ls_value
			else
				ls_tag = ls_tag + " ATTR=" + ls_type_a  + ":" + ls_obj_name
			end if
			//------------------- APPEON END -------------------
			
			ids_steps.SetItem( i, "notes", ls_tag )
			FileWrite( li_FileNum, ls_tag  )	
			IF ids_steps.GetItemNumber( i, "no_data_found_check" ) = 1 THEN			
				//lb_check_for_no_results = True
				is_no_results_message = Upper(ids_steps.GetItemString( i, "no_data_found_text" ))
			END IF
			
		CASE "Click VAR mod Link"	
			ls_tag = "TAG POS=" + ls_obj_pos  //Start Code Change ----01.04.2010 #V10 maha
			ls_tag = ls_tag + " TYPE=A ATTR=TXT:" + is_varmod   //Start Code Change ----01.04.2010 #V10 maha - added pos value
			//messagebox("",ls_tag)
			FileWrite( li_FileNum, ls_tag  )	
		//End Code Change ----12.16.2015
			
		CASE "Error on Site" //what would this be used for?
			ls_tag =  ls_obj_name
			FileWrite( li_FileNum, ls_tag  )
			
		CASE "Extract Single Piece Of Data"
			ls_tag = "EXTRACT POS=" + ls_obj_pos  //extract tag
			ls_tag = ls_tag + " TYPE=TXT ATTR=" +  ls_form_val	
			FileWrite( li_FileNum, ls_tag  )
			ls_tag = "SET !" + ls_content +  " {{!EXTRACT}} "  //set variable from extracted value
			FileWrite( li_FileNum, ls_tag  )
			//ib_extract = true
			
		CASE "Extract for Link"
			ls_tag = "TAG POS=" + ls_obj_pos  //extract tag
			ls_tag = ls_tag + " TYPE=" + ls_type_a + " ATTR=" +  ls_form_val	
			ls_tag = ls_tag + " EXTRACT=TXT"
			FileWrite( li_FileNum, ls_tag  )
			ls_tag = "SET !" + ls_content +  " {{!EXTRACT}} "  //set variable from extracted value
			FileWrite( li_FileNum, ls_tag  )
			//ib_extract = true
			
		 //Start Code Change ----12.16.2015 #V15 maha - check the extracted value for spaces
		CASE "Extract for Link VAR mod"
			ls_tag = "TAG POS=" + ls_obj_pos  //extract tag
			ls_tag = ls_tag + " TYPE=" + ls_type_a + " ATTR=" +  ls_form_val	
			ls_tag = ls_tag + " EXTRACT=TXT"
			FileWrite( li_FileNum, ls_tag  )
			
		CASE "Extract VAR Reset"
			 debugbreak()
			ls_value = myoleobject.iimGetLastExtract()
			ls_value = of_strip_char("[EXTRACT]", ls_value, "") 
			is_varmod = of_strip_char(" ", ls_value, "<sp>") 
			ls_tag = "SET !" + ls_content +  " " + is_varmod  //set variable from extracted value
			FileWrite( li_FileNum, ls_tag  )
			//ib_extract = true
			
		
		CASE "Extract for Data update" //add by stephen 06.29.2012 -V12.2 WebCrawler extract data
			ls_tag = "TAG POS=" + ls_obj_pos  //extract tag
			//---------Begin Modified by Alfee 09.11.2012 ------------------
			//if not (isnull(ls_type_i) or ls_type_i='') then ls_tag = ls_tag + " TYPE=" + ls_type_i 
			//if not (isnull(ls_type_f) or ls_type_f='') then ls_tag = ls_tag +  "  FORM="+ ls_type_f
			//if not (isnull(ls_form_val) or ls_form_val='') then ls_tag = ls_tag +" ATTR=" +  ls_form_val			
			if LenA (ls_type_i) < 1 or isnull(ls_type_i) or upper(ls_type_i) = "TEXT" then ls_type_i = "INPUT:TEXT"
			if LenA (ls_type_f) < 1 or isnull(ls_type_f) then ls_type_f = "NAME"
			if LenA (ls_type_a) < 1 or isnull(ls_type_a) then ls_type_a = "NAME"			
			
			if not (isnull(ls_type_i) or ls_type_i='') then ls_tag = ls_tag + " TYPE=" + ls_type_i 
			if not (isnull(ls_form_val) or ls_form_val='') then ls_tag = ls_tag +  " FORM="+ ls_type_f + ":" + ls_form_val
			if not (isnull(ls_obj_name) or ls_obj_name='') then ls_tag = ls_tag + " ATTR=" + ls_type_a + ":" + ls_obj_name			
			ls_tag = ls_tag + " EXTRACT=TXT"
			//---------End Modified --------------------------------------------
			
			FileWrite( li_FileNum, ls_tag  )
			ib_extract = true
			
		CASE "Extract Verification Result"	//rewritten maha 04-02-2007
			ib_verif_ext = True
			is_verif_search_val = ids_steps.GetItemString( i, "macro_extract_tag" )

		CASE "Fill In Edit Box"
			//  TAG POS=1 TYPE=INPUT:TEXT FORM=ACTION:licensetypecode.asp ATTR=NAME:License CONTENT=9107 
			ls_tag = "TAG POS=" + ls_obj_pos

			//Start Code Change ---- 04.03.2007 #V7 maha			
			if LenA (ls_type_i) < 1 or isnull(ls_type_i) then ls_type_i = "TEXT"
			if LenA (ls_type_f) < 1 or isnull(ls_type_f) then ls_type_f = "NAME"
			if LenA (ls_type_a) < 1 or isnull(ls_type_a) then ls_type_a = "NAME"
			
			ls_tag = ls_tag + " TYPE=INPUT:" + ls_type_i + " FORM=" + ls_type_f + ":" + ls_form_val
			//End Code Change---04.03.2007

			ls_tag = ls_tag + " ATTR=" + ls_type_a + ":" + ls_obj_name
			//Start Code Change ---- 08.08.2007 #V7 maha  moved to function
			ls_value =  of_get_data_value(  ls_content, i )
			//End Code Change---08.08.2007
			
			ls_value = trim(ls_value)  //Start Code Change ----06.16.2014 #V14.2 maha - strip leading spaces
			
			if ls_value = "" then return -1  //Start Code Change ----07.21.2015 #V15 maha - no value = failure
			
			ls_value = of_format_value( ids_steps.getitemnumber(i,"format_type"), ls_value )
			ls_value = of_spaces( ls_value)		
			
			ls_tag = ls_tag + " CONTENT=" + ls_value
			FileWrite( li_FileNum, ls_tag  )

		CASE "Go To Web Site URL"
			FileWrite( li_FileNum, "URL GOTO=" + is_url  )			
			
		CASE "Hard Coded Tag" //Start Code Change ----12.03.2008 #V8 maha -- added to simplify step building; just copy the line from the record to the object name field
			ls_tag = ls_obj_name
			FileWrite( li_FileNum, ls_tag  )
			
		CASE "Hard Coded Tag Plus Value"   //Start Code Change -----10.05.2017 #V154 maha - for DEA number crawler
			ls_tag = ls_obj_name
			ls_value =  of_get_data_value(  ls_content, i )
			FileWrite( li_FileNum, ls_tag + ls_value  )	
			
		CASE "Link Using Extracted Value"  //Start Code Change ---- 08.08.2007 #V7 maha
			ls_tag = "TAG POS=" + ls_obj_pos
			if LenA (ls_type_i) >0 then
				ls_tag = ls_tag + " TYPE=" + ls_type_i
			end if
			if LenA (ls_type_a) < 1 or isnull(ls_type_a) then ls_type_a = "NAME"
			if LenA (ls_content) > 0  then
				ls_data_from = of_get_data_value( ls_content, i)
				ls_tag = ls_tag + " ATTR=" + ls_type_a +  ":" +  ls_data_from
			end if
			if ids_steps.GetItemString( i, "macro_extract_tag") = "*" then
				ls_tag = ls_tag + "*"
			end if
			FileWrite( li_FileNum, ls_tag  )
		
		CASE "Save Page as HTML"						
			ls_file_type = "htm"
			ii_type = 3
			ib_image_saved = True
			is_saved_file = ls_path + "_ResultPage.htm"
			FileDelete( is_path + "_ResultPage.htm" ) //Start Code Change ----01.04.2010 #V10 maha - delete file before saving.
			ls_tag = "SAVEAS TYPE=HTM FOLDER=" + ls_crawl_path + " FILE=_ResultPage.htm"
			FileWrite( li_FileNum, ls_tag  )
		CASE "Save Page as Image"	
			FileDelete( is_path + "_ResultPage.htm" ) //Start Code Change ----01.04.2010 #V10 maha - delete file before saving.
			FileDelete( is_path + "_ResultPage.bmp" ) //Start Code Change ----01.04.2010 #V10 maha - delete file before saving.
			ls_file_type = "bmp"
			ii_type = 4
			ib_image_saved = True
			is_saved_file = ls_path + "_ResultPage.bmp"
			ls_tag = "SAVEAS TYPE=BMP FOLDER=" + ls_crawl_path + " FILE=_ResultPage.bmp"
			FileWrite( li_FileNum, ls_tag  )								
			ls_tag = "SAVEAS TYPE=HTM FOLDER=" + ls_crawl_path + " FILE=_ResultPage.htm"
			FileWrite( li_FileNum, ls_tag  )	
		CASE "Save Page as JPEG"	 //Start Code Change ----08.17.2017 #V154 maha
			//note maha 08.17.2017 - jpeg not supported in imacros 10
			messagebox("Save type","Save as JPEG is currently upsupported")
			FileDelete( is_path + "_ResultPage.htm" )
			FileDelete( is_path + "_ResultPage.jpeg" )
			ls_file_type = "jpeg"
			ii_type = 7 
			ib_image_saved = True
			is_saved_file = ls_path + "_ResultPage.jpeg"
			ls_tag = "SAVEAS TYPE=JPEG FOLDER=" + ls_crawl_path + " FILE=_ResultPage.jpeg"
			FileWrite( li_FileNum, ls_tag  )								
			ls_tag = "SAVEAS TYPE=HTM FOLDER=" + ls_crawl_path + " FILE=_ResultPage.htm"
			FileWrite( li_FileNum, ls_tag  )	
		CASE "Save Page as PNG"	
			//messagebox("Save type","Save as PNG is currently upsupported")
			FileDelete( is_path + "_ResultPage.htm" ) //Start Code Change ----01.04.2010 #V10 maha - delete file before saving.
			FileDelete( is_path + "_ResultPage.png" ) //Start Code Change ----01.04.2010 #V10 maha - delete file before saving.
			ls_file_type = "png"
			ii_type = 5  //Start Code Change ----04.29.2016 #V15 maha
			ib_image_saved = True
			is_saved_file = ls_path + "_ResultPage.png"
			ls_tag = "SAVEAS TYPE=PNG FOLDER=" + ls_crawl_path + " FILE=_ResultPage.png"
			FileWrite( li_FileNum, ls_tag  )								
			ls_tag = "SAVEAS TYPE=HTM FOLDER=" + ls_crawl_path + " FILE=_ResultPage.htm"
			FileWrite( li_FileNum, ls_tag  )				
		CASE "Save PDF File"     	
//			messagebox("Save type","Save as PDF is currently upsupported")
			ls_file_type = "pdf"
			ii_type = 2
			ib_image_saved = True
			is_saved_file = ls_path + "_ResultPage.pdf"
			FileDelete( is_path + "_ResultPage.htm" ) //Start Code Change ----01.04.2010 #V10 maha - delete file before saving.
			FileDelete( is_path + "_ResultPage.pdf" ) //Start Code Change ----01.04.2010 #V10 maha - delete file before saving.

			ls_tag = "ONDOWNLOAD FOLDER=" + ls_crawl_path + " FILE=" + is_saved_file + " WAIT=YES"  //Start Code Change ----.02.112016 #V15 maha - added wait
			FileWrite( li_FileNum, ls_tag  )
			
			ls_tag = "SAVEITEM"           			
			FileWrite( li_FileNum, ls_tag  )	

			
		CASE "Select From List Box" , "Select From Drop Down" //Start Code Change ----12.17.2007 #V8 maha  added drop down
			//TAG POS=1 TYPE=SELECT FORM=ACTION:http://www.nysed.gov/COMS/OP001/OPSCR2 ATTR=NAME:profcd CONTENT=$Mental<SP>Health<SP>Counselor						
			ls_tag = "TAG POS=" + ls_obj_pos
			
			if LenA (ls_type_f) < 1 or isnull(ls_type_f)  then ls_type_f = "NAME"
			//Start Code Change ---- 11.26.2007 #V7 maha
			if LenA (ls_type_a) < 1 or isnull(ls_type_a) then ls_type_a = "NAME"
			ls_tag = ls_tag + " TYPE=SELECT FORM=" + ls_type_f + ":" + ls_form_val			
			//ls_tag = ls_tag + " ATTR=NAME:" + ls_obj_name
			ls_tag = ls_tag + " ATTR=" + ls_type_a + ":" + ls_obj_name
			//End Code Change---11.26.2007
						
			ls_content = ls_content
			if ib_test <> true then  //(Appeon)Stephen 11.24.2014 - BugS111801
				ls_prof_suffix = ids_prac.getitemstring(1,"prof_suffix")
				ll_psufx_code = ids_prac.getitemnumber(1,"prof_suffix_code")
				ls_prosufx_code = string(ll_psufx_code)
			end if
			li_wc_id = ids_steps.GetItemNumber( i, "wc_id" )
			li_step_order = ids_steps.GetItemNumber( i, "step_order" )

			IF ls_content = "Professional Suffix" and ib_test <> true THEN //(Appeon)Stephen 11.24.2014 -add 'ib_test <> true'- BugS111801
				ls_content = ""
				IF ids_steps.GetItemNumber( i, "web_data_comparison_yes_no" ) = 1 THEN
					//messagebox("", ls_prof_suffix)
					SELECT wc_web_data_comparison.web_site_data  
					INTO :ls_content
					FROM wc_web_data_comparison  
					WHERE ( wc_web_data_comparison.wc_id = :li_wc_id ) AND  
				         ( wc_web_data_comparison.step_order = :li_step_order ) AND  
				         ( wc_web_data_comparison.intellicred_data = :ls_prosufx_code  )  ;
					IF SQLCA.SQLCODE = -1 THEN
						//MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
						//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
						inv_message.of_MessageBox( "SQL Error", SQLCA.SQLERRTEXT,true)
						FileClose( li_filenum ) //Start Code Change ----11.21.2011 #V12 maha
						RETURN -1 
					END IF
					
					IF isnull(ls_content) THEN ls_content = ""  //Start Code Change ----11.21.2011 #V12 maha
					
					IF ls_content = "" THEN
						//MessageBox( "No Data", "There is no Value mapped for the physicians Professional Suffix for: "  + ls_prof_suffix + " for selecting the Profession on the Website.  Go to Web Crawler Setyp Utility to correct.")
						//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
						inv_message.of_MessageBox( "No Data", "There is no Value mapped for the physicians Professional Suffix for: "  + ls_prof_suffix + " for selecting the Profession on the Website.  Go to Web Crawler Setup Utility to correct.",true) //Setyp->Setup, Modified by Appeon long.zhang 12.14.2015 (Typo in V14.2 Bug_id#4891)
						FileClose( li_filenum ) //Start Code Change ----11.21.2011 #V12 maha
						Return -1
					END IF
				ELSE
					ls_content = ls_prof_suffix
				END IF
			END IF
			
			ls_content = of_format_value( ids_steps.getitemnumber(i,"format_type"), ls_content  ) //add $ if set
			ls_content = of_spaces( ls_content)
			
			ls_tag = ls_tag + " CONTENT=" + ls_content
			FileWrite( li_FileNum, ls_tag  )	
			
		CASE "Select From Check Box" //to be removed from list
			//messagebox("Crawl Setup error", "There is no code for processing " + ls_step_action)
			//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
			inv_message.of_MessageBox("Crawl Setup error", "There is no code for processing " + ls_step_action,true)
			FileClose( li_filenum ) //Start Code Change ----11.21.2011 #V12 maha
			return -1
		CASE "Select From Radio Button"			//maha last mod 12.17.07
			ls_tag = "TAG POS=" + ls_obj_pos
			if LenA (ls_type_i) < 1 or isnull(ls_type_i) then ls_type_i = "RADIO"
			if LenA (ls_type_f) < 1 or isnull(ls_type_f) then ls_type_f = "NAME"
			if LenA (ls_type_a) < 1 or isnull(ls_type_a) then ls_type_a = "NAME"
			ls_tag = ls_tag + " TYPE=INPUT:" + ls_type_i + ":" + " FORM=" + ls_type_f + ":" +  ls_form_val	+ " ATTR=" + ls_type_a + ":" + ls_obj_name + "&&VALUE:" + ls_content
			FileWrite( li_FileNum, ls_tag  )
		CASE "Select From Table List"		//to be removed from list	
			//messagebox("Crawl Setup error", "There is no code for processing " + ls_step_action)
			//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
			inv_message.of_MessageBox("Crawl Setup error", "There is no code for processing " + ls_step_action,true)
			FileClose( li_filenum ) //Start Code Change ----11.21.2011 #V12 maha
			return -1

		CASE else
			//messagebox("Crawler ERROR","this crawler is designed using a Step Type '" + ls_step_action + "'.  This version of IntelliCred is not coded to use this step type and will not run properly.  Please upgrade your version of the program to run this Crawler.")
			//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
			inv_message.of_MessageBox("Crawler ERROR","this crawler is designed using a Step Type '" + ls_step_action + "'.  This version of IntelliCred is not coded to use this step type and will not run properly.  Please upgrade your version of the program to run this Crawler.",true)
			FileClose( li_filenum ) //Start Code Change ----11.21.2011 #V12 maha
			return -1
			
	END CHOOSE
	//End Code Change---12.17.2007

	if ids_steps.GetItemNumber( i, "search_opens_seperate_win" ) = 1 then //open separate window
		FileWrite( li_FileNum, "TAB T=2" )	
	end if
	
	if i = ai_end then
		if ids_steps.GetItemNumber( i, "no_data_found_check" ) = 1 then //to process a check, the file must be saved
			FileDelete( is_path + "_ResultPage.htm" ) //Start Code Change ----01.04.2010 #V10 maha - delete file before saving.
			ls_tag = "SAVEAS TYPE=HTM FOLDER=" + ls_crawl_path + " FILE=_ResultPage.htm"
			FileWrite( li_FileNum, ls_tag  )
		end if
	end if



END FOR
//end if crawler creation

ids_steps.Update( )

FileClose( li_filenum )

return 1
end function

public function string of_spaces (string as_val);string ls_value
string ls_char

integer li_len
integer c

ls_value = as_val
//Start Code Change ----12.04.2008 #V85 maha - modifed to use of_strip_char;  function as written did not handle multiple spaces well
ls_value = of_strip_char(" ", ls_value,"<SP>")

//li_len = Len( as_val )
//
//FOR c = 1 TO li_len			
//	ls_char = Mid( ls_value, c, 1 )
//	IF ls_char = " " THEN
//		ls_value = Mid( ls_value, 1, c -1 ) + "<SP>" + Mid( ls_value, c + 1, 1000 )
//	END IF
//END FOR	
//End Code Change---12.04.2008

return ls_value

end function

public function long of_image_save (string as_doc_id, integer ai_update);//Start Code Change ---- 02.21.2007 #V7 maha added function called from of_crawl_new

long ll_new_pos
long ll_filelen
long ll_logid //maha 07.22.2015
string ls_type    //maha 07.22.2015
integer li_filenum
integer li_loops
integer li_counter
long ll_bytes_read
blob blob_temp
blob lb_tot_b
blob total_blob
blob blank_blob
blob lb_verif_picture

//Put image into db
//	ll_filelen = FileLength( ls_path + "_ResultPage." + ls_file_type ) 
ll_filelen = FileLength( is_saved_file ) 

//@@@@@@@@@@@@@MUST STRIP LOG ID FROM LAST COMPONENT OF DOC ID  07.22.2015 maha
IF ib_from_batch_verif then
	//ll_logid = long(as_doc_id)
	ll_logid = long(mid(as_doc_id, 3))  //Start Code Change ----08.10.2017 #V154 maha
end if

//messagebox("file",  ls_saved_file )

li_filenum = FileOpen(is_saved_file, StreamMode!,READ!,LOCKREAD!)
IF li_filenum <> -1 THEN	
	if isvalid(w_infodisp) then w_infodisp.st_1.text = "Reading file"
	//Determine how many FileReads will be necessary to read all of the file ... 
	
	//You can't read in more than 32K at a time 
	IF ll_filelen > 32765 THEN 
  			IF Mod(ll_filelen,32765) = 0 THEN 
   		  	   li_loops = ll_filelen/32765 
		 ELSE 
  				   li_loops = (ll_filelen/32765) + 1 
   	 	 END IF 
	ELSE 
  			 li_loops = 1 
	END IF 
		//read the file ... 
	FOR li_counter = 1 to li_loops 
  		 ll_bytes_read = FileRead( li_filenum, blob_temp) 
		 IF ll_bytes_read = -1 THEN
			//MessageBox("Error", "Error with FileRead command.  Return -1." )
			//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
			inv_message.of_MessageBox("Error", "Error with FileRead command.  Return -1.",true)
			Return -1
		 END IF
    lb_tot_b = lb_tot_b + blob_temp 
  		 ll_new_pos = ll_new_pos + ll_bytes_read 
   	 FileSeek(li_filenum, ll_new_pos, FROMBEGINNING!) 

  		 if LenA(lb_tot_b) > 1000000 then 
   	     total_blob = total_blob + lb_tot_b 
  	   	  lb_tot_b = blank_blob 
	    end if 
	NEXT 
		total_blob = total_blob + lb_tot_b 

	lb_verif_picture = total_blob
		FileClose(li_filenum) 
	
	if isvalid(w_infodisp) then w_infodisp.st_1.text = "Saving image to database (may take a few moments)"
	//messagebox("blob length", len( total_blob) )
	 //Start Code Change ----07.22.2015 #V15 maha - batch verifications
	if ib_from_batch_verif = true then
		//create the record
	//Start Code Change ----08.10.2017 #V154 maha
		choose case ii_type
			case 4
				ls_type = "bmp"
			case 2
				ls_type = "pdf"
			case 3
				ls_type = "htm"
			case 5
				ls_type = "png"
		end choose
	//End Code Change ----08.10.2017
	
		insert into verif_batch_log_image (log_id, prac_id, rec_id, image_type) values(:ll_logid, :il_prac, :il_recid, :ls_type );
		if SQLCA.SQLCode = -1 then
				MessageBox("SQL Error", SQLCA.SQLErrText)
			Return -1
		end if
		//add blob data
		if ai_update = 1 then
			UPDATEBLOB verif_batch_log_image
			SET image_data = :lb_verif_picture
			WHERE log_id = :ll_logid
			USING SQLCA;
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("Error", SQLCA.SQLERRTEXT )
				Return -1
			END IF
		end if
	else //verifications
		if ai_update = 1 then
			UPDATEBLOB verif_info
			SET verification_picture = :lb_verif_picture
			WHERE doc_id = :as_doc_id
			USING SQLCA;
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("Error", SQLCA.SQLERRTEXT )
				Return -1
			END IF
		//	messagebox("type", ii_type)
			UPDATE verif_info
			SET verification_picture_flag = :ii_type
			WHERE doc_id = :as_doc_id
			USING SQLCA;	
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("Error", SQLCA.SQLERRTEXT )
				Return -1
			END IF	
		end if
	end if
	 //End Code Change ----07.22.2015
ELSE
	//MessageBox("Web Crawler - of_save_image", "File Open Error.  Could not open " + is_saved_file + " for StreamMode!" )
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
    inv_message.of_MessageBox("Web Crawler - of_save_image", "File Open Error.  Could not open " + is_saved_file + " for StreamMode!",true)
	Return -1
END IF

IF SQLCA.SQLNRows > 0 THEN
	COMMIT USING SQLCA ;
ELSEIF SQLCA.SQLCODE = -1 THEN
	//MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
    inv_message.of_MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT,true)
	Return -1
ELSEIF SQLCA.SQLNRows = 0 THEN	
	//MessageBox( "SQL Error", "No rows effected." )
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox( "SQL Error", "No rows effected.",true)
END IF


return 1
end function

public function string of_format_value (integer ai_type, string as_value);string ls_ret

ls_ret = as_value

choose case ai_type
	case 1 //strip to number
		ls_ret = of_strip_char("",ls_ret,"@NUM@")
	case 2,3,4  //date part formats from of_format_date
		//do nothing
	case 6
		ls_ret = "$" + as_value
	case 7
		//Last,<SP>First
	//Start Code Change ----03.08.2010 #V10 maha
	case 8
		//LAST,<SP>FIRST<SP>MIDDLE
	case 9 //last 4 characters
		ls_ret = RightA(ls_ret,4)
	//End Code Change---03.08.2010
end choose


return ls_ret
end function

public function string of_format_date (integer ai_type, datetime adt_date);//Start Code Change ---- 02.22.2007 #V7 maha
// get date part - of_date_to_string function in intelicred.pbl
string s

choose case ai_type
	case 2 //day
		s = of_date_to_string(adt_date,"dd")
	case 3 //month
		s = of_date_to_string(adt_date,"mm")
	case 4 //year
		s = of_date_to_string(adt_date,"yyyy")
	case 5 //mmddyyy
		s = of_date_to_string(adt_date,"mm/dd/yyyy")
end choose

return s
end function

public function long of_verif_response (integer ai_wcid, integer ai_step, string as_extract);//Start Code Change ---- 04.03.2007 #V7 maha
//new function for getting the response code
long ll_retval = 0
integer li_rc
integer li_filenum
string ls_data
integer f
n_ds lds_web_verif_rsp_mapping


//if not fileexists( is_path + "extract.csv" ) then //check to see if file was created
//	messagebox("Crawl Error",  is_path + "extract.csv" + " file does not exist for getting Response code.")
//end if
////debugbreak()
//li_filenum = FileOpen( is_path + "extract.csv", LineMode!)
//fileread(li_filenum,ls_data)
ls_data = as_extract //this is is_verif_search_val

//messagebox ("extract value",ls_data)
//if ls_data = "#EANF#" then  //vALUE NOT FOUND
//	return 0
//end if

lds_web_verif_rsp_mapping = CREATE n_ds
lds_web_verif_rsp_mapping.DataObject = "d_wc_verif_comparison_ext"
lds_web_verif_rsp_mapping.of_SetTransObject( SQLCA )
lds_web_verif_rsp_mapping.Retrieve( ai_wcid, ai_step)	
//Note: retrieval will fail (0) if string contains characters like < / or ;
li_rc = lds_web_verif_rsp_mapping.RowCount( )

f = lds_web_verif_rsp_mapping.find( "field = '" + ls_data + "'"    , 1,li_rc)
if f > 0 then
	ll_retval = long(lds_web_verif_rsp_mapping.getitemstring(1,'verif_response_code_value'))
else
	ll_retval = 0
end if


return ll_retval


					
					
	
end function

public function string of_get_data_value (string as_data, long al_step);//Start Code Change ---- 08.08.2007 #V7 maha Added.  Called from of_build_crawl()
string ls_value
string ls_reference
string ls_data_from
long i
datetime ldt_date

ls_data_from = as_data
i = al_step


//THIS IS TEST MODE CODE RUN CODE IS BELOW
if ib_test = true then //Start Code Change ---- 12.03.2007 #V7 maha added for testing
	CHOOSE CASE Upper(ls_data_from)
	CASE "VERIF REFERENCE 1"
		ls_value = "REF1"
	CASE "VERIF REFERENCE 2"					
		ls_value = "REF2"
	case "LAST NAME"
		ls_value ="last_name"
	case "FIRST NAME"
		ls_value ="first_name"
	case "FIRST MIDDLE LAST"   //Start Code Change ----12.15.2015 #V15 maha
		ls_value = "first_name" + "<SP>" + "middle_name" + "<SP>" + "last_name"
	case "LAST FIRST NAME"  //Start Code Change ---- 04.17.2007 #V7 maha
		ls_value = "last_name" + ",<SP>" + "first_name"
	case "LAST FIRST MIDDLE NAME"//Start Code Change ----03.08.2010 #V10 maha
		//LAST,<SP>FIRST<SP>MIDDLE
		ls_value = "last_name" + ",<SP>" + "first_name" + " <SP>" + "middle_name"
	case "DOB"
		ldt_date = datetime(today(),now())
		ls_value = of_format_date(ids_steps.getitemnumber(i,"format_type") ,ldt_date)
	case "SSN"
		ls_value = "1234567890"
	case "ACCOUNT NUMBER"
		ls_value = ids_wc.getitemstring(1,"web_site_account_number")
	case "USER NAME"
		ls_value = ids_wc.getitemstring(1,"web_site_user_id")
	case "PASSWORD"
		ls_value = ids_wc.getitemstring(1,"web_site_password")
	case "NPI Number"
		ls_value = "NPI123456"
	case "GENDER" 
		ls_value = "Female"
	case "VAR1","VAR2","VAR3"
			ls_value = "{{!" + ls_data_from + "}}"
	CASE ELSE					
		ls_value = ls_data_from
END CHOOSE
return ls_value
end if
	debugbreak()
//CRAWLER RUN CODE
CHOOSE CASE Upper(ls_data_from)
	CASE "VERIF REFERENCE 1"
		 //Start Code Change ----07.21.2015 #V15 maha - added options for batch verifications
		if ib_from_batch_verif then
			ls_value = of_get_reference_data( il_prac, il_recid, il_screen,"ref_1")
		else
			ls_reference = ids_prac.getitemstring(1,"reference_value")
			if PosA( ls_reference, " -" ) = 0 then //test if reference has no dash
				ls_value = ls_reference
			else
				ls_value = MidA( ls_reference, 1, PosA( ls_reference, " -" ) -1 )
			end if
		end if
	CASE "VERIF REFERENCE 2"		
		If ib_from_batch_verif then
			ls_value = of_get_reference_data( il_prac, il_recid, il_screen,"ref_2")
		else
			ls_reference = ids_prac.getitemstring(1,"reference_value")
			ls_value = MidA( ls_reference, PosA( ls_reference, "- " ) + 2, 100 )
		End if 
		 //End Code Change ----07.21.2015
	case "LAST NAME"
		ls_value = ids_prac.getitemstring(1,"last_name")
	case "FIRST NAME"
		ls_value = ids_prac.getitemstring(1,"first_name")
	case "FIRST MIDDLE LAST"  //Start Code Change ----12.15.2015 #V15 maha - added fo penn license
		ls_value = ids_prac.getitemstring(1,"first_name") + "<SP>" + ids_prac.getitemstring(1,"middle_name") + "<SP>" + ids_prac.getitemstring(1,"last_name")
		ls_value = upper(ls_value)
	case "FIRST NAME LAST NAME"  //Start Code Change ----10.20.2016 #V15.3 maha - added 
		ls_value = ids_prac.getitemstring(1,"first_name") + "<SP>" + ids_prac.getitemstring(1,"last_name")
	case "LAST FIRST NAME"  //Start Code Change ---- 04.17.2007 #V7 maha
		ls_value = ids_prac.getitemstring(1,"last_name") + ",<SP>" + ids_prac.getitemstring(1,"first_name")
	case "LAST FIRST MIDDLE NAME"  //Start Code Change ---- 03.08.2010 #V10 maha
		ls_value = ids_prac.getitemstring(1,"last_name") + ",<SP>" + ids_prac.getitemstring(1,"first_name") + " <SP>" + ids_prac.getitemstring(1,"middle_name")
	case "DOB"
		ls_value = of_format_date(ids_steps.getitemnumber(i,"format_type") ,ids_prac.getitemdatetime(1,"date_of_birth"))
	case "SSN"
		ls_value = ids_prac.getitemstring(1,"ssn")
	case "ACCOUNT NUMBER"
		ls_value = ids_wc.getitemstring(1,"web_site_account_number")
	case "USER NAME"
		ls_value = ids_wc.getitemstring(1,"web_site_user_id")
	case "PASSWORD"
		ls_value = ids_wc.getitemstring(1,"web_site_password")
	case "NPI NUMBER" //Start Code Change ----10.19.2010 #V10 maha - corrected to work
		ls_value = ids_prac.getitemstring(1,"npi_number")
	case "GENDER" //Start Code Change ----10.19.2010 #V10 maha - Corrected to work
		ls_value = ids_prac.getitemstring(1,"gender")
	case "VAR1","VAR2","VAR3" //Start Code Change ----12.06.2007 #V8 maha
			ls_value = "{{!" + ls_data_from + "}}"
	//Start Code Change ----10.23.2012 #V12 maha
	case "CC TYPE"
		ls_value = ids_wc.getitemstring(1,"cc_type")
	case "CC NUMBER"
		ls_value = ids_wc.getitemstring(1,"cc_number")
	case "CC CODE"
		ls_value = ids_wc.getitemstring(1,"cc_code")
	case "CC ADDRESS1"
		ls_value = ids_wc.getitemstring(1,"cc_billing_street_1")
	case "CC ADDRESS2"
		ls_value = ids_wc.getitemstring(1,"cc_billing_street_2")
	case "CC CITY"
		ls_value = ids_wc.getitemstring(1,"cc_billing_city")
	case "CC STATE"
		ls_value = ids_wc.getitemstring(1,"cc_billing_state")
	case "CC ZIP"
		ls_value = ids_wc.getitemstring(1,"cc_billing_zip")
	case "CC EXPIRES"
		ls_value = ids_wc.getitemstring(1,"cc_expiration")
	case "CC NAME ON CARD"
		ls_value = ids_wc.getitemstring(1,"cc_name_on_card")
	//Start Code Change ----10.23.2012
	CASE ELSE					
		ls_value = ls_data_from
END CHOOSE

return ls_value
end function

public function string of_get_sched_msg ();//Get messages of the schedule - alfee 02.06.2010

return inv_message.of_get_message()
end function

public function integer of_get_sched_cnt ();//Get processed count of the schedule - alfee 02.06.2010

return inv_message.of_get_proc_cnt( )
end function

public function string of_error_message (integer ai_mes);//Moved from w_web_crawler_verifications for scehduler- alfee 02.08.2010

string ls_mes

choose case ai_mes
	case 3
		ls_mes = "Not found on Site"
	case -10
		ls_mes = "Error retrieving Verification Data"
	case -20
		ls_mes = "Error retrieving Web Crawler"
	case -30
		ls_mes = "Crawler requires a password"
	case -40
		ls_mes = "Error retrieving crawler steps"
	case -901
		ls_mes = "Error building Crawler macro "
	case -902
		ls_mes = "Failed to connect to InternetMacros program"
	case -903
		ls_mes = "Crawler Failed on website"
	case -904
		ls_mes = "_ResultPage.htm file was not created"
	case else
		ls_mes = ""
end choose 

return ls_mes
end function

public function integer of_set_verifs_aftercrawl (datawindow adw_verif_list, string as_crawl_res, long al_row);//Set verif rec after Web Crawl based the returned value 
//Moved and modified from w_web_crawler_verifications for scheduler - alfee 02.08.2010

Integer li_type, li_number_sent
Long ll_retval
String ls_emes, ls_temp
string ls_notes  //maha 04.22.2016

IF IsNull(al_row) or al_row < 1 or al_row > adw_verif_list.rowcount() THEN 
	RETURN -1
END IF

ll_retval = long(MidA(as_crawl_res, 1, PosA(as_crawl_res,"*",1) - 1))
li_type = integer(MidA(as_crawl_res, PosA(as_crawl_res,"*",1)  + 1))

adw_verif_list.SetItem( al_row, "complete_status", 99 )

IF ll_retval = 1 THEN //successful print
	adw_verif_list.SetItem( al_row, "complete_status", 1 )
	adw_verif_list.SetItem( al_row, "verification_picture_flag", li_type ) //set so the picture button is visible
	li_number_sent = adw_verif_list.GetitemNumber( al_row, "number_sent" )
	li_number_sent++
	//Start Code Change ----04.13.2010 #V10 maha - added to set attempts
	adw_verif_list.SetItem( al_row, "number_sent", li_number_sent )		
	//adw_verif_list.SetItem( al_row, "date_recieved", Today( ) )  //Start Code Change ----11.02.2011 #V12 maha-  removed 
	adw_verif_list.SetItem( al_row, "last_sent", Today( ) )
	adw_verif_list.SetItem( al_row, "print_flag", 0)
	//Start Code Change ----04.22.2016 #V15 maha
	ls_notes = adw_verif_list.getItemstring(al_row, "verif_info_notes")
	if isnull(ls_notes) then ls_notes = ""
	adw_verif_list.SetItem( al_row, "verif_info_notes",  "Crawler run by: " + gs_user_id + "   Date: " + string(today()) + " " +  string(Now()) + " WebSite: " + is_url + " - " + ls_notes ) 	
	//Start Code Change ----08.17.2017 #V154 maha - stamp upload values
	adw_verif_list.SetItem( al_row, "image_stamp", datetime( today(), Now()) ) 
	adw_verif_list.SetItem( al_row, "image_stamp_user", gs_user_id )
	adw_verif_list.SetItem( al_row, "image_stamp_site", is_url)
	//End Code Change ----08.17.2017 
	//End Code Change ----04.22.2016
	IF IsNull( adw_verif_list.GetItemDateTime( al_row, "first_sent" ) ) THEN
		adw_verif_list.SetItem( al_row, "first_sent", Today( ) )	
	END IF
	//End Code Change---04.13.2010
ELSEIF ll_retval = 3 THEN //not found on site
	adw_verif_list.SetItem( al_row, "complete_status", 3 )
	adw_verif_list.SetItem( al_row, "verification_picture_flag", li_type )
	ls_emes = of_error_message(ll_retval )
	adw_verif_list.SetItem( al_row, "verif_info_notes", ls_emes + " - " + adw_verif_list.GetItemstring( al_row, "verif_info_notes" ) )	
	//Start Code Change ----04.13.2010 #V10 maha - added to set attempts
	adw_verif_list.SetItem( al_row, "number_sent", li_number_sent )		
	//adw_verif_list.SetItem( al_row, "date_recieved", Today( ) )  //Start Code Change ----11.02.2011 #V12 maha-  removed 
	adw_verif_list.SetItem( al_row, "last_sent", Today( ) )
	adw_verif_list.SetItem( al_row, "print_flag", 0)
	IF IsNull( adw_verif_list.GetItemDateTime( al_row, "first_sent" ) ) THEN
		adw_verif_list.SetItem( al_row, "first_sent", Today( ) )	
	END IF
	//End Code Change---04.13.2010
ELSEIF ll_retval > 1 THEN //successful and complete (we don't do these)
	adw_verif_list.SetItem( al_row, "response_code", ll_retval )
	adw_verif_list.SetItem( al_row, "complete_status", 2 )
	adw_verif_list.SetItem( al_row, "verification_picture_flag", li_type )
	li_number_sent = adw_verif_list.GetitemNumber( al_row, "number_sent" )
	li_number_sent++
	adw_verif_list.SetItem( al_row, "number_sent", li_number_sent )		
	//adw_verif_list.SetItem( al_row, "date_recieved", Today( ) )  //Start Code Change ----11.02.2011 #V12 maha-  removed 
	adw_verif_list.SetItem( al_row, "last_sent", Today( ) )
	adw_verif_list.SetItem( al_row, "print_flag", 0)
	IF IsNull( adw_verif_list.GetItemDateTime( al_row, "first_sent" ) ) THEN
		adw_verif_list.SetItem( al_row, "first_sent", Today( ) )	
	END IF
	adw_verif_list.SetItem( al_row, "user_name", gs_user_id )	
ELSEIF ll_retval < 0 THEN //maha 02.27.07  //crawler failed
	adw_verif_list.SetItem( al_row, "complete_status", -1 )	
	ls_emes = of_error_message(ll_retval )
	//adw_verif_list.SetItem( al_row, "verif_info_notes", ls_emes + " - " + adw_verif_list.GetItemstring( al_row, "verif_info_notes" ) )	
	//Start Code Change ----04.13.2010 #V10 maha - added to set attempts
	adw_verif_list.SetItem( al_row, "number_sent", li_number_sent )		
	//adw_verif_list.SetItem( al_row, "date_recieved", Today( ) )  //Start Code Change ----11.02.2011 #V12 maha-  removed 
	adw_verif_list.SetItem( al_row, "last_sent", Today( ) )
	adw_verif_list.SetItem( al_row, "print_flag", 1)
	IF IsNull( adw_verif_list.GetItemDateTime( al_row, "first_sent" ) ) THEN
		adw_verif_list.SetItem( al_row, "first_sent", Today( ) )	
	END IF
	//End Code Change---04.13.2010
	ls_temp = adw_verif_list.GetItemstring( al_row, "verif_info_notes" )
	if isnull(ls_temp) then ls_temp = ''
	if LenA(ls_temp) > 0 then ls_temp = ' - ' + ls_temp
	if LenA(ls_emes) > 0 then adw_verif_list.SetItem( al_row, "verif_info_notes", ls_emes + ls_temp)	
END IF

//IF gb_AutoSchedule AND Len(ls_emes) > 0 THEN
//	inv_message.of_messagebox( "Web Crawl", ls_emes, TRUE)
//END IF

RETURN 1

end function

public function integer of_set_verifs (datawindow adw_verif_list, boolean ab_crawler);//Set web crawler id and complete status on the specified verif datawindow
//Moved and modified from w_web_crawler_verifications for scheduler - alfee 02.08.2010

Integer li_screen_id, li_wc_id, res
Int li_screen_id_last = 0
Long i, ll_rc, ll_addr_code
Long ll_wc_hdr_cnt, ll_found_1, ll_found_1_last, ll_found_2, ll_found_2_last
String ls_ref, ls_ref_1, ls_ref_2, ls_filter, ls_screen_name
String ls_ref_1_last = ''
DataStore lds_wc_hdr, lds_wc_hdr_addr
Boolean lb_samewithlast = False
Boolean lb_samescreen = False

ll_rc = adw_verif_list.rowcount()
IF ll_rc < 1 THEN RETURN 0

lds_wc_hdr = create datastore
lds_wc_hdr_addr = create datastore
lds_wc_hdr.dataobject = "d_wc_hdr_imp"
lds_wc_hdr_addr.dataobject= "d_wc_hdr_addr"
lds_wc_hdr.SetTransObject(SQLCA)
lds_wc_hdr_addr.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
lds_wc_hdr.Retrieve()
res = lds_wc_hdr_addr.Retrieve()
gnv_appeondb.of_commitqueue( )

ll_wc_hdr_cnt = lds_wc_hdr.RowCount() //Added by Appeon long.zhang 12.18.2015 (Issue: Medimpact- Action Items not showing the Crawl_id)

FOR i = 1 TO ll_rc
	li_wc_id = 0
	if not ab_crawler then li_wc_id = -5

	ls_ref = adw_verif_list.GetItemString( i, "reference_value" )
	//Start Code Change ----02.03.2014 #V14 maha - added trap for bad data
	if len(ls_ref) > 1 and pos(ls_ref,"-",1) = 0 then
		ls_ref_1 = ls_ref
	else
		ls_ref_1 = MidA( ls_ref, 1, PosA( ls_ref, "-" ) -1 )
	end if
	//End Code Change ----02.03.2014 
	ls_ref_2 = MidA( ls_ref, PosA( ls_ref, "-" ) + 2, 100 )
	li_screen_id = adw_verif_list.GetItemNumber( i, "screen_id" )
	ls_screen_name = adw_verif_list.GetItemString( i, "screen_name" )
	ll_addr_code = adw_verif_list.GetItemNumber( i, "address_lookup_code" )
	
	//Record Screen id to li_screen_id_last and set lb_samescreen. Added by Appeon long.zhang 12.18.2015 (Issue: Medimpact- Action Items not showing the Crawl_id)
	If li_screen_id = li_screen_id_last Then
		lb_samescreen = True
	Else
		li_screen_id_last = li_screen_id
		lb_samescreen = False
	End If	
	
	IF isnull(li_screen_id) THEN
		adw_verif_list.SetItem( i, "web_crawler_id", li_wc_id )
		adw_verif_list.SetItem( i, "complete_status", -4 )	
	ELSEIF ab_crawler THEN
		//Get wc id
		Choose Case li_screen_id
			Case 5 //DEA Registration
				//Special logic to increase speed for large data. Added by Appeon long.zhang 12.18.2015 (Issue: Medimpact- Action Items not showing the Crawl_id)
				If ls_ref_1 = ls_ref_1_last and lb_samescreen Then
					lb_samewithlast = True
				Else
					lb_samewithlast = False
					ls_ref_1_last = ls_ref_1	
				End If
				
				//this assumes that the the first reference value is the state. if not it will fail
				If isnull(ls_ref_1) then ls_ref_1 = ""
				
				//'Not lb_samewithlast', Added by Appeon long.zhang 12.18.2015 (Issue: Medimpact- Action Items not showing the Crawl_id)
				If Not lb_samewithlast Then
					ls_ref_1 = gnv_data.of_getitem("code_lookup", "code", "lookup_name = 'State' AND code = '" + ls_ref_1 + "'")
				End If
				
				if ls_ref_1 = "" then 
					inv_message.of_messagebox( "Web Crawl", "The first reference value is not a state for DEA screen (" + ls_ref + ")", true)
				end if
				ls_ref_1 = Trim( ls_ref_1 )
			
				//------------------- APPEON BEGIN -------------------
				//<$>Modified:long.zhang 12.18.2015
				//<$>reason:Issue: Medimpact- Action Items not showing the Crawl_id
				
				////---------Begin Modified by (Appeon)Stephen 12.25.2014 for DEA Demographics screen for webcraw- Allegheny--------
				////ls_filter = "wc_hdr_wc_screen_id_link = 5 and wc_hdr_wc_screen_field_link_fixed_value = '" + ls_ref_1 + "'"
				//ls_filter = "wc_hdr_wc_screen_id_link = 5 and (wc_hdr_wc_screen_field_link_fixed_value = '" + ls_ref_1 + "' or wc_hdr_wc_screen_field_link_fixed_value = '' or isnull(wc_hdr_wc_screen_field_link_fixed_value))"
				////---------End Modfiied ------------------------------------------------------	
				
				//lds_wc_hdr.SetFilter(ls_filter)
				//lds_wc_hdr.Filter() 
				
				If Not lb_samewithlast Then
					ls_filter = "wc_hdr_wc_screen_id_link = 5 and (wc_hdr_wc_screen_field_link_fixed_value = '" + ls_ref_1 + "' or wc_hdr_wc_screen_field_link_fixed_value = '' or isnull(wc_hdr_wc_screen_field_link_fixed_value))"
					//Use Find instead of filter
					ll_found_1 = lds_wc_hdr.Find(ls_filter, 1, ll_wc_hdr_cnt)
					//Remember ll_found_1
					ll_found_1_last = ll_found_1
					
					//ll_found_2
					If ll_wc_hdr_cnt = ll_found_1 Then
						ll_found_2 = 0
					Else
						ll_found_2 = lds_wc_hdr.Find(ls_filter, ll_found_1 + 1, ll_wc_hdr_cnt)
					End If
					//Remember ll_found_2
					ll_found_2_last = ll_found_2
				Else
					ll_found_1 = ll_found_1_last
					ll_found_2 = ll_found_2_last
				End If
				
				//if lds_wc_hdr.rowcount( ) = 1 then li_wc_id = lds_wc_hdr.GetItemNumber(1, "wc_id")	
				If ll_found_1 > 0 and ll_found_2 = 0 Then  li_wc_id = lds_wc_hdr.GetItemNumber(ll_found_1, "wc_id")
		
				if ll_found_2 > 0 then 
				//if lds_wc_hdr.rowcount( ) > 1 then 
					if not gb_AutoSchedule and not ib_schedule then
						openwithparm(w_wc_crawl_select,"5" + "*" + ls_ref_1)
						li_wc_id = message.doubleparm
					else
						inv_message.of_messagebox( "Web Crawl", "There are more than one crawler id for DEA screen", true)
					end if
				end if		
				//------------------- APPEON END -------------------
				
			Case 20 //ECFMG
				ls_filter = "wc_hdr_wc_screen_id_link = 20"
				lds_wc_hdr.SetFilter(ls_filter)
				lds_wc_hdr.Filter()
				if lds_wc_hdr.rowcount( ) = 1 then li_wc_id = lds_wc_hdr.GetItemNumber(1, "wc_id")											
				if lds_wc_hdr.rowcount( ) > 1 then
					inv_message.of_messagebox( "Web Crawl", "There are more than one crawler id for ECFMG screen", true)
				end if						
			Case 23 //Other Ids	
				//this assumes that the the first reference value is the state.  if not it will fail
				If isnull(ls_ref_1) then ls_ref_1 = ""
				ls_ref_1 = gnv_data.of_getitem("code_lookup", "code", "lookup_name = 'Other Document Type' AND code = '" + ls_ref_1 + "'")
				if ls_ref_1 = "" then 
					inv_message.of_messagebox( "Web Crawl", "The first reference value is not a document type for Other Ids screen  (" + ls_ref + ")", true)
				end if
				ls_ref_1 = Trim( ls_ref_1 )
					
				ls_filter = "wc_hdr_wc_screen_id_link = 23 and wc_hdr_wc_screen_field_link_fixed_value = '" + ls_ref_1 + "'"
				res = lds_wc_hdr.SetFilter(ls_filter)
				lds_wc_hdr.Filter() 
				res = lds_wc_hdr.rowcount( )
				if lds_wc_hdr.rowcount( ) = 1 then li_wc_id = lds_wc_hdr.GetItemNumber(1, "wc_id")
				if lds_wc_hdr.rowcount( ) > 1 then 
					if not gb_AutoSchedule and not ib_schedule then
						openwithparm(w_wc_crawl_select,"23" + "*" + ls_ref_1)
						li_wc_id = message.doubleparm
					else
						inv_message.of_messagebox( "Web Crawl", "There are more than one crawler id for Other Ids screen", true)
					end if
				end if					
			Case ELSE //other screens
				if isnull(ll_addr_code) or ll_addr_code = 0 then
					li_wc_id = 0
				else
					ls_filter = "wc_screen_id_link = " + String(li_screen_id) + " AND lookup_code = " + String(ll_addr_code)
					res = lds_wc_hdr_addr.SetFilter(ls_filter)
					lds_wc_hdr_addr.Filter() 
					res = lds_wc_hdr_addr.rowcount( )
					if lds_wc_hdr_addr.rowcount( ) = 1 then li_wc_id = lds_wc_hdr_addr.GetItemNumber(1, "wc_id")
					if lds_wc_hdr_addr.rowcount( ) > 1 then 
						if not gb_AutoSchedule and not ib_schedule then
							openwithparm(w_wc_crawl_select, string(li_screen_id) + "*" + string(ll_addr_code))
							li_wc_id = message.doubleparm
						else
							inv_message.of_messagebox( "Web Crawl", "There are more than one crawler id for " + ls_screen_name + " screen", true)
						end if
					end if		
				end if					
		End Choose
	END IF
	
	//Set wc id and complete staus
	IF li_wc_id > 0 then //has a crawler
		adw_verif_list.SetItem( i, "web_crawler_id", li_wc_id )
		adw_verif_list.SetItem( i, "complete_status", 0 )
	ELSE
		adw_verif_list.SetItem( i, "web_crawler_id",0 )
		if LenA( adw_verif_list.GetItemString( i, "web_address") ) > 0 then
			adw_verif_list.SetItem( i, "complete_status", -3 )	
		else
			if li_wc_id = -5 then //no crawler module
				adw_verif_list.SetItem( i, "complete_status", -5 )
			else
				adw_verif_list.SetItem( i, "complete_status", -4 )
			end if
		end if
	END IF		
	adw_verif_list.Setitemstatus(i, 0 ,primary!, notmodified!)  //Start Code Change ----04.23.2013 #V14 maha
NEXT

Destroy lds_wc_hdr
Destroy lds_wc_hdr_addr

RETURN 1


end function

public function string of_parse_status (integer ai_status);//Parse the complete status for Web Crawl; For Scheduler - Alfee 02.08.2010
String ls_msg
	
CHOOSE CASE ai_status	
	CASE -100 
		ls_msg = "No Data Found"
	CASE -1 
		ls_msg = "Error Occured"
	CASE -3 
		ls_msg = "Web Link Available"
	CASE -4
		ls_msg = "No Web Crawler or Link"
	CASE -5 
		ls_msg = "No Web Link Available"
	CASE 0 
		ls_msg = "Web Crawler Available"
	CASE 1 
		ls_msg = "Data Verified NO Reponse Code"
	CASE 2 
		ls_msg = "Data Verified with Reponse Code"
	CASE  3 
		ls_msg = "Not found on Site"
	CASE 99 
		ls_msg = "Verifying..."
	CASE ELSE
		ls_msg = "Unknow"
END CHOOSE

RETURN ls_msg
end function

public function integer of_set_sched_flag (boolean ab_flag);//Set the schedule flag - Scheduler - alfee 02.06.2010

ib_schedule = ab_flag

IF Isvalid(inv_message) THEN
	inv_message.of_set_schedule(ab_flag)		
END IF

RETURN 1
end function

public function integer of_set_crawl_value (integer ai_wc_id, string as_wc_ret);//keep the wc ids & return values for failed Web Crawls - scheduler - alfee 03.25.2010

Long i, ll_cnt, ll_row

if IsNull(ai_wc_id) or isnull(as_wc_ret) then return 0

ll_cnt = ids_wc_ret.rowcount() 
for i = 1 to ll_cnt
	if ids_wc_ret.GetItemNumber(i, "wc_id") = ai_wc_id then return 0
next

choose case as_wc_ret
	case "-20*", "-30*", "-40*", "-901*", "- 902*", "- 903*"
		ll_row = ids_wc_ret.InsertRow(0)
		ids_wc_ret.SetItem(i, 'wc_id', ai_wc_id )
		ids_wc_ret.SetItem(i, 'wc_ret', as_wc_ret)
	case else
		//
end choose

return 1
end function

public function string of_get_crawl_value (integer ai_wc_id);//Check and get the return value for failed Web Crawls - scheduler - alfee 03.25.2010

Long i, ll_cnt, ll_found
String ls_rtn

if IsNull(ai_wc_id) then return ''

ll_cnt = ids_wc_ret.rowcount() 
if ll_cnt < 1 then return ''

ll_found = ids_wc_ret.Find("wc_id = " + string(ai_wc_id), 1, ll_cnt)
if ll_found > 0 then	ls_rtn = ids_wc_ret.GetItemString(ll_found, "wc_ret")

return ls_rtn
end function

public function string of_crawl_new (integer ai_wc_id, long al_prac_id, string as_doc_id, boolean ab_show_crawler, long al_rec_id, long al_facility_id);//Start Code Change ---- 02.20.2007 #V7 maha created to replace of_crawl

Boolean lb_image_saved = False
Boolean lb_extract_verif_result = False
Boolean 	lb_check_for_no_results = False
Long fh
Long ll_retval  // -100 = no data found page came up  -200 = macro error
Long ll_rec_id
Long ll_verif_response_cd = 0
Long ll_filelen
Long ll_bytes_read
Long ll_new_pos 
Long ll_cnt
String ls_sql
String ls_file_type
String ls_no_results_message
String ls_ic_ver_cd
String ls_ic_vef_cd
String ls_response_code
String ls_html_search_val
String ls_line
String ls_web_site_data
String ls_content
String ls_char
String ls_value
String ls_step_action
String ls_data_from
String ls_url
String ls_tag
String ls_f_name
String ls_m_name
String ls_l_name
String ls_prof_suffix
String ls_ssn
String ls_reference
String ls_ref_1
String ls_ref_2
string ls_crawl_name
string ls_form_val //maha020607
string ls_obj_pos //maha020607
string ls_obj_name //maha020607
string ls_var_name
string ls_actno 
string ls_userid
string ls_crawler
string ls_extract
string ls_message
string ls_macro_object //maha031510
integer li_type //012907
Integer li_filenum
Integer li_loops
Integer li_counter 
Integer li_retval
Integer li_result
Integer c
integer cnt
integer li_wc_loops[]
integer li_wc_start[]
integer li_wc_end[]
Integer li_found_pos
Integer li_step_order
Integer li_ver_extract_step
Integer li_len
Integer li_rc
Integer i
Integer li_FileNum2
integer f
integer li_stop
integer li_break
integer li_key_test
//OLEObject myoleobject   //maha 12.16.2015  - moved to instance variable
DateTime ldt_exp_dt
DateTime ldt_dob
//n_ds lds_steps
//n_ds lds_web_verif_rsp_mapping
n_cst_appeondll lnv_appeon
string ls_field_id
long ll_screen_id

//---------Begin Modified by (Appeon)Stephen 2013-07-13 for  Feature request #3602--------
/*
is_path = gs_dir_path + "intellicred\" //maha111605

//maha 111605 modifed from storing directly on the gs_dir_path which typically is C:\ 
FileDelete( is_path + "_ResultPage.htm" )
FileDelete( is_path + "_ResultPage.bmp" )
FileDelete( is_path + "_ResultPage.pdf" )
FileDelete( is_path + "extract.csv" )
*/
is_path = gs_temp_path + "webcraw\"
if not DirectoryExists(is_path) then CreateDirectory(is_path)
of_delete_craw_file('delete')
//---------End Modfiied ------------------------------------------------------
ii_resp_step = 0


 //Start Code Change ----10.01.2015 #V15 maha - PAth code moved to separat function

////Start Code Change ----01.14.2010 #V10 maha - update for imacros V6
////Start Code Change ---- 5.15.2007 #V7 maha modified  to use registry setting
////li_key_test = RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\IIM\", "PathBasic", RegString!, is_iim_path)
////IF IsNull(is_iim_path)  or li_key_test = -1 THEN  //if key does not exist returns -1
////	is_iim_path = "C:\Program Files\IMacros\Macros\"  //Start Code Change ---- 08.07.2007 #V7 maha  changed from internet macros
////	//messagebox("li_key_test",li_key_test)
////else
////	is_iim_path = is_iim_path + "\Macros\"
////END IF
//
////first check registry for App DataFolder; if not exists check Basic Path else default to program files
////Start Code Change ----06.12.2014 #V14.2 maha - for version 10
////V10 key
//li_key_test = RegistryGet( "HKEY_CURRENT_USER\SOFTWARE\iOpus\iMacros\", "FolderMacros", RegString!, is_iim_path)
////V6 key
//IF IsNull(is_iim_path)  or li_key_test = -1 THEN
//	 li_key_test = RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\IMacros\", "AppDataFolder", RegString!, is_iim_path)
//else
//	ii_macro_ver = 10
//end if
////End Code Change ----06.12.2014
////V5 key
//IF IsNull(is_iim_path)  or li_key_test = -1 THEN  //if key does not exist returns -1
//	li_key_test = RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\IIM\", "AppDataFolder", RegString!, is_iim_path)
//end if
//
//IF IsNull(is_iim_path)  or li_key_test = -1 THEN  //if key does not exist set default
//	//is_iim_path = "C:\Program Files\IMacros\Macros\"  //Start Code Change ---- 08.07.2007 #V7 maha  changed from internet macros
//	is_iim_path = "C:\Users\Public\Documents\iMacros\Macros\" //Start Code Change ----06.16.2014 #V14.2 maha - current folder for V6
//	//messagebox("li_key_test",li_key_test)
//ELSE //get the macro path from the iim.ini file
//	if RightA(is_iim_path, 1 ) <> "\" then is_iim_path = is_iim_path + "\"  //Start Code Change ----01.19.2010 #V10 maha - from registry
//	//is_iim_path = ProfileString(is_iim_path + "iim.ini", "iOpus", "PathMacros", "C:\Users\Public\Documents\iMacros\Macros\") //modify by stephen 06/29/2011 Imacros Saas issue
//	//Start Code Change ----06.16.2014 #V14.2 maha
//	if ii_macro_ver = 10 then
//		//leave alone
//	else
//		is_iim_path = lnv_appeon.of_ProfileString(is_iim_path + "iim.ini", "iOpus", "PathMacros", "C:\Users\Public\Documents\iMacros\Macros\") //added by evan 10.09.2011
//	end if		
//	//End Code Change ----06.16.2014
//	if RightA(is_iim_path, 1 ) <> "\" then is_iim_path = is_iim_path + "\"  //Start Code Change ----01.19.2010 #V10 maha - from ini file
//END IF
////End Code Change---01.14.2010
//
//if gi_test_mode = 1 then
//	//messagebox("is_iim_path",is_iim_path)
//	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
//	inv_message.of_MessageBox("is_iim_path",is_iim_path,true)
//end if
////End Code Change---05.15.2007
//

of_get_macro_directory( "Run")
 //End Code Change ----10.01.2015

//debugbreak()
//Start Code Change ----03.15.2010 #V10 maha
//Start Code Change ----10.08.2014 #V14.2 maha
if ii_macro_ver = 6 then
	li_key_test = RegistryGet ("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\iMacros\", "CurVer", RegString!, ls_macro_object ) //VER 6
else
	li_key_test = RegistryGet ("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\InternetMacros.iim\", "CurVer", RegString!, ls_macro_object ) //VER 5
end if

if li_key_test = 1 then
	//ls_macro_object = "InternetMacros.iim" // version 5
else
	ls_macro_object = "Imacros" //6 +

end if
//End Code Change---03.15.2010

//Start of actually crawling code

ids_prac = CREATE n_ds
 //Start Code Change ----07.21.2015 #V15 maha
if ib_from_batch_verif then
	ids_prac.dataobject = "d_wc_prac_batch_verif_info"
else
	ids_prac.dataobject = "d_wc_prac_verif_info"
end if
 //End Code Change ----07.21.2015
ids_prac.settransobject(sqlca)

ids_wc = CREATE n_ds
ids_wc.dataobject = "d_wc_header"
ids_wc.settransobject(sqlca)

if as_doc_id = "x-x-x-x" then
	ib_test = true
	//skip as test
//Start Code Change ----07.15.2015 #V15 maha	
elseif ib_from_batch_verif = true then   
	c = ids_prac.retrieve(al_prac_id)
	//Note: doc id for these is the logid of the verif log
	if c < 1 then
		inv_message.of_MessageBox( "Web Crawler Error", "Error retrieving practitioner data. " + as_doc_id,true)
		RETURN "-10*"
	end if
 //End Code Change ----07.21.2015
else
	c = ids_prac.retrieve(as_doc_id) //get prac data
	if c < 1 then
		//MessageBox( "Web Crawler Error", "Error retrieving practitioner data for verification record " + as_doc_id )
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
		inv_message.of_MessageBox( "Web Crawler Error", "Error retrieving practitioner data for verification record " + as_doc_id,true)
		RETURN "-10*"
	END IF
end if

c = ids_wc.retrieve(ai_wc_id ) //get crawler data
if c < 1 then
	//MessageBox( "Web Crawler Error", "Error retrieving Web Crawler data for Crawler " + string(ai_wc_id ))	
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox("Web Crawler Error", "Error retrieving Web Crawler data for Crawler " + string(ai_wc_id),true)
	RETURN "-20*"	
END IF

ls_crawler = ids_wc.getitemstring(1,"wc_description")

if ids_wc.getitemnumber(1,"pw_rqd") = 1 then
	if LenA(ids_wc.getitemstring(1,"web_site_password")) < 1 or isnull(ids_wc.getitemstring(1,"web_site_password")) then
		//messagebox(ls_crawler,"This Crawler requires a password.  Please set this up in the Web Crawler Painter.")
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
		inv_message.of_MessageBox(ls_crawler,"This Crawler requires a password.  Please set this up in the Web Crawler Painter.",true)
		RETURN "-30*"
	end if
end if

is_url = ids_wc.getitemstring(1,"wc_web_address")

IF Upper( MidA( is_url, 1, 4 ))  <> "HTTP" THEN
	is_url = "HTTP://" + is_url
END IF

ids_steps = CREATE n_ds
ids_steps.DataObject = "d_wc_steps_browse"
ids_steps.of_SetTransObject( SQLCA )
ids_steps.Retrieve( ai_wc_id )
li_rc = ids_steps.RowCount( )

if li_rc < 1 then
	//MessageBox( "Web Crawler Error", "Error retrieving crawler steps for crawler "  + string(ai_wc_id ))
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
   inv_message.of_MessageBox( "Web Crawler Error", "Error retrieving crawler steps for crawler "  + string(ai_wc_id ),true)
	RETURN "-40*"
END IF

cnt = 1//number of segments
li_wc_start[1] = 1

for c = 1 to li_rc //find out how many times you need to trap
	
	if ids_steps.getitemnumber(c,"no_data_found_check") = 1  or ids_steps.GetItemString( c, "step_action" )  = "Break for User Input" or ids_steps.GetItemString( c, "step_action" )  = "Extract for Data update" or ids_steps.GetItemString( c, "step_action" )  = "Extract for Link VAR mod"  then  //modify by stephen 08.03.2012 add step_action = Extract for Data update --V12.2 WebCrawler extract data   //Start Code Change ----12.15.2015 #V15 maha - added var mod type
		if ids_steps.GetItemString( c, "step_action" )  = "Break for User Input" then ab_show_crawler =  true //maha 05.14.07
		li_wc_end[cnt] = c
		if c < li_rc then //if not the last step create a new start
			cnt++
			li_wc_start[cnt] = c + 1
		end if
	end if
	if c = li_rc then li_wc_end[cnt] = c //if the last row, set the last end
next
			
ll_screen_id =  ids_wc.getitemnumber(1,"wc_screen_id_link")

 //Start Code Change ----07.21.2015 #V15 maha
 il_prac = al_prac_id
 il_recid = al_rec_id
 il_screen = ll_screen_id
 //End Code Change ----07.21.2015 

is_extract = ''  //V12.2 WebCrawler extract data -stephen 06.29.2012
//create crawl segments	
for c = 1 to cnt
	of_delete_craw_file('delete') //(Appeon)Stephen 2013-07-13 -  Feature request #3602
	ib_image_saved = false
	ib_verif_ext = false
	ib_extract = false  //V12.2 WebCrawler extract data -stephen 06.29.2012

//BUILD the CRAWLER
	li_retval = of_build_crawl( li_wc_start[c],li_wc_end[c], c)

	if li_retval < 1 then
		return "-901*"
	elseif li_retval = 999 then //break for user input
//		if not isvalid(myoleobject) then
//			myoleobject = CREATE OLEObjec
		ls_message = ids_steps.getitemstring(li_wc_end[c],"no_data_found_text")

		if gb_autoschedule or ib_schedule then continue//scheduler - alfee 04.02.2010

		li_break = openwithparm(w_wc_site_input,ls_message)
		//w_wc_site_input.st_mess.text = ids_steps.getitemstring(li_wc_end[c],"no_data_found_text")
		 if li_break = 0 then
			li_stop = 1  //on cancel drop out of crawl loop
			exit
		else //= 1 continue
			continue
		end if
	end if
	ls_crawl_name = "WebCrawl" +string(c)
	
	
//@@@@@@@@@@@@@ open imacros @@@@@@@@@@@@@
	if c = 1 then //create imacro object only if first loop
		//OLEObject myoleobject //Start Code Change ---- 05.14.2007 #V7 maha moved to declarations
		myoleobject = CREATE OLEObject
		li_result = myoleobject.ConnectToNewObject(ls_macro_object )
		IF li_result < 0 THEN
				//messagebox("of_Crawl failure","Failed to connect to InternetMacros.iim.  Check installation.")
				//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
				inv_message.of_MessageBox("of_Crawl failure","Failed to connect to " + ls_macro_object + "  Check installation.",true)
				Return "- 902*"
				exit
		END IF
		IF ab_show_crawler THEN
			li_result = myoleobject.iimInit() //-kioskmode
		ELSE
			li_result = myoleobject.iimInit("-tray")		
		END IF		
		
		if li_result < 0 then
			inv_message.of_MessageBox("of_Crawl failure","Error code: " + string(li_result)  +  "Failure to initiate",true)
			Return "- 903*"
			exit
		end if
	end if

	//ls_crawl_name = 	"C:\Users\Public\Documents\IMacros\Macros\" + ls_crawl_name + "iim"
	//Run the web crawl
	li_result = myoleobject.iimPlay (ls_crawl_name)
	//messagebox("ls_crawl_name",ls_crawl_name)
	IF li_result < 0 THEN
		//messagebox("of_Crawl failure","iimplay failed")
		//Start Code Change ----10.08.2014 #V14.2 maha - added choose for specific error message
		 //Start Code Change ----01.26.2017 #V153 maha - mod of message to include crawler id
		choose case li_result  
			case -4
				inv_message.of_MessageBox("of_Crawl_new failure (crawler id = " + string(ai_wc_id) + ")","Error code: " + string(li_result) + "~r Could not start the iMacros browser. iimOpen failed and the subsequent commands cannot proceed. ",true)
			case else
				inv_message.of_MessageBox("of_Crawl_new failure (crawler id = " + string(ai_wc_id) + ")","Error code: " + string(li_result),true)
		end choose
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
		inv_message.of_MessageBox("of_Crawl_new failure (crawler id = " + string(ai_wc_id) + ")","Web Crawler failed",true)
		myoleobject.iimExit()
		Return "- 903*"
		exit
//		IF NOT ab_show_crawler THEN
//			myoleobject.iimExit() 
//		END IF		
	END IF
	
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 06.29.2012
	//$<reason>  V12.2 WebCrawler extract data @@@@@@@@@@@@@@@@2
	if ib_extract then
//
		//ls_field_id =  ids_steps.getitemstring(li_wc_end[c],"object_name")
		ls_field_id =  ids_steps.getitemstring(li_wc_end[c],"content_or_value") //alfee 09.12.2012
		if not( isnull(ls_field_id) or ls_field_id='') then
			ls_extract = myoleobject.iimgetlastextract(1)
		//	messagebox("extract value", ls_extract)
			if of_save_extracted_data(ls_extract, ll_screen_id, ls_field_id, al_prac_id, as_doc_id, al_rec_id, al_facility_id)	<> 1 then RETURN "-40*"
		end if
	end if
	//------------------- APPEON END -------------------

//if check for no results	
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	if ids_steps.getitemnumber(li_wc_end[c],"no_data_found_check") = 1  or ib_verif_ext then
		if ids_steps.getitemnumber(li_wc_end[c],"no_data_found_check") = 1 then //41907
			lb_check_for_no_results =  true
			ls_no_results_message = ids_steps.getitemstring(li_wc_end[c],"no_data_found_text") //41907
		end if
		
	// htm must be saved before it can be tested for 'no results'
		//messagebox("","wait")
		//---------Begin Added by (Appeon)Stephen 2013-07-13 for  Feature request #3602--------
		if  not fileexists( is_path + "_ResultPage.htm" ) then
			of_delete_craw_file('modify')
		end if
		//---------End Added ------------------------------------------------------
		
		if not fileexists( is_path + "_ResultPage.htm" ) then //check to see if file was created
			//messagebox("Crawl Error",  is_path + "_ResultPage.htm" + " file does not exist.")
			//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
			inv_message.of_MessageBox("Crawl Error",  is_path + "_ResultPage.htm" + " file does not exist.",true)
			myoleobject.iimExit() //maha 05.17.07
			return "-904*" //maha
			exit
		end if
		li_filenum2 = FileOpen(is_path + "_ResultPage.htm" , StreamMode!) //41907
		ls_no_results_message = Upper( ls_no_results_message )	//41907
		long filerows
		filerows = FileRead( li_filenum2, ls_line )
		
		DO WHILE  filerows >= 0  //subsequent reads are done at the end of the loop

		//DO WHILE  FileRead( li_filenum2, ls_line ) >=  0
			ls_line = Upper( ls_line)
			//check for no results
			IF lb_check_for_no_results THEN
				//messagebox("",ls_no_results_message )
				li_found_pos = PosA( ls_line, ls_no_results_message )
				IF li_found_pos > 0 THEN
					//messagebox("found", ls_no_results_message)
					//myoleobject.DisconnectObject()
					ib_image_saved = true
					is_saved_file = is_path + "_ResultPage.htm"
					li_stop = 1
					ll_retval = 3
					ii_type = 3
					EXIT //do loop
					//EXIT //for loop
				END IF
			END IF
			IF ib_verif_ext THEN  //find the value on the page
			
//				//openwithparm(w_sql_msg,ls_line)
				li_found_pos = PosA( ls_line, is_verif_search_val )
				IF li_found_pos > 0 THEN
					ls_extract = MidA(ls_line, li_found_pos + LenA(is_verif_search_val ) , 50 )
					f = PosA(ls_extract,"<",1)
					if f > 0 then
						ls_extract = trim(MidA (ls_extract,1,f -1))
					end if
					ll_retval = of_verif_response( ai_wc_id ,ii_resp_step, ls_extract)
					EXIT

				ELSE

					//messagebox("not found",is_verif_search_val)
				END IF //pos found
			End if //verif extract
			
			filerows = FileRead( li_filenum2, ls_line ) //read next line
			
		LOOP	
		FileClose( li_filenum2 )		
		FileClose( li_filenum )

	END IF
	
	
	IF ib_image_saved THEN
		 //Start Code Change ----07.22.2015 #V15 maha - verif batch
		 if ib_from_batch_verif then
			of_image_save( as_doc_id,1 )
			ib_image_saved = false
		else
			of_image_save( as_doc_id,1 )
			ib_image_saved = false
		end if
		 //End Code Change ----07.22.2015
	END IF	
	
	if ib_verif_ext then
		
	end if
		
	if li_stop = 1 then exit //41907 drop out of loop if 'not found'	
	
NEXT

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 07.03.2012
//$<reason>  V12.2 WebCrawler extract data
if ib_test and not(isnull(is_extract) or is_extract = '') then
	messagebox("Extract data", is_extract)
end if
//------------------- APPEON END -------------------

IF ll_verif_response_cd = 0 and  ll_retval <> 3 THEN //41907
	ll_retval = 1
END IF

//myoleobject.DisconnectObject()	
myoleobject.iimExit() 


DESTROY ids_prac
DESTROY ids_wc
DESTROY ids_steps

if isvalid(ids_ref_data ) then destroy ids_ref_data
if isvalid(ids_screen_data ) then destroy ids_screen_data
if isvalid(ids_table_data ) then destroy ids_table_data

Return string(ll_retval) + "*" + string(ii_type)

end function

public function integer of_save_extracted_data (string as_extract, long al_screen_id, string as_field_id, long al_prac_id, string as_doc_id, long al_rec_id, long al_facility_id);//////////////////////////////////////////////////////////////////////
// $<Function> of_save_extracted_data
// $<arguments> N/A
// $<returns> integer
// $<description>insert record into wc_extracted_data   (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.04.2012 by Stephen
//////////////////////////////////////////////////////////////////////

integer li_ret
integer li_code
long  ll_field_id, ll_pk_id
string ls_Org_value
string ls_field_allias, ls_sql
string ls_field_name, ls_table_name
datastore lds_sys_fields
datetime ldt_today

ll_field_id = long(as_field_id)

lds_sys_fields = create datastore
lds_sys_fields.dataobject = 'd_wc_extract_fields'
lds_sys_fields.settransobject(sqlca)
//messagebox("","extracted data function")
lds_sys_fields.retrieve(al_screen_id, ll_field_id)
li_ret = lds_sys_fields.rowcount()
if li_ret < 1 then
	messagebox("Prompt", "The field isn’t matched with the screen in Extract for data update, please reset them.")
	destroy lds_sys_fields
	return 0
end if

ls_field_allias = lds_sys_fields.getitemstring(1, "sys_fields_field_name_allias")
ls_field_name = lds_sys_fields.getitemstring(1, "sys_fields_field_name")
ls_table_name = lds_sys_fields.getitemstring(1, "sys_tables_table_name") 
destroy lds_sys_fields

if ib_test then  //test mode
	is_extract = is_extract + '~r~n' + ls_field_allias + ": " + as_extract
else  //save data to wc_extracted_data
	gnv_appeondb.of_startqueue()
	ls_sql = "select " + ls_field_name + " from " + ls_table_name +  " where rec_id = " + string(al_rec_id) + " and prac_id = " + string(al_prac_id)
	declare c_1 dynamic cursor for sqlsa;
	prepare sqlsa from :ls_sql using sqlca; 
	open dynamic  c_1;
		
	select pk_id into :ll_pk_id from  wc_extracted_data 
	where Rec_id = :al_rec_id and Screen_id = :al_screen_id and field_id = :ll_field_id and Doc_id = :as_doc_id and Status=0 using sqlca;	
	gnv_appeondb.of_CommitQueue()
	
	fetch c_1 into :ls_Org_value;
	IF SQLCA.SQLCODE = -1 THEN
		close c_1;
		RETURN -1
	end if 
	close c_1;	
	
	ldt_today = datetime(today(), now())
	//if sqlca.sqlcode = 100 or isnull(ll_pk_id) or ll_pk_id = 0 then  //insert new record
	if isnull(ll_pk_id) or ll_pk_id = 0 then  //insert new record -alfee 09.06.2012
		insert into wc_extracted_data(
		Create_date, rec_id, prac_id, screen_id, field_id, doc_id, status, org_value, extract_value,facility_id
		)
		values(
		:ldt_today, :al_rec_id, :al_prac_id, :al_screen_id, :ll_field_id, :as_doc_id, 0, :ls_Org_value, :as_extract, :al_facility_id
		) using sqlca;
	else  //update record
		update wc_extracted_data
		   set Create_date = :ldt_today,
			    Org_value = :ls_Org_value,
			    extract_value = :as_extract
	    where Pk_id = :ll_pk_id using sqlca;
	end if
	li_code = SQLCA.SQLCODE    //Start Code Change ---08.08.2012 #V12 maha
	IF li_code = -1 THEN RETURN -1
end if

return 1
end function

public function integer of_delete_craw_file (string as_type);//====================================================================
//$<Function>: of_delete_craw_file
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-07-13 (Feature request #3602)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_i
Integer li_cnt, li_entries
String ls_import
String ls_currdir
string  ls_file_type

n_cst_dirattrib lnv_dirlist[]
SetPointer(HourGlass!)
 
If NOT isvalid(inv_filesrv) Then
	inv_filesrv =  create n_cst_filesrvwin32
End If

ls_currdir = is_path + "*.*"
li_entries = inv_filesrv.of_DirList(ls_currdir, 0, lnv_dirlist)
If isvalid(inv_filesrv) Then Destroy inv_filesrv

if lower(as_type) = 'delete' then
	for ll_i = 1 to upperbound(lnv_dirlist)	
		 if FileDelete ( is_path + lnv_dirlist[ll_i].is_filename ) <>  true then 
			SetPointer(arrow! )
			return -1
		end if	
	next
else
	for ll_i = 1 to upperbound(lnv_dirlist)	
		ls_file_type = mid(lnv_dirlist[ll_i].is_filename, lastpos(lnv_dirlist[ll_i].is_filename,".") +1 )
		if ls_file_type = 'htm' or ls_file_type = 'html' then
			filecopy( is_path + lnv_dirlist[ll_i].is_filename,  is_path + "_ResultPage.htm")
			exit
		end if
	next
end if

SetPointer(arrow! )

return 0



end function

public function string of_get_reference_data (long al_prac, long al_rec, integer ai_screen, string as_ref_field); //Start Code Change ----07.21.2015 #V15 maha - Created to get verification values without verif reference value
 //For batch verifications
long ll_ref1
long ll_ref2 
long ll_ref3 
long ll_refexp
long ll_dvalue
integer ll_find
integer w
string ls_find
string ls_table
string ls_field
string ls_islookup
string ls_lookuptype
string ls_lufield
string ls_dtype
string ls_value
string ls_select
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
 
 if not isvalid(ids_screen_data ) then
	ids_screen_data = create n_ds
	ids_screen_data.dataobject = "d_sys_list_for_dv1"
	ids_screen_data.settransobject(sqlca)
	ids_screen_data.retrieve(ai_screen)
end if

 if not isvalid(ids_ref_data ) then
	ids_ref_data = create n_ds
	ids_ref_data.dataobject = "d_sys_field_ref_fields_for_screen"
	ids_ref_data.settransobject(sqlca)
end if

 //get the table name from sys_tables
if ids_screen_data.rowcount() > 0 then
	if ids_ref_data.rowcount() = 0 then
		ll_ref1 = ids_screen_data.getitemnumber(1,"reference_field_1")
		ll_ref2 = ids_screen_data.getitemnumber(1,"reference_field_2")
		ll_ref3 = ids_screen_data.getitemnumber(1,"reference_field_3")
		ll_refexp = ids_screen_data.getitemnumber(1,"exp_field")
		ids_ref_data.retrieve(ai_screen, ll_ref1,  ll_ref2,  ll_ref3,  ll_refexp)
	end if
end if

ls_table = ids_screen_data.getitemstring(1,"table_name")

choose case as_ref_field
	case "ref_1"
		ls_find = "ref1"
	case "ref_2"
		ls_find = "ref2"
		
end choose

 // get the reference field from dvs as well as sys_field lookup info
  // get the field name for the reference
ll_find = ids_ref_data.find( "ref_type = '" + ls_find + "'", 1, ids_ref_data.rowcount())
if ll_find = 0 then return ""
if ll_find < 0 then
	messagebox("Find failed",  "ref_type = '" + ls_find + "'")
	return ""
end if
//debugbreak()

if ll_find > 0 then
	ls_field = ids_ref_data.getitemstring(ll_find, "sys_fields_field_name")
	ls_dtype = ids_ref_data.getitemstring(ll_find, "sys_fields_field_type")
	ls_islookup = ids_ref_data.getitemstring(ll_find, "lookup_field")
	ls_lufield = ids_ref_data.getitemstring(ll_find, "lookup_field_name")
	ls_lookuptype = ids_ref_data.getitemstring(ll_find, "lookup_type")
end if
	
ls_select = "Select " + ls_field + " from " + ls_table + " Where rec_id = " + string(al_rec) + ";" 


ls_presentation_str = "style(type=grid)"		
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_select, ls_presentation_str, ERRORS)
IF Len(ERRORS) > 0 THEN
	MessageBox("Caution on export field " + ls_select, &
	"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_select)
//	MessageBox("ls_select_table",ls_select_table)
	
	RETURN ""
END IF

ids_table_data = CREATE n_ds
w = ids_table_data.Create( ls_dwsyntax_str, ERRORS)
if w < 1 then
	messagebox("error on create",errors)
end if	

ids_table_data.settransobject(sqlca)
ids_table_data.retrieve()

 //get the data value from the pd table
if ids_table_data.rowcount() = 0 then return ""

choose case upper(mid(ls_dtype, 1,1))
	case "C", "V"
		ls_value = ids_table_data.getitemstring(1,1)
	case "N", "F", "I"
		ls_value = string(ids_table_data.getitemnumber(1,1))
	case "D"
		ls_value = string(ids_table_data.getitemdatetime(1,1))
end choose


 //if a lookup get the lookup value
if ls_islookup = "Y" then
	if not isnumber(ls_value) then
		//leave value as is
	else
		ll_dvalue = long(ls_value)
	end if
	
	choose case ls_lookuptype
		case "A"
			choose case upper(ls_lufield)
				case "CODE"
					select code into :ls_value from address_lookup where lookup_code = :ll_dvalue;
				case "ENTITY_NAME"
					select entity_name into :ls_value from address_lookup where lookup_code = :ll_dvalue;
			end choose
		case "C"	
			choose case upper(ls_lufield)
				case "CODE"
					select code into :ls_value from code_lookup where lookup_code = :ll_dvalue;
				case "DESCRIPTION"
					select description into :ls_value from code_lookup where lookup_code = :ll_dvalue;
			end choose
	end choose
end if

if isnull(ls_value) then ls_value = ""


return ls_value
 
end function

public function integer of_get_macro_directory (string as_test); //Start Code Change ----10.01.2015 #V15 maha - factored out so it could be accessed via a test
integer li_key_test 
integer li_test1
string s

 
//first check registry for App DataFolder; if not exists check Basic Path else default to program files
//Start Code Change ----06.12.2014 #V14.2 maha - for version 10
//V10 key
li_key_test = RegistryGet( "HKEY_CURRENT_USER\SOFTWARE\iOpus\iMacros\", "FolderMacros", RegString!, is_iim_path)
//V6 key
IF IsNull(is_iim_path)  or li_key_test = -1 THEN
	s = "Test for Imacros Version 10 registry path failed (HKEY_LOCAL_MACHINE\SOFTWARE\IMacros\)~r"
	 li_key_test = RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\IMacros\", "AppDataFolder", RegString!, is_iim_path)
	IF IsNull(is_iim_path)  or li_key_test = -1 THEN
		s+= "Test for Imacros Version 6 registry path failed (HKEY_LOCAL_MACHINE\SOFTWARE\IMacros\)~r"
		s+= "Check that Imacros is installed and the user rights allow read access to the registry.~r"
	else
		//s = "Registry path succeded; V6 Imacros~r"
		s = "Registry path succeeded; V6 Imacros~r" //succeded->succeeded, Modified by Appeon long.zhang 10.17.2015 (V14.2 Bug # 4785 - Typo in Imacros Path Test utility message)
	end if
		
else
	//s = "Registry path succeded; V10 Imacros~r"
	s = "Registry path succeeded; V10 Imacros~r" //succeded->succeeded, Modified by Appeon long.zhang 10.17.2015 (V14.2 Bug # 4785 - Typo in Imacros Path Test utility message)
	ii_macro_ver = 10
end if
//End Code Change ----06.12.2014
//V5 key
IF IsNull(is_iim_path)  or li_key_test = -1 THEN  //if key does not exist returns -1
	li_key_test = RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\IIM\", "AppDataFolder", RegString!, is_iim_path)
end if

IF IsNull(is_iim_path)  or li_key_test = -1 THEN  //if key does not exist set default
	//is_iim_path = "C:\Program Files\IMacros\Macros\"  //Start Code Change ---- 08.07.2007 #V7 maha  changed from internet macros
	is_iim_path = "C:\Users\Public\Documents\iMacros\Macros\" //Start Code Change ----06.16.2014 #V14.2 maha - current folder for V6
	s+= "All registry check failed. Default Save path is: C:\Users\Public\Documents\iMacros\Macros\~r "
	//messagebox("li_key_test",li_key_test)
ELSE //get the macro path from the iim.ini file
	if RightA(is_iim_path, 1 ) <> "\" then is_iim_path = is_iim_path + "\"  //Start Code Change ----01.19.2010 #V10 maha - from registry
	//is_iim_path = ProfileString(is_iim_path + "iim.ini", "iOpus", "PathMacros", "C:\Users\Public\Documents\iMacros\Macros\") //modify by stephen 06/29/2011 Imacros Saas issue
	//Start Code Change ----06.16.2014 #V14.2 maha
	if ii_macro_ver = 10 then
		//leave alone
	else
//		is_iim_path = lnv_appeon.of_ProfileString(is_iim_path + "iim.ini", "iOpus", "PathMacros", "C:\Users\Public\Documents\iMacros\Macros\") //added by evan 10.09.2011
	end if		
	//End Code Change ----06.16.2014
	if RightA(is_iim_path, 1 ) <> "\" then is_iim_path = is_iim_path + "\"  //Start Code Change ----01.19.2010 #V10 maha - from ini file
	s+= "Macro Save path is: " + is_iim_path +  "~r "
END IF
//End Code Change---01.14.2010

if gi_test_mode = 1 then
	//messagebox("is_iim_path",is_iim_path)
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox("is_iim_path",is_iim_path,true)
end if
//End Code Change---05.15.2007

if as_test = "TEST" then
	messagebox("Imacro Test",s)
end if


return 1

end function

on nvo_web_crawler_engine.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_web_crawler_engine.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//for scheduler - alfee 03.25.2010

ids_wc_ret = Create DataStore
ids_wc_ret.dataobject = 'd_wc_ret_message'

end event

event destructor;if isvalid(ids_wc_ret) then destroy ids_wc_ret //scheduler - alfee 03.25.2010
end event

