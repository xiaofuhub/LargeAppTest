$PBExportHeader$w_ai_print_letters.srw
forward
global type w_ai_print_letters from w_response
end type
type cbx_1 from checkbox within w_ai_print_letters
end type
type rb_bad from radiobutton within w_ai_print_letters
end type
type rb_fax from radiobutton within w_ai_print_letters
end type
type rb_email from radiobutton within w_ai_print_letters
end type
type rb_print from radiobutton within w_ai_print_letters
end type
type rb_all from radiobutton within w_ai_print_letters
end type
type dw_print1 from u_dw within w_ai_print_letters
end type
type mle_text from multilineedit within w_ai_print_letters
end type
type cbx_app_printer from checkbox within w_ai_print_letters
end type
type r_bar_outside from rectangle within w_ai_print_letters
end type
type cb_close from u_cb within w_ai_print_letters
end type
type cb_print_all from u_cb within w_ai_print_letters
end type
type cbx_preview from checkbox within w_ai_print_letters
end type
type ole_print from olecustomcontrol within w_ai_print_letters
end type
type dw_parent_facility from u_dw within w_ai_print_letters
end type
type dw_address_cnt from u_dw within w_ai_print_letters
end type
type dw_addr_mail_cnt from u_dw within w_ai_print_letters
end type
type gb_1 from groupbox within w_ai_print_letters
end type
type r_bar from rectangle within w_ai_print_letters
end type
type st_bar from statictext within w_ai_print_letters
end type
type st_apps from statictext within w_ai_print_letters
end type
type dw_letters from u_dw within w_ai_print_letters
end type
type gb_corro from groupbox within w_ai_print_letters
end type
type dw_corro from u_dw within w_ai_print_letters
end type
type gb_letters from groupbox within w_ai_print_letters
end type
type ddplb_filter from dropdownpicturelistbox within w_ai_print_letters
end type
type uo_print_app from pfc_cst_u_create_app2 within w_ai_print_letters
end type
end forward

global type w_ai_print_letters from w_response
integer x = 23
integer y = 248
integer width = 3154
integer height = 1872
string title = "Print Letters"
boolean controlmenu = false
long backcolor = 33551856
cbx_1 cbx_1
rb_bad rb_bad
rb_fax rb_fax
rb_email rb_email
rb_print rb_print
rb_all rb_all
dw_print1 dw_print1
mle_text mle_text
cbx_app_printer cbx_app_printer
r_bar_outside r_bar_outside
cb_close cb_close
cb_print_all cb_print_all
cbx_preview cbx_preview
ole_print ole_print
dw_parent_facility dw_parent_facility
dw_address_cnt dw_address_cnt
dw_addr_mail_cnt dw_addr_mail_cnt
gb_1 gb_1
r_bar r_bar
st_bar st_bar
st_apps st_apps
dw_letters dw_letters
gb_corro gb_corro
dw_corro dw_corro
gb_letters gb_letters
ddplb_filter ddplb_filter
uo_print_app uo_print_app
end type
global w_ai_print_letters w_ai_print_letters

type variables
pfc_n_cst_ai_printletters inv_printletters

String is_doc_id[]

u_dw idw_verif_data

Boolean ib_print_letter = True
Boolean ib_print_app = False
Boolean ib_app_faxed = False
Boolean ib_fax_num_email_search = False
boolean ib_ofe = false //maha 05.05.2011
Boolean ib_print_priv = False //long.zhang 02.07.2012
Boolean ib_priv_faxed = False //long.zhang 02.07.2012
boolean ib_exp_appt = false
Long il_app_id
long il_parent = 0
integer ii_num     //Stephen 10.09.2013
string   is_docid //Stephen 10.09.2013
string is_reqst //maha 04.24.12
String is_client_id,is_client_id_arr[]  //Ken.Guo 2007-10-25
string is_from //maha 12.08.08
string is_ptype //maha 07.09.2013

n_cst_appeondll inv_appeondll //add by Appeon:kater  03.28.2011

//maha 04.24.2012
datastore ids_print
datastore ids_clinic
datastore ids_prac
datastore ids_data

DataWindowChild idwc_form
DataWindowChild idwc_1
DataWindowChild idwc_2
DataWindowChild idwc_3
DataWindowChild idwc_4
//
end variables

forward prototypes
public function integer of_fax_num_email_search ()
public function integer of_prac_in_array (long al_pracids[], long al_id)
public function integer of_print_priv_form (integer ai_row)
public function integer of_get_privform_child (datastore ad_ds, string as_dwc_name, ref datawindowchild adw_child)
public function integer of_filter_by_type ()
public function integer of_print_appl_priv_form (boolean ab_skip_print, string as_docid[])
public function integer of_print_application (boolean ab_skip_print, string as_docid)
public function integer of_print_priv_form (boolean ab_skip_print, string as_docid)
public function gs_pass_ids of_get_facil_list (u_dw adw_data)
end prototypes

public function integer of_fax_num_email_search ();String ls_letter_name
String ls_fax_number
String ls_email
Integer li_rc
Integer L
Long ll_prac_id
Integer li_facility_id
Integer li_grow
Integer li_tick

IF ib_fax_num_email_search THEN
	RETURN 1
END IF

r_bar.Visible = True
r_bar_outside.Visible = True
st_bar.Visible = True

li_rc = dw_letters.RowCount( )

//li_tick = Round( r_bar.Width/li_rc, 0 )
//r_bar.Width = 1	

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<add> 03.03.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Move the SQLs in the loop in PT-05 here and rewrite the script by
//$<modification> using datastores to cache data from database. Then the subsequent
//$<modification> script directly obtain data from the datatastore.
Long ll_prac_id_arr[], li_facility_id_arr[], ll_i, ll_ic
FOR l = 1 TO li_rc
	ll_prac_id = dw_letters.GetItemNumber( l, "prac_id" )
	li_facility_id = dw_letters.GetItemNumber( l, "facility_id" )		
	ll_prac_id_arr[l] = ll_prac_id
	li_facility_id_arr[l] = li_facility_id
END FOR

IF li_rc > 0 THEN
	Datastore lds_pd_address
	lds_pd_address = Create Datastore
	lds_pd_address.dataobject = "d_pd_address_link_forpt"
	lds_pd_address.Settransobject( SQLCA )
	ll_ic = lds_pd_address.Retrieve(ll_prac_id_arr[], li_facility_id_arr[])
END IF
//---------------------------- APPEON END ----------------------------


FOR l = 1 TO li_rc
	li_grow = li_grow + li_tick
	r_bar.Width = r_bar.width + li_grow 
	//ls_letter_name = Upper( dw_letters.GetItemString( l, "letter_alias" ) )
	ls_letter_name = Upper( dw_letters.GetItemString( l, "letter_name" ) )
	ll_prac_id = dw_letters.GetItemNumber( l, "prac_id" )
	li_facility_id = dw_letters.GetItemNumber( l, "facility_id" )		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-05
	//$<modify> 03.03.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Move the SQLs in the loop to PT-04 and rewrite them to reduce client-server
	//$<modification> interactions.
	/*
	IF ls_letter_name = "EXPIRING APPOINTMENT" OR ls_letter_name = "BASIC INFORMATION" THEN
		SELECT fax, e_mail_address
		INTO :ls_fax_number,
			  :ls_email
		FROM pd_address,
		     pd_address_link
		WHERE (pd_address.rec_id = pd_address_link.address_id ) AND
				(pd_address_link.prac_id = :ll_prac_id ) AND
				(pd_address_link.facility_id = :li_facility_id ) AND
				(pd_address.active_status = 1 ) AND
				(pd_address_link.mailing = 1 );
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
			Return -1
		END IF
		dw_letters.SetItem( l, "fax_number", ls_fax_number )					
	ELSEIF Mid( ls_letter_name, 1, 8 )  = "EXPIRING" THEN
		SELECT fax, e_mail_address
		INTO :ls_fax_number,
			  :ls_email
		FROM pd_address,
		     pd_address_link
		WHERE (pd_address.rec_id = pd_address_link.address_id ) AND
				(pd_address_link.prac_id = :ll_prac_id ) AND
				(pd_address_link.facility_id = :li_facility_id ) AND
				(pd_address.active_status = 1 ) AND
				(pd_address_link.exp_letters = 1 );
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
			Return -1
		END IF
		dw_letters.SetItem( l, "fax_number", ls_fax_number )					
		dw_letters.SetItem( l, "email_address", ls_email )							
	END IF		
	*/
	//IF ls_letter_name = "EXPIRING APPOINTMENT" OR ls_letter_name = "BASIC INFORMATION" THEN
	IF dw_letters.GetItemnumber( l, "screen_id" )  = 1 THEN

		ll_i = lds_pd_address.Find("prac_id = " + String(ll_prac_id) + " and facility_id = " + String(li_facility_id) + &
				" and pd_address_link_mailing = 1", 1, ll_ic)  //Start Code Change ----01.09.2012 #V12 maha - filter failed because field was not in the query; corrected
		ls_fax_number = ""
		IF ll_i > 0 THEN	ls_fax_number = lds_pd_address.Getitemstring(ll_i,"pd_address_fax")

		dw_letters.SetItem( l, "fax_number", ls_fax_number )					
	ELSEIF MidA( ls_letter_name, 1, 8 )  = "EXPIRING" THEN
		ll_i = lds_pd_address.Find("prac_id = "+String(ll_prac_id) + " and facility_id = " + String(li_facility_id) + &
				" and pd_address_link_exp_letters = 1", 1, ll_ic)   //Start Code Change ----01.09.2012 #V12 maha - filter failed because field was not in the query; corrected
		ls_fax_number = ""
		ls_email = ""
		IF ll_i > 0 THEN
			ls_fax_number = lds_pd_address.Getitemstring(ll_i,"pd_address_fax")
			ls_email = lds_pd_address.Getitemstring(ll_i,"pd_address_e_mail_address")
		END IF
		
		dw_letters.SetItem( l, "fax_number", ls_fax_number )					
		dw_letters.SetItem( l, "email_address", ls_email )							
	END IF		
	//---------------------------- APPEON END ----------------------------
END FOR

ib_fax_num_email_search = True

r_bar.Visible = False
r_bar_outside.Visible = False
st_bar.Visible = False


Return 0
end function

public function integer of_prac_in_array (long al_pracids[], long al_id);//Start Code Change ----08.05.2008 #V85 maha
//purpose: find a prac in an array
long li_find
long i

for i = 1 to upperbound(al_pracids[])
	if al_pracids[i ] = al_id then
		return i
	end if
next
//if not found return 0
return 0
//End Code Change---08.05.2008
end function

public function integer of_print_priv_form (integer ai_row);//Start Code Change ----10.04.2013 #V14 maha - rewritten to more closely match the functionality from the prac privilege reports.
//prior code preserved in of_print_form_org in version 12.3 code base
//Start Code Change ----04.24.2012 #V12 maha - added copy from of_priv_print_form

Integer li_format
Integer li_found
Integer li_last_num_sent
Integer li_width
Integer li_cnt
Integer li_height


long li_facid
long ll_prac_id
long ll_clins[]
long ll_clins_null[]
long ll_print_rec
long ll_prac_rec
long ll_procd_id
long ll_rec
long i
long j
long k
long r
long g
long ll_row_cnt
long ll_rc

String ls_prac_name
String ls_stat
String ls_save_as
String ls_doc_id
String ls_letter_allias
String ls_tif_file
String ls_text
String ls_reqst

DataWindowChild ldwc_form
DataWindowChild ldwc_1
DataWindowChild ldwc_2
DataWindowChild ldwc_3
DataWindowChild ldwc_4
//datawindow ids_print

//ids_print = dw_print1
appeon_pdfservice lnv_pdf
n_cst_image_functions_cp ln_to_tif
n_appeon_download lnv_downlaod

if ib_print_priv = false then return -1
ll_rec = dw_letters.rowcount( )
IF ll_rec = 0 Then return -1

i = ai_row

ll_prac_id = dw_letters.GetItemNumber( i, "prac_id" )
li_facid = dw_letters.GetItemNumber(i, "facility_id" )
	
gnv_appeondb.of_startqueue( )

SELECT priv_template.alt_form into :li_format   FROM facility, priv_template    WHERE  facility.priv_template = priv_template.template_id   and facility.facility_id = :li_facid;
select full_name into :ls_prac_name from v_full_name where prac_id = :ll_prac_id;

