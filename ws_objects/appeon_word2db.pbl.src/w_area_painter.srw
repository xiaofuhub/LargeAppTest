$PBExportHeader$w_area_painter.srw
forward
global type w_area_painter from window
end type
type cbx_onlycontract from u_cbx within w_area_painter
end type
type cb_1 from commandbutton within w_area_painter
end type
type ddlb_filter from dropdownlistbox within w_area_painter
end type
type st_1 from statictext within w_area_painter
end type
type cb_save from commandbutton within w_area_painter
end type
type cb_sort from commandbutton within w_area_painter
end type
type dw_detail from datawindow within w_area_painter
end type
type cb_import_missing from commandbutton within w_area_painter
end type
type cb_2 from commandbutton within w_area_painter
end type
type cb_editarea from commandbutton within w_area_painter
end type
type cb_deldoc from commandbutton within w_area_painter
end type
type cb_exit from commandbutton within w_area_painter
end type
type cb_delarea from commandbutton within w_area_painter
end type
type cb_copyarea from commandbutton within w_area_painter
end type
type cb_addarea from commandbutton within w_area_painter
end type
type cb_copydoc from commandbutton within w_area_painter
end type
type cb_savedoc from commandbutton within w_area_painter
end type
type cb_viewdoc from commandbutton within w_area_painter
end type
type cb_adddoc from commandbutton within w_area_painter
end type
type dw_storage_docs from datawindow within w_area_painter
end type
type dw_storage_area from datawindow within w_area_painter
end type
type gb_1 from groupbox within w_area_painter
end type
type ddlb_new from dropdownlistbox within w_area_painter
end type
type gb_2 from groupbox within w_area_painter
end type
end forward

global type w_area_painter from window
integer width = 3918
integer height = 2328
boolean titlebar = true
string title = "Letter Storage Area"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cbx_onlycontract cbx_onlycontract
cb_1 cb_1
ddlb_filter ddlb_filter
st_1 st_1
cb_save cb_save
cb_sort cb_sort
dw_detail dw_detail
cb_import_missing cb_import_missing
cb_2 cb_2
cb_editarea cb_editarea
cb_deldoc cb_deldoc
cb_exit cb_exit
cb_delarea cb_delarea
cb_copyarea cb_copyarea
cb_addarea cb_addarea
cb_copydoc cb_copydoc
cb_savedoc cb_savedoc
cb_viewdoc cb_viewdoc
cb_adddoc cb_adddoc
dw_storage_docs dw_storage_docs
dw_storage_area dw_storage_area
gb_1 gb_1
ddlb_new ddlb_new
gb_2 gb_2
end type
global w_area_painter w_area_painter

type variables
Long il_area_id
boolean ib_open_4_edit = false

String is_contract_cachefilter = ""//(Appeon)Toney 10.12.2013 - V141 ISG-CLX, cache the filter syntax of contract in order to link the type filter syntax 
integer ii_rightvalue //(Appeon)Stephen 07.08.2015 - V15.1-Additional TDL type of Recruitment Task
end variables

forward prototypes
public subroutine of_security ()
public function string of_get_import_path ()
public function string of_set_object_name (integer ai_screen, string ai_type, integer ai_row)
public function integer of_set_screen_id (string as_doc)
public function string of_get_text_file (integer ai_screen, string ai_type)
public function integer of_open_for_edit ()
public function integer of_set_dddw_child (string as_from)
public function string of_export_file (integer ai_export, string as_path)
public function integer of_set_onlyforcontract (boolean ab_onlyforcontract)
end prototypes

public subroutine of_security ();//////////////////////////////////////////////////////////////////////
// $<function>w_area_painter.of_security()
// $<arguments> (none)
// $<returns>   (none)
// $<description> Check the rights
//////////////////////////////////////////////////////////////////////
// $<add> 06.07.2006 by Rodger Wu
//////////////////////////////////////////////////////////////////////
integer li_rightvalue
li_rightvalue = w_mdi.of_security_access(5010)

ii_rightvalue = li_rightvalue //(Appeon)Stephen 07.08.2015 - Issues with Letters
if li_rightvalue < 2  then
	cb_addarea.Enabled = False
	cb_editarea.Enabled = False
	cb_copyarea.Enabled = False
	cb_delarea.Enabled = False
	
	cb_adddoc.Enabled = False
	//cb_viewdoc.Enabled = False  //Commented by (Appeon)Stephen 07.08.2015 - Issues with Letters
	cb_savedoc.Enabled = False
	cb_copydoc.Enabled = False
	cb_deldoc.Enabled = False
end if
//Start Code Change ----07.22.2010 #V10 maha - SK settings
if gb_sk_ver then
	cb_addarea.visible = False
	cb_copyarea.visible = False
	cb_delarea.visible = False
	dw_storage_area.visible = False
end if
//End Code Change ----07.22.2010 #V10 maha

 //Start Code Change ----10.26.2015 #V15 maha - simple
 if of_get_app_setting("set_86","I") = 1 then
	cb_addarea.visible = False
	cb_copyarea.visible = False
	cb_delarea.visible = False
	dw_storage_area.visible = False
end if
 //End Code Change ----10.26.2015 


end subroutine

public function string of_get_import_path ();//Start Code Change ---- 11.29.2006 #V7 maha function added
String ls_doc_name
String ls_doc_type
string docname, named
integer value
//Start Code Change ---- 11.29.2006 #V7 maha
//value = GetFileOpenName("Select Any File in the Search directory",&
//+ docname, named, "DOC", &
//	+ "Doc Files (*.DOC),*.DOC")
//	
//IF value = 1 THEN
//	ls_doc_name = mid(docname,1, len(docname) - len(named) )
//	//messagebox(named,ls_doc_name)
//	return ls_doc_name
//else
//	return "CANCEL"
//END IF

ls_doc_name = dw_storage_area.getitemstring( dw_storage_area.getrow()  , "area_doc_path")
value = getfolder("Select Folder where letters exist.",ls_doc_name)
IF value = 1 THEN
	ls_doc_name += "\"  //Start Code Change ----03.20.2008 #V8 maha
	return ls_doc_name //Start Code Change ----04.21.2008 #V8 maha - moved below previous line
else
	return "CANCEL"
END IF
//End Code Change ---- 12.05.2006 #V7 maha
end function

public function string of_set_object_name (integer ai_screen, string ai_type, integer ai_row);//Start Code Change ----11.07.2011 #V12 maha - added
string ls_object
string ls_name

choose case ai_type
	case "O"
		ls_object = "d_ltr_ofe_correspondence"
	case "F"
		ls_object = "d_ltr_ofe_correspondence"
	case "E" //expiring
		choose case ai_screen
			case 1
				ls_object = "d_ltr_expiring_appointment"
			case 4
				ls_object = "d_ltr_expiring_licensure"
			case 5
				ls_object = "d_ltr_expiring_dea_registration"
			case 9
				ls_object = "d_ltr_expiring_special_certifications"
			case 12
				ls_object = "d_ltr_expiring_insurance"
			case 19
				ls_object = "d_ltr_expiring_board_specialty"
			case 23
				ls_object = "d_ltr_expiring_other_Ids"
			case 28
				ls_object = "d_ltr_expiring_custom_screen_1"
			case else
				return "none"
		end choose
	case "C"
		ls_name = dw_storage_docs.getitemstring(ai_row, "doc_name")
		choose case ls_name
			case "case_review_dept_chair_request_action.doc", "case_review_inform_dept_chair_case_findings.doc", "case_review_inform_dept_chair_case_open.doc"
				ls_object = "d_case_ltr_dept_chair"
			case "case_review_inform_committee_case_findings.doc", "case_review_inform_committee_case_open.doc"
				ls_object = "d_case_ltr_committee"
			case "case_review_inform_physician_case_findings.doc", "case_review_inform_physician_case_open.doc"
				ls_object = "d_case_ltr_physician"		
			case else
				ls_object = "d_ltr_general_corrospondence"
		end choose
	case "V"
		ls_object = ""
		choose case ai_screen
			case 1
				ls_object = "none"
			case 4
				ls_object = "d_ltr_licensure"
			case 6
				ls_object = "d_ltr_education"
			case 7
				ls_object = "d_ltr_training"
			case 8
				ls_object = "d_ltr_continuing_education"
			case 9
				ls_object = "d_ltr_special_certifications"
			case 10
				ls_object = "d_ltr_hospital_affiliation"
			case 11
				ls_object = "d_ltr_other_affiliations"
			case 12
				ls_object = "d_ltr_professional_experience"
			case 13
				ls_object = "d_ltr_references"
			case 15
				ls_object = "d_ltr_Insurance"
			case 16
				ls_object = "d_ltr_claims"
			case 18
				ls_object = "d_ltr_academic_appointment_letter"
			case 19
				ls_object = "d_ltr_board_specialty"
			case 20
				ls_object = "d_ltr_ecfmg"
			case 28
				ls_object = "d_ltr_custom_screen_1"
			case 29
				ls_object = "d_ltr_custom_screen_2"
			case 30
				ls_object = "d_ltr_custom_screen_3"
			case else
				return "none"
		end choose	
	case "A"
		ls_name = dw_storage_docs.getitemstring(ai_row, "doc_name")
		choose case ls_name
			case ""
				ls_object = ""
			case ""
				ls_object = ""
			case else
				return "none"
		end choose
	case "M"
		ls_object = "d_pd_app_audit_miss_rqst_data_w_vers_pt"
		
