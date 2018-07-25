$PBExportHeader$w_renew_priv_form.srw
forward
global type w_renew_priv_form from window
end type
type cbx_ruler from checkbox within w_renew_priv_form
end type
type st_format from statictext within w_renew_priv_form
end type
type cbx_eff from checkbox within w_renew_priv_form
end type
type mle_text from multilineedit within w_renew_priv_form
end type
type cb_8 from uo_cb_output within w_renew_priv_form
end type
type cbx_select from checkbox within w_renew_priv_form
end type
type cbx_printsetup from checkbox within w_renew_priv_form
end type
type cbx_history from checkbox within w_renew_priv_form
end type
type st_4 from statictext within w_renew_priv_form
end type
type cbx_cur from checkbox within w_renew_priv_form
end type
type cb_preview from commandbutton within w_renew_priv_form
end type
type st_3 from statictext within w_renew_priv_form
end type
type rb_all from radiobutton within w_renew_priv_form
end type
type rb_one from radiobutton within w_renew_priv_form
end type
type dw_pracs from datawindow within w_renew_priv_form
end type
type dw_browse from u_dw within w_renew_priv_form
end type
type cb_add from commandbutton within w_renew_priv_form
end type
type st_2 from statictext within w_renew_priv_form
end type
type st_facil from statictext within w_renew_priv_form
end type
type dw_facility from datawindow within w_renew_priv_form
end type
type dw_batchlist from datawindow within w_renew_priv_form
end type
type dw_list from datawindow within w_renew_priv_form
end type
type st_1 from statictext within w_renew_priv_form
end type
type dw_stat from datawindow within w_renew_priv_form
end type
type st_stat from statictext within w_renew_priv_form
end type
type cb_close from commandbutton within w_renew_priv_form
end type
type cb_print from commandbutton within w_renew_priv_form
end type
type gb_2 from groupbox within w_renew_priv_form
end type
type dw_2 from datawindow within w_renew_priv_form
end type
type dw_clin from datawindow within w_renew_priv_form
end type
type ddlb_selectform from dropdownlistbox within w_renew_priv_form
end type
type dw_3 from datawindow within w_renew_priv_form
end type
type dw_1 from u_dw within w_renew_priv_form
end type
type ddlb_format from dropdownlistbox within w_renew_priv_form
end type
end forward

global type w_renew_priv_form from window
integer x = 14
integer y = 80
integer width = 4498
integer height = 2444
boolean titlebar = true
string title = "Practitioners Privilege Forms "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 33551856
cbx_ruler cbx_ruler
st_format st_format
cbx_eff cbx_eff
mle_text mle_text
cb_8 cb_8
cbx_select cbx_select
cbx_printsetup cbx_printsetup
cbx_history cbx_history
st_4 st_4
cbx_cur cbx_cur
cb_preview cb_preview
st_3 st_3
rb_all rb_all
rb_one rb_one
dw_pracs dw_pracs
dw_browse dw_browse
cb_add cb_add
st_2 st_2
st_facil st_facil
dw_facility dw_facility
dw_batchlist dw_batchlist
dw_list dw_list
st_1 st_1
dw_stat dw_stat
st_stat st_stat
cb_close cb_close
cb_print cb_print
gb_2 gb_2
dw_2 dw_2
dw_clin dw_clin
ddlb_selectform ddlb_selectform
dw_3 dw_3
dw_1 dw_1
ddlb_format ddlb_format
end type
global w_renew_priv_form w_renew_priv_form

type variables
long il_pracid
long il_pracs[]
integer ii_clinid
integer ii_facid
integer ii_facs[]
long il_status
long il_reqst
string is_clin_filter
string is_prac_name
boolean ib_single_only  //maha 01.05.2012
Integer ii_selectedform = 1
integer ii_format  //maha 01.05.2012


end variables

forward prototypes
public function integer of_filter (long ai_status)
public function integer of_prac_name (long ai_pracid)
public function integer of_preview ()
public function integer of_dataobject ()
public function integer of_set_height ()
public function integer of_set_value (string as_prac_name, long al_stat, integer ai_set_value)
end prototypes

public function integer of_filter (long ai_status);long ll_status
string ls_filt
string ls_filt_col
datawindowchild dwchild
integer fnd


if dw_1.dataobject = "d_prac_priv_list_all_status" or dw_1.dataobject = "d_prac_priv_list_all_status_w_notes" then
	ls_filt_col = "status_code "


	
	ll_status = ai_status
	
	if isnull(ll_status) or ll_status = 0 then
		ls_filt = ""
	elseif ll_status = 1 then //not requested
		if il_reqst < 1 then
			messagebox("Find error","Can't find Reqst code")
		else
			ls_filt = ls_filt_col + " <> " + string(il_reqst)
		end if
	elseif ll_status = 2 then //grant or Cond
		ls_filt = ls_filt_col + " in (24478,24479)" 
	else	
		ls_filt = ls_filt_col + " = " + string(ll_status)
	end if
else
	ls_filt_col = "facility_zip "
	
end if
		
	//filtname = this.getitemstring(row,"status_code")
	

if LenA(is_clin_filter) > 0 then
	if LenA(ls_filt) > 0 then
		ls_filt = ls_filt + " and " + is_clin_filter
	else
		ls_filt = is_clin_filter
	end if
end if

//messagebox("filter",ls_filt)

dw_1.Setfilter(ls_filt)
dw_1.filter( )



return 1
end function

public function integer of_prac_name (long ai_pracid);string ls_prac_name
integer cnt
long ll_ca
//debugbreak()
il_pracs[1] = il_pracid
dw_pracs.settransobject(sqlca)

gnv_appeondb.of_startqueue()

dw_pracs.retrieve(il_pracs[])
select full_name into :ls_prac_name from v_full_name where prac_id = :ai_pracid;
//Start Code Change ----10.26.2011 #V12 maha - added to set the current clinical area for the provider
select count( distinct clinical_area_id) into :cnt from pd_priv_list where prac_id = :ai_pracid and facility_id = :ii_facid;
select top 1 clinical_area_id into :ll_ca from pd_priv_list where prac_id = :ai_pracid and facility_id = :ii_facid;

gnv_appeondb.of_commitqueue()

if cnt = 1 then
	dw_clin.setitem(1,"clinical_area_id", ll_ca)
	ii_clinid = ll_ca
end if
//Start Code Change ----10.26.2011

is_prac_name = ls_prac_name

return 1
end function

public function integer of_preview ();//Start Code Change ---- 09.10.2007 #V7 maha corrected code so that it works as it did in version 5
// by copying the v 5 code and modifying for the dropdowns rather than the radio buttons
integer r
integer rc
integer p
integer pc
long g
long ll_procd_id
long ll_stat
string ls_stat
string ls_prac_name
long ll_clins[]
long ll_clin
integer clincnt
integer setvalue
integer fnd_g
integer fnd_r
long ll_nullarray[]
datetime ldt_start
datetime ldt_end 
DataWindowChild ldwc_form
n_cst_string lnv_string//Added by Appeon long.zhang 01.06.2017

//------------------- APPEON BEGIN -------------------
//<$>Delete:Stephen 04.03.2013
//<$>Reason:Issues with Privileging -bug 3447
//$<add> Michael 05.28.2012
//$<reason>set header field height 
//n_cst_priv_height lu_set_height
//lu_set_height = create n_cst_priv_height
//------------------- APPEON END ---------------------



select lookup_code 
into :ll_stat
from code_lookup 
where code = 'GRANTED';

if il_reqst < 1 then
	select lookup_code into :il_reqst from code_lookup where code = 'REQST';
end if

//messagebox("stat",stat)

if ii_facid < 1 then //maha added 8-03 
	messagebox("No Facility","No facility was available to run any report.  Please select Facility.")
	return -1
end if

if il_pracid < 1 then //maha added 8-03 
	messagebox("No Practitoner","No practitioner was available to run any report.")
	return -1
else
	select full_name into :ls_prac_name from v_full_name where prac_id = :il_pracid;
	
	If PosA(ls_prac_name,'"') > 0 Then ls_prac_name = lnv_string.of_globalreplace( ls_prac_name, '"','~~"')//Added by Appeon long.zhang 01.06.2017 (Double quotes on first name creating error Case#68566 Bug_id#5461)
	If PosA(ls_prac_name,"'") > 0 Then ls_prac_name = lnv_string.of_globalreplace( ls_prac_name, "'","~~'")//Added by Appeon long.zhang 01.06.2017 (Double quotes on first name creating error Case#68566 Bug_id#5461)
end if

ll_clins[] = ll_nullarray[] //clear array


//Start Code Change ----01.05.2012 #V12 maha - rewrote based on variable instead of list of objects
if ib_single_only = true then
	if ii_clinid < 1 then //maha added 8-03 
		messagebox("No Clinical Area ","A Single Clinical Area is required to run this report.  Please select Clinical Area,.")
		return -1
	else
		ll_clins[1] = ii_clinid
	end if
else //can run from multiple CA
	if cbx_cur.checked = false then 
		if ii_clinid < 1 then
			messagebox("No Clinical Area ","Please select a Clinical Area, or check the 'Print from Practitioner current privileges' checkbox to print a form for the current Clinical Areas.")
			return -1
		else
			ll_clins[1] = ii_clinid
		end if
	else //checked - using prac current privs
		dw_3.settransobject(sqlca) //practitoner current clin areas that are not requested
		pc = dw_3.retrieve(il_pracid,ii_facid)
		if pc > 0 then
			for p = 1 to pc 
				ll_clins[p] = dw_3.getitemnumber(p,"clinical_area_id")
			next
		else // the clin area selected
			messagebox("No data ","There are no privileges for this Provider for this Facility. " )  
			return -1
		end if	
	end if	