ids_prac.retrieve(ll_prac_id,li_facid)
ids_clinic.retrieve(ll_prac_id,li_facid )
	
gnv_appeondb.of_commitqueue( )
	
ll_prac_rec = ids_prac.rowcount( )
ll_clins[] = ll_clins_null[]
	
for j = 1 to ids_clinic.rowcount()
		ll_clins[UpperBound(ll_clins[]) + 1] = ids_clinic.getitemnumber( j,"clinical_area_id")
next
IF UpperBound(ll_clins[]) = 0 THEN return -1	//No data
	
Choose case li_format
	case 1
		ids_print.dataobject = "d_form_clin_priv_request_master_f2"
	case 3
		ids_print.dataobject = "d_form_clin_priv_request_master_f3"
	case 4
		ids_print.dataobject = "d_form_clin_priv_request_master_f4"
	Case -1  //Start Code Change ----10.02.2013 #V14 maha - added f1Alt
		ids_print.dataobject =  "d_form_clin_priv_request_master_f1_alt"	
	case 5  //Added by Appeon long.zhang 09.17.2015 (Bug # 4721 for Case #00056366 Privilege Lists)
		ids_print.dataobject =  "d_form_clin_priv_request_master_f5"
	case else   //Start Code Change ----10.02.2013 #V14 maha - changed from  ..._inova
		ids_print.dataobject =  "d_form_clin_priv_request_master_f1"
End choose
	
ids_print.settransobject( sqlca)
ids_data.dataobject = ids_print.dataobject

of_get_privform_child(ids_data,"priv_req",ldwc_1)
of_get_privform_child(ids_data,"clin_req",ldwc_2)
of_get_privform_child(ids_data,"priv_ack",ldwc_3)
of_get_privform_child(ids_data,"priv_head",ldwc_4)
	

	debugbreak()
for j =1 to UpperBound(ll_clins[])	//loop clinic area
	ids_print.retrieve(li_facid,ll_clins[j])
	

	of_get_privform_child(ids_print,"priv_req",ldwc_form)

	ll_rc = ldwc_form.rowcount( )
	for k = 1 to ll_rc	//copy dw_1
		ll_procd_id = ldwc_form.getitemnumber(k,"procd_id")
		g = 0
		g = ids_prac.find("procd_id = " + string(ll_procd_id)  + " and status_code <> " + is_reqst,1,ll_prac_rec)
		if g > 0 then
			ls_stat = ids_prac.getitemstring(g,"code")
			ldwc_form.setitem(k,"facility_zip",ls_stat) 
		elseif g < 0 then
			messagebox("of_print_priv_form", "Filter failed.  Contact support")
			return -1
		else
			ldwc_form.setitem(k,"facility_zip","") 
		end if
		
		if  ids_prac.find("procd_id = " + string(ll_procd_id),1,ll_prac_rec) >0 then
				ll_row_cnt = ldwc_1.rowcount( ) + 1
				ldwc_form.rowscopy( k,k,primary!,ldwc_1, ll_row_cnt,primary!)
		end if
	next
	
	ldwc_form.Modify( "prac_name.text = '" + ls_prac_name + "'" )
	
	for k= 2 to 4	//copy dw_2 dw_3 dw_4
			//	ids_print.GetChild( "dw_"+string(k), ldwc_form )
		choose case k
			case 2
				of_get_privform_child(ids_print,"clin_req",ldwc_form)	//long.zhang 08.07.2012
				//ll_row_cnt = ldwc_2.rowcount( ) + 1
			//	ldwc_form.rowscopy( 1,ldwc_form.rowcount(),primary!,ldwc_2,ll_row_cnt,primary!)
				ldwc_form.Modify( "prac_name.text = '" + ls_prac_name + "'" )
			case 3
					//Start Code Change ----10.03.2013 #V14 maha - modified to case
				of_get_privform_child(ids_print,"priv_ack",ldwc_form)
				ldwc_form.Modify( "prac_name.text = '" + ls_prac_name + "'" )

			case else
				//if ids_print.dataobject = "d_form_clin_priv_request_master_inova" then	exit
				if ids_print.dataobject = "d_form_clin_priv_request_master_inova" or ids_print.dataobject ="d_form_clin_priv_request_master_f1" or ids_print.dataobject = "d_form_clin_priv_request_master_f1_alt" &
					or ids_print.dataobject ="d_form_clin_priv_request_master_f5" then	exit //Added by Appeon long.zhang 09.17.2015 (Bug # 4721 for Case #00056366 Privilege Lists)
				of_get_privform_child(ids_print,"priv_head",ldwc_form)	//long.zhang 08.07.2012
//				ll_row_cnt = ldwc_4.rowcount( ) + 1
//				ldwc_form.rowscopy( 1,ldwc_form.rowcount(),primary!,ldwc_4,ll_row_cnt,primary!)
				ldwc_form.Modify( "prac_name.text = '" + ls_prac_name + "'" )
				//Start Code Change ----10.04.2013 #V14 maha - removed as really is redundant
//				if of_get_app_setting("set_46","I") = 1 then
//					ldwc_formldwc_4.Modify( "title1.text = 'Section Chief' " )
//					ldwc_form.Modify( "title2.text = 'Department Chair'" )
//					ldwc_form.Modify( "title3.text = 'Credentials Committee Chair'" )
//					ldwc_form.Modify( "title4.text = 'Secretary, Medical Executive Committee'" )
//					ldwc_form.Modify( "title5.text = 'Secretary, Inova Health Care Services Board'" )
//				end if
		end choose
	next

ldwc_form.GroupCalc()
	
//ids_data.print( false)	
	ids_print.print( false)

end for	//clinic area for loop
	


IF IsValid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
return 1

end function

public function integer of_get_privform_child (datastore ad_ds, string as_dwc_name, ref datawindowchild adw_child);//==========================================
// $<Function>of_get_privform_child
// $<arguments>
// 	value   datastore    ad_ds : the datastore object
// value string as_dwc_name:which  the child datawindow can be get
//reference the datawindowchild needtoget
// $<returns>Integer
// $<description> Because the child datawindow name has been changed so need correct called from of_print_priv_form()
// $<add> (Appeon) Long.zhang 08.07.2012
//==========================================

choose case as_dwc_name
	case 	"priv_req"
		if ad_ds.dataobject = 'd_form_clin_priv_request_master_f4' or  ad_ds.dataobject = 'd_form_clin_priv_request_master_f3' or ad_ds.dataobject = 'd_form_clin_priv_request_master_f2' then
			ad_ds.GetChild( "dw_3", adw_child )
		elseif ad_ds.dataobject = 'd_form_clin_priv_request_master_inova' or ad_ds.dataobject = 'd_form_clin_priv_request_master_f1' &
			or ad_ds.dataobject = 'd_form_clin_priv_request_master_f1_alt' or ad_ds.dataobject = 'd_form_clin_priv_request_master_f5' then //Start Code Change ----10.02.2013 #V14 maha - added_f1 //f5, Added by Appeon long.zhang 09.17.2015 (Bug # 4721 for Case #00056366 Privilege Lists)
			ad_ds.GetChild( "dw_1", adw_child )
		end if 
	case "clin_req"
		ad_ds.GetChild( "dw_2", adw_child )
	case "priv_ack"
		if ad_ds.dataobject = 'd_form_clin_priv_request_master_f4' or  ad_ds.dataobject = 'd_form_clin_priv_request_master_f3' or ad_ds.dataobject = 'd_form_clin_priv_request_master_f2' then
			ad_ds.GetChild( "dw_4", adw_child )
		elseif ad_ds.dataobject = 'd_form_clin_priv_request_master_inova' or ad_ds.dataobject = 'd_form_clin_priv_request_master_f1' &
				or ad_ds.dataobject = 'd_form_clin_priv_request_master_f1_alt' or ad_ds.dataobject = 'd_form_clin_priv_request_master_f5'  then  //Start Code Change ----10.02.2013 #V14 maha - added_f1 //f5, Added by Appeon long.zhang 09.17.2015 (Bug # 4721 for Case #00056366 Privilege Lists)
			ad_ds.GetChild( "dw_3", adw_child )
		end if 
	case "priv_head"	
		if ad_ds.dataobject = 'd_form_clin_priv_request_master_f4' or  ad_ds.dataobject = 'd_form_clin_priv_request_master_f3' or ad_ds.dataobject = 'd_form_clin_priv_request_master_f2' &
			or ad_ds.dataobject = 'd_form_clin_priv_request_master_f5' then //f5, Added by Appeon long.zhang 09.17.2015 (Bug # 4721 for Case #00056366 Privilege Lists)
			ad_ds.GetChild( "dw_1", adw_child )
		elseif ad_ds.dataobject = 'd_form_clin_priv_request_master_inova' or  ad_ds.dataobject = 'd_form_clin_priv_request_master_f1' or ad_ds.dataobject = 'd_form_clin_priv_request_master_f1_alt' then //(Appeon)Stephen 03.27.2015 - Bug # 4463 - Reappointment package is not printing the header for the privilege form
			ad_ds.GetChild( "dw_4", adw_child )
		end if 
end choose
		
return 1

end function

public function integer of_filter_by_type ();//Start Code Change ----04.12.2013 #V12 maha copied from the original list box
//Start Code Change ----07.15.2013 #V14 maha - rewrote with variables
of_fax_num_email_search( )
dw_letters.AcceptText()
long i
long rc //maha 07.12.2013
string ls_filter //maha 07.15.2013

//show all
IF rb_print.checked THEN
	ls_filter =  "Len( street2 ) > 0 " 
	 is_ptype = "P"  //Start Code Change ----07.09.2013 #V14 maha
//faxable letters	
ELSEIF rb_fax.checked THEN
	ls_filter =  "Len( fax_number ) > 0 " 	
	 is_ptype = "F"
ELSEIF rb_email.checked THEN
	ls_filter =  "Len( email_address ) > 0 " 
	 is_ptype = "E"
ELSEIF rb_bad.checked THEN	
	ls_filter =  " (Len(  fax_number ) = 0 OR IsNull(  fax_number )) AND (Len( email_address ) = 0 OR IsNull(email_address)) AND  (Len( street2 ) = 0 OR IsNull(street2))"	
	 is_ptype = "P"
ELSE
	ls_filter =  ""
	 is_ptype = "P"
END IF

i = dw_letters.SetFilter( ls_filter)
if i < 0 then 
	messagebox("Filter Failed",ls_filter)
end if
dw_letters.Filter( )	


debugbreak()
//Start Code Change ----07.12.2013 #V14 maha - Printer checkbox should only be visible if expiring appt type letter exposed
if ib_exp_appt = true then
	boolean lb_hide = true
	string ls_doc_name
	
	rc = dw_letters.rowcount()
	i = dw_letters.find("PosA (upper(doc_name), 'EXPIRING_') > 0 and screen_id = 1" , 1 , rc )
	//messagebox("",i)
	if i > 0 then
		cbx_app_printer.visible = true
	else
		cbx_app_printer.visible = false
	end if
	
//	FOR i = 1 TO rc
//		ls_doc_name = dw_letters.getitemstring(i,"doc_name")
//		choose case upper(mid(ls_doc_name ,1 ,15 ))
//			case  "EXPIRING_APPOIN" , "EXPIRING_PROVIS", "EXPIRING_ALLIED"
//				lb_hide = false
//				exit
//		end choose
//		
//	next
//	
//	if lb_hide = true then
//		cbx_app_printer.visible = false
//	else
//		cbx_app_printer.visible = true
//	end if
end if
//End Code Change ----07.12.2013

dw_letters.sort()
dw_letters.GroupCalc ( )

return 1
end function

public function integer of_print_appl_priv_form (boolean ab_skip_print, string as_docid[]);long li_facility_id
long li_rc
long ll_docs  //maha 10.11.2013
long i, f,j
long LI_LAST_NUM_SENT
long li_found
integer li_pause = 0
String ls_letter_allias
Long ll_prac_id
String ls_doc_id
String ls_image_path
Boolean ib_connected
Boolean ib_current
n_cst_datetime lnv

appeon_pdfservice lnv_pdf
n_cst_image_functions_cp ln_to_tif
n_appeon_download lnv_downlaod

//Start Code Change ----10.08.2013 #V14 maha - Added for Kaleida
//if em_pause.visible = true then
//	li_pause = integer(em_pause)
//end if
//End Code Change ----10.08.2013

