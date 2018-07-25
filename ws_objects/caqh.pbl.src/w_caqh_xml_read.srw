$PBExportHeader$w_caqh_xml_read.srw
forward
global type w_caqh_xml_read from w_popup
end type
type pb_2 from picturebutton within w_caqh_xml_read
end type
type cb_about from commandbutton within w_caqh_xml_read
end type
type cb_ac from commandbutton within w_caqh_xml_read
end type
type dw_log_items from datawindow within w_caqh_xml_read
end type
type cbx_ac from checkbox within w_caqh_xml_read
end type
type pb_1 from picturebutton within w_caqh_xml_read
end type
type cbx_dir from checkbox within w_caqh_xml_read
end type
type dw_app_audit from datawindow within w_caqh_xml_read
end type
type cbx_pid from checkbox within w_caqh_xml_read
end type
type cbx_title from checkbox within w_caqh_xml_read
end type
type cb_3 from commandbutton within w_caqh_xml_read
end type
type cb_all from commandbutton within w_caqh_xml_read
end type
type dw_verifs from datawindow within w_caqh_xml_read
end type
type dw_otherids from datawindow within w_caqh_xml_read
end type
type dw_verifsxxxx from datawindow within w_caqh_xml_read
end type
type dw_audit_trail from datawindow within w_caqh_xml_read
end type
type dw_spec_link from datawindow within w_caqh_xml_read
end type
type dw_hosp_link from datawindow within w_caqh_xml_read
end type
type dw_addr_link from datawindow within w_caqh_xml_read
end type
type dw_appointment from datawindow within w_caqh_xml_read
end type
type dw_log from datawindow within w_caqh_xml_read
end type
type cb_4 from commandbutton within w_caqh_xml_read
end type
type lb_1 from listbox within w_caqh_xml_read
end type
type dw_facility_default from u_dw within w_caqh_xml_read
end type
type dw_code_lu from datawindow within w_caqh_xml_read
end type
type dw_address_lu from datawindow within w_caqh_xml_read
end type
type dw_ecfmg from datawindow within w_caqh_xml_read
end type
type dw_map_fields from datawindow within w_caqh_xml_read
end type
type dw_dea from datawindow within w_caqh_xml_read
end type
type dw_claims from datawindow within w_caqh_xml_read
end type
type dw_workgap from datawindow within w_caqh_xml_read
end type
type dw_hospital from datawindow within w_caqh_xml_read
end type
type dw_attest from datawindow within w_caqh_xml_read
end type
type dw_specialty from datawindow within w_caqh_xml_read
end type
type dw_language from datawindow within w_caqh_xml_read
end type
type dw_license from datawindow within w_caqh_xml_read
end type
type cb_run from commandbutton within w_caqh_xml_read
end type
type cb_2 from commandbutton within w_caqh_xml_read
end type
type cb_1 from commandbutton within w_caqh_xml_read
end type
type gb_1 from groupbox within w_caqh_xml_read
end type
type dw_experience from datawindow within w_caqh_xml_read
end type
type dw_insurance from datawindow within w_caqh_xml_read
end type
type dw_committees from datawindow within w_caqh_xml_read
end type
type dw_cpr from datawindow within w_caqh_xml_read
end type
type dw_education from datawindow within w_caqh_xml_read
end type
type dw_training from datawindow within w_caqh_xml_read
end type
type dw_address from datawindow within w_caqh_xml_read
end type
type dw_settings from datawindow within w_caqh_xml_read
end type
type mle_1 from multilineedit within w_caqh_xml_read
end type
type gb_3 from groupbox within w_caqh_xml_read
end type
type dw_basic from datawindow within w_caqh_xml_read
end type
type dw_reference from datawindow within w_caqh_xml_read
end type
end forward

global type w_caqh_xml_read from w_popup
integer width = 3675
integer height = 1712
string title = "CAQH XML File Import"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
pb_2 pb_2
cb_about cb_about
cb_ac cb_ac
dw_log_items dw_log_items
cbx_ac cbx_ac
pb_1 pb_1
cbx_dir cbx_dir
dw_app_audit dw_app_audit
cbx_pid cbx_pid
cbx_title cbx_title
cb_3 cb_3
cb_all cb_all
dw_verifs dw_verifs
dw_otherids dw_otherids
dw_verifsxxxx dw_verifsxxxx
dw_audit_trail dw_audit_trail
dw_spec_link dw_spec_link
dw_hosp_link dw_hosp_link
dw_addr_link dw_addr_link
dw_appointment dw_appointment
dw_log dw_log
cb_4 cb_4
lb_1 lb_1
dw_facility_default dw_facility_default
dw_code_lu dw_code_lu
dw_address_lu dw_address_lu
dw_ecfmg dw_ecfmg
dw_map_fields dw_map_fields
dw_dea dw_dea
dw_claims dw_claims
dw_workgap dw_workgap
dw_hospital dw_hospital
dw_attest dw_attest
dw_specialty dw_specialty
dw_language dw_language
dw_license dw_license
cb_run cb_run
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
dw_experience dw_experience
dw_insurance dw_insurance
dw_committees dw_committees
dw_cpr dw_cpr
dw_education dw_education
dw_training dw_training
dw_address dw_address
dw_settings dw_settings
mle_1 mle_1
gb_3 gb_3
dw_basic dw_basic
dw_reference dw_reference
end type
global w_caqh_xml_read w_caqh_xml_read