end if

//modifications by form
Choose Case ii_selectedform
	Case 1 //Privileges Without Notes
		dw_1.retrieve(il_pracid,ii_facs[])
		setvalue = 0
		IF Not cbx_history.checked THEN
			of_filter(il_status)
		END IF
	Case 2 //Privileges With Notes
		dw_1.retrieve(il_pracid,ii_facs[])
		setvalue = 0
		IF Not cbx_history.checked THEN
			of_filter(il_status)
		END IF
	Case 3 //Request Form with Headers
		//---------------appeon begin---------------
		//<$>Modified by long.zhang 09.21.2012
		//<$>reason For an issue of  Alpha id 3276 - Error when running Provider Privilege Report
//		rc = dw_1.retrieve(ii_facid,ll_clins)
//		dw_1.object.prac_name.text = ls_prac_name
//		setvalue = 1
		if ii_format =3 or ii_format =4 or ii_format = 1 or ii_format = -1 then	//added by long.zhang 09.21.2012
			rc = dw_1.retrieve(ii_facid,ll_clins[1])
			//---------Begin Added by (Appeon)Stephen 11.26.2014 for Privilege Report not displaying name Bug#4323--------
			dw_1.GetChild( "dw_1", ldwc_form )
			ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' ) 
			//---------End Added ------------------------------------------------------			
		else
			rc = dw_1.retrieve(ii_facid,ll_clins)
			//dw_1.object.prac_name.text = ls_prac_name
			dw_1.Modify( 'prac_name.text = "' + ls_prac_name + '"' ) //Modified by Appeon long.zhang 01.06.2017 (Double quotes on first name creating error Case#68566 Bug_id#5461)
		end if		
		//dw_1.object.prac_footer.text = ls_prac_name  //Start Code Change ----07.27.2016 #V152 maha
		dw_1.Modify( 'prac_footer.text = "' + ls_prac_name + '"' ) //Modified by Appeon long.zhang 01.06.2017 (Double quotes on first name creating error Case#68566 Bug_id#5461)
		setvalue = 1
		//------------------appeon end----------------
	Case 4 //Request Form with Detail
		//---------------appeon begin---------------
		//<$>Modified by long.zhang 09.21.2012
		//<$>reason For an issue of  Alpha id 3276 - Error when running Provider Privilege Report
//		rc = dw_1.retrieve(ii_facid,ll_clins)
//		dw_1.object.prac_name.text = ls_prac_name
//		setvalue = 1
		if ii_format =3 or ii_format =4 or ii_format = 1 or ii_format = -1 then //add ii_format = 1/-1 (Appeon)Stephen 04.30.2015 - V14.1 Bug # 4463 - Reappointment package is not printing the header for the privilege form
			rc = dw_1.retrieve(ii_facid,ll_clins[1])
			//---------Begin Added by (Appeon)Stephen 11.26.2014 for Privilege Report not displaying name Bug#4323--------
			dw_1.GetChild( "dw_1", ldwc_form )
			ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' ) 
			//---------End Added ------------------------------------------------------
		else
			rc = dw_1.retrieve(ii_facid,ll_clins)
			//dw_1.object.prac_name.text = ls_prac_name
			dw_1.Modify( 'prac_name.text = "' + ls_prac_name + '"' )  //Modified by Appeon long.zhang 01.06.2017 (Double quotes on first name creating error Case#68566 Bug_id#5461)
		end if	
		//dw_1.object.prac_footer.text = ls_prac_name  //Start Code Change ----07.27.2016 #V152 maha
		dw_1.Modify( 'prac_footer.text = "' + ls_prac_name + '"' ) //Modified by Appeon long.zhang 01.06.2017 (Double quotes on first name creating error Case#68566 Bug_id#5461)
		setvalue = 1
		//-------------appeon end--------------------
	Case 5 //Comparison Report
		if pc < 1 then
			messagebox("No Data","The practitioner has no active privileges from which to create this report.")
			return 1
		else
			rc = dw_1.retrieve(ii_facid,ll_clins[])
			setvalue = 1
		end if
		
		//dw_1.object.prac_footer.text = ls_prac_name  //Start Code Change ----07.27.2016 #V152 maha
		dw_1.Modify( 'prac_footer.text = "' + ls_prac_name + '"' ) //Modified by Appeon long.zhang 01.06.2017 (Double quotes on first name creating error Case#68566 Bug_id#5461)
	Case 6 //Complete Privilege Application with Description
	
		dw_1.Retrieve( ii_facid, ll_clins[1] )
		
		//Start Code Change ---- 11.28.2006 #V7 maha
		dw_1.GetChild( "dw_2", ldwc_form )
		ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' )  //Start Code Change ----10.17.2014 #V14.2 maha - adjusted for apostrophie in name
		dw_1.GetChild( "dw_3", ldwc_form )
		ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"')   //Start Code Change ----10.17.2014 #V14.2 maha - adjusted for apostrophie in name
		dw_1.GetChild( "dw_4", ldwc_form )
		ldwc_form.Modify('prac_name.text = "' + ls_prac_name + '"')   //Start Code Change ----10.17.2014 #V14.2 maha - adjusted for apostrophie in name
		if of_get_app_setting("set_46","I") = 1 then
			ldwc_form.Modify( "title1.text = 'Section Chief' " )
			ldwc_form.Modify( "title2.text = 'Department Chair'" )
			ldwc_form.Modify( "title3.text = 'Credentials Committee Chair'" )
			ldwc_form.Modify( "title4.text = 'Secretary, Medical Executive Committee'" )
			ldwc_form.Modify( "title5.text = 'Secretary, Inova Health Care Services Board'" )
		end if
		//End Code Change---11.28.2006
		
		//Modify Michael 05.28.2012 set header field height 
		//dw_1.GetChild( "dw_1", ldwc_form )
				
		//dw_1.object.prac_footer.text = ls_prac_name  //Start Code Change ----07.27.2016 #V152 maha
		dw_1.Modify('prac_footer.text = "' + ls_prac_name + '"')  //Added by Appeon long.zhang 01.06.2017 (Double quotes on first name creating error Case#68566 Bug_id#5461)
		
		if dw_1.dataobject = 'd_form_clin_priv_request_master_f4' or  dw_1.dataobject = 'd_form_clin_priv_request_master_f3' or dw_1.dataobject = 'd_form_clin_priv_request_master_f2' or dw_1.dataobject = 'd_form_clin_priv_request_master_cm6' then   //Start Code Change ----04.24.2017 #V153 maha - added cm6
		//Start Code Change ----04.22.2016 #V15 maha separated ...master_5 for effective dates
		//&
		//	or dw_1.dataobject = 'd_form_clin_priv_request_master_f5' then //format 5, Added by Appeon long.zhang 09.17.2015 (Bug # 4721 for Case #00056366 Privilege Lists)
			//---------Begin Added by (Appeon)Stephen 11.26.2014 for Privilege Report not displaying name Bug#4323--------		
			dw_1.GetChild( "dw_1", ldwc_form )  //Start Code Change ----04.22.2016 #V15 maha
			ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' ) 
			//---------End Added ------------------------------------------------------
			dw_1.GetChild( "dw_3", ldwc_form )
		elseif  dw_1.dataobject = 'd_form_clin_priv_request_master_f5'  then 
			dw_1.GetChild( "dw_1", ldwc_form )  
			ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' ) 
			//End Code Change ----04.22.2016
		
		elseif dw_1.dataobject = 'd_form_clin_priv_request_master_inova' or dw_1.dataobject =  "d_form_clin_priv_request_master_f1" or  dw_1.dataobject =  "d_form_clin_priv_request_master_f1_alt" then
			//---------Begin Modified by (Appeon)Stephen 03.23.2015 for Bug # 4453 for Case # 00052702: Dates on privilege lists/V.14130 --------
			//dw_1.GetChild( "dw_1", ldwc_form )
			dw_1.GetChild( "dw_4", ldwc_form )
			//---------End Modfiied ------------------------------------------------------

		end if 
		//------------------- APPEON END ---------------------
		
		rc = ldwc_form.Rowcount()
		ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' )   //Start Code Change ----10.17.2014 #V14.2 maha - adjusted for apostrophie in name
		
		dw_2.settransobject(sqlca) //practitoner privs
		pc = dw_2.retrieve(il_pracid,ii_facid)
////Start Code Change ----12.16.2011 #V12 maha - removed at request of	Northwest Surgical Hospital (Tina) not sure of the logic to add originally
//		//Start Code Change ----11.04.2010 #V10 maha
	if cbx_eff.checked then
		fnd_r = dw_2.find("status_code in (24478,24479)", 1, dw_2.rowcount())
		if fnd_r > 0 then
			ldt_start = dw_2.getitemdatetime(fnd_r,"start_date")
			ldt_end = dw_2.getitemdatetime(fnd_r,"end_date")
			//ldwc_form.Modify( "start_date.visible =true'" ) //modify Michael 07.23.2012 Bug#3124:The Effective Dates are not populating
			ldwc_form.Modify( "start_date.visible =true" )
			ldwc_form.Modify( "start_date.text = '" + string(date(ldt_start)) + "'" )
			//ldwc_form.Modify( "end_date.visible =true'" ) //modify Michael 07.23.2012 Bug#3124:The Effective Dates are not populating
			ldwc_form.Modify( "end_date.visible =true" )
			ldwc_form.Modify( "end_date.text = '" + string(date(ldt_end)) + "'" )
		end if
	else //add Michael 07.23.2012 Bug#3124:The Effective Dates are not populating
		ldwc_form.Modify( "start_date.visible =false" )
		ldwc_form.Modify( "end_date.visible =false" )
	end if