li_rc = dw_letters.RowCount()
ll_docs = upperbound(as_docid)

for i = 1 to ll_docs
	ls_doc_id = as_docid[i]
	//li_find = dw_letters.Find( "doc_id = '" +  ls_doc_id + "'" , 1, 10000 )	

	//print application
	if ib_print_app then
		of_print_application( ab_skip_print, ls_doc_id )
//		if li_pause > 0 then lnv.of_wait(li_pause)  //Start Code Change ----10.07.2013 
	end if
	
	//print priv_forms
	if ib_print_priv  then
		of_print_priv_form( ab_skip_print, ls_doc_id)
//		if li_pause > 0 then lnv.of_wait(li_pause)  //Start Code Change ----10.07.2013 
	end if
	

	IF NOT ib_print_letter THEN
			//ls_doc_id = dw_letters.GetItemString( i, "doc_id" )//Comment by Appeon long.zhang 09.10.2015 (V14.2 Bug #4703 - # of attempts and dates are not incremented/populated when expiring appt AI is printed with only the application)
			li_found = idw_verif_data.Find( "doc_id = '" +  ls_doc_id + "'" , 1, 10000 )	
			li_last_num_sent = idw_verif_data.GetItemNumber( li_found, "number_sent" )
			IF IsNull(li_last_num_sent) THEN
				li_last_num_sent = 0
			END IF
			li_last_num_sent++
			idw_verif_data.SetItem( li_found, "number_sent", li_last_num_sent )
			idw_verif_data.SetItem( li_found, "print_flag", 0 )			
			IF IsNull( idw_verif_data.GetItemDateTime( li_found, "first_sent" ) ) THEN
				idw_verif_data.SetItem( li_found, "first_sent", DateTime(Today(), Now()) )
			END IF
			idw_verif_data.SetItem( li_found, "last_sent", DateTime(Today(), Now()) )
	END IF

END FOR

gnv_appeondb.of_startqueue( )

idw_verif_data.Update( )
COMMIT USING SQLCA;

gnv_appeondb.of_commitqueue( )


dw_letters.SetItem( dw_letters.GetRow(), "num_printed", upperbound(as_docid)) // li_rc)	 //modify by (Appeon)Stephen 10.10.2013 for Application and Privilege form is printing error--------
dw_letters.SetItem( dw_letters.GetRow(), "print_status", 1 )		

uo_print_app.Visible = False
st_apps.Visible = False

if IsValid( lnv_pdf) then destroy lnv_pdf
if isValid(ln_to_tif) then destroy ln_to_tif
IF IsValid(w_appeon_gifofwait) then close(w_appeon_gifofwait)

Return 1
end function

public function integer of_print_application (boolean ab_skip_print, string as_docid);//function called from this window as well as w_prin_msg_box email/fax functionality
long li_facility_id
long li_rc
long i, f
Integer LI_LAST_NUM_SENT
long li_found
String ls_letter_allias
Long ll_prac_id
String ls_doc_id
String ls_image_path
Boolean ib_connected

if ib_print_app = false then return -1 //Start Code Change ----02.15.2011 #V11 maha  - don't print app of off

st_apps.Visible = True

li_rc = dw_letters.RowCount()

uo_print_app.Visible = True

uo_print_app.of_connections( "IntelliCred", "0" )


ls_image_path = gnv_data.of_getitem( "ids", "imaging_path", false )
gs_app_image_path = gnv_data.of_getitem( "ids", "intelliapp_app_path", false )
//---------------------------- APPEON END ----------------------------

uo_print_app.of_set_app_id( il_app_id  )

//Start Code Change ----10.11.2013 #V14 maha - recoded

//FOR i = 1 TO li_rc

i = dw_letters.find( "doc_id = '" + as_docid + "'", 1, li_rc)
if i < 1 then return -1


ls_letter_allias = dw_letters.GetItemString( i, "letter_alias" )
	//---------Begin add by (Appeon)Stephen 10.09.2013 for bug id 3688--------
//	if not isnull(is_docid) then
//		ls_doc_id = dw_letters.GetItemString( i, "doc_id" )
//		if ls_doc_id <> is_docid then continue
//	end if
	//---------End add ------------------------------------------------------		

IF ls_letter_allias <> "Expiring Appointment Letter" and  ls_letter_allias <> "Expiring Provisional Letter" and  ls_letter_allias <> "Expiring Allied Health Letter" THEN
	return -1 
END IF

	//GarbageCollect ( )
IF uo_print_app.of_load_app( ) = -1 THEN
	Return -1
END IF

st_apps.Text = "Generating application " + String( i ) + " of " + String( li_rc )

ll_prac_id = dw_letters.GetItemNumber( i, "prac_id" )
li_facility_id = dw_letters.GetItemNumber( i, "facility_id" )

uo_print_app.ii_prac_id = ll_prac_id

IF uo_print_app.of_setup( il_app_id, 1  , 99, li_facility_id ) = -1 THEN
	return -1
END IF
	
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 02.14.2012
	//$<reason> bind fields in the app-image
for f = 1 to uo_print_app.ole_edit.Object.PageCount()
	IF gi_burn_annos = 1 THEN
		uo_print_app.ole_edit.Object.Page( f )
		uo_print_app.ole_edit.Object.Display()
		try
			if AppeonGetClientType() = "WEB" then uo_print_app.ole_edit.Object.BurnInAnnotations( 1, 2 )//Added by Appeon long.zhang 12.01.2014 (Bug 4325 # 00051117: When emailing reappt letter w/app, the received email has a blank app)
			uo_print_app.ole_edit.Object.BurnInAnnotations( 1, 0 )
		Catch(Throwable th1) 
			uo_print_app.ole_edit.Object.BurnInAnnotations( 1, 2 )
		end try
		uo_print_app.ole_edit.Object.save()
	END IF
next
	//------------------- APPEON END -------------------
	
	IF ab_skip_print THEN  //does it need to be printed??
		//---------Begin Modified by (Appeon)Stephen 10.09.2013 for bug id 3688--------
		//uo_print_app.of_save_for_faxing( i )			
		if isnull(ii_num) or ii_num = 0 then ii_num = i
		uo_print_app.of_save_for_faxing(ii_num )			
		//---------End Modfiied ------------------------------------------------------	
	ELSE  //Start Code Change ---- 11.01.2006 #1 maha
		if not cbx_app_printer.checked then
			//--------Begin Modified by  Nova 05.05.2010------------------------
			//uo_print_app.ole_edit.object.PrintImage()
			uo_print_app.ole_edit.object.PrintImage(1,uo_print_app.ole_edit.object.PageCount,3)
			//--------End Modified --------------------------------------------
	
		else
			uo_print_app.of_print_all( )	
		end if
		//End Code Change---11.01.2006
	END IF




Return 1


end function

public function integer of_print_priv_form (boolean ab_skip_print, string as_docid);//==========================================
// $<Function>Reappointment Packet Modification: of_print_priv_form()
// $<arguments>
// 	value    boolean     ab_fax : whether faxed
// $<returns> integer 1 - success; -1 - failure 
// $<description> Print privilege form
// $<add> (Appeon) Long.zhang 02.07.2012
//==========================================
//Start Code Change ----10.11.2013 #V14 maha - restructured code
Integer li_format
long li_found
Integer li_last_num_sent
Integer li_width
Integer li_cnt
Integer li_height
long li_facid
long ll_prac_id
long ll_clins[]
long ll_clins_null[]
long ll_print_rec
long ll_prac_rec
long ll_procd_id
long ll_rec
long i
long j
long k
long r
long g
long ll_row_cnt
long ll_rc
String ls_prac_name
String ls_stat
String ls_save_as
String ls_doc_id
String ls_letter_allias
String ls_tif_file
String ls_text
String ls_reqst

datastore lds_print
datastore lds_clinic
datastore lds_prac
datastore lds_data

DataWindowChild ldwc_form
DataWindowChild ldwc_1
DataWindowChild ldwc_2
DataWindowChild ldwc_3
DataWindowChild ldwc_4

appeon_pdfservice lnv_pdf
n_cst_image_functions_cp ln_to_tif
n_appeon_download lnv_downlaod

if ib_print_priv = false then return -1
ll_rec = dw_letters.rowcount( )
IF ll_rec = 0 Then return -1

lds_print = create datastore 

lds_clinic = create datastore 
lds_clinic . dataobject = "d_distinct_clin_for_prac"
lds_clinic.settransobject( sqlca)

lds_prac = create datastore
lds_prac.dataobject = "d_prac_priv_list_clin_area"
lds_prac.settransobject( sqlca)

lds_data = create datastore
lnv_pdf = Create appeon_pdfservice
ln_to_tif = create n_cst_image_functions_cp

OpenWithParm( w_appeon_gifofwait, "Printing privilege Form...")
ls_reqst = gnv_data.of_getitem( 'code_lookup','lookup_code',"code = 'REQST'")

li_found = dw_letters.find(" doc_id = '" + as_docid + "'" , 1, dw_letters.rowcount())
ll_prac_id = dw_letters.GetItemNumber( li_found, "prac_id" )
li_facid = dw_letters.GetItemNumber(li_found, "facility_id" )
	
gnv_appeondb.of_startqueue( )
	
SELECT priv_template.alt_form into :li_format   FROM facility, priv_template    WHERE  facility.priv_template = priv_template.template_id   and facility.facility_id = :li_facid;
select full_name into :ls_prac_name from v_full_name where prac_id = :ll_prac_id;
	
lds_prac.retrieve(ll_prac_id,li_facid)
lds_clinic.retrieve(ll_prac_id,li_facid )

gnv_appeondb.of_commitqueue( )
	
ll_prac_rec = lds_prac.rowcount( )
ll_clins[] = ll_clins_null[]
	
for j = 1 to lds_clinic.rowcount()
	ll_clins[UpperBound(ll_clins[]) + 1] = lds_clinic.getitemnumber( j,"clinical_area_id")
next

IF UpperBound(ll_clins[]) = 0 THEN return -1	//No data
	

Choose case li_format
		case 1
			lds_print.dataobject = "d_form_clin_priv_request_master_f2"
		case 3
			lds_print.dataobject = "d_form_clin_priv_request_master_f3"
		case 4
			lds_print.dataobject = "d_form_clin_priv_request_master_f4"
		Case 5  //Added by Appeon long.zhang 09.17.2015 (Bug # 4721 for Case #00056366 Privilege Lists)
			lds_print.dataobject =  "d_form_clin_priv_request_master_f5"	
		Case -1  //Start Code Change ----10.02.2013 #V14 maha - added f1Alt
			lds_print.dataobject =  "d_form_clin_priv_request_master_f1_alt"	
		case else   //Start Code Change ----10.02.2013 #V14 maha - changed from  ..._inova
			lds_print.dataobject =  "d_form_clin_priv_request_master_f1"
end choose
	
lds_print.settransobject( sqlca)
lds_data.dataobject = lds_print.dataobject

of_get_privform_child(lds_data,"priv_req",ldwc_1)
of_get_privform_child(lds_data,"clin_req",ldwc_2)
of_get_privform_child(lds_data,"priv_ack",ldwc_3)
of_get_privform_child(lds_data,"priv_head",ldwc_4)