type variables
string is_file
string is_caqh_path
string is_match_type = "0"

integer ii_parent
integer ii_audit
integer ii_verif
string is_type
string is_affil 
string is_parent
end variables

forward prototypes
public function integer of_check_defaults ()
public function integer of_get_caqh_files (string as_file_path, ref string as_filename[])
end prototypes

public function integer of_check_defaults ();//Start Code Change ----02.04.2010 #V10 maha - added to be sure required data is selected
if  ii_parent = 0 or IsNull(ii_parent) then  //or IsNull Added by Appeon long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
	messagebox("Record Defaults", "The Parent Facility must be selected")
	return -1
end if

if  ii_verif = 0 or IsNull(ii_verif) then //or IsNull Added by Appeon long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
	messagebox("Record Defaults", "The Verifying Facility must be selected")
	return -1
end if

if  ii_audit = 0 or IsNull(ii_audit) then //or IsNull Added by Appeon long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
	messagebox("Record Defaults", "The Audit Template must be selected")
	return -1
end if

return 1
end function

public function integer of_get_caqh_files (string as_file_path, ref string as_filename[]);//Get caqh xml file list, called by n_cst_scheduler - alfee 02.06.2010

Integer i

lb_1.DirList ( as_file_path + "*.xml",0)

FOR i = 1 To lb_1.TotalItems()
	as_filename[i] = lb_1.Text(i)
NEXT

RETURN 1
end function

on w_caqh_xml_read.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_about=create cb_about
this.cb_ac=create cb_ac
this.dw_log_items=create dw_log_items
this.cbx_ac=create cbx_ac
this.pb_1=create pb_1
this.cbx_dir=create cbx_dir
this.dw_app_audit=create dw_app_audit
this.cbx_pid=create cbx_pid
this.cbx_title=create cbx_title
this.cb_3=create cb_3
this.cb_all=create cb_all
this.dw_verifs=create dw_verifs
this.dw_otherids=create dw_otherids
this.dw_verifsxxxx=create dw_verifsxxxx
this.dw_audit_trail=create dw_audit_trail
this.dw_spec_link=create dw_spec_link
this.dw_hosp_link=create dw_hosp_link
this.dw_addr_link=create dw_addr_link
this.dw_appointment=create dw_appointment
this.dw_log=create dw_log
this.cb_4=create cb_4
this.lb_1=create lb_1
this.dw_facility_default=create dw_facility_default
this.dw_code_lu=create dw_code_lu
this.dw_address_lu=create dw_address_lu
this.dw_ecfmg=create dw_ecfmg
this.dw_map_fields=create dw_map_fields
this.dw_dea=create dw_dea
this.dw_claims=create dw_claims
this.dw_workgap=create dw_workgap
this.dw_hospital=create dw_hospital
this.dw_attest=create dw_attest
this.dw_specialty=create dw_specialty
this.dw_language=create dw_language
this.dw_license=create dw_license
this.cb_run=create cb_run
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_experience=create dw_experience
this.dw_insurance=create dw_insurance
this.dw_committees=create dw_committees
this.dw_cpr=create dw_cpr
this.dw_education=create dw_education
this.dw_training=create dw_training
this.dw_address=create dw_address
this.dw_settings=create dw_settings
this.mle_1=create mle_1
this.gb_3=create gb_3
this.dw_basic=create dw_basic
this.dw_reference=create dw_reference
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_about
this.Control[iCurrent+3]=this.cb_ac
this.Control[iCurrent+4]=this.dw_log_items
this.Control[iCurrent+5]=this.cbx_ac
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.cbx_dir
this.Control[iCurrent+8]=this.dw_app_audit
this.Control[iCurrent+9]=this.cbx_pid
this.Control[iCurrent+10]=this.cbx_title
this.Control[iCurrent+11]=this.cb_3
this.Control[iCurrent+12]=this.cb_all
this.Control[iCurrent+13]=this.dw_verifs
this.Control[iCurrent+14]=this.dw_otherids
this.Control[iCurrent+15]=this.dw_verifsxxxx
this.Control[iCurrent+16]=this.dw_audit_trail
this.Control[iCurrent+17]=this.dw_spec_link
this.Control[iCurrent+18]=this.dw_hosp_link
this.Control[iCurrent+19]=this.dw_addr_link
this.Control[iCurrent+20]=this.dw_appointment
this.Control[iCurrent+21]=this.dw_log
this.Control[iCurrent+22]=this.cb_4
this.Control[iCurrent+23]=this.lb_1
this.Control[iCurrent+24]=this.dw_facility_default
this.Control[iCurrent+25]=this.dw_code_lu
this.Control[iCurrent+26]=this.dw_address_lu
this.Control[iCurrent+27]=this.dw_ecfmg
this.Control[iCurrent+28]=this.dw_map_fields
this.Control[iCurrent+29]=this.dw_dea
this.Control[iCurrent+30]=this.dw_claims
this.Control[iCurrent+31]=this.dw_workgap
this.Control[iCurrent+32]=this.dw_hospital
this.Control[iCurrent+33]=this.dw_attest
this.Control[iCurrent+34]=this.dw_specialty
this.Control[iCurrent+35]=this.dw_language
this.Control[iCurrent+36]=this.dw_license
this.Control[iCurrent+37]=this.cb_run
this.Control[iCurrent+38]=this.cb_2
this.Control[iCurrent+39]=this.cb_1
this.Control[iCurrent+40]=this.gb_1
this.Control[iCurrent+41]=this.dw_experience
this.Control[iCurrent+42]=this.dw_insurance
this.Control[iCurrent+43]=this.dw_committees
this.Control[iCurrent+44]=this.dw_cpr
this.Control[iCurrent+45]=this.dw_education
this.Control[iCurrent+46]=this.dw_training
this.Control[iCurrent+47]=this.dw_address
this.Control[iCurrent+48]=this.dw_settings
this.Control[iCurrent+49]=this.mle_1
this.Control[iCurrent+50]=this.gb_3
this.Control[iCurrent+51]=this.dw_basic
this.Control[iCurrent+52]=this.dw_reference
end on