//	//Start Code Change ----11.04.2010
////End Code Change ----12.16.2011		

 //Start Code Change ----05.09.2017 #V153 maha - changed to case statement
	//---------Begin Added by (Appeon)Stephen 04.30.2015 for V14.1 Bug # 4463 - Reappointment package is not printing the header for the privilege form--------
//	if dw_1.dataobject = 'd_form_clin_priv_request_master_inova' or dw_1.dataobject =  "d_form_clin_priv_request_master_f1" or  dw_1.dataobject =  "d_form_clin_priv_request_master_f1_alt" &
//		or dw_1.dataobject = 'd_form_clin_priv_request_master_f5' then//Format 5, Added by Appeon long.zhang 09.17.2015 (Bug # 4721 for Case #00056366 Privilege Lists)
//		dw_1.GetChild( "dw_1", ldwc_form )		
//	elseif dw_1.dataobject = 'd_form_clin_priv_request_master_f4' or  dw_1.dataobject = 'd_form_clin_priv_request_master_f3' or dw_1.dataobject = 'd_form_clin_priv_request_master_f2' or dw_1.dataobject = 'd_form_clin_priv_request_master_cm6' then   //Start Code Change ----04.24.2017 #V153 maha - added cm6then
//		dw_1.GetChild( "dw_3", ldwc_form )
//	elseif dw_1.dataobject = 'd_form_clin_priv_request_master_cm6' then   //Start Code Change ----05.09.2017 #V153 maha
//		dw_1.GetChild( "dw_3", ldwc_form )
//	else
//		dw_1.GetChild( "dw_1", ldwc_form )	
//	end if
	
	choose case ii_format
		case 1,3,4
			dw_1.GetChild( "dw_3", ldwc_form )
		case 6   //Start Code Change ----05.03.2017 #V153 maha
			dw_1.GetChild( "dw_4", ldwc_form )
		case else
			dw_1.GetChild( "dw_1", ldwc_form )
	end choose
 //End Code Change ----05.09.2017 
	rc = ldwc_form.Rowcount()
	//---------End Added ------------------------------------------------------
	
		for r = 1 to rc
			ll_procd_id = ldwc_form.getitemnumber(r,"procd_id")
			g = 0
			
			//---------Begin Modified by (Appeon)Stephen 05.13.2014 for Bug 4033 : Privilege Granted not displaying --------
			//g = dw_2.find("procd_id = " + string(ll_procd_id)  + " and status_code <> " + string(il_reqst),1,pc)
			g = dw_2.find("procd_id = " + string(ll_procd_id)  + " and code <> '" + string(il_reqst) +"'",1,pc)
			//---------End Modfiied ------------------------------------------------------

			if g > 0 then
				ls_stat = dw_2.getitemstring(g,"code")
				ldwc_form.setitem(r,"facility_zip",ls_stat) 
			elseif g < 0 then
				messagebox("Find error in of_preview function","Contact IntelliSoft Support")
				return -1
			else
				ldwc_form.setitem(r,"facility_zip","") 
			end if
		next
		//of_set_height() //add Michael 03.02.2012 Bug id 2935-set DW heander height //delete Michael 05.28.2012
		//------------------- APPEON BEGIN -------------------
		//<$>Delete:Stephen 04.03.2013
		//<$>Reason:Issues with Privileging -bug 3447
		//$<add> Michael 05.28.2012
		//$<reason>set header field height 
//		lu_set_height.of_set_height(dw_1,mle_text)
//		destroy lu_set_height
		//------------------- APPEON END ---------------------
		Return 1;
		
	case 7  //Start Code Change ----07.21.2009 #V92 maha - add retrieval for this report
		dw_1.retrieve(il_pracid, ii_facid)  //Start Code Change ----12.06.2012 #V12 maha - modifed aguments to change to single facility
		setvalue = 0
End Choose
	debugbreak()	
//Start Code Change ----06.11.2012 #V12 maha - moved here from previous case
//Choose case ii_selectedform
// note the modify fields do not exist for these dataobjects
//	case 3,4	
//		if cbx_eff.checked then
//			
//			fnd_r = dw_2.find("status_code in (24478,24479)", 1, dw_2.rowcount())
//			if fnd_r > 0 then
//				ldt_start = dw_2.getitemdatetime(fnd_r,"start_date")
//				ldt_end = dw_2.getitemdatetime(fnd_r,"end_date")
//				ldwc_form.Modify( "start_date.visible =true'" )
//				ldwc_form.Modify( "start_date.text = '" + string(date(ldt_start)) + "'" )
//				ldwc_form.Modify( "end_date.visible =true'" )
//				ldwc_form.Modify( "end_date.text = '" + string(date(ldt_end)) + "'" )
//			end if
//		end if
//end choose

//End Code Change ----06.11.2011	

//-------------appeon begin---------------------
//<$>Commented and Modified by long.zhang 09.21.2012
//<$>reason:For an issue of FW: Alpha id 3276 - Error when running Provider Privilege Report - replaced with of_set_value

if of_set_value(ls_prac_name,ll_stat,setvalue) = -1 then return -1
	
//if setvalue = 1 then
//	dw_2.settransobject(sqlca) //practitoner privs
//	pc = dw_2.retrieve(il_pracid,ii_facid)
//	for r = 1 to rc
//		ll_procd_id = dw_1.getitemnumber(r,"procd_id") 
//		g = 0
//	//messagebox("ll_procd_id",ll_procd_id)
//	//messagebox("ii_facid",ii_facid)
//	//messagebox("gl_prac_id",gl_prac_id)
//		g = dw_2.find("procd_id = " + string(ll_procd_id)  + " and status_code <> " + string(il_reqst),1,pc)
//		if g > 0 then
//			ls_stat = dw_2.getitemstring(g,"code")
//			dw_1.setitem(r,"facility_zip",ls_stat) 
//			if cbx_select.checked then
//				if dw_2.getitemnumber(g,"status_code") = ll_stat then
//					dw_1.setitem(r,"req_check", " X") 
//				end if
//			end if
//		elseif g < 0 then
//			messagebox("Find error in of_preview function","Contact IntelliSoft Support")
//			return -1
//		else
//			dw_1.setitem(r,"facility_zip","") 
//		end if
//	next
//
//	IF ii_selectedform = 5 THEN //Comparison Report
//		dw_2.setfilter("") 
//		dw_2.filter()
//
//		for r = 1 to rc
//			//if dw_1.getitemstring(r,"facility_zip","") = "REQST" then dw_1.setitem(r,"facility_zip","") 
//			ll_procd_id = dw_1.getitemnumber(r,"procd_id") 
//			fnd_r = dw_2.find("procd_id = " + string(ll_procd_id)  + " and status_code = " + string(il_reqst),1,pc)
//			if fnd_r > 0 then
//				fnd_g = dw_2.find("procd_id = " + string(ll_procd_id)  + " and status_code in (24478,24479)",1,pc)
//				if fnd_g = 0 then
//					dw_1.setitem(r,"col_r","R")
//				elseif fnd_g > 0 then
//					dw_1.setitem(r,"col_c","C") 
//				end if
//			elseif fnd_r = 0 then
//				fnd_g = dw_2.find("procd_id = " + string(ll_procd_id)  + " and status_code in (24478,24479)",1,pc)
//				if fnd_g > 0 then
//					dw_1.setitem(r,"col_n","N")
//				elseif fnd_g = 0 then
//					dw_1.setitem(r,"col_d","D")
//				end if
//			else
//				messagebox("Find error","Contact IntelliSoft Support")
//				return -1
//			end if
//		next
//	end if
//	
//	//select full_name into :ls_prac_name from v_full_name where prac_id = :il_pracid;
//	dw_1.object.prac_name.text = ls_prac_name
//end if
//---------------------appeon end---------------------------

//dw_1.object.prac_name.text = is_prac_name
//of_filter(il_status)

//of_set_height() //add Michael 03.02.2012 Bug id 2935-set DW heander height //delete Michael 05.28.2012
//------------------- APPEON BEGIN -------------------
//<$>Delete:Stephen 04.03.2013
//<$>Reason:Issues with Privileging -bug 3447
//$<add> Michael 05.28.2012
//$<reason>set header field height 
//lu_set_height.of_set_height(dw_1,mle_text)
//destroy lu_set_height
//------------------- APPEON END ---------------------


return 1

end function

public function integer of_dataobject ();//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-10-09 By: Rodger Wu (Inova)
//$<reason> Script adjustment due to old radiobutton objects removed.