for j =1 to UpperBound(ll_clins[])	//loop clinic area
	lds_print.retrieve(li_facid,ll_clins[j])
	
	//---------Begin Added by (Appeon)Stephen 04.16.2015 for V14.1 Bug # 4463 - Reappointment package is not printing the header for the privilege form--------
	ldwc_1.reset()	
	ldwc_2.reset()	
	ldwc_3.reset()	
	ldwc_4.reset()	
	//---------End Added ------------------------------------------------------
	of_get_privform_child(lds_print,"priv_req",ldwc_form)


	ll_rc = ldwc_form.rowcount( )
	for k = 1 to ll_rc	//copy dw_1
		ll_procd_id = ldwc_form.getitemnumber(k,"procd_id")
		g = 0
		g = lds_prac.find("procd_id = " + string(ll_procd_id)  + " and status_code <> " + ls_reqst,1,ll_prac_rec)
		if g > 0 then
			ls_stat = lds_prac.getitemstring(g,"code")
			ldwc_form.setitem(k,"facility_zip",ls_stat) 
		elseif g < 0 then
			messagebox("Find error in of_print_priv_form function","Contact IntelliSoft Support")
			destroy lnv_pdf
			destroy lds_print
			destroy lds_clinic
			destroy lds_prac
			destroy lds_data
			destroy ln_to_tif
			IF IsValid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
			return -1
		else
			ldwc_form.setitem(k,"facility_zip","") 
		end if
		
		if  lds_prac.find("procd_id = " + string(ll_procd_id),1,ll_prac_rec) >0 then
				ll_row_cnt = ldwc_1.rowcount( ) + 1
				ldwc_form.rowscopy( k,k,primary!,ldwc_1, ll_row_cnt,primary!)
		end if
	next
	
	ldwc_1.Modify( "prac_name.text = '" + ls_prac_name + "'" )
	
	for k= 2 to 4	//copy dw_2 dw_3 dw_4
	//	lds_print.GetChild( "dw_"+string(k), ldwc_form )
		choose case k
			case 2
				of_get_privform_child(lds_print,"clin_req",ldwc_form)	//long.zhang 07.08.2012
				ll_row_cnt = ldwc_2.rowcount( ) + 1
				ldwc_form.rowscopy( 1,ldwc_form.rowcount(),primary!,ldwc_2,ll_row_cnt,primary!)
				ldwc_2.Modify( "prac_name.text = '" + ls_prac_name + "'" )
			case 3
				//IF lds_print.dataobject <> "d_form_clin_priv_request_master_inova" and j<> 1 then Continue  //Commented by (Appeon)Stephen 04.21.2015 - V14.1 Bug # 4463 - Reappointment package is not printing the header for the privilege form
				of_get_privform_child(lds_print,"priv_ack",ldwc_form)	//long.zhang 07.08.2012
				ll_row_cnt = ldwc_3.rowcount( ) + 1
				ldwc_form.rowscopy( 1,ldwc_form.rowcount(),primary!,ldwc_3,ll_row_cnt,primary!)
				ldwc_3.Modify( "prac_name.text = '" + ls_prac_name + "'" )
			case else
				if lds_print.dataobject = "d_form_clin_priv_request_master_inova" then	exit
				
				of_get_privform_child(lds_print,"priv_head",ldwc_form) //long.zhang 07.08.2012
				if  ldwc_4.rowcount( ) < 1 then //(Appeon)Stephen 04.02.2015 - Bug # 4463 - Reappointment package is not printing the header for the privilege form
					ll_row_cnt = ldwc_4.rowcount( ) + 1
					ldwc_form.rowscopy( 1,ldwc_form.rowcount(),primary!,ldwc_4,ll_row_cnt,primary!)
				end if
				
				ldwc_4.Modify( "prac_name.text = '" + ls_prac_name + "'" )
				if of_get_app_setting("set_46","I") = 1 then
					ldwc_4.Modify( "title1.text = 'Section Chief' " )
					ldwc_4.Modify( "title2.text = 'Department Chair'" )
					ldwc_4.Modify( "title3.text = 'Credentials Committee Chair'" )
					ldwc_4.Modify( "title4.text = 'Secretary, Medical Executive Committee'" )
					ldwc_4.Modify( "title5.text = 'Secretary, Inova Health Care Services Board'" )
				end if
		end choose
	next

	ldwc_1.GroupCalc()
	
	
	IF ab_skip_print then  //Save File
			//---------Begin Modified by (Appeon)Stephen 10.09.2013 for bug id 3688--------
			/*
			ls_save_as = gs_dir_path + "intellicred\fax\priv_" + String(ll_prac_id)+"_"+String(i) +  ".pdf" 
			lnv_pdf.of_Print(lds_data,ls_save_as)
			ls_tif_file = gs_dir_path + "intellicred\fax\priv_" + String(ll_prac_id)+"_"+String(i) + ".tif"
			*/
			if isnull(ii_num) or ii_num = 0 then ii_num = i
			ls_save_as = gs_temp_path + "fax\priv_" + String(ll_prac_id)+"_"+string(j)+"_"+String(ii_num) +  ".pdf"  //(Appeon)Stephen 04.21.2015 - add '_j' V14.1 Bug # 4463 - Reappointment package is not printing the header for the privilege form
			//---------Begin Modified by (Appeon)Stephen 02.17.2014 for pdf print--------
			//lnv_pdf.of_Print(lds_data,ls_save_as)
			if gi_citrix = 1 then
				lds_data.saveas(ls_save_as, PDF!, true)
			else
				lnv_pdf.of_Print(lds_data,ls_save_as)
			end if
			//---------End Modfiied ------------------------------------------------------
			
			ls_tif_file = gs_temp_path + "fax\priv_" + String(ll_prac_id)+"_"+string(j)+"_"+String(ii_num) + ".tif"		//(Appeon)Stephen 04.21.2015 - add '_j' V14.1 Bug # 4463 - Reappointment package is not printing the header for the privilege form 	
			//---------End Modfiied ------------------------------------------------------		
			
			IF	ln_to_tif.of_pdf2tif( ls_save_as) = -1 THEN
				return -1
			END IF	
			FileDelete(ls_save_as)
	else	
			lds_data.print( false)
	end if
end for	//clinic area for loop  //Move by (Appeon)Stephen 04.16.2015 - V14.1 Bug # 4463 - Reappointment package is not printing the header for the privilege form


destroy lds_print
destroy lds_clinic
destroy lds_prac
destroy lds_data
if IsValid( lnv_pdf) then destroy lnv_pdf
if isValid(ln_to_tif) then destroy ln_to_tif

IF IsValid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
return 1

end function

public function gs_pass_ids of_get_facil_list (u_dw adw_data);long r
long f
long ll_facs[]
long ll_facil
boolean lb_add
gs_pass_ids lst_ids

ll_facs[1] = adw_data.getitemnumber(1, "facility_id")

for r = 2 to adw_data.rowcount()
	lb_add = true
	ll_facil = adw_data.getitemnumber(r, "facility_id")
	for f = 1 to upperbound(ll_facs)
		if ll_facil = ll_facs[f] then
			lb_add = false
			exit
		end if
	next
	if lb_add then ll_facs[upperbound(ll_facs) + 1] = ll_facil
next

lst_ids.i_facility_ids = ll_facs

return lst_ids

	
end function

on w_ai_print_letters.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.rb_bad=create rb_bad
this.rb_fax=create rb_fax
this.rb_email=create rb_email
this.rb_print=create rb_print
this.rb_all=create rb_all
this.dw_print1=create dw_print1
this.mle_text=create mle_text
this.cbx_app_printer=create cbx_app_printer
this.r_bar_outside=create r_bar_outside
this.cb_close=create cb_close
this.cb_print_all=create cb_print_all
this.cbx_preview=create cbx_preview
this.ole_print=create ole_print
this.dw_parent_facility=create dw_parent_facility
this.dw_address_cnt=create dw_address_cnt
this.dw_addr_mail_cnt=create dw_addr_mail_cnt
this.gb_1=create gb_1
this.r_bar=create r_bar
this.st_bar=create st_bar
this.st_apps=create st_apps
this.dw_letters=create dw_letters
this.gb_corro=create gb_corro
this.dw_corro=create dw_corro
this.gb_letters=create gb_letters
this.ddplb_filter=create ddplb_filter
this.uo_print_app=create uo_print_app
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.rb_bad
this.Control[iCurrent+3]=this.rb_fax
this.Control[iCurrent+4]=this.rb_email
this.Control[iCurrent+5]=this.rb_print
this.Control[iCurrent+6]=this.rb_all
this.Control[iCurrent+7]=this.dw_print1
this.Control[iCurrent+8]=this.mle_text
this.Control[iCurrent+9]=this.cbx_app_printer
this.Control[iCurrent+10]=this.r_bar_outside
this.Control[iCurrent+11]=this.cb_close
this.Control[iCurrent+12]=this.cb_print_all
this.Control[iCurrent+13]=this.cbx_preview
this.Control[iCurrent+14]=this.ole_print
this.Control[iCurrent+15]=this.dw_parent_facility
this.Control[iCurrent+16]=this.dw_address_cnt
this.Control[iCurrent+17]=this.dw_addr_mail_cnt
this.Control[iCurrent+18]=this.gb_1
this.Control[iCurrent+19]=this.r_bar
this.Control[iCurrent+20]=this.st_bar
this.Control[iCurrent+21]=this.st_apps
this.Control[iCurrent+22]=this.dw_letters
this.Control[iCurrent+23]=this.gb_corro
this.Control[iCurrent+24]=this.dw_corro
this.Control[iCurrent+25]=this.gb_letters
this.Control[iCurrent+26]=this.ddplb_filter
this.Control[iCurrent+27]=this.uo_print_app
end on

on w_ai_print_letters.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.rb_bad)
destroy(this.rb_fax)
destroy(this.rb_email)
destroy(this.rb_print)
destroy(this.rb_all)
destroy(this.dw_print1)
destroy(this.mle_text)
destroy(this.cbx_app_printer)
destroy(this.r_bar_outside)
destroy(this.cb_close)
destroy(this.cb_print_all)
destroy(this.cbx_preview)
destroy(this.ole_print)
destroy(this.dw_parent_facility)
destroy(this.dw_address_cnt)
destroy(this.dw_addr_mail_cnt)
destroy(this.gb_1)
destroy(this.r_bar)
destroy(this.st_bar)
destroy(this.st_apps)
destroy(this.dw_letters)
destroy(this.gb_corro)
destroy(this.dw_corro)
destroy(this.gb_letters)
destroy(this.ddplb_filter)
destroy(this.uo_print_app)
end on

event open;call super::open;Integer rc
Integer i
Long ll_verif_method
long ll_exp_cnt //maha 072808
String ls_verif_method
gs_pass_ids lstr_ids
string is_doc
string ls_doc_name  //maha 072808
long ll_recids[]

lstr_ids = Message.PowerObjectParm
This.Title = This.Title + "  ( " + lstr_ids.s_stringval + " )"
inv_printletters = CREATE pfc_n_cst_ai_printletters
is_doc_id = lstr_ids.s_ids
rc = upperbound(is_doc_id[])
idw_verif_data = lstr_ids.dw
is_from  = lstr_ids.ls_from_window //Start Code Change ----12.08.2008 #V85 maha - get value to pass to functions
il_parent = lstr_ids.facility_id 

//Start Code Change ----05.05.2011 #V11 maha - ofe processing
if lstr_ids.committee_id = 1 then
	dw_letters.dataobject = 'd_ai_print_processing_letters'
	dw_letters.settransobject(sqlca)
	ll_recids = lstr_ids.l_ids
	ib_ofe = true
end if

if ib_ofe = true then
	rc = dw_letters.Retrieve( ll_recids )
else
	rc = dw_letters.Retrieve( is_doc_id )
end if
//End Code Change ----05.05.2011 

//Start Code Change ----07.28.2008 #V85 maha - if there are expiring cred letters show the combined button
FOR i = 1 TO rc
	ls_doc_name = dw_letters.getitemstring(i,"doc_name")
	//Start Code Change ----07.12.2013 #V14 maha - modified for appointment letter settings
	//	IF PosA( Upper(ls_doc_name), "EXPIRING" ) > 0  and PosA( Upper(ls_doc_name), "EXPIRING_APPOINT" ) = 0 then //skip expiring appointment
	//		ll_exp_cnt++
	//	End if	
	IF PosA( Upper(ls_doc_name), "EXPIRING" ) > 0  then
		if dw_letters.getitemnumber( i , "screen_id") = 1 then
			ib_exp_appt = true
		else
			ll_exp_cnt++
		end if
//		choose case upper(mid(ls_doc_name ,1 ,15 ))
//			case  "IND_EXPIRING_APPOIN" , "IND_EXPIRING_PROVIS", "IND_EXPIRING_ALLIED"
//				ib_exp_appt = true
//			case else
//				ll_exp_cnt++
//		end choose
	End if	
	//End Code Change ----07.12.2013
	if ib_ofe = true then
		if isnull(ls_doc_name) or ls_doc_name = '' then
			dw_letters.setitem(i,"doc_name",dw_letters.getitemstring(i,"letter_alias"))
		end if
	end if
next



//Start Code Change ----07.12.2013 #V14 maha - for setting to show printer checkbox
select count(facility_id)into :i from facility where reap_use_app = 1;
if i < 1 then ib_exp_appt = false
if ib_exp_appt = true then 
	cbx_app_printer.visible = true