end choose


//dw_storage_docs.setitem(ai_row, "dataobject", ls_object)

return ls_object
		
end function

public function integer of_set_screen_id (string as_doc);//Start Code Change ----11.07.2011 #V12 maha - added
integer r

if pos(as_doc, "cred_combined_letter" ,1) > 0 then
	r = -2
elseif pos(as_doc, "expiring_appointment" ,1) > 0 then
	r = 1
elseif pos(as_doc, "contract" ,1) > 0 then  //Start Code Change ----05.11.2012 #V12 maha
	r = 3	
elseif pos(as_doc, "licensure" ,1) > 0 then
	r = 4
elseif pos(as_doc, "_dea_" ,1) > 0 then  //Start Code Change ----03.12.2012 #V12 maha
	r = 5
elseif pos(as_doc, "ind_education" ,1) > 0 then
	r = 6
elseif pos(as_doc, "ind_training" ,1) > 0 then
	r = 7
elseif pos(as_doc, "continuing_education" ,1) > 0 then
	r = 8	
elseif pos(as_doc, "post_grad_training" ,1) > 0 then
	r = 8
elseif pos(as_doc, "special_certification" ,1) > 0 then
	r = 9
elseif pos(as_doc, "ind_hospital" ,1) > 0 then
	r = 10
elseif pos(as_doc, "other_affiliation" ,1) > 0 then
	r = 11
elseif pos(as_doc, "professional_experience" ,1) > 0 then
	r = 12
elseif pos(as_doc, "ind_reference" ,1) > 0 then
	r = 13
elseif pos(as_doc, "insurance" ,1) > 0 then
	r = 15
elseif pos(as_doc, "claims" ,1) > 0 then
	r = 16
elseif pos(as_doc, "academic_appointment" ,1) > 0 then
	r = 18
elseif pos(as_doc, "board_specialty" ,1) > 0 then
	r = 19
elseif pos(as_doc, "ecfmg" ,1) > 0 then
	r = 20
elseif pos(as_doc, "other_ids" ,1) > 0 then
	r = 23
elseif pos(as_doc, "custom_screen_1" ,1) > 0 then
	r = 28
elseif pos(as_doc, "custom_1" ,1) > 0 then  //Start Code Change ----05.02.2012 #V12 maha
	r = 28
elseif pos(as_doc, "custom_screen_2" ,1) > 0 then
	r = 29
elseif pos(as_doc, "custom_screen_3" ,1) > 0 then
	r = 30
//Start Code Change ----04.16.2012 #V12 maha
elseif pos(as_doc, "health_history" ,1) > 0 then
	r = 71
elseif pos(as_doc, "dues" ,1) > 0 then
	r = 70
elseif pos(as_doc, "other_verif" ,1) > 0 then
	r = 72
//End Code Change ----04.16.2012
else
	r = 0
end if

return r
end function

public function string of_get_text_file (integer ai_screen, string ai_type);//Start Code Change ----11.07.2011 #V12 maha - added
string ls_object
string ls_name

choose case ai_type
	case "O"
		ls_object = "lettername"
	case "F"
		ls_object = "fppe.txt"
	case "E" //expiring
		choose case ai_screen
			case 1
				ls_object = "expiring_appointment.txt"
			case 4
				ls_object = "expiring_licensure.txt"
			case 5
				ls_object = "expiring_dea_registration.txt"
			case 9
				ls_object = "expiring_special_certifications.txt"
			case 15  //maha corrected from 12 04.27.2012
				ls_object = "expiring_insurance.txt"
			case 19
				ls_object = "expiring_board_specialty.txt"
			case 23
				ls_object = "expiring_other_Ids.txt"
			case 24 //Start Code Change ----04.23.2014 #V14.2 maha
				ls_object = "expiring_cpr_certifications.txt"	
			case 28
				ls_object = "expiring_custom_screen_1.txt"
			case 71  
				ls_object = "expiring_health_history.txt"
			case -2   //exp combined
				ls_object = "expiring_combined.txt"
			case else
				return "none"
		end choose
	case "C"
		ls_name = dw_storage_docs.getitemstring(dw_storage_docs.getrow(), "doc_name")
		choose case ls_name
			case "case_review_dept_chair_request_action.doc", "case_review_inform_dept_chair_case_findings.doc", "case_review_inform_dept_chair_case_open.doc"
				ls_object = "case_review_depart_chair.txt"
			case "case_review_inform_committee_case_findings.doc", "case_review_inform_committee_case_open.doc"
				ls_object = "case_review_committee.txt"
			case "case_review_inform_physician_case_findings.doc", "case_review_inform_physician_case_open.doc"
				ls_object = "case_review_practitioner.txt"		
			case else
				ls_object = "ind_generic_corrospondence.txt"
		end choose
	case "V"
		ls_object = ""
		choose case ai_screen
			case 1
				ls_object = "none"
			case 4
				ls_object = "licensure.txt"
			case 5  //(Appeon)Stephen 02.14.2014 -  Issue with DEA verification letter
				ls_object = "DEA_Registration.txt"
			case 6
				ls_object = "education.txt"
			case 7
				ls_object = "training.txt"
			case 8
				ls_object = "continuing_education.txt"
			case 9
				ls_object = "special_certifications.txt"
			case 10
				ls_object = "hospital_affiliation.txt"
			case 11
				ls_object = "other_affiliations.txt"
			case 12
				ls_object = "professional_experience.txt"
			case 13
				ls_object = "references.txt"
			case 15
				ls_object = "insurance.txt"
			case 16
				ls_object = "claims.txt"
			case 18
				ls_object = "academic_appointment.txt"
			case 19
				ls_object = "board_specialty.txt"
			case 20
				ls_object = "ecfmg.txt"
			case 28
				ls_object = "custom_screen_1.txt"
			case 29
				ls_object = "custom_screen_2.txt"
			case 30
				ls_object = "custom_screen_3.txt"
			case else
				return "none"
		end choose	
	case "A"
		ls_name = dw_storage_docs.getitemstring( dw_storage_docs.getrow(), "doc_name")
		choose case ls_name
			case "ind_payer_follow_up_letter.doc"
				ls_object = "net_dev_app_rcvd_payer.txt"
			case "ind_credentialing_application_signed_followup.doc"
				ls_object = "net_dev_app_rcvd_prac.txt"
			case else
				return "none"
		end choose
	case "M"
		ls_object = "missing_info_request.txt"
	case "L"
		ls_object = "mailing_labels.txt"	   //Start Code Change ----09.22.2015 #V15 maha - corrected from '-label'
end choose



return ls_object
		
end function