/*
if rb_notes.checked then
	dw_1.dataobject = "d_prac_priv_list_all_status_w_notes"
elseif rb_nonotes.checked then
	dw_1.dataobject = "d_prac_priv_list_all_status"
elseif rb_dt.checked then
	dw_1.dataobject = "d_form_pract_priv_request_d"
elseif rb_hd.checked then
	dw_1.dataobject = "d_form_pract_priv_request_h"
elseif rb_comp.checked then
	dw_1.dataobject = "d_form_pract_priv_request_compare"
end if
*/
integer li_form
//debugbreak()
//Start Code Change ----06.10.2011 #V11 maha - get format setting
//Start Code Change ----01.05.2012 #V12 maha - format set elsewhere 
//  SELECT priv_template.alt_form into :li_form   FROM facility, priv_template    WHERE  facility.priv_template = priv_template.template_id   and facility.facility_id = :ii_facid;
li_form = ii_format
//messagebox("format",li_form)
//End Code Change ----01.05.2012
//Start Code Change ----10.25.2011 #V12maha - copied back from v12
Choose Case ii_selectedform
	Case 1 //Privileges Without Notes
		IF cbx_history.Checked THEN
			dw_1.dataobject = "d_prac_priv_list_history"
		ELSE
			dw_1.dataobject = "d_prac_priv_list_all_status"
		END IF
	Case 2 //Privileges With Notes
		IF cbx_history.Checked THEN
			dw_1.dataobject = "d_prac_priv_list_history_w_notes"
		ELSE
			dw_1.dataobject = "d_prac_priv_list_all_status_w_notes"
		END iF
	//Start Code Change ----09.21.2011 #V12 maha	- added form option
	Case 3 //Request Form with Headers
		if li_form = 1 then
			dw_1.dataobject = "d_form_pract_priv_request_f2"	
		elseif li_form = 3 then
			dw_1.dataobject = "d_form_pract_priv_request_f3"
		elseif li_form = 4 then
			dw_1.dataobject = "d_form_pract_priv_request_f4"
		elseif li_form = -1 then  //Start Code Change ----10.01.2013 #V14 maha  -added 
			dw_1.dataobject = "d_form_pract_priv_request_h_1a"
		elseif li_form = 6 then  //Start Code Change ----04.24.2017 #V153 maha - milford custom
			messagebox("Request form","Request Form with headers is not supported in this format.")
			return -1
		else
			dw_1.dataobject = "d_form_pract_priv_request_h"
		end if
	Case 4 //Request Form with Detail
		//messagebox("",li_form)
		if li_form = 1 then
			dw_1.dataobject = "d_form_pract_priv_request_f2d"
		elseif	li_form = 3 then
			dw_1.dataobject = "d_form_pract_priv_request_f3"
		elseif li_form = 4 then
			dw_1.dataobject = "d_form_pract_priv_request_f4"
		elseif li_form = -1 then   //Start Code Change ----10.01.2013 #V14 maha  -added 
			dw_1.dataobject = "d_form_pract_priv_request_d"	
		else   //Start Code Change ----10.01.2013 #V14 maha  - changed
			dw_1.dataobject = "d_form_pract_priv_request_d_f1_only"
		end if
	//End Code Change ----09.21.2011  
	Case 5 //Comparison Report
		dw_1.dataobject = "d_form_pract_priv_request_compare"
		
	Case 6 //Complete Privilege Application with Description
		if li_form = 1 then
			dw_1.dataobject = "d_form_clin_priv_request_master_f2"
		elseif li_form = 3 then
			dw_1.dataobject = "d_form_clin_priv_request_master_f3"
		elseif li_form = 4 then
			dw_1.dataobject = "d_form_clin_priv_request_master_f4"
		elseif  li_form = -1 then//Start Code Change ----10.01.2013 #V14 maha - added
			dw_1.dataobject = "d_form_clin_priv_request_master_f1_alt"	
		elseif  li_form = 5 then//Added by Appeon long.zhang 09.17.2015 (Bug # 4721 for Case #00056366 Privilege Lists)
			dw_1.dataobject = "d_form_clin_priv_request_master_f5"	
		elseif  li_form = 6 then   //Start Code Change ----04.24.2017 #V153 maha - milford custom
			dw_1.dataobject  =  "d_form_clin_priv_request_master_cm6"
		else //=0 //Start Code Change ----1001.2013 #V14 maha - changed from "d_form_clin_priv_request_master_f1"
			dw_1.dataobject = "d_form_clin_priv_request_master_f1"
		end if
		//messagebox("",dw_1.dataobject)
	case 7  //Privileges With staff cat/ dept             //Start Code Change ---- 11.08.2007 #V7 maha
		dw_1.dataobject = "d_prac_priv_list_dept_staff_cat" //Start Code Change ----07.21.2009 #V92 maha - added dataobject
End Choose

//Start Code Change ----06.11.2012 #V12 maha - view format if appropriate
choose case ii_selectedform
	case 3,4,6
		st_format.visible = true
		ddlb_format.visible = true
		//cbx_eff.visible = true
	case else
		st_format.visible = False
		ddlb_format.visible = False
		//cbx_eff.visible = False
end choose

if ii_selectedform = 6 then
	cbx_eff.visible = true
else
	cbx_eff.visible = false
end if
//end Code Change ----06.11.2012 		
dw_1.settransobject(sqlca)
cbx_ruler.event clicked()	//added by long.zhang appeon 11.30.2012	
return 1
end function

public function integer of_set_height ();//------------------- APPEON BEGIN -------------------
//$<delete> Michael 05.28.2012
//$<reason> set header field height
/*

//////////////////////////////////////////////////////////////////////
// $<function> of_set_height
// $<arguments>
//              (None)
// $<returns> (None)
// $<description> Bug id 2935-set DW heander height 
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Michael 03.02.2012
// Modify by Appeon: Michael 04.10.2012 add some new DW for V12.1
//////////////////////////////////////////////////////////////////////
string ls_text
integer li_cnt, li_height, li_width
datawindowchild ldwc_1

If Upper(appeongetclienttype()) <> "PB" Then
	if dw_1.dataobject  = "d_form_clin_priv_request_master_inova" or dw_1.dataobject  = "d_form_pract_priv_request_f3"  or dw_1.dataobject  = "d_form_pract_priv_request_f4" or dw_1.dataobject  = "d_form_pract_priv_request_h" or dw_1.dataobject  = "d_form_clin_priv_request_master_f2" or dw_1.dataobject  = "d_form_clin_priv_request_master_f3" or dw_1.dataobject  = "d_form_clin_priv_request_master_f4" then
		
		dw_1.getchild("dw_1",ldwc_1)
		li_width = integer(ldwc_1.describe("priv_template_header_text.width"))
		mle_text.width = li_width		
		if ldwc_1.rowcount() >0 then 
			ls_text = ldwc_1.getitemstring(1,"priv_template_header_text")
			mle_text.text = ls_text
			li_cnt = mle_text.linecount() - 1
			li_height = integer(ldwc_1.describe("datawindow.header.height")) + li_cnt * 68 + 10
			ldwc_1.modify("datawindow.header.height = '"+string(li_height)+"'")
		end if		
	end if
	
	if dw_1.dataobject  = "d_form_pract_priv_request_f2" or dw_1.dataobject  = "d_form_pract_priv_request_h" or dw_1.dataobject  = "d_form_pract_priv_request_f2d" or dw_1.dataobject  = "d_form_pract_priv_request_d" then
		li_width = integer(dw_1.describe("priv_template_header_text.width"))
		mle_text.width = li_width		
		if  dw_1.rowcount() > 0 then
			ls_text =  dw_1.getitemstring(1,"priv_template_header_text")
			mle_text.text = ls_text
			li_cnt = mle_text.linecount() - 1
			
			li_height = integer(dw_1.describe("datawindow.header.height")) + li_cnt * 68 + 10
			dw_1.modify("datawindow.header.height = '"+string(li_height)+"'")
		end if
	end if
end if

//------------------- APPEON BEGIN -------------------
//$<add> Michael 04.09.2012
//$<reason>Apha id 2988 - Exclusive Contract text doesn't preview correctly in reports
If Upper(appeongetclienttype()) <> "PB" Then
	if dw_1.dataobject  = "d_form_pract_priv_request_f3" or dw_1.dataobject  = "d_form_pract_priv_request_f4" or dw_1.dataobject  = "d_form_clin_priv_request_master_f2" or  dw_1.dataobject  = 	"d_form_clin_priv_request_master_f3" or   dw_1.dataobject  = "d_form_clin_priv_request_master_f4"   then
		dw_1.getchild("dw_1",ldwc_1)
		if ldwc_1.getitemnumber(ldwc_1.getrow(),"use_exclusive") = 1 then
			li_width = integer(ldwc_1.describe("priv_template_excl_cont_text.width"))
			mle_text.width = li_width		
			if ldwc_1.rowcount() >0 then 
				ls_text = ldwc_1.getitemstring(1,"priv_template_excl_cont_text")
				mle_text.text = ls_text
				li_cnt = mle_text.linecount() - 1
				li_height = integer(ldwc_1.describe("datawindow.header.height")) + li_cnt * 68 + 10
				ldwc_1.modify("datawindow.header.height = '"+string(li_height)+"'")
			end if
		end if
	end if
end if
//------------------- APPEON END -------------------

*/
//------------------- APPEON END ---------------------

return 1
end function

public function integer of_set_value (string as_prac_name, long al_stat, integer ai_set_value);//==========================================
// $<Function>  of_set_value ()
// $<arguments>
// 	value    string    as_prac_name :the practitioner name
// 	value    long      al_stat: GRANTED status
//	value 	integer	ai_set_value:whether needs set value 0:not need 1:need
// $<returns> integer 1 - success; -1 - failure 
// $<description> Set value in datawindow or datawindowchild 
//copied and modified from of_preview()
// $<add> (Appeon) Long.zhang 09.21.2012
//==========================================

boolean lb_exists_child = false
long ll_prac_rec
long ll_pc_rec
long r
long ll_procd_id
long g
long fnd_r
long fnd_g
string ls_stat
datawindowChild ldwc_form

if ai_set_value = 0 then return 1