else
	cbx_app_printer.visible = false
end if
//End Code Change ----07.12.2013

If ll_exp_cnt > 0 then 
	dw_letters.object.datawindow.header.height = 180
end if
//End Code Change---07.28.2008

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.23.2006 By: Jervis
//$<reason> print Correspondence
if gb_workflow then
	rc = upperbound(lstr_ids.s_doc_ids)
	if rc > 0 then
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 10/25/2007 By: Ken.Guo
		//$<reason> For web performance
		dw_corro.Retrieve(lstr_ids.s_doc_ids)
		/* Evan 02.06.2009
		If appeongetclienttype() = 'WEB' Then
			If ln_cst_array_db_case.of_array_to_db(lstr_ids.s_doc_ids[], ls_client_id) < 0 Then
				messagebox('Information','Failed to generate letter data, please call support.')
				Destroy ln_cst_array_db_case
				Return				
			End If
			dw_corro.dataobject = 'd_ai_print_corro_web'
			dw_corro.SetTransObject(SQLCA)	
			gnv_appeondb.of_startqueue()
			dw_corro.Retrieve( ls_client_id )
			ln_cst_array_db_case.of_delete_temp_data(ls_client_id)
			gnv_appeondb.of_commitqueue()					
		Else
			dw_corro.Retrieve(lstr_ids.s_doc_ids[])
		End If
		*/
		//---------------------------- APPEON END ----------------------------
		dw_letters.height = gb_corro.y - gb_letters.y - 80
		gb_letters.height = gb_corro.y - gb_letters.y
		uo_print_app.height = dw_letters.height
		
		gb_corro.visible = true
		dw_corro.visible = true
		dw_corro.bringtotop = true
	end if
end if
//---------------------------- APPEON END ----------------------------


//------------------- APPEON BEGIN -------------------
//$<add> Kater 03.28.2011
//$<reason> Bring to Top dialog "Invalid Merge Field"
inv_appeondll.of_BringTopMergeFieldDlg (1)
//------------------- APPEON END ---------------------


//If isvalid(ln_cst_array_db_case) Then Destroy ln_cst_array_db_case //Evan 02.06.2009



end event

event close;call super::close;//idw_verif_data.SetFilter( "" )
//idw_verif_data.Filter( )

//------------------- APPEON BEGIN -------------------
//$<add> Kater 03.28.2011
//$<reason> Bring to Top dialog "Invalid Merge Field"
inv_appeondll.of_BringTopMergeFieldDlg (0)
//------------------- APPEON END ---------------------
end event

type cbx_1 from checkbox within w_ai_print_letters
integer x = 2034
integer y = 96
integer width = 375
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "View Details"
end type

event clicked;//Start Code Change ----07.15.2013 #V14 maha
if this.checked then
	dw_letters.object.datawindow.detail.height = 76
else
	dw_letters.object.datawindow.detail.height = 0
end if
	
end event

type rb_bad from radiobutton within w_ai_print_letters
integer x = 1129
integer y = 96
integer width = 782
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Insufficient Contact  Info"
end type

event clicked;of_filter_by_type()
end event

type rb_fax from radiobutton within w_ai_print_letters
integer x = 859
integer y = 96
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Fax"
end type

event clicked;of_filter_by_type()
end event

type rb_email from radiobutton within w_ai_print_letters
integer x = 571
integer y = 96
integer width = 270
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Email"
end type

event clicked;of_filter_by_type()
end event

type rb_print from radiobutton within w_ai_print_letters
integer x = 311
integer y = 96
integer width = 279
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Print"
end type

event clicked;of_filter_by_type()
end event

type rb_all from radiobutton within w_ai_print_letters
integer x = 87
integer y = 96
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "All"
boolean checked = true
end type

event clicked;of_filter_by_type()
end event

type dw_print1 from u_dw within w_ai_print_letters
boolean visible = false
integer x = 1609
integer y = 2076
integer width = 521
integer height = 932
integer taborder = 30
end type

type mle_text from multilineedit within w_ai_print_letters
boolean visible = false
integer x = 3319
integer y = 376
integer width = 411
integer height = 324
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "none"
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_app_printer from checkbox within w_ai_print_letters
boolean visible = false
integer x = 2034
integer y = 164
integer width = 722
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Change Application Printer"
end type

type r_bar_outside from rectangle within w_ai_print_letters
boolean visible = false
integer linethickness = 4
long fillcolor = 80269524
integer x = 2112
integer y = 1696
integer width = 1015
integer height = 60
end type

type cb_close from u_cb within w_ai_print_letters
integer x = 2734
integer y = 76
integer height = 84
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10/25/2007 By: Ken.Guo
//$<reason> Destroy temp data
n_cst_array_db ln_cst_array_db_case
If UpperBound(is_client_id_arr[]) > 0 Then
	ln_cst_array_db_case = Create n_cst_array_db
	ln_cst_array_db_case.of_delete_temp_data(is_client_id_arr[])
	Destroy ln_cst_array_db_case
End If
//---------------------------- APPEON END ----------------------------
Close( Parent )
end event

type cb_print_all from u_cb within w_ai_print_letters
boolean visible = false
integer x = 1742
integer y = 2148
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Print All"
end type

event clicked;//////updated 051501 maha
//Integer li_error = 0
//Integer li_rc
//integer li_row_cnt
//Integer i
//integer r
//Integer li_facility_id
//Integer li_address_cnt
//Integer li_parent_id
//Long ll_prac_id
//Boolean lb_print_preview
//Boolean lb_print_release = False
//Boolean lb_print_priv = False
//String ls_doc_name
//String ls_sql
//string ls_doc_check
//String ls_facility_name
//String is_clear_id[]
//integer pos //maha 121900
//string doctest
//
//dw_letters.AcceptText()
//
//
//li_row_cnt = dw_letters.RowCount()
//
//IF li_row_cnt = 0 THEN
//	MessageBox("Print", "No letters to print.", Information! )
//	Return -1
//END IF
//
//for r = 1 to li_row_cnt
//
//	IF dw_letters.GetItemNumber( r, "print_status" ) = 1  THEN
//		continue
//	END IF
//	IF dw_letters.GetItemNumber( r, "print_release" ) = 1  THEN
//		lb_print_release = True
//	END IF
//	
//	IF dw_letters.GetItemNumber( r, "print_priv" ) = 1  THEN
//		lb_print_priv = True
//	END IF
//	
//	ls_doc_name = dw_letters.GetItemString( r, "doc_name" )
//	//\/maha 121900 for pix second verification letter
//	if dw_letters.GetItemnumber( r, "verif_info_verification_id" ) = 2 then
//		pos = Pos( Upper(ls_doc_name), ".DOC" )
//		pos = pos - 1
//		ls_doc_name = Mid ( ls_doc_name, 1 , pos) + "_cc.doc"
//	end if
//	//\maha
//	if ls_doc_check = ls_doc_name then 
//		continue
//	else
//		ls_doc_check = ls_doc_name
//	end if
//	IF dw_letters.GetItemNumber( r, "ctotal_letters" ) = 0 THEN
//		MessageBox("Invalid Selection", "All letters for selected letter type have been printed.")
//		Return -1
//	END IF
//	
//	dw_letters.SetRow(r)
//	
//	IF cbx_preview.Checked THEN
//		lb_print_preview = True
//	ELSE
//		lb_print_preview = False
//	END IF
//	
//	li_rc = dw_letters.RowCount()
//	
//	is_doc_id[] = is_clear_id[]
//	
//	dw_parent_facility.SetTransObject( SQLCA )
//	dw_address_cnt.SetTransObject( SQLCA )
//	dw_addr_mail_cnt.SetTransObject( SQLCA )
//	FOR i = 1 TO li_rc
//		li_facility_id = dw_letters.GetItemNumber( i, "facility_id" )
//		SELECT facility.facility_name  
//		INTO :ls_facility_name  
//		FROM facility  
//		WHERE facility.facility_id = :li_facility_id   ;
//		//\/maha 011801
//		doctest = dw_letters.GetItemString( i, "doc_name" )
//		if dw_letters.GetItemnumber( i, "verif_info_verification_id" ) = 2 then
//			pos = Pos( Upper(doctest), ".DOC" )
//			pos = pos - 1
//			doctest = Mid ( doctest, 1 , pos) + "_cc.doc"
//		end if
//			//\maha
//		IF   doctest = ls_doc_name THEN			//line changed 011801 maha
//			ll_prac_id = dw_letters.GetItemNumber( i, "prac_id" )
//			
//			//the following code rechanged 111300 from that of 101000 maha
//			IF Pos( Upper(ls_doc_name), "EXPIRING" ) > 0 THEN
//				//expiring cred letters addr link check
//				if Pos( Upper(ls_doc_name), "EXPIRING_APPOINT" ) < 1 then //not expiring appointment
//					dw_parent_facility.Retrieve( ll_prac_id, li_facility_id )
//					IF dw_parent_facility.RowCount() > 0 THEN   //there might still be an issue if this returns more than 1 row 111300 maha
//						li_parent_id = dw_parent_facility.GetItemNumber( 1, "parent_facility_id" )
//					ELSE
//						li_parent_id = 0
//					END IF
//					li_address_cnt = 0
//					dw_address_cnt.Retrieve( ll_prac_id)
//					IF dw_address_cnt.RowCount() > 0 THEN
//						li_address_cnt = dw_address_cnt.GetItemNumber( 1, "address_cnt" )
//					ELSE
//						li_address_cnt = 0
//					END IF
//					IF li_address_cnt < 1 THEN
//						MessageBox("Expiring Letter", "Check the address link screen to see that Practitioner ID " + String( ll_prac_id ) + " has an expiring letter address link selected for each affiliated facility")
//						li_error = 1
//					END IF
//				ELSE
//			
//				//\/maha 011300  expiring appt letters addr link check
//					li_address_cnt = 0
//					dw_addr_mail_cnt.Retrieve( ll_prac_id, li_facility_id ) //dw changed 032101 maha to check mailing address
//					IF dw_addr_mail_cnt.RowCount() > 0 THEN
//						li_address_cnt = dw_addr_mail_cnt.GetItemNumber( 1, "address_cnt" )
//					ELSE
//						li_address_cnt = 0
//					END IF
//					IF li_address_cnt < 1 THEN
//						MessageBox("Expiring Letter", "The Practitioner with the ID of " + String( ll_prac_id ) + " does not have a practitioner correspondence address setup in the address link window for the " + ls_facility_name + " facility.")
//						li_error = 1
//					END IF
//					//\maha
//				END IF
//			END IF
//			is_doc_id[ i ] = dw_letters.GetItemString( i, "doc_id" )
//		END IF
//	END FOR
//	
//	debugbreak()
//	//IF li_error = 1 THEN
//	//	Return
//	//END IF
//	//messagebox("",dw_letters.GetItemString( row, "doc_name" ))
//	ls_sql = dw_letters.GetItemString( r, "ver_ltr_sql" )	
//	inv_printletters.of_printletters( is_doc_id[], "S", +&
//					dw_letters.GetItemString( r, "letter" ), +&
//					Upper(Left(dw_letters.GetItemString( r, "letter_style1" ),1)), +&
//					idw_verif_data,ls_doc_name, lb_print_preview, ls_sql ) //maha 121900 replaced:dw_letters.GetItemString( row, "doc_name" )with ls_doc nam
//				
//end for
//				
end event

type cbx_preview from checkbox within w_ai_print_letters
boolean visible = false
integer x = 2034
integer y = 16
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Print Preview"
boolean checked = true
end type