on w_caqh_xml_read.destroy
call super::destroy
destroy(this.pb_2)
destroy(this.cb_about)
destroy(this.cb_ac)
destroy(this.dw_log_items)
destroy(this.cbx_ac)
destroy(this.pb_1)
destroy(this.cbx_dir)
destroy(this.dw_app_audit)
destroy(this.cbx_pid)
destroy(this.cbx_title)
destroy(this.cb_3)
destroy(this.cb_all)
destroy(this.dw_verifs)
destroy(this.dw_otherids)
destroy(this.dw_verifsxxxx)
destroy(this.dw_audit_trail)
destroy(this.dw_spec_link)
destroy(this.dw_hosp_link)
destroy(this.dw_addr_link)
destroy(this.dw_appointment)
destroy(this.dw_log)
destroy(this.cb_4)
destroy(this.lb_1)
destroy(this.dw_facility_default)
destroy(this.dw_code_lu)
destroy(this.dw_address_lu)
destroy(this.dw_ecfmg)
destroy(this.dw_map_fields)
destroy(this.dw_dea)
destroy(this.dw_claims)
destroy(this.dw_workgap)
destroy(this.dw_hospital)
destroy(this.dw_attest)
destroy(this.dw_specialty)
destroy(this.dw_language)
destroy(this.dw_license)
destroy(this.cb_run)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_experience)
destroy(this.dw_insurance)
destroy(this.dw_committees)
destroy(this.dw_cpr)
destroy(this.dw_education)
destroy(this.dw_training)
destroy(this.dw_address)
destroy(this.dw_settings)
destroy(this.mle_1)
destroy(this.gb_3)
destroy(this.dw_basic)
destroy(this.dw_reference)
end on

event open;call super::open;datawindowchild dwchild
long ll_facil
long ll_app
long ll_verif
integer li_title = 1 //maha 04.12.2011
integer li_pid  = 1//maha 04.12.2011
Int li_addr_dir_link = 1 //Added by Appeon long.zhang 05.05.2016 (V15.1 Bug # 5139 - CAQH Default Settings is missing Set Address Directory link)
string ls_type  //maha 04.12.2011
string ls_stat  //maha 04.12.2011


if message.stringparm = 'invisible' then this.visible = false //for scheduler - alfee 02.06.2010

//mle_1.text = "This utility is designed for importing new practitioner data from XML files downloaded from the CAQH website.   It is not designed to update data for existing providers. A) THE FILES MUST BE DOWNLOADED BEFORE RUNNING THE UTILITY.  CONTACT  THE CAQH DIRECTLY FOR HOW TO DO THIS.  B) Select the match field from the provider data.   C) The program will log each file as imported.  If a file for a provider is imported a second time, it will be ignored. D) Select the Appointment default data if applicable.  E) Click get files to browse to the directory into which you downloaded the CAQH files.  F) Select/Deselect the files by Clicking on them.  Hold the Ctrl key for multiple selections.  G) Click Import to start the file import process."
mle_1.text = "This utility is designed for importing practitioner data from XML files downloaded from the CAQH website. ~r~n~n " + &
"A) THE FILES MUST BE DOWNLOADED BEFORE RUNNING THE UTILITY.  CONTACT  THE CAQH DIRECTLY FOR HOW TO DO THIS.  ~r~n~n " + &
"B) The program will log each file as imported.  If a file for a provider is imported a second time, it will be ignored. ~r~n~n " + &
"C) Select the Appointment default data if applicable.  ~r~n~n " + &
"D) Click get files to browse to the directory into which you downloaded the CAQH files.  ~r~n~n " + &
"E) Select/Deselect the files by Clicking on them.  Hold the Ctrl key for multiple selections.  ~r~n~n " + &
"F) Click Import to start the file import process.~r~n~n " + &
"G) If Use Acceptance is checked, the data will need to be accepted before it can be viewed in the provider folder."  //Added by Appeon long.zhang 03.18.2015 (v15.1 CAQH Import Data Approval)