dw_2.settransobject(sqlca) //practitoner privs
ll_prac_rec = dw_2.retrieve(il_pracid,ii_facid)

if ii_selectedform = 3 or ii_selectedform = 4 then
		if ii_format = 3 or ii_format = 4 then	lb_exists_child = true
end if

if lb_exists_child then
	dw_1.getchild( "dw_2",ldwc_form)
	ll_pc_rec = ldwc_form.rowcount( )
else
	ll_pc_rec = dw_1.rowcount()
end if
//---------Begin Added by (Appeon)Stephen 04.30.2015 for V14.1 Bug # 4463 - Reappointment package is not printing the header for the privilege form--------
choose case dw_1.dataobject
	case 'd_form_pract_priv_request_f2' , 'd_form_pract_priv_request_h_1a', 'd_form_pract_priv_request_f2d', 'd_form_pract_priv_request_d'
		r = dw_1.getchild( "dw_2",ldwc_form)
		ll_pc_rec = ldwc_form.rowcount( )
		lb_exists_child = true
end choose
//---------End Added ------------------------------------------------------

for r = 1 to ll_pc_rec
		if lb_exists_child then
			ll_procd_id = ldwc_form.getitemnumber(r,"procd_id") 
		else
			ll_procd_id = dw_1.getitemnumber(r,"procd_id") 
		end if
		
		g = 0
		g = dw_2.find("procd_id = " + string(ll_procd_id)  + " and status_code <> " + string(il_reqst),1,ll_prac_rec)
		if g > 0 then
			ls_stat = dw_2.getitemstring(g,"code")
			if lb_exists_child then
				ldwc_form.setitem(r,"facility_zip",ls_stat) 
			else
				dw_1.setitem(r,"facility_zip",ls_stat) 
			end if
			
			if cbx_select.checked then
				if dw_2.getitemnumber(g,"status_code") = al_stat then
					if not lb_exists_child then
						dw_1.setitem(r,"req_check", " X") 
					end if
				end if
			end if
		elseif g < 0 then
			messagebox("Find error in of_preview function","Contact IntelliSoft Support")
			return -1
		else
			if lb_exists_child then
				ldwc_form.setitem(r,"facility_zip","") 
			else
				dw_1.setitem(r,"facility_zip","") 
			end if
		end if
end for	

if ii_selectedform = 5 THEN //Comparison Report
		dw_2.setfilter("") 
		dw_2.filter()
debugbreak()
		for r = 1 to ll_pc_rec
			ll_procd_id = dw_1.getitemnumber(r,"procd_id") 
			fnd_r = dw_2.find("procd_id = " + string(ll_procd_id)  + " and status_code = " + string(il_reqst),1,ll_prac_rec)
			if fnd_r > 0 then
				fnd_g = dw_2.find("procd_id = " + string(ll_procd_id)  + " and status_code in (24478,24479)",1,ll_prac_rec)
				if fnd_g = 0 then
					dw_1.setitem(r,"col_r","R")
				elseif fnd_g > 0 then
					dw_1.setitem(r,"col_c","C") 
				end if
			elseif fnd_r = 0 then
				fnd_g = dw_2.find("procd_id = " + string(ll_procd_id)  + " and status_code in (24478,24479)",1,ll_prac_rec)
				if fnd_g > 0 then
					dw_1.setitem(r,"col_n","N")
				elseif fnd_g = 0 then
					dw_1.setitem(r,"col_d","D")
				end if
			else
				messagebox("Find error","Contact IntelliSoft Support")
				return -1
			end if
		next
	end if
	if not lb_exists_child then
			//dw_1.object.prac_name.text = as_prac_name
			dw_1.Modify( 'prac_name.text = "' + as_prac_name + '"' ) //Modified by Appeon long.zhang 01.06.2017 (Double quotes on first name creating error Case#68566 Bug_id#5461)
	end if
	

return 1

end function

on w_renew_priv_form.create
this.cbx_ruler=create cbx_ruler
this.st_format=create st_format
this.cbx_eff=create cbx_eff
this.mle_text=create mle_text
this.cb_8=create cb_8
this.cbx_select=create cbx_select
this.cbx_printsetup=create cbx_printsetup
this.cbx_history=create cbx_history
this.st_4=create st_4
this.cbx_cur=create cbx_cur
this.cb_preview=create cb_preview
this.st_3=create st_3
this.rb_all=create rb_all
this.rb_one=create rb_one
this.dw_pracs=create dw_pracs
this.dw_browse=create dw_browse
this.cb_add=create cb_add
this.st_2=create st_2
this.st_facil=create st_facil
this.dw_facility=create dw_facility
this.dw_batchlist=create dw_batchlist
this.dw_list=create dw_list
this.st_1=create st_1
this.dw_stat=create dw_stat
this.st_stat=create st_stat
this.cb_close=create cb_close
this.cb_print=create cb_print
this.gb_2=create gb_2
this.dw_2=create dw_2
this.dw_clin=create dw_clin
this.ddlb_selectform=create ddlb_selectform
this.dw_3=create dw_3
this.dw_1=create dw_1
this.ddlb_format=create ddlb_format
this.Control[]={this.cbx_ruler,&
this.st_format,&
this.cbx_eff,&
this.mle_text,&
this.cb_8,&
this.cbx_select,&
this.cbx_printsetup,&
this.cbx_history,&
this.st_4,&
this.cbx_cur,&
this.cb_preview,&
this.st_3,&
this.rb_all,&
this.rb_one,&
this.dw_pracs,&
this.dw_browse,&
this.cb_add,&
this.st_2,&
this.st_facil,&
this.dw_facility,&
this.dw_batchlist,&
this.dw_list,&
this.st_1,&
this.dw_stat,&
this.st_stat,&
this.cb_close,&
this.cb_print,&
this.gb_2,&
this.dw_2,&
this.dw_clin,&
this.ddlb_selectform,&
this.dw_3,&
this.dw_1,&
this.ddlb_format}
end on

on w_renew_priv_form.destroy
destroy(this.cbx_ruler)
destroy(this.st_format)
destroy(this.cbx_eff)
destroy(this.mle_text)
destroy(this.cb_8)
destroy(this.cbx_select)
destroy(this.cbx_printsetup)
destroy(this.cbx_history)
destroy(this.st_4)
destroy(this.cbx_cur)
destroy(this.cb_preview)
destroy(this.st_3)
destroy(this.rb_all)
destroy(this.rb_one)
destroy(this.dw_pracs)
destroy(this.dw_browse)
destroy(this.cb_add)
destroy(this.st_2)
destroy(this.st_facil)
destroy(this.dw_facility)
destroy(this.dw_batchlist)
destroy(this.dw_list)
destroy(this.st_1)
destroy(this.dw_stat)
destroy(this.st_stat)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.gb_2)
destroy(this.dw_2)
destroy(this.dw_clin)
destroy(this.ddlb_selectform)
destroy(this.dw_3)
destroy(this.dw_1)
destroy(this.ddlb_format)
end on

event open;integer li_facility_id
integer ss

il_pracid = message.doubleparm
//of_prac_name(il_pracid)

ii_facid = gi_facil_change
ii_facs[1] = ii_facid
//Start Code Change ----01.05.2012 #V12 maha
SELECT priv_template.alt_form into :ii_format   FROM facility, priv_template    WHERE  facility.priv_template = priv_template.template_id   and facility.facility_id = :ii_facid;
//End Code Change ----01.05.2012
//debugbreak()
 //Start Code Change ----06.11.2012 #V12 maha
if ii_format > 0 then 
	choose case ii_format   //Start Code Change ----01.06.2017 #V153 maha - corrected selectitems
		case 0
			ddlb_format.selectitem(2)
		case 1
			ddlb_format.selectitem(4)
		case -1
			ddlb_format.selectitem(1)
		case 3
			ddlb_format.selectitem(5)
		case 4
			ddlb_format.selectitem(6)
		case 5
			ddlb_format.selectitem(3)
		case else
			ddlb_format.selectitem(0)
	end choose
end if
 //End Code Change ----06.11.2012

dw_clin.settransobject(sqlca)
DataWindowChild dwchild

gnv_appeondb.of_startqueue()
//dw_stat. The following script is moved from the constructor event of dw_stat 
dw_stat.retrieve()
dw_stat.GetChild( "status_code", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
//Start Code Change ----10.18.2011 #V12 maha - modified for template functionality.
//dw_batchlist. The following script is moved from the constructor event of dw_batchlist 
dw_batchlist.retrieve()
//debugbreak()

//dw_clin.retrieve() //maha removed 10.11.2011

//dw_clin.retrieve(ii_facid)

//------------------- APPEON BEGIN -------------------
//$<delete> Michael 01.09.2012
//$<reason> Ticket # 00033433: Can't select All 
/*
dw_clin.GetChild( "clinical_area_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(ii_facid)
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "clinical_area_description", "All" )
dwchild.SetItem( 1, "clinical_area_id",0 )
//The following script is modified
dw_clin.insertrow(1)
dw_clin.SetItem( 1, "clinical_area_description", "All" )
dw_clin.SetItem( 1, "clinical_area_id",0 )
ii_clinid = 0
*/
//------------------- APPEON END ---------------------
//dw_clin.GetChild( "clinical_area_id", dwchild )  
//dwchild.settransobject(sqlca)
//End Code Change ----10.18.2011

dw_facility.settransobject(sqlca)

dw_facility.getchild("facility_facility_id",dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)

gnv_appeondb.of_commitqueue()

//------------------- APPEON BEGIN -------------------
//$<add> Michael 01.09.2012
//$<reason> Ticket # 00033433: Can't select All 
dw_clin.GetChild( "clinical_area_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(ii_facid)
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "clinical_area_description", "All" )
dwchild.SetItem( 1, "clinical_area_id",0 )
dw_clin.insertrow(1)
dw_clin.SetItem( 1, "clinical_area_description", "All" )
dw_clin.SetItem( 1, "clinical_area_id",0 )
ii_clinid = 0
//------------------- APPEON END ---------------------

//dw_stat. The following script is moved from the constructor event of dw_stat 
dw_stat.InsertRow( 1 )
dw_stat.GetChild( "status_code", dwchild )
dwchild.settransobject(sqlca)

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "code", "All NOT Requested" )
dwchild.SetItem( 1, "lookup_code", 1 )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "code", "All GRANT or COND" )
dwchild.SetItem( 1, "lookup_code", 2 )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "code", "All" )
dwchild.SetItem( 1, "lookup_code", 0 )