type ole_print from olecustomcontrol within w_ai_print_letters
event keydown ( ref integer keycode,  integer shift )
event keyup ( ref integer keycode,  integer shift )
event keypress ( ref integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  ref string description,  long scode,  string source,  string helpfile,  long helpcontext,  ref boolean canceldisplay )
event ocx_close ( )
event markend ( long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event toolselected ( integer toolid )
event selectionrectdrawn ( long left,  long top,  long ocx_width,  long ocx_height )
event tooltip ( integer index )
event toolpalettehidden ( long left,  long top )
event scroll ( )
event markselect ( integer button,  integer shift,  long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event pastecompleted ( )
event load ( double zoom )
event markmove ( integer marktype,  string groupname )
event pagepropertiesclose ( )
event checkcontinueprinting ( long pagesprinted,  long currentpage,  integer status )
event hyperlinkgotopage ( long page )
event errorsavingundoinformation ( long ocx_error )
event straightenpage ( )
event hyperlinkgotodoc ( string link,  long page,  ref boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( ref long mode )
event baddocumentfiletype ( long page,  ref boolean errorout,  ref boolean skippage,  ref boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( ref string overlayfilename,  ref boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event readystatechange ( long readystate )
boolean visible = false
integer x = 1042
integer y = 2100
integer width = 466
integer height = 144
integer taborder = 70
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
string binarykey = "w_ai_print_letters.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type dw_parent_facility from u_dw within w_ai_print_letters
boolean visible = false
integer x = 2235
integer y = 2088
integer width = 165
integer height = 136
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_get_parent_facility"
end type

type dw_address_cnt from u_dw within w_ai_print_letters
boolean visible = false
integer x = 2450
integer y = 2084
integer width = 169
integer height = 136
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_get_address_cnt"
end type

type dw_addr_mail_cnt from u_dw within w_ai_print_letters
boolean visible = false
integer x = 2729
integer y = 2084
integer width = 169
integer height = 136
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_get_mail_address_cnt"
end type

type gb_1 from groupbox within w_ai_print_letters
integer x = 27
integer y = 28
integer width = 1902
integer height = 176
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Process Method Ability Filter"
end type

type r_bar from rectangle within w_ai_print_letters
boolean visible = false
long linecolor = 80269524
integer linethickness = 4
long fillcolor = 255
integer x = 2117
integer y = 1700
integer width = 1006
integer height = 52
end type

type st_bar from statictext within w_ai_print_letters
boolean visible = false
integer x = 1623
integer y = 1700
integer width = 480
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Processing Records"
boolean focusrectangle = false
end type

type st_apps from statictext within w_ai_print_letters
integer y = 1684
integer width = 1637
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_letters from u_dw within w_ai_print_letters
integer x = 73
integer y = 280
integer width = 3008
integer height = 1356
integer taborder = 10
string dataobject = "d_ai_print_all_letters_asa"
boolean hscrollbar = true
end type

event constructor;//Start Code Change ---- 12.20.2007 #V8 maha
if gs_dbtype = "ASA" then
	this.dataobject = "d_ai_print_all_letters_asa"
elseif gs_dbtype = "SQL" then
	this.dataobject = "d_ai_print_all_letters"
end if

This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )

end event

event buttonclicked;
if Row < 1 then return //add Michael 01.09.2011 Invalid DataWindow row/column specified	
//Start Code Change ----07.28.2008 #V85 maha
IF dwo.name = "print_it" or  dwo.name = "b_all_cred" then
	Integer li_error = 0
	Integer li_rc
	Integer li_retval
	Integer i
	integer pos //maha 121900
	Integer li_address_cnt
	integer li_screen //maha - 03.07.2012
	long ck //maha072508
	long cnt //maha080508
	long li_parent_id
	long li_facility_id
	long ll_addr_test //maha 080508
	long ll_prac_comb[] //maha 080508
	Long ll_prac_id
	long ll_row  //maha 021008
	Boolean lb_print_preview
	Boolean lb_print_release = False
	Boolean lb_print_priv = False
	boolean lb_combined = false //maha 061708
	String ls_print_rule
	String ls_sql
	String ls_doc_name
	String ls_letter_allias
	string ls_let_name //maha 033108
	String ls_facility_name
	String ls_combined_path //maha072409
	String ls_facility_path  //072409
	String is_clear_id[]
	string ls_ext_data = "#"
	string ls_style //maha changed variable name 061308
	string doctest
	string ls
	string ls_filter 
	string ls_error = "LETTER ERRORS:"  //maha080508
	string ls_from //maha 120808
	gs_pass_ids lst_ids  //maha 10.19.2016

	
	Long ll_pracids[]  //maha 040903 for use with export
	//----------------------------APPEON BEGIN------------------
	//$<add> long.zhang 02.07.2011
	//$<Reason>Reappointment Packet Modification
	Long ll_reap_letter
	Long ll_reap_app
	Long ll_reap_priv
	//----------------------------APPEON END--------------------
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-06
	//$<add> 02.20.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Define the datastores for caching data.
	LONG ll_arr_prac_id[]
	DataStore lds_parent_facility
	DataStore lds_address_cnt
	DataStore lds_addr_mail_cnt
	String ls_doc_id  //Ken.Guo 10/31/2007
	
	SetPointer(HourGlass!)
	//---------------------------- APPEON END ----------------------------
	
	This.AcceptText()
	//debugbreak()
	ls_from = is_from  //Start Code Change ----08.34.2011 #V11 maha - was not coded previously
	ll_reap_letter = -1 //added by long.zhang 02.08.2012 Reappointment Packet Modification
	
	if dwo.name = "b_all_cred" then //#@#@#@#@##@#@#@#@
		ll_row = row
		//Start Code Change ----02.10.2009 #V92 maha - combined exp cred function - moved from below
		ls_ext_data = "E"
		lb_combined = true
		ls_doc_name = "ind_expiring_cred_combined_letter.doc"
		ls_let_name = "Expiring Credential Combined"

	else
	
		IF This.GetItemNumber( row, "print_release" ) = 1  THEN
			lb_print_release = True
		END IF
		
		IF This.GetItemNumber( row, "print_priv" ) = 1  THEN
			lb_print_priv = True
		END IF
		
		ls_letter_allias = This.GetItemString( row, "letter_alias" )
		ls = This.GetItemString( row, "letter_name" )
		li_screen = This.GetItemnumber( row, "screen_id" ) //Start Code Change ----03.07.2012 #V12 maha 
		
		ls_doc_name = This.GetItemString( row, "doc_name" )
		//if isnull(ls_doc_name) then ls_doc_name = ls_letter_allias
		
		//Start Code Change ----03.31.2008 #V8 maha - moved from of_buttonclicked
		if dw_letters.getitemstring( row, "letter_style" ) =  "P" then  //if correspondence letter
			ls_let_name = dw_letters.GetItemString( row, "letter_alias" )
		else
			ls_let_name = dw_letters.GetItemString( row, "letter" )
		end if
		
		ll_row = row
		//End Code Change---03.31.2008
	end if	

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 07.05.2006 By: LeiWei
	//$<reason> Check word templete storage type
	Integer li_word_storage_type
	li_word_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "set_50", FALSE))
	IF Isnull(li_word_storage_type) THEN li_word_storage_type = 0
	
	IF Upper( AppeonGetClientType() ) = "PB" AND li_word_storage_type = 0 THEN //if stored on hard drive add path
		ls_doc_name = This.GetItemString( ll_row, "facility_letter_path" ) + ls_doc_name
	END IF
	//---------------------------- APPEON END ----------------------------
	
	li_facility_id = This.GetItemNumber( ll_row, "facility_id" )
	
	//Start Code Change ----10.19.2016 #V152 maha
	if lb_combined then //see if there are multiple facilities letters
		ls_filter = "facility_id <> " + string(li_facility_id)
		li_retval = this.find( ls_filter, row + 1, this.rowcount())
		if li_retval > 0 then
			lst_ids = of_get_facil_list(this)
			lst_ids.ls_from_window = "L"
			
			openwithparm(w_select_facility_from_passed_list, lst_ids)
			li_facility_id = message.doubleparm
			if li_facility_id = 0 then
				return
			else
				//use the selected facility
			end if	
		end if
	end if
	//End Code Change ----10.19.2016
	
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-07
	//$<add> 01.17.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> 1)Copy the script from PT-12 here.
	//$<modification> 2)Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	 if not lb_combined then  //skip if combined letter
		gnv_appeondb.of_startqueue( )
		
		SELECT facility.facility_name  //select moved from beginning of if maha 040903
		INTO :ls_facility_name  
		FROM facility  
		WHERE facility.facility_id = :li_facility_id; 
		
		//------------------Appeon Begin----------------------------
			//$<Modified> long.zhang 02.07.2012
			//$<Reason>Reappointment Packet Modification
		IF ls_letter_allias = "Expiring Appointment Letter"  THEN
			//SELECT ia_reapp_ai_process, ia_reapp_app
			//INTO: ls_print_rule,
			// : il_app_id 
			//FROM facility
			//WHERE facility_id = :li_facility_id;
			SElECT   reap_use_letter,reap_use_app,reap_use_privform,ia_reapp_app 
			INTO :ll_reap_letter,:ll_reap_app,:ll_reap_priv,:il_app_id
			FROM facility
			WHERE  facility_id = :li_facility_id;
			
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("SQL ERROR", SQLCA.SQLERRTEXT )
				Return -1
			END IF
	
		elseif ls_letter_allias = "Expiring Provisional Letter" then
	//		SELECT ia_reapp_ai_process, prov_app_id
//			INTO: ls_print_rule,
//				 : il_app_id 
//			FROM facility
//			WHERE facility_id = :li_facility_id;
			SElECT   reap_use_letter,reap_use_app,reap_use_privform,prov_app_id 
			INTO :ll_reap_letter,:ll_reap_app,:ll_reap_priv,:il_app_id
			FROM facility
			WHERE  facility_id = :li_facility_id;	
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("SQL ERROR", SQLCA.SQLERRTEXT )
				Return -1
			END IF

		elseif ls_letter_allias = "Expiring Allied Health Letter"  then
//			SELECT ia_reapp_ai_process, reappah_app_id
//			INTO: ls_print_rule,
//				 : il_app_id 
//			FROM facility
//			WHERE facility_id = :li_facility_id;
			SElECT   reap_use_letter,reap_use_app,reap_use_privform,reappah_app_id 
			INTO :ll_reap_letter,:ll_reap_app,:ll_reap_priv,:il_app_id
			FROM facility
			WHERE  facility_id = :li_facility_id;	
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("SQL ERROR", SQLCA.SQLERRTEXT )
				Return -1
			END IF
		END IF
		
		if ll_reap_letter = 0 and ll_reap_app = 0 and ll_reap_priv = 0 then ll_reap_letter = 1 //Start Code Change ----06.26.2012 #V12 maha - added trap to default to letter if nothing is checked
	//------------------APPEON END----------------------------	
		gnv_appeondb.of_commitqueue( )

	//---------------------------- APPEON END ----------------------------
		//messagebox("buttonclicked event test message", "ls_doc_name = " + ls_doc_name + " ; ls_let_name = " + ls_let_name)	
		doctest = This.GetItemString( row, "init_veif_letter_doc_nm" )
		//Start Code Change ---- 03.27.2006 #346 maha
			//Start Code Change ---- 05.17.2006 #455 maha changed from field letter to letter_name
		//Start Code Change ----07.20.2009 #V92 maha	 - changed test variable from ls_doc_name to ls_let_name
		//IF Pos( Upper(ls_doc_name), "EXPIRING" ) < 1  and this.GetItemstring( row, "letter_name") <> "Basic Information" then
		//if not an expiring letter and no a correspondence letter check for a verification letter name.
		IF PosA( Upper(ls_let_name), "EXPIRING" ) < 1  and this.GetItemstring( row, "letter_name") <> "Basic Information" then
			if isnull(doctest) or doctest = "" then
				messagebox("Data Error","There is no verification letter name set up for the " + ls_letter_allias + " Screen in the facility painter for the " + ls_facility_name + " facility.")
				return -1
			end if
		end if

	//	//Start Code Change ----- combined exp cred function - 02102008 moved higher in code
	//	if dwo.name = "b_all_cred" then
	//		ls_ext_data = "E"
	//		lb_combined = true
	//	end if
	//	//End Code Change---06.13.2008
		
		//End Code Change---03.27.2006
		//\/maha 121900 for pix second verification letter
		if This.GetItemnumber( row, "verif_info_verification_id" ) = 2 then
			pos = PosA( Upper(ls_doc_name), ".DOC" )
			pos = pos - 1
			ls_doc_name = MidA ( ls_doc_name, 1 , pos) + "_cc.doc"
		end if
		//\maha
		IF This.GetItemNumber( row, "ctotal_letters" ) = 0 THEN
			MessageBox("Invalid Selection", "All letters for selected letter type have been printed.")
			Return -1
		END IF
		
		This.SetRow(row)
	end if  // not combined
	
	IF cbx_preview.Checked THEN
		lb_print_preview = True
	ELSE
		lb_print_preview = False
	END IF
	
	li_rc = This.RowCount()
	
	is_doc_id[] = is_clear_id[]
	
	//maha -  note: these are redundant and not used 080508
	dw_parent_facility.SetTransObject( SQLCA )
	dw_address_cnt.SetTransObject( SQLCA )
	dw_addr_mail_cnt.SetTransObject( SQLCA )
	//\ maha
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-08
	//$<add> 01.17.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> 1)Use datastores to cache data from database. Refer to PT-10 for more information.
	//$<modification> 2)Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	FOR i = 1 TO li_rc
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 10/26/2007 By: Ken.Guo
		//$<reason> Suppress repeating values, For retrieve performance.
		//ll_arr_prac_id[i] = This.GetItemNumber( i, "prac_id" )
		If i = 1 Then
			ll_arr_prac_id[UpperBound(ll_arr_prac_id) + 1] = This.GetItemNumber( i, "prac_id" )
		Else
			If ll_arr_prac_id[UpperBound(ll_arr_prac_id)] <> This.GetItemNumber( i, "prac_id" ) Then
				ll_arr_prac_id[UpperBound(ll_arr_prac_id) + 1] = This.GetItemNumber( i, "prac_id" )
			End If
		End If
		//---------------------------- APPEON END ----------------------------
	NEXT
		
	lds_parent_facility = Create DataStore  //maha - 080508 appears this has no functionality attached
	lds_parent_facility.DataObject = "d_get_parent_facility_all_forpt"
	lds_parent_facility.settransobject( SQLCA )
	
	lds_address_cnt = Create DataStore
	lds_address_cnt.DataObject = "d_get_address_cnt_all_forpt"
	lds_address_cnt.settransobject( SQLCA )
	
	lds_addr_mail_cnt = Create DataStore
	lds_addr_mail_cnt.DataObject = "d_get_mail_address_cnt_all_forpt"
	lds_addr_mail_cnt.settransobject( SQLCA )
	
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 10/25/2007 By: Ken.Guo
	//$<reason>  For web performance
	gnv_appeondb.of_startqueue()
	lds_parent_facility.Retrieve( ll_arr_prac_id[], li_facility_id )
	lds_address_cnt.Retrieve( ll_arr_prac_id[] )
	lds_addr_mail_cnt.Retrieve( ll_arr_prac_id[], li_facility_id )
	gnv_appeondb.of_commitqueue()
	/* Evan 02.06.2009
	n_cst_array_db ln_cst_array_db_case
	If AppeonGetclientType() = 'WEB' Then
		If is_client_id = '' Then
			ln_cst_array_db_case = Create n_cst_array_db
			If ln_cst_array_db_case.of_array_to_db(ll_arr_prac_id[], is_client_id) < 0 Then
				messagebox('Information','Failed to generate letter data, please call support.')
				Destroy ln_cst_array_db_case
				Return
			End If
		End If
		lds_parent_facility.DataObject = "d_get_parent_facility_all_forpt_web"
		lds_address_cnt.DataObject = "d_get_address_cnt_all_forpt_web"
		lds_addr_mail_cnt.DataObject = "d_get_mail_address_cnt_all_forpt_web"
		lds_parent_facility.settransobject( SQLCA )
		lds_address_cnt.settransobject( SQLCA )
		lds_addr_mail_cnt.settransobject( SQLCA )
		
		gnv_appeondb.of_startqueue()
		lds_parent_facility.Retrieve(is_client_id, li_facility_id )
		lds_address_cnt.Retrieve(is_client_id ) //maha 072808 - may want to change how this works, need exception for combined letters
		lds_addr_mail_cnt.Retrieve(is_client_id, li_facility_id )
		is_client_id_arr[2] = is_client_id
		gnv_appeondb.of_commitqueue()
	Elseif  lb_combined = true then 
		lds_address_cnt.Retrieve( ll_arr_prac_id[] )
	Else
		gnv_appeondb.of_startqueue()
		lds_parent_facility.Retrieve( ll_arr_prac_id[], li_facility_id )
		lds_address_cnt.Retrieve( ll_arr_prac_id[] )
		lds_addr_mail_cnt.Retrieve( ll_arr_prac_id[], li_facility_id )
		gnv_appeondb.of_commitqueue()
	End If
	Destroy ln_cst_array_db_case
	*/
	//---------------------------- APPEON END ----------------------------


	//---------------------------- APPEON END ----------------------------
	//Start Code Change ----08.05.2008 #V85 maha
	IF lb_combined = true then
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	
		//write code to get all the docids for expiring letters
		ll_addr_test = lds_address_cnt.rowcount()
		FOR i = 1 TO li_rc
			//get the list of all prac ids for expiring cred letters
			ls_doc_name = This.GetItemString( i, "doc_name" )
			IF PosA( Upper(ls_doc_name), "EXPIRING" ) > 0  THEN
				if PosA( Upper(ls_doc_name), "EXPIRING_APPOINT" ) > 0 then continue //skip expiring appointment
				//get the list of providers and doc_ids 
				ll_prac_id = This.GetItemNumber( i, "prac_id" )
				if li_facility_id <> This.GetItemNumber( i, "facility_id" ) then continue		//skip if facility does not match	
				//check for existing address data
				ck = lds_address_cnt.find( "prac_id = " + String(ll_prac_id), 1, ll_addr_test)
				if ck < 0 then
					messagebox("Find error in buttonclicked event","Combined letter code. Contact Support.")
				elseif ck = 0 then
					ls_error+= "Check the Address link screen to see that Practitioner ID " + String( ll_prac_id ) + " has an Active Expiring Letter address link selected."
				else  //if the prac has proper address data add to arrays
					cnt++
					//add to prac array
					//Start Code Change ----07.24.2009 #V92 maha
					if LenA(ls_facility_path) = 0 then  //if not stored in the database get the directory path; only do it once
						ls_facility_path = This.GetItemString( i, "facility_letter_path" )	
					end if
					//End Code Change---07.24.2009
					if  of_prac_in_array(ll_pracids, ll_prac_id) = 0 then
						ll_pracids[upperbound(ll_pracids) + 1]  = ll_prac_id
					end if
					//add to docid array
					ls_doc_id = This.GetItemString( i, "doc_id" )
					If ls_doc_id <> '' and not isnull(ls_doc_id) Then
						is_doc_id[UpperBound(is_doc_id[]) + 1 ] = ls_doc_id
					end if
				end if
			End if		
		Next
		//report errors
		if LenA(ls_error) > 16 then openwithparm(w_sql_msg,ls_error)
		//if no providers then return
		If cnt = 0 then
			messagebox("Print Letters","No letters printed.")
			return 
		end if
		//End Code Change---08.05.2008	

	ELSE //individual letters
		debugbreak()	
		FOR i = 1 TO li_rc
			
			if li_facility_id <> This.GetItemNumber( i, "facility_id" ) then continue		//Add By Jervis 10-07-2008:skip if facility does not match	
			
			doctest = This.GetItemString( i, "doc_name" )
		
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 07.05.2006 By: LeiWei
			//$<reason> Check word templete storage type
			IF Upper( AppeonGetClientType() ) = "PB" AND li_word_storage_type = 0 THEN
				doctest = This.GetItemString( row, "facility_letter_path" ) + doctest
			END IF
		
			if This.GetItemnumber( i, "verif_info_verification_id" ) = 2 then //this tests to see if the verification was set up as duplicate letter
				pos = PosA( Upper(doctest), ".DOC" )
				pos = pos - 1
				doctest = MidA ( doctest, 1 , pos) + "_cc.doc"
			end if
				
			IF   doctest = ls_doc_name THEN			
				li_error = 0 //resetting error variable
				ll_prac_id = This.GetItemNumber( i, "prac_id" )
				
				
				IF PosA( Upper(ls_doc_name), "EXPIRING" ) > 0  THEN
					//expiring cred letters addr link check
					if PosA( Upper(ls_doc_name), "EXPIRING_APPOINT" ) < 1 then //Expiring credentials
		
						//maha - 080508 appears to have no function
						lds_parent_facility.SetFilter( "prac_id = " + String(ll_prac_id))
						lds_parent_facility.Filter()
						IF lds_parent_facility.RowCount() > 0 THEN   //there might still be an issue if this returns more than 1 row 111300 maha
							li_parent_id = lds_parent_facility.GetItemNumber( 1, "parent_facility_id" )
						ELSE
							li_parent_id = 0
						END IF
						//\maha
						
						li_address_cnt = 0
						
						lds_address_cnt.SetFilter( "prac_id = " + String(ll_prac_id))
						lds_address_cnt.Filter()
						IF lds_address_cnt.RowCount() > 0 THEN
							li_address_cnt = lds_address_cnt.GetItemNumber( 1, "address_cnt" )
						ELSE
							li_address_cnt = 0
						END IF
			
						IF li_address_cnt < 1 THEN			
							MessageBox("Expiring Letter", "Check the Address link screen to see that Practitioner ID " + String( ll_prac_id ) + " has an Active Expiring Cred address link selected.")
							li_error = 1
						END IF
					ELSE //Exp Appt letter
						li_address_cnt = 0
		
						lds_addr_mail_cnt.SetFilter( "prac_id = " + String(ll_prac_id))
						lds_addr_mail_cnt.Filter()
						IF lds_addr_mail_cnt.RowCount() > 0 THEN
							li_address_cnt = lds_addr_mail_cnt.GetItemNumber( 1, "address_cnt" )
						ELSE
							li_address_cnt = 0
						END IF
						IF li_address_cnt < 1 THEN
							MessageBox("Expiring Letter", "The Practitioner with the ID of " + String( ll_prac_id ) + " does not have an Active Mailing address setup in the address link window for the " + ls_facility_name + " facility.")
							li_error = 1
						END IF
						//\maha
					END IF
				END IF
				IF li_error = 0 THEN //if error = 1 don't add to arrays
					//--------------------------- APPEON BEGIN ---------------------------
					//$<modify> 10/26/2007 By: Ken.Guo
					//$<reason>  For Performance
					/*
					is_doc_id[ i ] = This.GetItemString( i, "doc_id" )
					ll_pracids[ i ] = ll_prac_id		
					*/
					ls_doc_id = This.GetItemString( i, "doc_id" )
					If ls_doc_id <> '' and not isnull(ls_doc_id) Then
						is_doc_id[UpperBound(is_doc_id[]) + 1 ] = This.GetItemString( i, "doc_id" )
					End If
					If UpperBound(ll_pracids[]) = 0 Then
						ll_pracids[UpperBound(ll_pracids[]) + 1 ] = ll_prac_id
					Else
						If ll_pracids[UpperBound(ll_pracids[])] <> ll_prac_id Then
							ll_pracids[UpperBound(ll_pracids[]) + 1 ] = ll_prac_id
						End If
					End If
					//---------------------------- APPEON END ----------------------------		
		
				end if
			END IF
		END FOR
		
	END IF //combined

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-11
	//$<add> 02.20.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Destroy datastores to release memory.
	Destroy lds_parent_facility
	Destroy lds_address_cnt
	Destroy lds_addr_mail_cnt
	//---------------------------- APPEON END ----------------------------
	
	if This.getitemstring( row, "letter_style" ) =  "P" then  //maha changed to variable 081601
		ls_style = "P"  //corresp letter
	elseif lb_combined = true then  //Start Code Change ----07.28.2008 #V85 maha - new style setting
		ls_style = "E"  //Combined exp cred
	else
	//	ls_style = "I" 
		ls_style = Upper(LeftA(This.GetItemString( row, "letter_style1" ),1))
	end if
	
	//Start Code Change ----05.05.2011 #V11 maha - process tracking
	if ib_ofe then
		ls_style = "OFE"
		ls_let_name = string(This.getitemnumber( row, "document_id" ))
	end if
	//End Code Change ----05.05.2011
	
	ls_sql = This.GetItemString( row, "ver_ltr_sql" )
	

	
	//------------------Appeon Begin----------------------------
		//$<Modified> long.zhang 02.07.2012
		//$<Reason>Reappointment Packet Modification
//		IF Upper( ls_print_rule ) = "PRINTAPP" THEN
//			ib_print_letter = False		
//			ib_print_app = True
//		ELSEIF Upper( ls_print_rule ) = "PRINTBOTH" THEN
//			ib_print_app = True
//		END IF
		IF ll_reap_letter = 1 THEN
			ib_print_letter = TRUE
		ELSEIF ll_reap_letter = 0 THEN
			ib_print_letter = False
		END IF
		IF ll_reap_app = 1 THEN	ib_print_app = TRUE
		IF ll_reap_priv = 1 THEN ib_print_priv = TRUE
	//------------------APPEON END-------------------------------
	li_retval = 0 
	IF appeongetclienttype() = 'WEB' THEN StopIEpopupmsg() //long.zhang 03.13.2014 
	IF ib_print_letter THEN
		//messagebox("",This.GetItemString( row, "doc_name" ))

		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2006-10-17 By: Rodger Wu (Inova)
		//$<reason> Add code to allow printing Miss Info Letter 90 days.
		
	//	li_retval = inv_printletters.of_printletters( is_doc_id[], "S", This.GetItemString( row, "letter" ), 	style , idw_verif_data,ls_doc_name, lb_print_preview, ls_sql,ll_pracids[],li_facility_id )
		inv_printletters.is_process_type = is_ptype  //Start Code Change ----07.09.2013 #V14 maha
		
		if this.getitemstring( row, "letter_alias" ) = "Applications Audit Missing 90 days" then
			inv_printletters.of_missing_info_90_days_print( is_doc_id[], idw_verif_data )
		elseif lb_combined = true then
			//Start Code Change ----07.24.2009 #V92 maha
			if isnumber(ls_facility_path) then //if number then stored in db
				ls_combined_path = ""
			else
				ls_combined_path = ls_facility_path
			end if
			ls_doc_name = ls_combined_path + "ind_expiring_cred_combined_letter.doc"  //Start Code Change ----07.24.2009 #V92 maha - added combined path
			//End Code Change---07.24.2009
			li_retval = inv_printletters.of_printletters_combined( is_doc_id[], "S", ls_let_name, 	ls_style , idw_verif_data,ls_doc_name, lb_print_preview, ls_sql,ll_pracids[],li_facility_id ,ls_ext_data, ls_from) //Start Code Change ----12.08.2008 #V85 maha - added ls_from argument
		elseif ib_ofe then //Start Code Change ----05.05.2011 #V11 maha 
			li_retval = inv_printletters.of_printletters_combined( is_doc_id[], "S", ls_let_name, 	"OFE" , idw_verif_data,ls_doc_name, lb_print_preview, ls_sql,ll_pracids[],li_facility_id ,ls_ext_data, ls_from) //Start Code Change ----12.08.2008 #V85 maha - added ls_from argument
		else
			li_retval = inv_printletters.of_printletters( is_doc_id[], "S", ls_let_name, 	ls_style , idw_verif_data,ls_doc_name, lb_print_preview, ls_sql,ll_pracids[], li_facility_id, il_parent, li_screen  ) //Start Code Change ----03.07.2012 #V12 maha - added il_parent and li_screen arguments
	
		end if
		//---------------------------- APPEON END ----------------------------
	
	END IF

	//IF ls_letter_allias = "Reappointment Letter" THEN
	//MessageBox("", "Would you like to print your reappointment application now." )
	//END IF
	
//Start Code Change ----04.24.2012 #V12 maha - so that apps and priv forms will collate combined functions
if li_retval = 0 then
	if  ib_priv_faxed = false then  //Start Code Change ----10.11.2013 #V14 maha -  added ib_print_faxed check
		if ib_print_app or ib_print_priv then
			of_print_appl_priv_form(False,  is_doc_id[] )
		end if
	end if
end if	
IF appeongetclienttype() = 'WEB' THEN ResumeIEpopupmsg() //long.zhang 03.13.2014 

	
//	IF ib_print_app AND li_retval = 0 AND ib_app_faxed = False THEN
//		of_print_application( False )
//	END IF
//	
//	//-----------------------------APPEON BEGIN--------------------------------
//		//$<add> long.zhang 02.07.2012
//		//$<Reason>Reappointment Packet Modification
//	IF ib_print_priv and li_retval = 0 and ib_priv_faxed = false THEN
//		of_print_priv_form(false)
//	END IF
	//-----------------------------APPEON END----------------------------------
//End Code Change ----04.24.2012 

END IF


end event

event retrieveend;call super::retrieveend;Integer i
string ls_ref//maha081501
string ls_lett//maha081501
string ls_print_rule
Long ll_app_id
Integer li_facility_id
Boolean lb_print_app = False
//return 1
//if its a special case letter then pop in the letter name and doc name

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11/01/2007 By: Ken.Guo
//$<reason> For Web Performance, Setitem slowly,so use dataobject 'd_ai_print_all_letters_web'
//Notice!!! if you modify below script, you must do same modification in 'd_ai_print_all_letters_web' 
/* Evan 02.19.2009
If AppeonGetClientType() = 'WEB' Then 
	This.Sort()
	Return 
End If
*/
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO rowcount
	IF Upper(This.GetItemString( i, "letter_name" )) = "EXPIRING BASIC INFORMATION" THEN
		ls_ref = dw_letters.getitemstring(i,"verif_info_reference_value")
		This.SetItem( i, "letter_name", ls_ref )
		//messagebox("","test")
		This.SetItem( i, "letter_alias", ls_ref )
		If ls_ref = "Expiring Appointment Letter" then
			This.SetItem( i, "letter_name", "expiring_appointment" )

			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 07.06.2006 By: Rodger Wu
			//$<reason> Letter path will be assigned to doc_name in buttonclicked event.
			
			/* This.SetItem( i, "doc_name", This.GetItemString( i, "facility_letter_path") + This.GetItemString( i,"reapp_doc_name" )) */
			
			This.SetItem( i, "doc_name", This.GetItemString( i,"reapp_doc_name" ))
			cbx_app_printer.visible = true
			//---------------------------- APPEON END ----------------------------
		elseIf ls_ref = "Expiring Allied Health Letter" then
			This.SetItem( i, "letter_name", "expiring_allied_health" )
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 07.06.2006 By: Rodger Wu
			//$<reason> Letter path will be assigned to doc_name in buttonclicked event.
			
			/* This.SetItem( i, "doc_name", This.GetItemString( i, "facility_letter_path") + This.GetItemString( i,"reappah_doc_name" )) */
			This.SetItem( i, "doc_name", This.GetItemString( i,"reappah_doc_name" ))
			cbx_app_printer.visible = true
			//---------------------------- APPEON END ----------------------------
		elseIf ls_ref = "Expiring Provisional Letter" then
			This.SetItem( i, "letter_name", "expiring_provisional" )
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 07.06.2006 By: Rodger Wu
			//$<reason> Letter path will be assigned to doc_name in buttonclicked event.
			/* This.SetItem( i, "doc_name", This.GetItemString( i, "facility_letter_path") + This.GetItemString( i,"prov_doc_name" )) */
			This.SetItem( i, "doc_name", This.GetItemString( i,"prov_doc_name" ))
			cbx_app_printer.visible = true //Start Code Change ---- 11.01.2006 #1 maha
			//---------------------------- APPEON END ----------------------------
		end if
	elseif dw_letters.getitemstring(i,"letter_name") = "Basic Information" then  //\/maha 081601 correspondence letters
		ls_ref = dw_letters.getitemstring(i,"verif_info_reference_value")
		if LenA(ls_ref) < 1 then
			ls_ref = "No reference value"
			This.SetItem( i, "letter_alias", ls_ref )
		else
			select document_name into :ls_lett from sys_letters where letter_name = :ls_ref;
			//This.SetItem( i, "letter_alias", ls_ref ) //maha app102505
			//This.SetItem( i, "letter_name", ls_ref ) //Start Code Change ---- 05.17.2006 #454 maha removed
			This.SetItem( i, "letter_alias", ls_ref )
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 07.06.2006 By: Rodger Wu
			//$<reason> Letter path will be assigned to doc_name in buttonclicked event.
			
			/* This.SetItem( i, "doc_name", This.GetItemString( i, "facility_letter_path") + ls_lett )//\maha */
			
			This.SetItem( i, "doc_name", ls_lett )
			//---------------------------- APPEON END ----------------------------
			This.SetItem( i, "letter_style", "P" )
		end if
	END IF
END FOR

//Start Code Change ---- 09.26.2007 #V7 maha
this.sort() //after modifying - resort
This.Groupcalc() //Added By Ken.Guo 04.15.2008
end event

type gb_corro from groupbox within w_ai_print_letters
boolean visible = false
integer x = 37
integer y = 948
integer width = 3077
integer height = 712
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Correspondence"
end type

type dw_corro from u_dw within w_ai_print_letters
boolean visible = false
integer x = 69
integer y = 1008
integer width = 3008
integer height = 620
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_ai_print_corro"
boolean hscrollbar = true
end type

event buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.23.2006 By: Jervis
//$<reason> print Correspondence letters
long ll_letter_id
long ll_rec_id[],ll_prac_id[],ll_facility_id[],ll_seq_no[],ll_app_id[]
n_cst_print_letter   lnv_print_letter

if row > 0 and this.GetItemNumber(row,"print_status") = 0 then
	ll_letter_id = this.GetItemNumber(row,"letter_id")
	ll_rec_id[1] = this.GetItemNumber(row,"rec_id")
	ll_prac_id[1] = this.GetItemNumber(row,"prac_id")
	ll_facility_id[1] = this.GetItemNumber(row,"facility_id")
	ll_seq_no[1] = this.GetItemNumber(row,"seq_no")
else
	MessageBox("Message","The letter has been printed!")
	return
end if

if lnv_print_letter.of_print_letter(ll_letter_id,ll_rec_id,ll_prac_id,ll_facility_id,ll_seq_no,ll_app_id) = 1 then
	this.SetItem(row,"print_status",1)
	//refresh data
	idw_verif_data.event pfc_retrieve()
end if
//---------------------------- APPEON END ----------------------------

end event

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )

end event

type gb_letters from groupbox within w_ai_print_letters
integer x = 37
integer y = 212
integer width = 3077
integer height = 1448
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Verification Letters "
end type

type ddplb_filter from dropdownpicturelistbox within w_ai_print_letters
boolean visible = false
integer x = 1344
integer y = 76
integer width = 178
integer height = 96
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Show All Letters","Faxable Letters","Faxable Letters with NO email","Emailable Letters","Emailable Letters with NO Fax #","Letters with no Fax or Email"}
borderstyle borderstyle = stylelowered!
integer itempictureindex[] = {4,3,3,2,2,1}
string picturename[] = {"Report5!","Globals!","Custom020!","Report!"}
long picturemaskcolor = 553648127
end type

event selectionchanged;of_fax_num_email_search( )
dw_letters.AcceptText()

//show all
IF index = 1 THEN
	dw_letters.SetFilter( "" )
	dw_letters.Filter( )		
//faxable letters	
ELSEIF index = 2 THEN
	dw_letters.SetFilter( "Len( fax_number ) > 0 " )

	dw_letters.Filter( )					
//faxable letters	with NO email
ELSEIF index = 3 THEN
	dw_letters.SetFilter( "Len( fax_number ) > 0 OR Len( fax ) > 0 AND (Len( email_address ) = 0 OR email_address = '' OR IsNull(email_address))" )
	dw_letters.Filter( )						
//emailable letters
ELSEIF index = 4 THEN
	dw_letters.SetFilter( "Len( email_address ) > 0 " )
	dw_letters.Filter( )					
//emailable letters with NO fax	
ELSEIF index = 5 THEN
	dw_letters.SetFilter( "Len( email_address ) > 0 AND (Len( fax_number ) = 0 OR fax_number = '' OR IsNull(fax_number))" )
	dw_letters.Filter( )					
//print only
ELSE
	dw_letters.SetFilter( "(Len( fax_number ) = 0 OR fax_number = '' OR IsNull(fax_number)) AND (Len( email_address ) = 0 OR email_address = '' OR IsNull(email_address))" )
	dw_letters.Filter( )						
END IF

//e_mail_address

dw_letters.sort()
dw_letters.GroupCalc ( )


	
end event

type uo_print_app from pfc_cst_u_create_app2 within w_ai_print_letters
boolean visible = false
integer x = 69
integer y = 284
integer width = 3008
integer height = 1356
integer taborder = 30
long backcolor = 80269524
borderstyle borderstyle = stylelowered!
end type

on uo_print_app.destroy
call pfc_cst_u_create_app2::destroy
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
05w_ai_print_letters.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15w_ai_print_letters.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