//"B) Select the match field from the provider data.  ~r~n~n " + &

dw_facility_default.settransobject(sqlca)
dw_facility_default.insertrow(1)

dw_facility_default.settransobject(sqlca) //maha 082201
dw_facility_default.GetChild( "parent_facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
dwchild.insertrow(1)
dwchild.setitem(1, 'facility_id', 0) //Added by Appeon long.zhang 05.12.2015 (v15.1 CAQH Import Data Approval)
dwchild.setitem(1, 'facility_facility_name', ' ') //Added by Appeon long.zhang 05.12.2015 (v15.1 CAQH Import Data Approval)

dw_facility_default.GetChild( "verifying_facility", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
dwchild.insertrow(1)

dw_facility_default.GetChild( "application_audit_facility", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
dwchild.insertrow(1)

dw_facility_default.GetChild( "affiliation_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
dwchild.insertrow(1)


	
//Start Code Change ----04.12.2011 #V11 maha - rewrote code to use default settings
if gs_cust_type = "I" then   //Start Code Change ----01.208.2010 #V10 maha _ change from IntelliApp	
	ll_facil = 1
	ll_app = 1
	ll_verif = 1
	 if dw_settings.rowcount() = 1 then
		 li_title = dw_settings.getitemnumber(1,"set_title") 
		 li_pid = dw_settings.getitemnumber(1,"set_prov_id")
		 li_addr_dir_link = dw_settings.getitemnumber(1,"set_addr_dir_link")//Added by Appeon long.zhang 05.05.2016 (V15.1 Bug # 5139 - CAQH Default Settings is missing Set Address Directory link)
	end if
	ls_type = "I"
	ls_stat = "M"
	dw_facility_default.enabled=  false
else
	if dw_settings.rowcount() = 1 then
		 ll_facil = dw_settings.getitemnumber(1,"parent_id")
		 ll_app = dw_settings.getitemnumber(1,"template_id")
		 ll_verif = dw_settings.getitemnumber(1,"verify_id") 
		 li_title = dw_settings.getitemnumber(1,"set_title") 
		 li_pid = dw_settings.getitemnumber(1,"set_prov_id") 
		 li_addr_dir_link = dw_settings.getitemnumber(1,"set_addr_dir_link") //Added by Appeon long.zhang 05.05.2016 (V15.1 Bug # 5139 - CAQH Default Settings is missing Set Address Directory link)
		 ls_type = dw_settings.getitemstring(1,"app_type") 
		 ls_stat = dw_settings.getitemstring(1,"affil_stat") 
	else
		ls_type = "I"
		ls_stat = "M"
		
		select default_search_facility into :ll_facil from security_users where user_id = :gs_user_id;
		if ll_facil > 0 then
			dw_facility_default.setitem(1,"parent_facility_id",ll_facil)
			select facility_name, default_audit_temp, default_verif_facility into :is_parent, :ll_app, :ll_verif from facility where facility_id = :ll_facil;
			dw_facility_default.setitem(1,"verifying_facility",ll_app )
			dw_facility_default.setitem(1,"application_audit_facility",ll_verif )
		end if
		
	end if
end if

dw_facility_default.setitem(1,"parent_facility_id",ll_facil)
//---------Begin Modified by (Appeon)Stephen 12.08.2014 for CAQH Default settings Bug# 4339--------
/*
dw_facility_default.setitem(1,"verifying_facility",ll_app)
dw_facility_default.setitem(1,"application_audit_facility",ll_verif)
*/
dw_facility_default.setitem(1,"verifying_facility",ll_verif)
dw_facility_default.setitem(1,"application_audit_facility",ll_app)
//---------End Modfiied ------------------------------------------------------

dw_facility_default.setitem(1,"affiliation_status",ls_stat)
dw_facility_default.setitem(1,"apptmnt_type",ls_type)
ii_parent = ll_facil
ii_audit = ll_app
ii_verif = ll_verif
is_type = ls_type
is_affil  = ls_stat

//---------Begin Modified by (Appeon)Stephen 12.08.2014 for CAQH Default settings Bug# 4339--------
/*
if li_title = 1 then cbx_title.checked = true
if li_pid = 1 then cbx_pid.checked = true
*/
if li_title = 0 then cbx_title.checked = false
if li_pid = 0 then cbx_pid.checked = false
if li_addr_dir_link = 0 then cbx_dir.checked = false //Added by Appeon long.zhang 05.05.2016 (V15.1 Bug # 5139 - CAQH Default Settings is missing Set Address Directory link)
//---------End Modfiied ------------------------------------------------------

//End Code Change ----04.12.2011

This.ib_disableclosequery = True //Added by Appeon long.zhang 08.15.2016 (Bug id 5287 - CAQH Import not brinng Attest Questions Answers in)
end event

type pb_2 from picturebutton within w_caqh_xml_read
integer x = 2414
integer y = 12
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean originalsize = true
string picturename = "Help!"
alignment htextalign = left!
end type

event clicked;String s


s = "When using Acceptance, the data will be stored in an audit screen.~r~r" 
s+= "Before the data appears for the Provider it must be accepted.~r~r" 
s+= "If Accepatance is not used, the Provider data will be updated immediately.~r~r" 

messagebox("Acceptance",s)
end event

type cb_about from commandbutton within w_caqh_xml_read
integer x = 3191
integer y = 12
integer width = 251
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;
string s

s = "This function is designed to import data from XML files received from CAQH.~r"
s+= "You must have an account with CAQH to get these files.~r"
s+= "If you are using import files for providers that exist in your database, you may want to use the acceptance option to help prevent unexpected changes to data including appearent duplicate records."


messagebox("About CAQH Import",s)
end event

type cb_ac from commandbutton within w_caqh_xml_read
integer x = 2569
integer y = 12
integer width = 302
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Acceptance"
end type

event clicked; open( w_caqh_audit )
end event

type dw_log_items from datawindow within w_caqh_xml_read
integer x = 2793
integer y = 2956
integer width = 635
integer height = 192
integer taborder = 90
string title = "none"
string dataobject = "d_caqh_log_items"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_ac from checkbox within w_caqh_xml_read
integer x = 1929
integer y = 28
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Use Acceptance"
end type

type pb_1 from picturebutton within w_caqh_xml_read
integer x = 1371
integer y = 12
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean originalsize = true
string picturename = "Help!"
alignment htextalign = left!
end type

event clicked;String s


s = "When you click on the Get Files button, you browse to the directory where your CAQH xml files are stored.~r~r" 
s+= "By default all files are selected.~r~r" 
s+= "To select or deselect files hold the Crtl key and click the file.~r~r" 

messagebox("Getting and selecting files:",s)













end event

type cbx_dir from checkbox within w_caqh_xml_read
integer x = 2414
integer y = 1492
integer width = 699
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Set Address Directory Link"
boolean checked = true
end type

type dw_app_audit from datawindow within w_caqh_xml_read
boolean visible = false
integer x = 4014
integer y = 1556
integer width = 421
integer height = 188
integer taborder = 80
string dataobject = "d_caqh_app_audit"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_pid from checkbox within w_caqh_xml_read
integer x = 1733
integer y = 1492
integer width = 658
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Set Provider Id from file"
boolean checked = true
end type

type cbx_title from checkbox within w_caqh_xml_read
integer x = 1106
integer y = 1492
integer width = 635
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Set Title default to Dr."
boolean checked = true
end type

type cb_3 from commandbutton within w_caqh_xml_read
integer x = 2875
integer y = 12
integer width = 311
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Import Log"
end type

event clicked;open(w_caqh_log_report)
end event

type cb_all from commandbutton within w_caqh_xml_read
integer x = 155
integer y = 1688
integer width = 302
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Deselect All"
end type

event clicked;string ls_path
long i

if this .text  = "Select All" then
	for i = 1 to lb_1.TotalItems()
		lb_1.setstate(i, true) 
	next
	this .text  = "Deselect All"
else
	for i = 1 to lb_1.TotalItems()
		lb_1.setstate(i, false) 
	next
	this .text  = "Select All"
end if
	
end event

type dw_verifs from datawindow within w_caqh_xml_read
integer x = 3863
integer y = 2916
integer width = 434
integer height = 288
integer taborder = 80
string dataobject = "d_qa_ver_records"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type dw_otherids from datawindow within w_caqh_xml_read
integer x = 1591
integer y = 1772
integer width = 667
integer height = 220
integer taborder = 80
string title = "none"
string dataobject = "d_caqh_imp_other_ids"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_verifsxxxx from datawindow within w_caqh_xml_read
integer x = 3982
integer y = 236
integer width = 398
integer height = 292
integer taborder = 70
string title = "none"
string dataobject = "d_ver_summary_record_view"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_audit_trail from datawindow within w_caqh_xml_read
integer x = 3154
integer y = 2336
integer width = 398
integer height = 292
integer taborder = 70
string title = "none"
string dataobject = "d_view_audit"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_spec_link from datawindow within w_caqh_xml_read
integer x = 3154
integer y = 2020
integer width = 398
integer height = 292
integer taborder = 70
string title = "none"
string dataobject = "d_sf_link"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hosp_link from datawindow within w_caqh_xml_read
integer x = 3154
integer y = 1744
integer width = 398
integer height = 292
integer taborder = 70
string title = "none"
string dataobject = "d_caqh_imp_hospital_link"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_addr_link from datawindow within w_caqh_xml_read
integer x = 3808
integer y = 1452
integer width = 334
integer height = 224
integer taborder = 70
string title = "none"
string dataobject = "d_caqh_imp_address_link"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_appointment from datawindow within w_caqh_xml_read
integer x = 2391
integer y = 2576
integer width = 686
integer height = 292
integer taborder = 80
string title = "none"
string dataobject = "d_caqh_imp_affil_stat"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_log from datawindow within w_caqh_xml_read
integer x = 2414
integer y = 2916
integer width = 347
integer height = 260
integer taborder = 70
string title = "none"
string dataobject = "d_caqh_log_prac"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_caqh_xml_read
integer x = 3817
integer y = 620
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "dir path"
end type

event clicked;messagebox("dir path",gs_dir_path )
end event

type lb_1 from listbox within w_caqh_xml_read
integer x = 14
integer y = 16
integer width = 1029
integer height = 1596
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean multiselect = true
borderstyle borderstyle = stylelowered!
boolean extendedselect = true
end type

type dw_facility_default from u_dw within w_caqh_xml_read
integer x = 1083
integer y = 1156
integer width = 2240
integer height = 332
integer taborder = 40
string title = "none"
string dataobject = "d_affil_status_default"
boolean vscrollbar = false
boolean border = false
end type

event itemchanged;long ll_app
long ll_facil
long ll_verif

if dwo.name = "parent_facility_id" then
	ll_facil = long(data)
	select facility_name,default_audit_temp, default_verif_facility into :is_parent :ll_app, :ll_verif from facility where facility_id = :ll_facil;
	dw_facility_default.setitem(1,"verifying_facility",ll_verif )
	ii_parent = ll_facil
	ii_verif = ll_verif
	dw_facility_default.setitem(1,"application_audit_facility",ll_app )
	ii_audit = ll_app
	dw_facility_default.setitem(1,"apptmnt_type","I" )
	is_type = "I"
	dw_facility_default.setitem(1,"affiliation_status","M" )
	is_affil = "M"
elseif dwo.name = "verifying_facility" then
	ii_verif = long(data)	//Start Code Change ----09.29.2009 #V92 maha - corrected variable
elseif dwo.name = "application_audit_facility" then
	ii_audit = long(data)	//Start Code Change ----09.29.2009 #V92 maha - corrected variable
elseif dwo.name = "apptmnt_type" then
	is_type = data
elseif dwo.name = "affiliation_status" then
	is_affil = data	
end if
end event

event constructor;call super::constructor;This.of_setupdateable(false) //Added by Appeon long.zhang 05.12.2015 (v15.1 CAQH Import Data Approval)
end event

type dw_code_lu from datawindow within w_caqh_xml_read
integer x = 1559
integer y = 2900
integer width = 421
integer height = 292
integer taborder = 60
string title = "none"
string dataobject = "d_code_lookup_caqh"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_address_lu from datawindow within w_caqh_xml_read
integer x = 1989
integer y = 2900
integer width = 357
integer height = 292
integer taborder = 60
string title = "none"
string dataobject = "d_address_lookup_caqh_add"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_ecfmg from datawindow within w_caqh_xml_read
integer x = 55
integer y = 2900
integer width = 686
integer height = 292
integer taborder = 70
string title = "none"
string dataobject = "d_caqh_imp_ecfmg"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type dw_map_fields from datawindow within w_caqh_xml_read
integer x = 3502
integer y = 2912
integer width = 283
integer height = 264
integer taborder = 70
string title = "none"
string dataobject = "d_caqh_mapping_fields"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type dw_dea from datawindow within w_caqh_xml_read
integer x = 1833
integer y = 2568
integer width = 466
integer height = 292
integer taborder = 70
string title = "none"
string dataobject = "d_caqh_imp_dea"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_claims from datawindow within w_caqh_xml_read
integer x = 55
integer y = 2568
integer width = 686
integer height = 292
integer taborder = 60
string title = "none"
string dataobject = "d_caqh_imp_claims"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_workgap from datawindow within w_caqh_xml_read
integer x = 3177
integer y = 2640
integer width = 302
integer height = 292
integer taborder = 60
string title = "none"
string dataobject = "d_caqh_imp_workgap"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hospital from datawindow within w_caqh_xml_read
integer x = 1582
integer y = 2376
integer width = 686
integer height = 188
integer taborder = 60
string title = "none"
string dataobject = "d_caqh_imp_hospital"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_attest from datawindow within w_caqh_xml_read
integer x = 2377
integer y = 2252
integer width = 686
integer height = 292
integer taborder = 60
string title = "none"
string dataobject = "d_caqh_imp_attest"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_specialty from datawindow within w_caqh_xml_read
integer x = 3707
integer y = 1196
integer width = 686
integer height = 292
integer taborder = 60
string title = "none"
string dataobject = "d_caqh_imp_specialty"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_language from datawindow within w_caqh_xml_read
integer x = 2377
integer y = 1780
integer width = 686
integer height = 260
integer taborder = 60
string title = "none"
string dataobject = "d_caqh_imp_language"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_license from datawindow within w_caqh_xml_read
integer x = 3607
integer y = 2588
integer width = 686
integer height = 268
integer taborder = 50
string title = "none"
string dataobject = "d_caqh_imp_license"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_run from commandbutton within w_caqh_xml_read
integer x = 1669
integer y = 12
integer width = 251
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Import"
end type

event clicked;integer i
integer ck
boolean lb_p = true
boolean lb_t = true
integer res
integer ok
integer no
integer ex
long ll_total = 0 //maha 09.30.2015
string ls_filename
string ls_proc_path
n_cst_caqh_import ln_caqh
string ls_log_ids =''

//make sure w_caqh_audit is closed,Added by Appeon long.zhang 03.31.2015 (v15.1 CAQH Import Data Approval)
If isvalid(w_caqh_audit) Then
	If MessageBox("CAQH Import", "The Acceptance window is open. Do you want to close it? ", Question!,YesNo!, 2) = 1 Then
		close(w_caqh_audit)
	Else
		Return -1
	END IF
End If

//Start Code Change ----05.28.2014 #V14.2 maha
res = of_check_prac_facility_max("P") 
if res > 0 then
	MessageBox("Practitioner Limit", "You have reached the limit of providers ( "  + string(res) + " ) as defined by the system setup, and cannot add any additional providers.  Contact IntelliSoft Group for Options.")
	this.enabled = false
	Return -1
END IF

//trap for missing import mapping data - moved from n_cst_caqh_import by (caqh 2)alfee 12.18.2009
if dw_map_fields.rowcount() = 0 then
	res = dw_map_fields.retrieve()
	if res < 1 then
		messagebox("CAQH Import","Failed to retrieve mapping data; unable to continue import")
		return -1
	end if
end if

//Start Code Change ----02.04.2010 #V10 maha - make sure defaults are properly set
res = of_check_defaults( ) 
if res = -1 then return
//End Code Change---02.04.2010

ln_caqh = create n_cst_caqh_import
//Start Code Change ----08.17.2009 #V92 maha - added variable for defaulting tite and pid
if cbx_pid.checked = false then lb_p = false
if cbx_title.checked = false then lb_t = false

if cbx_dir.checked then  //Start Code Change ----12.03.2010 #V10 maha
	ln_caqh.of_set_dir_links(1)
else
	ln_caqh.of_set_dir_links(0)
end if

ln_caqh.of_set_appt_defaults( ii_parent , ii_audit , ii_verif ,  is_type,  is_affil , is_parent, lb_p, lb_t)
//End Code Change---08.17.2009

ln_caqh.of_set_approval_flag( cbx_ac.checked ) //Added by Appeon long.zhang 03.18.2015 (v15.1 CAQH Import Data Approval)

//Start Code Change ----03.17.2010 #V10 maha - moved from of_set_dw function so that the windows are reset at only the beginning of the import series rather than after each file
ln_caqh.of_set_dws( )
ln_caqh.of_reset_lookups()
//End Code Change---03.17.2010

for i = 1 to lb_1.TotalItems()
	yield() //Added by Appeon long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
	IF lb_1.State(i) = 1 THEN 
		ll_total++   //Start Code Change ----09.30.2015 #V15 maha
		ls_filename = lb_1.text(i)
		if PosA(ls_filename, "ExtractIndex",  1) > 0 then continue ////Start Code Change ----10.20.2009 #V10 maha
		ls_proc_path =  is_caqh_path + "Processed\" + ls_filename
		ls_filename = is_caqh_path  + ls_filename
		is_file = ls_filename
//		messagebox("file", is_file)
		res = ln_caqh.of_import_xml(is_file,i)
		if res = 1 then  //processed
			ok++
			ck = FileCopy ( is_file,ls_proc_path  ,true )
			if ck = 1 then FileDelete ( is_file)
			
			If cbx_ac.checked Then ls_log_ids += String(ln_caqh.of_get_log_id()) +',' //Get log ids, Added by Appeon long.zhang 03.27.2015 (v15.1 CAQH Import Data Approval)
		elseif res = 0 then  //skipped - skipped could be because there were multiple provider records matching the key data, because the user manually skipped or because the attest date was earlier than the existing.
			ex++
			ck = FileCopy ( is_file, ls_proc_path ,true )
			if ck = 1 then FileDelete ( is_file)
		else  //failed
			no++
		end if
	end if
next

lb_1.DirList ( is_caqh_path + "*.xml",0)

If cbx_ac.checked Then // Added by Appeon long.zhang 03.18.2015 (v15.1 CAQH Import Data Approval)
 //Start Code Change ----09.30.2015 #V15 maha - changed messages
	//messagebox("CAQH Audit Import","Process Complete: " + string(ok) + " files imported; " + string(no) + " files failed; " + string(ex) + " incomplete log skipped;")
	messagebox("CAQH Audit Import","Process Complete: " + string(ll_total) + " files processed; " + string(no) + " files failed; " + string(ex) + " incomplete log skipped;")
Else
	//messagebox("CAQH Import","Process Complete: " + string(ok) + " files imported; " + string(no) + " files failed; " + string(ex) + " provider exists;")
	messagebox("CAQH Import","Process Complete: " + string(ll_total) + " files processed; " + string(no) + " files failed; " + string(ex) + " files skipped;")
End If

destroy ln_caqh

//Added by Appeon long.zhang 03.18.2015 (v15.1 CAQH Import Data Approval)
If cbx_ac.checked and cb_ac.enabled and ok > 0 Then 
	If RightA(ls_log_ids, 1 ) = ',' Then ls_log_ids = LeftA(ls_log_ids, LenA(ls_log_ids) - 1 )
	OpenWithParm( w_caqh_audit ,ls_log_ids )
End If
end event

type cb_2 from commandbutton within w_caqh_xml_read
integer x = 1061
integer y = 12
integer width = 302
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get Files"
end type

event clicked;string ls_path
string ls_pro_path
long i


ls_path =  gs_temp_path

GetFolder ( "Select Caqh import file folder", ls_path )

if RightA(ls_path, 1 ) <> "\" then ls_path+= "\"
is_caqh_path = ls_path

//Start Code Change ----08.05.2009 #V92 maha - add create process directory and select all
if not directoryexists(ls_path + "Processed") then
	 ls_pro_path = ls_path + "Processed\"
	CreateDirectoryA(ls_pro_path, 0)  
end if

lb_1.DirList ( ls_path + "*.xml",0)

for i = 1 to lb_1.TotalItems()
	lb_1.setstate(i, true) 
next
//End Code Change---08.05.2009

ChangeDirectory(gs_current_path) //Added by Evan 09.13.2011 - BugE090702
end event

type cb_1 from commandbutton within w_caqh_xml_read
integer x = 3447
integer y = 12
integer width = 197
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type gb_1 from groupbox within w_caqh_xml_read
integer x = 1074
integer y = 1104
integer width = 2565
integer height = 508
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Data Defaults:"
end type

type dw_experience from datawindow within w_caqh_xml_read
integer x = 37
integer y = 2316
integer width = 613
integer height = 284
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_caqh_imp_experience"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_insurance from datawindow within w_caqh_xml_read
integer x = 2377
integer y = 1940
integer width = 686
integer height = 292
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_caqh_imp_insurance"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_committees from datawindow within w_caqh_xml_read
integer x = 3840
integer y = 932
integer width = 576
integer height = 236
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_caqh_committees"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_cpr from datawindow within w_caqh_xml_read
integer x = 1586
integer y = 2560
integer width = 219
integer height = 308
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_caqh_imp_certs"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_education from datawindow within w_caqh_xml_read
integer x = 763
integer y = 2552
integer width = 795
integer height = 340
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_caqh_imp_education"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_training from datawindow within w_caqh_xml_read
integer x = 805
integer y = 2948
integer width = 713
integer height = 204
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_caqh_imp_training"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_address from datawindow within w_caqh_xml_read
integer x = 3639
integer y = 1832
integer width = 718
integer height = 728
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_caqh_imp_address"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_settings from datawindow within w_caqh_xml_read
boolean visible = false
integer x = 974
integer y = 1288
integer width = 151
integer height = 108
integer taborder = 50
string title = "none"
string dataobject = "d_caqh_defaults"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type mle_1 from multilineedit within w_caqh_xml_read
integer x = 1083
integer y = 152
integer width = 2546
integer height = 944
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "This utility is designed yada,yada,yada"
boolean border = false
integer tabstop[] = {0}
end type

type gb_3 from groupbox within w_caqh_xml_read
integer x = 1074
integer y = 108
integer width = 2565
integer height = 996
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "About"
borderstyle borderstyle = stylebox!
end type

type dw_basic from datawindow within w_caqh_xml_read
integer x = 18
integer y = 1772
integer width = 4357
integer height = 300
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_caqh_imp_basic_info"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_reference from datawindow within w_caqh_xml_read
integer x = 18
integer y = 2108
integer width = 4370
integer height = 540
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_caqh_imp_reference"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