dw_batchlist.insertrow(1) 

of_prac_name(il_pracid) //Start Code Change ----10.26.2011 #V12 maha - moved from above


//dw_facility.retrieve(gs_user_id)
dw_facility.insertrow(1)
if ii_facid < 1 or isnull(ii_facid) then //if no facility passed then get and set default
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-05
	//$<modify> 02.20.2006 By: Cao YongWang
	//$<reason> Performance tuning.
	//$<modification> Write script to retrieve data from a cache instead of from the database.

	/*
	SELECT security_users.default_search_facility  
	INTO :li_facility_id  
	FROM security_users  
	WHERE security_users.user_id = :gs_user_id;
	*/
	li_facility_id = integer(gnv_data.of_getitem("security_users" , "default_search_facility" , "upper(user_id)='" + upper(gs_user_id) + "'"))
	//---------------------------- APPEON END ----------------------------
	
	IF Not IsNull( li_facility_id ) THEN //set user default facility
		dw_facility.SetItem( 1, "facility_facility_id", li_facility_id )
		ii_facid = li_facility_id
	else
	END IF
else
	dw_facility.SetItem( 1, "facility_facility_id", ii_facid )
end if

dw_1.settransobject(sqlca)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-10 By: Rodger Wu (Inova)
//$<reason> Make index 1 as default form/report.

ddlb_selectform.SelectItem( 1 )
ddlb_selectform.Post Event SelectionChanged( 1 )

//---------------------------- APPEON END ----------------------------
//Start Code Change ----03.02.2010 #V10 maha
if w_mdi.of_security_access(40) < 2 or w_mdi.of_security_access(210) < 2 then
	cb_add.visible = false
end if
//End Code Change---03.02.2010

if gi_print_dialog = 1 then cbx_printsetup.checked = true       //Start Code Change ----10.03.2011 #V12 maha - modify to show print dialog box`


end event

event resize;//Start Code Change ----12.12.2011 #V12 maha - made window popup and added resize code
long lx
long lw
long ldw
long ldh

lx = dw_1.x - this.x 
lw = dw_1.y - this.y

dw_1.width = this.width - lx - 125
dw_1.height = this.height - lw - 250
dw_pracs.height = this.height - lw - 250




end event

type cbx_ruler from checkbox within w_renew_priv_form
integer x = 3904
integer y = 152
integer width = 640
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Show Rulers"
end type

event clicked;//added by long.zhang appeon 11.30.2012 Printing the Privileges and Margins
if dw_1.dataobject = "" then return 
if this.checked then
	dw_1.Object.DataWindow.Print.Preview = 'Yes'
	dw_1.Object.DataWindow.Print.Preview.Rulers = 'Yes'
else
	dw_1.Object.DataWindow.Print.Preview.Rulers = 'No'
end if

end event

type st_format from statictext within w_renew_priv_form
boolean visible = false
integer x = 3909
integer y = 284
integer width = 375
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Select Format"
boolean focusrectangle = false
end type

type cbx_eff from checkbox within w_renew_priv_form
boolean visible = false
integer x = 2318
integer y = 420
integer width = 585
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Show Effective Dates"
end type

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-10 By: Rodger Wu (Inova)
//$<reason> This is new object.
//ToDo:
//---------------------------- APPEON END ----------------------------

end event

type mle_text from multilineedit within w_renew_priv_form
boolean visible = false
integer x = 1893
integer width = 142
integer height = 76
integer taborder = 50
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_8 from uo_cb_output within w_renew_priv_form
integer x = 3415
integer y = 344
integer width = 439
integer height = 84
integer taborder = 40
end type

event clicked;

m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(idw)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'EMail'
//NewMenu.m_options.PopMenu(w_mdi.pointerx(),w_mdi.pointerY())
NewMenu.m_options.PopMenu(this.x + parent.x, this.y + parent.y + 90) //alfee 11.17.2010
//this calls events in u_dw
//the save as pdf calls ...
end event

event constructor;call super::constructor;idw = dw_1
end event

type cbx_select from checkbox within w_renew_priv_form
boolean visible = false
integer x = 2318
integer y = 356
integer width = 1033
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Check R box for Granted privs (Forms)"
end type

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-10 By: Rodger Wu (Inova)
//$<reason> This is new object.
//ToDo:
//---------------------------- APPEON END ----------------------------

end event

type cbx_printsetup from checkbox within w_renew_priv_form
integer x = 3904
integer y = 208
integer width = 398
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Printer"
end type

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-10 By: Rodger Wu (Inova)
//$<reason> This is new object.
//ToDo:
//---------------------------- APPEON END ----------------------------

end event

type cbx_history from checkbox within w_renew_priv_form
boolean visible = false
integer x = 2318
integer y = 292
integer width = 946
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Print history privileges"
end type

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-10 By: Rodger Wu (Inova)
//$<reason> This is new object.
//ToDo:
//---------------------------- APPEON END ----------------------------

end event

type st_4 from statictext within w_renew_priv_form
integer x = 2313
integer y = 8
integer width = 448
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Form/Report"
boolean focusrectangle = false
end type

type cbx_cur from checkbox within w_renew_priv_form
integer x = 955
integer y = 308
integer width = 1029
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Print from Practitioner current privileges"
end type

type cb_preview from commandbutton within w_renew_priv_form
integer x = 3415
integer y = 152
integer width = 439
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Preview"
end type

event clicked;//of_dataobject()
of_preview()


end event

type st_3 from statictext within w_renew_priv_form
integer x = 37
integer y = 420
integer width = 887
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Double-Click Name to preview report"
boolean focusrectangle = false
end type

type rb_all from radiobutton within w_renew_priv_form
integer x = 2816
integer y = 196
integer width = 178
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
string text = "All"
end type

type rb_one from radiobutton within w_renew_priv_form
integer x = 2423
integer y = 196
integer width = 320
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
string text = "Individual"
boolean checked = true
end type

type dw_pracs from datawindow within w_renew_priv_form
integer x = 23
integer y = 496
integer width = 846
integer height = 1800
integer taborder = 120
boolean titlebar = true
string title = "Providers"
string dataobject = "d_practitioner_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r

r  = this.getclickedrow()
if r < 1 then return

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

il_pracid = this.getitemnumber(r,"prac_id")
//messagebox("il_pracid",il_pracid)
//dw_browse.settransobject(sqlca)
//dw_browse.retrieve(il_prac,ii_facil)
//of_retrieve_data(is_ret_type)
end event

event retrieveend;//debugbreak()
//if this.rowcount() > 0 then
//	//this.selectrow(0,false)
//	//this.selectrow(1,true)
//	il_prac = this.getitemnumber(1,"prac_id")
//	//of_retrieve_data("R")
//	//messagebox("rc",string(dw_browse.rowcount()))
//	dw_browse.setredraw(true)
//end if
end event

event rowfocuschanged;
//debugbreak()

end event

event doubleclicked;rb_one.checked = true
of_dataobject()
of_preview()
end event

type dw_browse from u_dw within w_renew_priv_form
boolean visible = false
integer x = 1970
integer y = 48
integer width = 165
integer height = 84
integer taborder = 140
boolean titlebar = true
string title = "Requested Privileges"
string dataobject = "d_priv_batch_browse"
boolean hscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

event buttonclicked;call super::buttonclicked;integer i

for i = 1 to this.rowcount()
	this.setitem(i,"selected",1)
next
end event

event clicked;
Integer li_row

li_row = This.GetClickedRow( )

IF li_row < 1 THEN
	Return
END IF


This.ScrollToRow( li_row )
This.SetRow( li_row )
//this.selectrow(0,false)
//this.selectrow(li_row,true)

end event

event doubleclicked;call super::doubleclicked;
//long ll_core
//integer li_row
//integer li_end
//
//if this.rowcount() > 0 then
//	tab_1.selecttab (2)
//	
//end if
end event

event rowfocuschanged;call super::rowfocuschanged;
//IF tab_1.tabpage_detail.dw_detail.RowCount() >= currentrow THEN
	//tab_1.tabpage_detail.dw_detail.SetRow( currentrow )
	//tab_1.tabpage_detail.dw_detail.ScrollToRow( currentrow )
//END IF
//this.selectrow(0,false)
//this.selectrow(this.getrow(),true)

//st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())
end event

event pfc_deleterow;integer r
integer res

res = messagebox("Delete","Are you sure you wish to delete the selected privilege?",Question!,yesno!,2)