public function integer of_open_for_edit ();Long ll_row, ll_area_id, ll_found, ll_rowcount
Long ll_area_row	//Letter Storage I: long.zhang 06.17.2011
String ls_doc_name, ls_return, ls_str
String ls_doc_path	//Letter Storage I: long.zhang 06.17.2011
IF NOT cb_adddoc.Enabled THEN RETURN 0

ll_row = dw_storage_docs.GetSelectedrow( 0 )
ll_area_row = dw_storage_area.GetSelectedrow( 0 )	//Letter Storage I: long.zhang 06.17.2011
IF ll_row = 0 THEN RETURN 0
	
ll_area_id = dw_storage_docs.GetItemNumber(ll_row, "area_id")
ls_doc_name = dw_storage_docs.GetItemString(ll_row, "doc_name")
ls_doc_path = dw_storage_area.GetItemString(ll_area_row,"area_doc_path")	//Letter Storage I: added by long.zhang 06.17.2011

ls_str = String(ll_area_id) + "~t" + ls_doc_name

OPENWITHPARM( w_storage_docs_edit, ls_str + "~t" + ls_doc_path )	//Letter Storage:Modified by  long.zhang 06.17.2011

ls_return = Message.StringParm
if LenA( Trim(ls_return) ) <> 0 then
	dw_storage_docs.SetRedraw( False )
	ll_rowcount = dw_storage_docs.retrieve( ll_area_id )
	ll_found = dw_storage_docs.Find( "doc_name = '" + ls_return + "'", &
												1, ll_rowcount )
	if ll_found > 0 then
		dw_storage_docs.SelectRow( 0, False )
		dw_storage_docs.SelectRow( ll_found, True )
		dw_storage_docs.SetRow( ll_found )
		dw_storage_docs.ScrollToRow( ll_found )
	end if
	dw_storage_docs.SetRedraw( True )
END IF

return 1
end function

public function integer of_set_dddw_child (string as_from);//Start Code Change ----03.08.2012 #V12 maha
datawindowchild dwchild


//dw_storage_docs.Retrieve( ll_area_id )
if as_from = "DOCS" then
//	dw_storage_area.getchild("screen_id",dwchild)
//	dwchild.settransobject(sqlca)
//	//dwchild.retrieve()
//	dwchild.insertrow(1)
//	dwchild.setitem(1,"screen_id", -2)
//	dwchild.setitem(1,"screen_alias", "Exp Combined")
//	dwchild.insertrow(1)
//	dwchild.setitem(1,"screen_id", -1000)
//	dwchild.setitem(1,"screen_alias", "FPPE letter")
//	dwchild.insertrow(1)
//	dwchild.setitem(1,"screen_id", 0)
//	dwchild.setitem(1,"screen_alias", "")
elseif  as_from = "DETAIL" then

	dw_detail.getchild("screen_id",dwchild)
	dwchild.settransobject(sqlca)
	dwchild.retrieve()
	dwchild.insertrow(1)
	dwchild.setitem(1,"screen_id", -2)
	dwchild.setitem(1,"screen_alias", "Exp Combined")
	dwchild.insertrow(1)
	dwchild.setitem(1,"screen_id", -1000)
	dwchild.setitem(1,"screen_alias", "FPPE letter")
	dwchild.insertrow(1)
	dwchild.setitem(1,"screen_id", 0)
	dwchild.setitem(1,"screen_alias", "")
end if
//Start Code Change ----03.08.2012

return 1
end function

public function string of_export_file (integer ai_export, string as_path);//Start Code Change ----07.31.2013 #V14 maha - added - copied/modifed from letter generation

Long prac_ids[]
long ll_pracid
string ls_exp_file
integer res

pfc_n_cst_ai_export_apb  n_export

long ll_export_id
integer i

select top 1 prac_id into :ll_pracid from pd_affil_stat where active_status = 1;
prac_ids[1] = ll_pracid

n_export = CREATE pfc_n_cst_ai_export_apb

n_export.is_called_type = '4'	// Export format set to .txt 

res = n_export.of_export_data_with_text( ai_export, prac_ids[],as_path,0,"","","",2,"" ) 

destroy n_export

if res < 0 then
	return "Failed"
else
	return as_path
end if
end function

public function integer of_set_onlyforcontract (boolean ab_onlyforcontract);//====================================================================
//$<Function>: of_set_onlyforcontract
//$<Arguments>:
// 	value    boolean    ab_onlyforcontract
//$<Return>:  integer
//$<Description>: Fix Reintegration BugT100901, filter data and control ui by parameter ab_onlyforcontract
//$<Author>: (Appeon) Toney 10.12.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string   ls_filter = "",ls_filtertype,ls_visible
integer li_index
long     ll_areaid,ll_row
//Filter Storage Area
//Get current area
ll_row = dw_storage_area.GetRow( )
IF ll_row > 0 THEN ll_areaid = dw_storage_area.GetItemNumber(ll_row,"Area_ID")

IF ab_onlyforcontract THEN
	ls_filter = "area_id = 1"
ELSE
	ls_filter = ""
END IF
dw_storage_area.SetFilter(ls_filter)
dw_storage_area.Filter( )
IF dw_storage_area.rowcount( ) > 0 AND Upper(AppeonGetClientType()) = "WEB" THEN dw_storage_area.event rowfocuschanged(1)//Fixed the APB bug,the filter function can't fire the rowfocuschagned event
//Restore current area
IF ll_row > 0 THEN
	ll_row = dw_storage_area.Find("area_id="+string(ll_areaid),1,dw_storage_area.rowcount())
	IF ll_row > 0 THEN 
		dw_storage_area.ScrollToRow(ll_row)
		dw_storage_area.SelectRow(0,False)
		dw_storage_area.SelectRow(ll_row,True)
	END IF
END IF
//Set the global filter syntax for contract
IF ab_onlyforcontract THEN
	IF LenA(is_contract_cachefilter) = 0 THEN is_contract_cachefilter = "left(lower(doc_name),5) <> 'case_' and left(lower(doc_name),4) <> 'ind_' and left(lower(doc_name),15) <> 'mailing_labels_'"
ELSE
	is_contract_cachefilter = ""
END IF
//Set Filter Type 
ls_filtertype = ddlb_filter.text

ddlb_filter.reset( )
IF ab_onlyforcontract THEN
	ddlb_filter.additem("All")
	ddlb_filter.additem("Correspondence")
	ddlb_filter.additem("Expiring")
	ddlb_filter.additem("Verification")
ELSE
	ddlb_filter.additem("All")
	ddlb_filter.additem("Correspondence")
	ddlb_filter.additem("Expiring")
	ddlb_filter.additem("Verification")	
	ddlb_filter.additem("Missing Checklist")
	ddlb_filter.additem("OPPE")
	ddlb_filter.additem("FPPE")
	ddlb_filter.additem("Applications")
	ddlb_filter.additem("Labels")
END IF
li_index = ddlb_filter.finditem(ls_filtertype,0)
IF IsNull(li_index) OR li_Index <= 0 THEN li_Index = 1
ddlb_filter.selectitem(li_index)
ddlb_filter.event selectionchanged(li_index)
//Control the Data Screen 
IF ab_onlyforcontract THEN
	ls_visible="0"
ELSE
	ls_visible="1"
END IF
dw_storage_docs.Modify("screen_id.visible='"+ls_visible+"'")
dw_storage_docs.Modify("screen_id_t.visible='"+ls_visible+"'")
dw_detail.Modify("screen_id.visible='"+ls_visible+"'")
dw_detail.Modify("data_object_t.visible='"+ls_visible+"'")
IF ab_onlyforcontract THEN
	dw_detail.Modify("export_id.visible='"+ls_visible+"'")
	dw_detail.Modify("t_1.visible='"+ls_visible+"'")
ELSE
	dw_detail.Modify("export_id.visible='1~tif( screen_id = 1,1,0)'")
	dw_detail.Modify("t_1.visible='1~tif( screen_id = 1,1,0)'")