if res = 1 then
	r = this.getrow()
	of_add_audit_priv_prac( "PracDel", this, r) //Start Code Change ----12.14.2009 #V10 maha - auditing
	this.deleterow(r)
end if

this.update()

return 0
end event

event pfc_addrow;call super::pfc_addrow;//
integer li_rows
integer li_newrow
long ll_recno
long ll_procd
long ll_core
integer li_ir_stat
string ls_procd
long ll_clin
string ls_clin
string ls_core
integer r
g_str_clin_info lstr_priv
integer li_rowcount
long ll_code
integer checkrow
integer res
date ld_start
date ld_end
date nulldate
long ll_rqs


//Start Code Change ----02.27.2008 #V8 maha
openwithparm(w_clin_area_select,"B*" + string(ii_facid) + "@" + string(il_pracid) )
//openwithparm(w_clin_area_select,"B*" + string(ii_facil))
//End Code Change---02.27.2008

setnull(nulldate)
lstr_priv = message.powerobjectparm
debugbreak()
if isnull(lstr_priv) then return 0


li_rowcount = lstr_priv.row_count
//messagebox("li_rowcount",li_rowcount)
ll_clin = lstr_priv.clin_id
ll_code = lstr_priv.stat
li_ir_stat = lstr_priv.appnt
//messagebox("start",string(lstr_priv.dstart))
//messagebox("end",string(lstr_priv.dend))
if string(lstr_priv.dstart) = "1/1/1900" then
	//messagebox("1/1/1900","1/1/1900")
	ld_start = nulldate
else
	//messagebox("1/1/1900","else")
	ld_start = lstr_priv.dstart
end if
if string(lstr_priv.dend) = "1/1/1900" then
	ld_end  = nulldate
else
	ld_end = lstr_priv.dend
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<modify> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
///$<modification> Write script to retrieve data from a cache instead of from the database.

//select lookup_code into :ll_rqs from code_lookup where lookup_name = 'Privilege Status'  and code = 'REQST';
ll_rqs = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name)='" +upper('Privilege Status')+ "' and upper(code)='REQST'"))
//---------------------------- APPEON END ----------------------------

if ll_rqs < 1 then
	messagebox("Lookup table error", "Unable to find the Requested Status Record.  Records not Added.~rCheck your Privilege Status lookup table for a record with the code of 'REQST' ")
	return 0
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<add> 02.14.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
n_ds lds_prac
long ll_find

lds_prac = create n_ds
lds_prac.dataobject = "d_priv_core_procd_all"
lds_prac.of_settransobject(SQLCA)

gnv_appeondb.of_startqueue()
lds_prac.retrieve(lstr_priv.priv_ids[])	

//---------------------------- APPEON END ----------------------------
dw_browse.settransobject(sqlca)
dw_browse.reset()
	SELECT Max( pd_priv_list.rec_id )
	INTO :ll_recno  
	FROM pd_priv_list;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<add> 02.17.2006 By: Wangchao
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------		

if isnull(ll_recno) then ll_recno = 0

for r = 1 to li_rowcount
	checkrow = 0
	ll_procd = lstr_priv.priv_ids[r]
	//check to see if already exists
//	select pd_priv_list.rec_id
//	into :checkrow
//	from pd_priv_list
//	where pd_priv_list.procd_id = :ll_procd and pd_priv_list.prac_id = :gl_prac_id and pd_priv_list.facility_id = :gi_facil_change and pd_priv_list.active_status = 1;
//	//checkrow = this.find("procd_id = " + string(ll_procd),1,this.rowcount())
//	//messagebox("checkrow",checkrow)
//	if checkrow > 0 then
//		continue
//	end if
	//create new row
	dw_browse.insertrow (r)	
		
 
	
	ll_recno++
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-09
	//$<modify> 02.14.2006 By: Wangchao
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.

	/*
	SELECT priv_core_procd.priv_core_id 
	INTO :ll_core  
	FROM priv_core_procd
	where priv_core_procd.procd_id = :ll_procd;
	*/
	ll_find = lds_prac.find("priv_core_procd_procd_id="+string(ll_procd),1,lds_prac.rowcount())
	If ll_find > 0 then ll_core = lds_prac.getitemnumber(ll_find , 'priv_core_procd_priv_core_id')
	//---------------------------- APPEON END ----------------------------

	//messagebox("ll_core ",ll_core )
	dw_browse.setitem(r,"rec_id",ll_recno)
	dw_browse.setitem(r,"facility_id",ii_facid)
	dw_browse.setitem(r,"prac_id",il_pracid)
//	il_clin = dw_store.getitemnumber(li_newrow,"priv_core_clinical_area_id")
	dw_browse.setitem(r,"clinical_area_id",ll_clin)
	dw_browse.setitem(r,"priv_core_id",ll_core)
	dw_browse.setitem(r,"procd_id",ll_procd)
	dw_browse.setitem(r,"active_status",1)
	dw_browse.Setitem(r,"ir_code",li_ir_stat)
	if string(lstr_priv.dstart) <> "1/1/1900" then
		dw_browse.Setitem(r,"start_date",ld_start)
	end if
	if string(lstr_priv.dend) <> "1/1/1900" then
		dw_browse.Setitem(r,"end_date",ld_end)
	end if
	//dw_browse.Settext("Inital")

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-10
	//$<modify> 02.14.2006 By: Wangchao
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.

	/*
	SELECT priv_core.priv_core_description 
	INTO :ls_core  
	FROM priv_core,priv_core_procd
	WHERE priv_core.priv_core_id = priv_core_procd.priv_core_id AND priv_core_procd.procd_id = :ll_procd;
	//messagebox("ls_core ", ls_core )
	SELECT priv_core_procd.core_procd_description 
	INTO :ls_procd  
	FROM priv_core_procd
	WHERE priv_core_procd.procd_id = :ll_procd;
	*/
		
	If ll_find > 0 then 
		ls_core = lds_prac.GetItemString(ll_find , 'priv_core_priv_core_description')
		ls_procd = lds_prac.GetItemString(ll_find , 'priv_core_procd_core_procd_description')
	End If
	//---------------------------- APPEON END ----------------------------
	//ls_procd = dw_store.getitemstring(li_newrow,"core_procd_description")
	dw_browse.setitem(r,"pd_priv_list_priv_text",ls_procd)

	dw_browse.setitem(r,"status_code",ll_rqs)
	dw_browse.setitem(r,"enter_date",datetime(today(),now()))
	//ls_core = dw_store.getitemstring(li_newrow,"priv_core_priv_core_description")
	dw_browse.setitem(r,"priv_core_priv_core_description",ls_core)
	
NEXT
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<add> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_autocommit()
//---------------------------- APPEON END ----------------------------

of_add_audit_priv_prac(  "PracAdd",  this,0) //Start Code Change ----12.14.2009 #V92 maha - for audit

this.update()
commit using sqlca;
//messagebox("","")
//of_retrieve_data(is_type)



return 1
end event

event pfc_preupdate;call super::pfc_preupdate;//Start Code Change ----12.14.2009 #V10 maha - auditing
of_add_audit_priv_prac( "Prac", this,0)

return 1
end event

type cb_add from commandbutton within w_renew_priv_form
integer x = 3419
integer y = 60
integer width = 439
integer height = 84
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Privileges"
end type

event clicked;dw_browse.triggerevent("pfc_addrow")
end event

type st_2 from statictext within w_renew_priv_form
integer x = 32
integer y = 164
integer width = 375
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Select Batch List"
boolean focusrectangle = false
end type

type st_facil from statictext within w_renew_priv_form
integer x = 32
integer y = 16
integer width = 375
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Facility "
boolean focusrectangle = false
end type

type dw_facility from datawindow within w_renew_priv_form
integer x = 32
integer y = 68
integer width = 809
integer height = 84
integer taborder = 90
string dataobject = "d_facility_users_batch"
boolean border = false
boolean livescroll = true
end type

event itemchanged;datawindowchild dwchild

ii_facid = integer(data)

SELECT priv_template.alt_form into :ii_format   FROM facility, priv_template    WHERE  facility.priv_template = priv_template.template_id   and facility.facility_id = :ii_facid;
dw_clin.GetChild( "clinical_area_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(ii_facid)
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "clinical_area_description", "All" )
dwchild.SetItem( 1, "clinical_area_id",0 )

ii_clinid = 0

//------------------- APPEON BEGIN -------------------
//$<add> Michael 01.09.2012
//$<reason> Ticket # 00033433: Can't select All 
dw_clin.SetItem( 1, "clinical_area_description", "All" )
dw_clin.SetItem( 1, "clinical_area_id",0 )
//------------------- APPEON END ---------------------
end event

type dw_batchlist from datawindow within w_renew_priv_form
integer x = 32
integer y = 220
integer width = 850
integer height = 84
integer taborder = 150
string dataobject = "d_d_batch_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;
long ll_batch
integer i
integer ic

ll_batch = long(data)

dw_list.settransobject(sqlca)
ic = dw_list.retrieve(ll_batch)

if ic > 0 then
	for i = 1 to ic
		il_pracs[i] = dw_list.getitemnumber(i,"prac_id")
	next
	
	dw_pracs.retrieve(il_pracs[])
	rb_all.checked = true
end if
//dw_list.InsertRow( 1 )
//dw_list.GetChild( "full_name", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve(ll_batch)

end event

event constructor;this.settransobject(sqlca)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<comment> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Move the following script to the Open event of w_renew_priv_form
//$<modification> due to the usage of CreateOnDemand.
/*
this.retrieve()
this.insertrow(1) 
*/
//---------------------------- APPEON END ----------------------------

end event

type dw_list from datawindow within w_renew_priv_form
boolean visible = false
integer x = 471
integer y = 188
integer width = 59
integer height = 80
integer taborder = 70
string dataobject = "d_batch_items_prac_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_pracid = long(data)

of_prac_name(il_pracid)
end event

type st_1 from statictext within w_renew_priv_form
integer x = 942
integer y = 168
integer width = 722
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Clin Area/Department"
boolean focusrectangle = false
end type

type dw_stat from datawindow within w_renew_priv_form
integer x = 942
integer y = 72
integer width = 663
integer height = 72
integer taborder = 100
string dataobject = "d_dddw_priv_status"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-13
//$<comment> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
/*
DataWindowChild dwchild
this.retrieve()
this.InsertRow( 1 )
This.GetChild( "status_code", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()


dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "code", "All NOT Requested" )
dwchild.SetItem( 1, "lookup_code", 1 )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "code", "All GRANT or COND" )
dwchild.SetItem( 1, "lookup_code", 2 )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "code", "All" )
dwchild.SetItem( 1, "lookup_code", 0 )
*/
//---------------------------- APPEON END ----------------------------
end event

event itemchanged;integer li_row
long ll_status
string filt
string filtname
datawindowchild dwchild
integer fnd

ll_status = long(data)
//messagebox("",ll_status)
il_status = ll_status


if ll_status = 1 then //not requested
	this.getchild("status_code",dwchild)
	fnd = dwchild.find("code = 'REQST'",1,dwchild.rowcount())
	if fnd < 1 then
		messagebox("Find error","Can't find Reqst code")
		return
	else
		il_reqst = dwchild.getitemnumber(fnd,"lookup_code")
		//filt = "status_code <> " + string(ll_status)
	end if
end if

if dw_1.dataobject = "d_prac_priv_list_all_status" or dw_1.dataobject = "d_prac_priv_list_all_status_w_notes" then
	of_filter(ll_status)
end if
end event

type st_stat from statictext within w_renew_priv_form
integer x = 942
integer y = 20
integer width = 375
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Status Filter "
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_renew_priv_form
integer x = 3890
integer y = 60
integer width = 439
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
boolean cancel = true
end type

event clicked;Close(parent)
end event

type cb_print from commandbutton within w_renew_priv_form
integer x = 3415
integer y = 248
integer width = 439
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;integer i
integer orgrow

//of_dataobject()

//Start Code Change ----07.22.2009 #V92 maha - allow printer selection
if cbx_printsetup.checked then
	printsetup()
end if
//End Code Change---07.22.2009

if rb_one.checked then
	of_preview()
//	if ii_clinid < 0 then
//		return
//	end if

	dw_1.print()

else
	for i = 1 to dw_pracs.rowcount()
		dw_pracs.selectrow(0,false) //mark the row being printed
		dw_pracs.selectrow(i,true)
		il_pracid = dw_pracs.getitemnumber(i,"prac_id")
		of_preview()
//		if ii_clinid < 0 then
//			return
//		end if
		if dw_1.rowcount() > 0 then //100903 //Start Code Change ---- 05.12.2006 #473 maha cvorrected from > 1
			dw_1.print()
		end if
	next
	dw_pracs.setrow(1)
	dw_pracs.selectrow(0,false)
	dw_pracs.selectrow(1,true)
end if
end event

type gb_2 from groupbox within w_renew_priv_form
integer x = 2318
integer y = 152
integer width = 997
integer height = 128
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Print Process"
end type

type dw_2 from datawindow within w_renew_priv_form
boolean visible = false
integer x = 1906
integer y = 340
integer width = 265
integer height = 80
integer taborder = 30
string dataobject = "d_prac_priv_list_compare"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor; //Start Code Change ----04.27.2017 #V153 maha - changed dwo to d_prac_priv_list_compare
end event

type dw_clin from datawindow within w_renew_priv_form
integer x = 937
integer y = 224
integer width = 997
integer height = 84
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dddw_clin_area2"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_clinid = integer(data)

if ii_clinid > 0 then
	is_clin_filter = "priv_clinical_area_clinical_area_id = " + string(ii_clinid)
else
	is_clin_filter = ""
end if
end event

event constructor;//DataWindowChild dwchild
//this.retrieve()
//this.InsertRow( 1 )
//This.GetChild( "clinical_area_description", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve(ii_facid)
//
//
//dwchild.InsertRow( 1 )
//dwchild.SetItem( 1, "clinical_area_description", "All" )
//dwchild.SetItem( 1, "clinical_area_id",0 )
end event

type ddlb_selectform from dropdownlistbox within w_renew_priv_form
integer x = 2318
integer y = 60
integer width = 997
integer height = 656
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Privileges Without Notes","Privileges With Notes","Request Form with Headers","Request Form with Detail","Comparison Report","Complete Privilege Application w/ Description"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-09 By: Rodger Wu (Inova)
//$<reason> Attention: This is a new object.
//$<reason> Attention: Remove 6 radio button objects.
/*
Attention!!!

3 Datawindows modified:
  d_form_priv_acknowledgement_col adds 2 signaturelines for a total of 5.
  d_form_pract_priv_request_d and d_form_pract_priv_request_h add a signature and date line at the bottom.
  
4 New Datawindow:
  d_form_pract_priv_request_d_inova
  d_form_clin_priv_request_master_inova
  d_prac_priv_list_history
  d_prac_priv_list_history_w_notes
*/

//Start Code Change ---- 11.08.2007 #V7 maha
cb_preview.enabled = true
cb_Print.enabled = true

IF index > 0 THEN
	ii_selectedform = index
	cbx_select.visible = False  //Start Code Change ----03.03.2016 #V15 maha
	cbx_history.visible = False	//Start Code Change ----03.03.2016 #V15 maha
	Choose Case index
		Case 1,2  //reports
			cbx_history.Enabled = True
			cbx_history.visible = True	//Start Code Change ----03.03.2016 #V15 maha
			cbx_cur.Enabled = True  //Start Code Change ----01.05.2012 #V12 maha - change from false
			cbx_select.enabled = False  //Start Code Change ----03.15.2011 #V11 maha - added checkbox	
			ib_single_only = False  //Start Code Change ----01.05.2012 #V12 maha - added ib_single_only variable
		Case 3,4  //request forms
			choose case ii_format
				case 3,4
					cbx_history.Enabled = False
					cbx_cur.Enabled = False
					cbx_select.enabled = False
					ib_single_only = True
				case 1
					cbx_history.Enabled = False
					cbx_cur.Enabled = True
					cbx_select.enabled = False
					ib_single_only = False	
				case else
					cbx_history.Enabled = False
					cbx_cur.Enabled = True
					cbx_select.enabled = True
					cbx_select.visible = True //Start Code Change ----03.03.2016 #V15 maha
					ib_single_only = False 
			end choose
		case 5 //comparison
			cbx_history.Enabled = False
			cbx_cur.Enabled = True
			cbx_cur.checked = True
			cbx_select.enabled = False
			ib_single_only = False  //Start Code Change ----01.05.2012 #V12 maha - added ib_single_only variable
		Case 6 //complete application
			cbx_history.Enabled = False
			cbx_cur.Enabled = False
			cbx_cur.checked = False
			cbx_select.enabled = False
			ib_single_only = True  //Start Code Change ----01.05.2012 #V12 maha - added ib_single_only variable
		case 7//Start Code Change ---- 11.08.2007 #V8 maha //report with Dept/ Staff cat data
			//Start Code Change ----04.11.2012 #V12 maha - removed from the list as is has never been usable
			//Privileges With Staff Cat/Dept data
			//messagebox("New Report","Under developent")
			//Start Code Change ----07.21.2009 #V92 maha
//			cbx_history.Enabled = false
//			cbx_cur.Enabled = true
//			cbx_cur.checked = true
//			cb_preview.enabled = true
//			cb_Print.enabled = true
//			cbx_select.enabled = False
//			ib_single_only = False  //Start Code Change ----01.05.2012 #V12 maha - added ib_single_only variable
			//End Code Change---07.21.2009
	End Choose
//End Code Change---11.08.2007
END IF

of_dataobject( )
//---------------------------- APPEON END ----------------------------

end event

type dw_3 from datawindow within w_renew_priv_form
boolean visible = false
integer x = 1961
integer y = 112
integer width = 242
integer height = 72
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_distinct_clin_for_prac"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from u_dw within w_renew_priv_form
integer x = 928
integer y = 496
integer width = 3488
integer height = 1800
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_prac_priv_list_all_status"
end type

type ddlb_format from dropdownlistbox within w_renew_priv_form
integer x = 3899
integer y = 348
integer width = 411
integer height = 508
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Format 1 (ORG)","Format 1  Alt","Format 1 (V3)","Format 2","Format 3","Format 4","Custom M6"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//Start Code Change ----06.11.2012 #V12 maha - added selector
//Start Code Change ----10.01.2013 #V14 maha - changed for added 1 alt
choose case index
	case 1 //1
		ii_format = 0
	case 2 //1alt
		ii_format = -1
	case 3 //5 Added by Appeon long.zhang 09.18.2015 (Bug # 4721 for Case #00056366 Privilege Lists)
		ii_format = 5
	case 4 //2
		ii_format = 1
	case 5 //3
		ii_format = 3
	case 6 //4,
		ii_format = 4
	case 7 //cm6   //Start Code Change ----04.25.2017 #V153 maha - 
		ii_format = 6
end choose

of_dataobject( )
end event