END IF
//Hide or Show the function buttons
cb_addarea.visible =(Not gb_sk_ver) AND (Not gb_contract_version) AND (Not ab_onlyforcontract)
cb_copyarea.visible =(Not gb_sk_ver) AND (Not gb_contract_version) AND (Not ab_onlyforcontract)
cb_delarea.visible =(Not gb_sk_ver) AND (Not gb_contract_version) AND (Not ab_onlyforcontract)


Return 1
end function

on w_area_painter.create
this.cbx_onlycontract=create cbx_onlycontract
this.cb_1=create cb_1
this.ddlb_filter=create ddlb_filter
this.st_1=create st_1
this.cb_save=create cb_save
this.cb_sort=create cb_sort
this.dw_detail=create dw_detail
this.cb_import_missing=create cb_import_missing
this.cb_2=create cb_2
this.cb_editarea=create cb_editarea
this.cb_deldoc=create cb_deldoc
this.cb_exit=create cb_exit
this.cb_delarea=create cb_delarea
this.cb_copyarea=create cb_copyarea
this.cb_addarea=create cb_addarea
this.cb_copydoc=create cb_copydoc
this.cb_savedoc=create cb_savedoc
this.cb_viewdoc=create cb_viewdoc
this.cb_adddoc=create cb_adddoc
this.dw_storage_docs=create dw_storage_docs
this.dw_storage_area=create dw_storage_area
this.gb_1=create gb_1
this.ddlb_new=create ddlb_new
this.gb_2=create gb_2
this.Control[]={this.cbx_onlycontract,&
this.cb_1,&
this.ddlb_filter,&
this.st_1,&
this.cb_save,&
this.cb_sort,&
this.dw_detail,&
this.cb_import_missing,&
this.cb_2,&
this.cb_editarea,&
this.cb_deldoc,&
this.cb_exit,&
this.cb_delarea,&
this.cb_copyarea,&
this.cb_addarea,&
this.cb_copydoc,&
this.cb_savedoc,&
this.cb_viewdoc,&
this.cb_adddoc,&
this.dw_storage_docs,&
this.dw_storage_area,&
this.gb_1,&
this.ddlb_new,&
this.gb_2}
end on

on w_area_painter.destroy
destroy(this.cbx_onlycontract)
destroy(this.cb_1)
destroy(this.ddlb_filter)
destroy(this.st_1)
destroy(this.cb_save)
destroy(this.cb_sort)
destroy(this.dw_detail)
destroy(this.cb_import_missing)
destroy(this.cb_2)
destroy(this.cb_editarea)
destroy(this.cb_deldoc)
destroy(this.cb_exit)
destroy(this.cb_delarea)
destroy(this.cb_copyarea)
destroy(this.cb_addarea)
destroy(this.cb_copydoc)
destroy(this.cb_savedoc)
destroy(this.cb_viewdoc)
destroy(this.cb_adddoc)
destroy(this.dw_storage_docs)
destroy(this.dw_storage_area)
destroy(this.gb_1)
destroy(this.ddlb_new)
destroy(this.gb_2)
end on

event open;string ls_parm
integer li_areaid
Long ll_found
datawindowchild dwchild

ls_parm = Message.StringParm

dw_storage_area.Settransobject( SQLCA )
dw_storage_docs.Settransobject( SQLCA )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.26.2006 By: LeiWei
//$<reason> Requirement modify for intellicontract.
IF gb_contract_version THEN
	String ls_filter
	ls_filter = "left(lower(doc_name),5) <> 'case_' and left(lower(doc_name),4) <> 'ind_' and left(lower(doc_name),15) <> 'mailing_labels_'"
	is_contract_cachefilter = ls_filter//(Appeon)Toney 10.12.2013 - V141 ISG-CLX, cache the filter syntax of contract in order to link the type filter syntax 
	dw_storage_docs.Setfilter( ls_filter )
	//Start Code Change ---- 11.29.2006 #V7 maha
	cb_addarea.visible = false
	cb_copyarea.visible = false
	cb_delarea.visible = false
	//End Code Change---11.29.2006
END IF
//---------------------------- APPEON END ----------------------------

dw_storage_area.Retrieve()
dw_storage_docs.sharedata( dw_detail)


//Start Code Change ---- 12.07.2006 #V7 maha
if dw_storage_area.rowcount( ) = 0 then
	dw_storage_area.insertrow(1)
	dw_storage_area.setitem(1,"Area_id",1)
	dw_storage_area.setitem(1,"Area_name","Area 1")
	dw_storage_area.setitem(1,"Area_doc_path",gs_temp_path+"letters\standard\")
	dw_storage_area.update( )
	//
	il_area_id = dw_storage_area.GetItemNumber( dw_storage_area.getrow(), "area_id" )
end if
//End Code Change---12.07.2006

if ls_parm <> '' then
	if RightA( ls_parm, 5 ) = "@path" then//locate area;
		ll_found = dw_storage_area.Find( "area_id = " + LeftA( ls_parm, LenA( ls_parm) - 5 ), 1, dw_storage_area.rowcount() )
		if ll_found > 0 then
			dw_storage_area.Trigger Event rowfocuschanged( ll_found )
		end if
	else//locate document;
		select top 1 area_id into :li_areaid from sys_storage_docs where doc_name = :ls_parm;
		if SQLCA.SQLCode = 0 then
			if li_areaid > 0 then
				ll_found = dw_storage_area.Find( "area_id = " + string( li_areaid ), 1, dw_storage_area.rowcount() )
				if ll_found > 0 then
					dw_storage_area.Trigger Event rowfocuschanged( ll_found )
					ll_found = dw_storage_docs.Find( "doc_name = '" + ls_parm + "'", 1, dw_storage_docs.rowcount() )
					if ll_found > 0 then
						dw_storage_docs.Post Event rowfocuschanged( ll_found )
						dw_storage_docs.ScrolltoRow( ll_found )
					end if
				end if
			end if
		end if
	end if
end if

of_security()

//---------Begin Added by (Appeon)Toney 10.12.2013 for V141 ISG-CLX--------
//$Reason:Fix Reintegration BugT100901
IF gb_contract_version THEN 
	cbx_onlycontract.checked = True
	cbx_onlycontract.visible = False
	of_set_OnlyForContract(True)	
ELSEIF Not gb_contract_module THEN
	cbx_onlycontract.visible = False//if this system doesn't contain contract module,hides the control
END IF
//---------End Added ------------------------------------------------------------------

end event

type cbx_onlycontract from u_cbx within w_area_painter
integer x = 2597
integer y = 276
integer width = 544
integer height = 68
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "For Contract Only"
end type

event clicked;call super::clicked;of_set_onlyforcontract(THIS.Checked)//(Appeon)Toney 10.12.2013 - V141 ISG-CLX Fix Reintegration BugT100901
end event

type cb_1 from commandbutton within w_area_painter
integer x = 3232
integer y = 120
integer width = 645
integer height = 84
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About Merge files"
end type

event clicked;string ls_mess

ls_mess = "Merge files are created by the system for each letter type based on a program-defined set of data fields.~r~r"
ls_mess += "For Correspondence and Expiring Appointment type letters, it is possible to use an export to generate the the merge file, if the system includes that module.  See the help files for further information.~r~r"
ls_mess += "For other letter types including Verification and Expiring Verification type letters, the merge file queries are hard coded in the program and cannot be modified by the user.~r"


	
//li_ans = MessageBox("Delete Row", "Are you sure you want to delete selected storage area?  All documents connected to this storage area will also be deleted.", Question!, YesNo!, 1 )
MessageBox("About Document merge files", ls_mess )



end event

type ddlb_filter from dropdownlistbox within w_area_painter
integer x = 1353
integer y = 268
integer width = 677
integer height = 724
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"All","Correspondence","Expiring","Verification","Missing Checklist","OPPE","FPPE","Applications","Labels"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//Start Code Change ----06.16.2011 #V11 maha 
//Start Code Change ----11.09.2011 #V112maha  - added additional filter types
string ls_filter

choose case index
	case 1
		ls_filter = ""
	case 2
		ls_filter = "doc_type =  'C'"
	case 3
		ls_filter = "doc_type =  'E'"
	case 4
		ls_filter = "doc_type =  'V'"
	case 5
		ls_filter = "doc_type =  'M'"
	case 6
		ls_filter = "doc_type =  'O'"
	case 7
		ls_filter = "doc_type =  'F'"
	case 8
		ls_filter = "doc_type =  'A'"
	case 9
		ls_filter = "doc_type =  'L'"
		
end choose

//---------Begin Added by (Appeon)Toney 10.12.2013 for V141 ISG-CLX--------
//$Reason:link the cached the filter syntax of contract
IF LenA(is_contract_cachefilter) > 0 THEN
	IF LenA(ls_filter) = 0 THEN
		ls_filter = is_contract_cachefilter + " AND doc_type in ('C','E','V')"
	ELSE
		ls_filter = is_contract_cachefilter + " AND doc_type in ('C','E','V') AND "+ls_filter
	END IF
END IF
//---------End Added ------------------------------------------------------------------


dw_storage_docs.setfilter(ls_filter)
dw_storage_docs.filter()

return 1
end event

type st_1 from statictext within w_area_painter
integer x = 1047
integer y = 284
integer width = 283
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_area_painter
integer x = 1015
integer y = 432
integer width = 379
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;dw_detail.accepttext()

dw_detail.update()
end event

type cb_sort from commandbutton within w_area_painter
integer x = 2126
integer y = 264
integer width = 357
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sor&t"
end type

event clicked;string null_str

SetNull(null_str)

dw_storage_docs.SetSort(null_str)

dw_storage_docs.Sort( )
end event

type dw_detail from datawindow within w_area_painter
integer x = 9
integer y = 1832
integer width = 3890
integer height = 412
integer taborder = 120
string title = "none"
string dataobject = "d_sys_storage_docs_detail"
boolean livescroll = true
end type

event itemchanged;//Start Code Change ----11.07.2011 #V12 maha - added
integer r
string ls_object

if dwo.name = "doc_type" then
	this.accepttext()
	r = of_set_screen_id( this.getitemstring(row, "doc_name") )
	this.setitem(row, "screen_id", r)
	
	ls_object = of_set_object_name(this.getitemnumber(row, "screen_id"), data ,row)
	this.setitem(row, "data_object", ls_object)
	
end if
end event

event constructor;//Start Code Change ----05.20.2016 #V152 maha
datawindowchild dwchild

this.settransobject(sqlca)
this.getchild( "export_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)


end event

event buttonclicked;long ll_doc
gs_pass_ids lst_ids

//Start Code Change ----10.24.2016 #V153 maha
if dwo.name = "b_letter" then
	lst_ids.ls_ref_value = this.getitemstring(row, "doc_name")
	lst_ids.facility_id = this.getitemnumber(row, "export_id")
	openwithparm(w_letter_painter,lst_ids)
end if
end event

type cb_import_missing from commandbutton within w_area_painter
integer x = 1742
integer y = 120
integer width = 736
integer height = 84
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Import Missing Documents"
end type

event clicked;Integer li_ans
integer r
integer rc
integer cnt
integer badcnt
Long ll_row
Long ll_area_id
string ls_path
string ls_file
string ls_doc_name
n_appeon_storage_area lnv_storage_area
		

ll_row = dw_storage_area.GetSelectedrow( 0 )
IF ll_row = 0 THEN RETURN
rc = dw_storage_docs.rowcount()
if rc = 0 then return

li_ans = MessageBox("Import Documents", "This function will search for documents that were not imported to the database when the letter records were created.  It will not create new records.  Do you wish to continue?.", Question!, YesNo!, 1 )
IF li_ans = 1 THEN
	ls_path = of_get_import_path( )
	ll_area_id = dw_storage_area.GetItemNumber(ll_row, "area_id")
	if ls_path  = "CANCEL" then return
	for r = 1 to rc
		if dw_storage_docs.getitemnumber(r,"dsize") > 0 then 
			continue
		else
			ls_doc_name = dw_storage_docs.getitemstring(r,"doc_name") 
			ls_file = ls_path + ls_doc_name
			ls_file = Trim(ls_file) //V12.2 usage of docx - alfee 07.05.2012	
			if fileexists(ls_file) then
				lnv_storage_area.of_upload_file( ll_area_id, ls_doc_name, ls_file)
				cnt ++
			elseif right(lower(ls_file),4) = ".doc" and fileexists(ls_file + "x") then	//V12.2 usage of docx - alfee 07.05.2012	
				lnv_storage_area.of_upload_file( ll_area_id, ls_doc_name, ls_file + "x")
				cnt ++				
			else
				badcnt++
			end if
		end if
	next
	messagebox("Imported","There were " + string(cnt) + " files imported and " + string(badcnt) + " files not found.")
	dw_storage_docs.retrieve(ll_area_id)
END IF

end event

type cb_2 from commandbutton within w_area_painter
integer x = 2482
integer y = 120
integer width = 736
integer height = 84
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Document Edit Help"
end type

event clicked;string ls_mess

ls_mess = " To update an existing letter in the system:~r~r"
ls_mess += "A) Select the letter you wish to modify, and click View Doc to open it.~r"
ls_mess += "B) Modify your letter as desired, and save it.  Do not change the file name.~r"
ls_mess += "C) Click the Update Doc button.~r"
ls_mess += "D) In the update screen, click the Select Document button, and select the letter.~r"
ls_mess += "E) Click Save to upload the modified document to the database."


	
//li_ans = MessageBox("Delete Row", "Are you sure you want to delete selected storage area?  All documents connected to this storage area will also be deleted.", Question!, YesNo!, 1 )
MessageBox("Update Document Help", ls_mess )



end event

type cb_editarea from commandbutton within w_area_painter
integer x = 1001
integer y = 120
integer width = 736
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Edit Storage Area"
end type

event clicked;Long ll_row
Long ll_area_id

if this.Enabled = False then return;

ll_row = dw_storage_area.GetSelectedrow( 0 )
IF ll_row = 0 THEN RETURN
	
ll_area_id = dw_storage_area.GetItemNumber(ll_row, "area_id")

OPENWITHPARM( w_storage_area, ll_area_id )

IF Message.Doubleparm = 100 THEN
	dw_storage_area.Reset( )
	dw_storage_area.Retrieve( )
END IF
end event

type cb_deldoc from commandbutton within w_area_painter
integer x = 1801
integer y = 432
integer width = 379
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;Integer li_ans
Long ll_row
Long ll_area_id
String ls_doc_names[]
Integer li_doc_name
Integer li_selected
string ls_doc_name

FOR ll_row = 1 TO dw_storage_docs.Rowcount( )
	li_selected = dw_storage_docs.GetitemNumber(ll_row, "selected")
	IF li_selected = 1 THEN
		li_doc_name++
		ls_doc_name = dw_storage_docs.GetItemString(ll_row, "doc_name")
		ls_doc_names[li_doc_name] = ls_doc_name
	END IF
END FOR

IF li_doc_name = 0 THEN
	Messagebox("Delete document","Please select a document to delete.")
	RETURN
END IF

//li_ans = MessageBox("Delete document", "Are you sure you want to delete selected row?", Question!, YesNo!, 1 )
li_ans = MessageBox("Delete document", "Are you sure you want to delete the selected Documents?", Question!, YesNo!, 1 )  //maha - 02.10.2014 - modified message
IF li_ans = 1 THEN
	
	gnv_appeondb.of_startqueue( )
	
	FOR ll_row = 1 TO li_doc_name
		ls_doc_name = ls_doc_names[ll_row]
		
		Delete From sys_storage_docs
		Where area_id = :il_area_id
		And doc_name = :ls_doc_name;
		
	END FOR
	
	COMMIT;
	
	//dw_storage_docs.Retrieve( il_area_id )		//Move it to after Queue sentence,because it will cause the compute column error on Web
	
	gnv_appeondb.of_commitqueue( )
	
	dw_storage_docs.Retrieve( il_area_id )			//Modify by scofield on 2007-08-16

	IF dw_storage_docs.Rowcount( ) > 0 THEN
		dw_storage_docs.Selectrow( 0 , FALSE)
		dw_storage_docs.Selectrow( 1 , TRUE)
		dw_storage_docs.SetRow( 1 )
		dw_storage_docs.ScrollToRow( 1 )
	End IF
END IF

end event

type cb_exit from commandbutton within w_area_painter
integer x = 3227
integer y = 28
integer width = 649
integer height = 84
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close ( Parent )
end event

type cb_delarea from commandbutton within w_area_painter
integer x = 2482
integer y = 28
integer width = 736
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Stora&ge Area"
end type

event clicked;Integer li_ans
Long ll_row
Long ll_area_id

ll_row = dw_storage_area.GetSelectedrow( 0 )
IF ll_row = 0 THEN RETURN

//---------Begin Added by (Appeon)Toney 10.12.2013 for V141 ISG-CLX--------
//$Reason:Fix Reintegration BugT100901, It’s not allowed to delete the storage area when its id is 1.
IF gb_contract_module THEN
	ll_area_id = dw_storage_area.GetItemNumber(ll_row, "area_id")
	IF ll_area_id = 1 THEN
		MessageBox("Delete Row", "This storage area needs to apply to contract business, it’s not deletable.", StopSign!)
		Return
	END IF
END IF
//---------End Added ------------------------------------------------------------------

	
//li_ans = MessageBox("Delete Row", "Are you sure you want to delete selected storage area?  All documents connected to this storage area will also be deleted.", Question!, YesNo!, 1 )
li_ans = MessageBox("Delete Row", "Are you sure you want to delete the selected storage area?  All documents connected to this storage area will also be deleted.", Question!, YesNo!, 1 )
IF li_ans = 1 THEN
	
	ll_area_id = dw_storage_area.GetItemNumber(ll_row, "area_id")
	IF ll_area_id > 0 THEN
		gnv_appeondb.of_startqueue( )
		
		Delete From sys_storage_docs Where area_id = :ll_area_id;
		Delete From sys_storage_area Where area_id = :ll_area_id;
		COMMIT;
		
		dw_storage_docs.Reset( )
		
		dw_storage_area.Reset( )
		dw_storage_area.Retrieve( )

		gnv_appeondb.of_commitqueue( )
	END IF
END IF

end event

type cb_copyarea from commandbutton within w_area_painter
integer x = 1742
integer y = 28
integer width = 736
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy Sto&rage Area"
end type

event clicked;long ll_area_id
Long ll_row
Long ll_select_area_id

ll_row = dw_storage_area.GetSelectedrow( 0 )
IF ll_row = 0 THEN
	Messagebox("Copy storage area","Please select a storage area to copy from.")
	RETURN
END IF

IF Messagebox("Copy storage area","This function will copy ALL documents in the selected storage area to another storage area.  Continue?",question!,yesno!,2) = 2 THEN RETURN

ll_area_id = dw_storage_area.GetItemNumber(ll_row, "area_id")

open(w_select_storage_area)

ll_select_area_id = message.doubleparm
if ll_select_area_id = 0 then return
if ll_select_area_id = ll_area_id then return

// Copy the Document to other Area
Delete From sys_storage_docs
Where area_id = :ll_select_area_id
And doc_name IN (
	Select doc_name From sys_storage_docs 
	Where area_id = :ll_area_id
);
Insert Into sys_storage_docs(area_id, doc_name, doc_type, doc_data, last_edit_date, user_id)
Select :ll_select_area_id, doc_name, doc_type, doc_data, getdate(), :gs_user_id
From sys_storage_docs
Where area_id = :ll_area_id;

IF SQLCA.SQLCODE = -1 THEN
	ROLLBACK;
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

COMMIT;

MessageBox( "Copy document", "Completed!" )

end event

type cb_addarea from commandbutton within w_area_painter
integer x = 1001
integer y = 28
integer width = 736
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add St&orage Area"
end type

event clicked;OPEN( w_storage_area )

IF Message.Doubleparm = 100 THEN
	dw_storage_area.Reset( )
	dw_storage_area.Retrieve( )
END IF
end event

type cb_copydoc from commandbutton within w_area_painter
integer x = 2587
integer y = 432
integer width = 379
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Co&py"
end type

event clicked;n_appeon_storage_area lnv_storage_area
Long ll_row
Long ll_select_area_id
String ls_doc_name
String ls_doc_path
String ls_full_name
Integer li_rtn
String ls_doc_names[]
Integer li_doc_name
Integer li_selected

FOR ll_row = 1 TO dw_storage_docs.Rowcount( )
	li_selected = dw_storage_docs.GetitemNumber(ll_row, "selected")
	IF li_selected = 1 THEN
		li_doc_name++
		ls_doc_name = dw_storage_docs.GetItemString(ll_row, "doc_name")
		ls_doc_names[li_doc_name] = ls_doc_name
	END IF
END FOR

IF li_doc_name = 0 THEN
	Messagebox("Copy document","Please select a document to copy from.")
	RETURN
END IF

IF Messagebox("Copy document","Are you sure to copy the selected document(s)?",question!,yesno!,2) = 2 THEN RETURN

open(w_select_storage_area)

ll_select_area_id = message.doubleparm
if ll_select_area_id = 0 then return
if ll_select_area_id = il_area_id then return

// Copy the Document to other Area

gnv_appeondb.of_startqueue( )

FOR ll_row = 1 TO li_doc_name
	ls_doc_name = ls_doc_names[ll_row]
	
	Delete From sys_storage_docs
	Where area_id = :ll_select_area_id
	And doc_name = :ls_doc_name;
	
	Insert Into sys_storage_docs(area_id, doc_name, doc_type, doc_data, last_edit_date, user_id)
	Select :ll_select_area_id, doc_name, doc_type, doc_data, getdate(), :gs_user_id
	From sys_storage_docs
	Where area_id = :il_area_id
	And doc_name = :ls_doc_name;
END FOR

COMMIT;

gnv_appeondb.of_commitqueue( )

MessageBox( "Copy document", "Completed!" )

end event

type cb_savedoc from commandbutton within w_area_painter
integer x = 2981
integer y = 432
integer width = 379
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update"
boolean cancel = true
end type

event clicked;Long ll_row, ll_area_id, ll_found, ll_rowcount
Long ll_area_row	//Letter Storage I: long.zhang 06.17.2011
String ls_doc_name, ls_return, ls_str
String ls_doc_path	//Letter Storage I: long.zhang 06.17.2011
IF NOT cb_adddoc.Enabled THEN RETURN

ll_row = dw_storage_docs.GetSelectedrow( 0 )
ll_area_row = dw_storage_area.GetSelectedrow( 0 )	//Letter Storage I: long.zhang 06.17.2011
IF ll_row = 0 THEN RETURN
	
ll_area_id = dw_storage_docs.GetItemNumber(ll_row, "area_id")
ls_doc_name = dw_storage_docs.GetItemString(ll_row, "doc_name")
ls_doc_path = dw_storage_area.GetItemString(ll_area_row,"area_doc_path")	//Letter Storage I: added by long.zhang 06.17.2011

ls_str = String(ll_area_id) + "~t" + ls_doc_name
//---------Begin Added by (Appeon)Toney 10.12.2013 for V141 ISG-CLX--------
//$Reason:Fix Reintegration BugT100901,limit the document type items
string   ls_onlycontract = "0"
IF cbx_onlycontract.checked THEN
	ls_onlycontract = "1"
END IF
//---------End Added ------------------------------------------------------------------

OPENWITHPARM( w_storage_docs_edit, ls_str + "~t" + ls_doc_path+"~t"+ ls_onlycontract)	//Letter Storage:Modified by  long.zhang 06.17.2011
																													//(Appeon)Toney 10.12.2013 - V141 ISG-CLX Fix Reintegration BugT100901,append ls_onlycontract options in order to limit the document type items
ls_return = Message.StringParm
if LenA( Trim(ls_return) ) <> 0 then
	dw_storage_docs.SetRedraw( False )
	ll_rowcount = dw_storage_docs.retrieve( ll_area_id )
	ll_found = dw_storage_docs.Find( "doc_name = '" + ls_return + "'", &
												1, ll_rowcount )
	if ll_found > 0 then
		dw_storage_docs.SelectRow( 0, False )
		dw_storage_docs.SelectRow( ll_found, True )
		dw_storage_docs.SetRow( ll_found )
		dw_storage_docs.ScrollToRow( ll_found )
	end if
	dw_storage_docs.SetRedraw( True )
END IF

//string docpath, docname
//integer li_rtn
//n_appeon_storage_area lnv_storage_area
//Long ll_row, ll_area_row
//Long ll_area_id
//String ls_doc_name
//String ls_doc_path
//String ls_full_name
//
//ll_area_row = dw_storage_area.GetSelectedrow( 0 )
//ll_row = dw_storage_docs.GetSelectedrow( 0 )
//IF ll_row = 0 THEN RETURN
//
//ll_area_id = dw_storage_docs.GetItemNumber(ll_row, "area_id")
//ls_doc_name = dw_storage_docs.GetItemString(ll_row, "doc_name")
//ls_doc_path = dw_storage_area.GetItemString(ll_area_row, "area_doc_path")
//ls_full_name = ls_doc_path + ls_doc_name
//
//
//li_rtn = GetFileOpenName("Select File", &
//    docpath, docname, "DOC", &
//    "Doc Files (*.DOC),*.DOC", ls_doc_path	 )
//
//IF li_rtn < 1 THEN RETURN
//
//// Upload the Document
//li_rtn = lnv_storage_area.of_upload_file( ll_area_id, ls_doc_name, docpath)
//
//IF li_rtn > 0 THEN
//	gnv_appeondb.of_autocommit( )
//	UPDATE sys_storage_docs
//	SET last_edit_date = getdate()
//	WHERE area_id = :ll_area_id AND doc_name = :ls_doc_name;
//	COMMIT;
//END IF
end event

type cb_viewdoc from commandbutton within w_area_painter
integer x = 2190
integer y = 432
integer width = 379
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&View/Edit"
end type

event clicked;n_appeon_storage_area lnv_storage_area
Long ll_row, ll_area_row
Long ll_area_id
String ls_doc_name
String ls_doc_path
String ls_full_name
String ls_Null
string ls_text //maha 11.07.2011
string ls_type  //maha 11.07.2011
string ls_open_merge //maha 11.07.2011
string ls_merge_path //maha 11.07.2011
string ls_exp_path  //maha 07.31.2013
string ls_exp_name  //maha 07.31.2013
Integer li_rtn
integer li_screen //maha 11.07.2011
integer li_export //maha 07.31.2013

if this.Enabled = False then return;
SetNull( ls_Null )

ll_area_row = dw_storage_area.GetSelectedrow( 0 )
ll_row = dw_storage_docs.GetSelectedrow( 0 )
IF ll_row = 0 THEN RETURN

ll_area_id = dw_storage_docs.GetItemNumber(ll_row, "area_id")
ls_doc_name = dw_storage_docs.GetItemString(ll_row, "doc_name")
ls_doc_path = dw_storage_area.GetItemString(ll_area_row, "area_doc_path")
ls_full_name = ls_doc_path + ls_doc_name
//Start Code Change ----11.07.2011 #V12 maha
ls_type = dw_storage_docs.GetItemString(ll_row, "doc_type")
li_screen = dw_storage_docs.GetItemNumber(ll_row, "screen_id")
//End Code Change ----11.07.2011
li_export = dw_storage_docs.GetItemNumber(ll_row, "export_id")

IF LenA(ls_full_name) > 0 THEN
		
	// Create directory
	n_appeon_download lnv_download
	lnv_download.of_parsepath( ls_doc_path )

	// Open process window
	OpenWithParm( w_appeon_gifofwait, "Downloading document from database...")

	li_rtn = lnv_storage_area.of_download_file( ll_area_id, ls_doc_name, ls_full_name)
	
	// Close process window
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
	
	IF li_rtn < 0 THEN
		IF li_rtn = -2 THEN Messagebox("View document","The document does not exist in the database!")
		RETURN
	END IF
	//debugbreak()
	//Start Code Change ----11.07.2011 #V12 maha - added functionality to open the letter with a data source
	//Start Code Change ----07.31.2013 #V14 maha - modified for export
    	ls_merge_path = of_letter_paths("D") //merge document path
	debugbreak()		 
	If li_export > 0 then
		select export_name, export_format into :ls_exp_name, :ls_type from export_header where export_id = :li_export;
		if isnull(ls_exp_name) then 
			ls_text = of_get_text_file( li_screen,ls_type)
		elseif ls_type <> '.txt' then 
			messagebox("Invalid Export type","The selected export for the letter must be a delimited text type in order to mail merge. Using standard merge file.")
			ls_text = of_get_text_file( li_screen,ls_type)
		else
			ls_exp_name+= ls_type
			ls_exp_path = 	ls_merge_path + ls_exp_name
			if fileexists(ls_exp_path) then
				ls_text = ls_exp_name
			else
			 	ls_exp_path = of_export_file(li_export, ls_merge_path)
				if ls_exp_path = "Failed" then
					messagebox("Export file","Failed to create export file. Using standard merge file.")
					ls_text = of_get_text_file( li_screen,ls_type)
				else
					ls_text = ls_exp_name
				end if //exp created
			end if //file exists
		end if  //trapping
	else
		ls_text = of_get_text_file( li_screen,ls_type)
	end if //is export
	//End Code Change ----07.31.2013	
	
	
	choose case ls_text 
		case "none" , "lettername"
		messagebox("Open letter","Unsure of the data source for letter " + ls_doc_name  + ".  Opening without merge file." )
		IF FileExists(ls_full_name) THEN
			ShellExecuteA ( Handle( This ), "open", ls_full_name, ls_Null, ls_Null, 1)
		END IF
	case else
		
		
		ls_open_merge = ls_merge_path + ls_text  //look for the file in the letters/data folder
		
		if not fileexists(ls_open_merge) then //if it does not exist, look for a default file on the intellicred root
			ls_open_merge = gs_dir_path + "IntelliCred\default_data_sources\default_" + 	ls_text
			if AppeonGetClientType() = "WEB" then // Added by Evan on 04.10.2012
				n_appeon_download lnv_appeon
				if lnv_appeon.of_DownloadLetterDataSource(ls_open_merge) = -1 then
					MessageBox("Download Data Source", "Failed to download 'default_" + ls_text + "' file. Please contact the system administrator.")
				end if
			elseif not fileexists(ls_open_merge) then //PB
				ls_open_merge = Gs_Current_Directory + "\default_data_sources\default_" + 	ls_text //alfee 03.13.2014
			end if
			//messagebox("ls_open_merge" ,ls_open_merge )
		end if
			
		
		if not fileexists(ls_open_merge) then
			messagebox("Open letter","The data source (" + ls_open_merge + ") does not exist for letter " + ls_doc_name  + ".  Opening without merge file." )
			IF FileExists(ls_full_name) THEN
				ShellExecuteA ( Handle( This ), "open", ls_full_name, ls_Null, ls_Null, 1)
			END IF
		else
			n_cst_appeondll lnv_appeondll
			lnv_appeondll.of_BringTopMergeFieldDlg(1) //Added by Evan 04.27.2012
			if gnv_app.gnvlo_msword.of_open_word_document( ls_full_name , ls_open_merge, "Verification") = -1 then
				lnv_appeondll.of_BringTopMergeFieldDlg(0)
				return -1
			end if
			lnv_appeondll.of_BringTopMergeFieldDlg(0) //Added by Evan 04.27.2012
		end if
	end choose
	//End Code Change ----11.07.2011 
	
END IF

ib_open_4_edit = true
if ii_rightvalue >= 2 then //(Appeon)Stephen 07.08.2015 -  Issues with Letters
	of_open_for_edit()
end if
ib_open_4_edit = false
end event

type cb_adddoc from commandbutton within w_area_painter
integer x = 1408
integer y = 432
integer width = 379
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;
String ls_return
Long ll_rowcount, ll_found, ll_selected

IF dw_storage_area.rowcount() < 1 THEN
	MessageBox( "Add Document", "Please add a Storage Area first." )
	dw_storage_area.SetFocus()
	Return;
END IF

ll_selected = dw_storage_area.GetSelectedRow( 0 )
IF ll_selected = 0 THEN
	MessageBox( "Add Document", "Please select a Storage Area before add document." )
	dw_storage_area.SetFocus()
	Return;
END IF

OpenWithParm( w_storage_docs, il_area_id )

ls_return = Message.StringParm
if LenA( Trim(ls_return) ) <> 0 then
	dw_storage_docs.SetRedraw( False )
	ll_rowcount = dw_storage_docs.Retrieve( il_area_id )
	ll_found = dw_storage_docs.Find( "doc_name = '" + ls_return + "'", &
												1, ll_rowcount )
	if ll_found > 0 then
		dw_storage_docs.SelectRow( 0, False )
		dw_storage_docs.SelectRow( ll_found, True )
		dw_storage_docs.SetRow( ll_found )
		dw_storage_docs.ScrollToRow( ll_found )
	end if
	dw_storage_docs.SetRedraw( True )
end if
end event

type dw_storage_docs from datawindow within w_area_painter
integer x = 9
integer y = 540
integer width = 3890
integer height = 1284
integer taborder = 20
string title = "none"
string dataobject = "d_sys_storage_docs_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;Long ll_row
string ls_object
integer r

ll_row = This.Getrow( )
IF ll_row = 0 THEN RETURN

This.Selectrow( 0 , FALSE)
This.Selectrow( ll_row , TRUE)

dw_detail.scrolltorow(ll_row)

if isnull(this.getitemnumber(ll_row, "screen_id")) or this.getitemnumber(ll_row, "screen_id") = 0 then 
	r = of_set_screen_id( this.getitemstring(currentrow, "doc_name") )
	if r > -1000 then
		this.setitem(currentrow, "screen_id", r)
	end if
end if
	

if isnull(this.getitemstring(ll_row, "data_object")) then
	ls_object = of_set_object_name(this.getitemnumber(currentrow, "screen_id"), this.getitemstring(currentrow, "doc_type") ,currentrow)
	if ls_object <> "none" then
		this.setitem(currentrow, "data_object", ls_object)
	end if
end if

//Start Code Change ----04.19.2012 #V12 maha - added to set the type for the missing letters
if pos(this.getitemstring(currentrow, "doc_name"),"ind_missing_info", 1) > 0 then
	this.setitem(currentrow, "doc_type", "M")
end if
//End Code Change ----04.19.2012




end event

event doubleclicked;cb_savedoc.triggerevent( clicked!)

//Long ll_row, ll_area_id, ll_found, ll_rowcount
//String ls_doc_name, ls_return, ls_str
//
//IF NOT cb_adddoc.Enabled THEN RETURN
//
//ll_row = dw_storage_docs.GetSelectedrow( 0 )
//IF ll_row = 0 THEN RETURN
//	
//ll_area_id = dw_storage_docs.GetItemNumber(ll_row, "area_id")
//ls_doc_name = dw_storage_docs.GetItemString(ll_row, "doc_name")
//
//ls_str = String(ll_area_id) + "~t" + ls_doc_name
//
//OPENWITHPARM( w_storage_docs_edit, ls_str )
//
//ls_return = Message.StringParm
//if Len( Trim(ls_return) ) <> 0 then
//	dw_storage_docs.SetRedraw( False )
//	ll_rowcount = dw_storage_docs.retrieve( ll_area_id )
//	ll_found = dw_storage_docs.Find( "doc_name = '" + ls_return + "'", &
//												1, ll_rowcount )
//	if ll_found > 0 then
//		dw_storage_docs.SelectRow( 0, False )
//		dw_storage_docs.SelectRow( ll_found, True )
//		dw_storage_docs.SetRow( ll_found )
//		dw_storage_docs.ScrollToRow( ll_found )
//	end if
//	dw_storage_docs.SetRedraw( True )
//END IF
end event

event clicked;IF row > 0 THEN
	This.Setrow( row )
	this.selectrow(0,false)
	this.selectrow(row,true)
End IF
end event

event constructor;if AppeonGetClientType() = 'PB' Then //Add by Evan 01.30.2008
	this.object.p_1.filename = gs_current_path + "\sectiongreen.bmp"
end if
end event

event buttonclicked;Long i

IF this.rowcount() = 0 THEN RETURN

IF dwo.text = "Select All" THEN
	dw_storage_docs.SetRedraw(False)
	FOR i = 1 to dw_storage_docs.rowcount()
		dw_storage_docs.setitem(i,"selected",1)
	END FOR
	dw_storage_docs.SetRedraw(True)
	dwo.text = "Unselect All"
ELSE
	dw_storage_docs.SetRedraw(False)
	FOR i = 1 to dw_storage_docs.rowcount()
		dw_storage_docs.setitem(i,"selected",0)
	END FOR
	dw_storage_docs.SetRedraw(True)
	dwo.text = "Select All"
END IF
end event

type dw_storage_area from datawindow within w_area_painter
integer x = 9
integer y = 32
integer width = 946
integer height = 492
integer taborder = 10
string title = "none"
string dataobject = "d_sys_storage_area_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;Long ll_area_id
long ll_null
datawindowchild dwchild

if currentrow < 1 then return;

This.SetRow( currentrow )
This.Selectrow( 0, FALSE)
This.Selectrow( currentrow , TRUE)

ll_area_id = This.GetItemNumber( currentrow, "area_id" )

//dw_storage_docs.Reset( )
dw_storage_docs.Retrieve( ll_area_id )
of_set_dddw_child("DOCS")
of_set_dddw_child("DETAIL")


il_area_id = ll_area_id
end event

event doubleclicked;LONG ll_row
ll_row = This.Getrow( )

IF ll_row > 0 AND cb_editarea.Enabled THEN
	cb_editarea.postevent( clicked! )
END IF

end event

type gb_1 from groupbox within w_area_painter
integer x = 983
integer y = 220
integer width = 1111
integer height = 152
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filter"
end type

type ddlb_new from dropdownlistbox within w_area_painter
boolean visible = false
integer x = 3145
integer y = 268
integer width = 640
integer height = 152
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"All","Application","Case Review","Correspondence","Expiring","FPPE","Labels","Missing Info","OPPE","Privilege","QA","Verification"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//Start Code Change ----06.16.2011 #V11 maha 
string ls_filter

choose case index
	case 1
		ls_filter = ""
	case 2
		ls_filter = "doc_type =  'A'"
	case 3
		ls_filter = "doc_type =  'R'"
	case 4
		ls_filter = "doc_type =  'C'"
	case 5
		ls_filter = "doc_type =  'E'"
	case 6
		ls_filter = "doc_type =  'F'"
	case 7
		ls_filter = "doc_type =  'L'"		
	case 8
		ls_filter = "doc_type =  'M'"
	case 9
		ls_filter = "doc_type =  'O'"
	case 10
		ls_filter = "doc_type =  'P'"
	case 11
		ls_filter = "doc_type =  'Q'"
	case 12
		ls_filter = "doc_type =  'V'"
		
end choose
//---------Begin Added by (Appeon)Toney 10.12.2013 for V141 ISG-CLX--------
//$Reason:link the cached the filter syntax of contract
IF LenA(is_contract_cachefilter) > 0 THEN
	IF LenA(ls_filter) = 0 THEN
		ls_filter = is_contract_cachefilter + " AND doc_type in ('C','E','V')"
	ELSE
		ls_filter = is_contract_cachefilter + " AND doc_type in ('C','E','V') AND "+ls_filter
	END IF
END IF
//---------End Added ------------------------------------------------------------------

dw_storage_docs.setfilter(ls_filter)
dw_storage_docs.filter()

return 1



end event

type gb_2 from groupbox within w_area_painter
integer x = 983
integer y = 376
integer width = 2427
integer height = 152
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Document Functions"
end type

