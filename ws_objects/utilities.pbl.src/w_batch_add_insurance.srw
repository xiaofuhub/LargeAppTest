$PBExportHeader$w_batch_add_insurance.srw
forward
global type w_batch_add_insurance from w_master
end type
type st_pracs from statictext within w_batch_add_insurance
end type
type cb_prac from commandbutton within w_batch_add_insurance
end type
type cb_batch from commandbutton within w_batch_add_insurance
end type
type dw_select_section from datawindow within w_batch_add_insurance
end type
type dw_table from datawindow within w_batch_add_insurance
end type
type dw_pracs from datawindow within w_batch_add_insurance
end type
type cb_run from commandbutton within w_batch_add_insurance
end type
type dw_list from datawindow within w_batch_add_insurance
end type
type rb_ins from radiobutton within w_batch_add_insurance
end type
type rb_add from radiobutton within w_batch_add_insurance
end type
type cb_1 from commandbutton within w_batch_add_insurance
end type
type gb_3 from groupbox within w_batch_add_insurance
end type
type dw_3 from datawindow within w_batch_add_insurance
end type
type dw_2 from datawindow within w_batch_add_insurance
end type
type dw_detail from u_dw within w_batch_add_insurance
end type
type st_1 from statictext within w_batch_add_insurance
end type
type dw_verifww from datawindow within w_batch_add_insurance
end type
type dw_verif from u_dw within w_batch_add_insurance
end type
type gb_prac from groupbox within w_batch_add_insurance
end type
end forward

global type w_batch_add_insurance from w_master
integer width = 3643
integer height = 2332
string title = "Batch Add Data"
long backcolor = 33551856
boolean ib_disableclosequery = true
st_pracs st_pracs
cb_prac cb_prac
cb_batch cb_batch
dw_select_section dw_select_section
dw_table dw_table
dw_pracs dw_pracs
cb_run cb_run
dw_list dw_list
rb_ins rb_ins
rb_add rb_add
cb_1 cb_1
gb_3 gb_3
dw_3 dw_3
dw_2 dw_2
dw_detail dw_detail
st_1 st_1
dw_verifww dw_verifww
dw_verif dw_verif
gb_prac gb_prac
end type
global w_batch_add_insurance w_batch_add_insurance

type variables
long il_pracid
long il_pracs[]

integer ii_clinid
integer ii_facid
integer ii_facs[]
integer ii_screen
long il_status
long il_reqst
string is_clin_filter
string is_prac_name
string is_prac_names[]
integer ii_message
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.17.2006 By: Jack (Inova)
//$<reason> Required Documents Check Box on Data Entry Screen
string is_reference
//---------------------------- APPEON END ----------------------------
//Start Code Change ----04.21.2009 #V92 maha - moved from of_creatr_verif
n_ds ids_ver_orgs_facilities
//n_ds ids_last_verif_seq_no
n_ds ids_dfl_rsp_code
n_ds ids_parent_facilities//maha 011201
n_ds ids_verif_facilities//maha 011201
//End Code Change---04.21.2009

pfc_cst_nv_data_entry_functions inv_data_entry //alfee 07.18.2013
end variables

forward prototypes
public function integer of_create_verif (string as_reference)
public function string of_prac_name (long ai_pracid)
end prototypes

public function integer of_create_verif (string as_reference);/*There is an issue with verifications created for facility specific data screens.
If the verifying facility is common across parents, multiple verifs could be connected to the same
verifying facility.  
*///04-2002
//Start Code Change ----04.21.2009 #V92 maha - rewrote this function and the cb_run clicked event
// prior performanc tuning implemented improperly and actually slowed function.
//moved n_ds to instance variables and moved create/destroy/retireve to cb_run
//app audit functionality need to be rewritten for auto gen
Integer li_nr
Integer li_nr2 //maha 010401
Integer li_row_cnt
Integer li_rc
Integer i
Integer r
integer cnt1
integer cnt2
Integer ll_hc_code
Integer li_rsp_rc
Integer li_facility_id
Integer li_priority
integer li_dupe_check //maha 010401
integer li_isprime //maha 010901
integer resp //maha 010901
integer li_parent_id //maha 020901
integer li_date_check //maha 010901
integer li_fac_ids//maha 011001
integer pc//maha 011001
integer pi//maha 011001
integer li_end_year//maha 012301
integer li_end_month//maha 012301
integer li_end_day// maha 031201
integer li_check_back_years
integer li_prime_check//maha 012201
Integer li_facility_id_first = -1

long li_seq_no
Long ll_default_verif_method
long ll_address_lookup_code
long ll_prac
long ll_rec
double ll_fee

String ls_identifying_number
string ls_facility_name//maha 011001
String ls_doc_id
String ls_priority_user
string ls_primary_check //maha 010901
string ls_screen_name //maha 010401
string ls_appt_type = "R" //maha 012401
string ls_verif_data //maha 012401
string ls_mes //maha 111308
string ls_add_type = "A"
string ls_prac

datetime ld_verifdate //maha 010901
datetime ld_dr //jad 06/03/02
date ld_hosp_check_date//maha 012201
date ld_data_check_date//maha 031501

ll_address_lookup_code = dw_detail.getitemnumber(1,"carrier_code")
IF ll_address_lookup_code = 0 THEN
	SetNull( ll_address_lookup_code )
END IF

ll_prac = dw_detail.GetItemNumber( 1, "prac_id" ) 
ll_rec = dw_detail.GetItemNumber( 1, "rec_id" )

gnv_appeondb.of_startqueue( )
cnt1 = ids_dfl_rsp_code.Retrieve( ll_prac, 15, ls_identifying_number )
li_rc = ids_verif_facilities.Retrieve( ll_prac,15 ) //Start Code Change ----04.21.2009 #V92 maha - changed arg from 10 to 15
if not isnull(ll_address_lookup_code) then
	select fee into :ll_fee from address_lookup where lookup_code = : ll_address_lookup_code; // alfee 07.18.2013
end if
gnv_appeondb.of_commitqueue( )

cnt1=ids_dfl_rsp_code.rowcount( )  // alfee 01.29.2015
li_rc=ids_verif_facilities.rowcount( ) // alfee 01.29.2015

ids_verif_facilities.setsort("verifying_facility A")
ids_verif_facilities.sort()

li_rsp_rc = ids_dfl_rsp_code.rowcount()

FOR i = 1 TO li_rc//li_ver_fac_cnt
	debugbreak()
	li_date_check = 0
	li_facility_id = ids_verif_facilities.GetItemNumber( i, "verifying_facility" )
	ls_facility_name = ids_verif_facilities.GetItemstring( i, "facility_name" )
	ls_verif_data = ids_verif_facilities.GetItemstring( i, "verify_data" )
	if ls_verif_data = "N" then continue	

	ids_parent_facilities.setfilter('verifying_facility='+string(li_facility_id)+' and prac_id='+string(ll_prac))
	ids_parent_facilities.filter()
	pc=ids_parent_facilities.rowcount()
	
	if pc < 1 then messagebox("Error","No retrieval on parents of verif facility")
	//checking all parents appttype to see if verif should be created maha 012401
			ls_appt_type = "R"
	for pi = 1 to pc
		if ls_appt_type = "R" and ids_parent_facilities.GetItemstring( pi, "apptmnt_type" )  = "I" then
			ls_appt_type = "I"
		end if
		//checking verifs completed date for all parents		
		ld_verifdate = ids_parent_facilities.GetItemdatetime( pi, "date_verif_completed" )
		if not(isnull(ld_verifdate)) then
			li_date_check = 1		
			exit
		end if
	next
	//if ALL parents are recred and data item is Inital only, don't create.
	if ls_verif_data = "I" and ls_appt_type = "R" then continue

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-04
	//$<modify> 02.13.2006 By: Wangchao
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.
	
	//Start Code Change ---- 10.16.2007 #V7 maha
	//because this was poorly implemented and never tested, reverting to original code
	if li_date_check = 1 then
		//Start Code Change ----11.03.2008 #V85 maha = added option for yes or no all
		if ii_message < 2 then // 0 =  no or first time; yes = 1;    3 = yes all;      4 = no all
			ls_prac = of_prac_name(ll_prac)
			ls_mes = "The verification process has been completed for all Appointments for the verifying facility " + ls_facility_name + " for practitioner " + ls_prac + " . Do you want to add the verification item?"
			openwithparm(w_verif_compl_message,ls_mes)
			ii_message = message.doubleparm
			//-----------appeon begin-------------
			//<$>Modified:long.zhang 11.06.2012
			//<$>reason:Fixed BugS110101 verification update failed
			//	if ii_message = 0 or ii_message = 4 then continue //no or no all
			if ii_message = 0 then continue
			if ii_message = 4 then return 1
			//-----------appeon end---------------
		end if
		//resp = messagebox("Verifications Completed" ,"The verification process has been completed for all Appointments for the verifying facility " + ls_facility_name + " for practitioner " + ls_prac + " . Do you want to add the verification item.",question!,yesno!,2)
		//if resp = 2 then continue
	end if
	//End Code Change---11.13.2008

	ids_ver_orgs_facilities.setfilter('verifying_facility='+string(li_facility_id)+' and prac_id='+string(ll_prac)+' and screen_id=15')
	ids_ver_orgs_facilities.filter()
	r=ids_ver_orgs_facilities.rowcount()	
	//---------------------------- APPEON END ----------------------------
	
	if r < 1 then continue
	
	IF ids_ver_orgs_facilities.GetItemString( r, "verify_data" ) = "N" AND ls_add_type = "A" THEN
		CONTINUE
	END IF
		
	ll_default_verif_method = ids_ver_orgs_facilities.GetItemNumbeR( r, "default_verif_means" )		

	li_nr = dw_verif.InsertRow( 0 )
	ls_priority_user = ids_ver_orgs_facilities.GetItemString( r, "priority_user" )	
	li_priority = ids_ver_orgs_facilities.GetItemNumber( r, "priority" )	
 
	dw_verif.SetItem( li_nr, "prac_id", ll_prac )
	dw_verif.SetItem( li_nr, "rec_id", ll_rec )
	//dw_verif.SetItem( li_nr, "facility_id", li_facility_id )
	dw_verif.SetItem( li_nr, "verif_info_facility_id", li_facility_id )
	dw_verif.SetItem( li_nr, "priority_user", ls_priority_user )
	dw_verif.SetItem( li_nr, "priority", li_priority )
	dw_verif.SetItem( li_nr, "number_sent", 0 )
	dw_verif.SetItem( li_nr, "exp_credential_flag", 0)
	dw_verif.SetItem( li_nr, "active_status", 1)
	dw_verif.SetItem( li_nr, "verif_info_data_status", dw_detail.getitemnumber(1,"active_status") ) //Start Code Change ----08.04.2008 #V85 maha - added data_status update

	//06/03/02
	//added in for IntelliApp only users,  need this entry auto verified so intellicred can gen exp letters when due
	IF Upper( gs_cust_type ) = 'I' THEN
			  dw_verif.SetItem( li_nr, "response_code", 326 )		
			  ld_dr = DateTime( Today(), Now() )
			  dw_verif.SetItem( li_nr, "date_recieved", ld_dr )					  
			  dw_verif.SetItem( li_nr, "user_name", 'System' )					  			  
	END IF	
		
	IF li_rsp_rc = 1 THEN//maha 04.21.09 - this code will not run because the retrieval will never retrieve anything.  should be rewritten to be 
							//consistant with the dataentry code and create app audit items via auto gen
		dw_verif.SetItem( li_nr, "response_code", ids_dfl_rsp_code.GetItemNumber( 1, "default_ver_response" ))
		dw_verif.SetItem( li_nr, "user_name", ls_priority_user )
		dw_verif.SetItem( li_nr, "date_recieved", Today() )
		ll_hc_code = Long(gnv_data.of_getitem('code_lookup','lookup_code','code="Hard Copy"'))
		dw_verif.SetItem( li_nr, "verification_method", ll_hc_code )				
	ELSE
		//added in for IntelliApp only users,  need this entry auto verified so intellicred can gen exp letters when due
		IF Upper( gs_cust_type ) = 'I' THEN
			  dw_verif.SetItem( li_nr, "response_code", 326 )		
			  ld_dr = DateTime( Today(), Now() )
			  dw_verif.SetItem( li_nr, "date_recieved", ld_dr )					  
			  dw_verif.SetItem( li_nr, "user_name", 'System' )					  			  
		END IF
		//set verif method only
		dw_verif.SetItem( li_nr, "verification_method", ll_default_verif_method )		
	END IF

	li_seq_no = 1 
	dw_verif.SetItem( li_nr, "seq_no", li_seq_no )		
	dw_verif.SetItem( li_nr, "screen_id", 15)
	dw_verif.SetItem( li_nr, "reference_value",MidA(as_reference,1,100)) //maha added mid 022504 as trap for overlong values.as_reference )
	dw_verif.SetItem( li_nr, "expiration_date", dw_detail.getitemdatetime(1,"coverage_to"))
	dw_verif.SetItem( li_nr, "screen_name", "Insurance" )
	
	dw_verif.SetItem( li_nr, "address_lookup_code", ll_address_lookup_code )
	
	//Start Code Change ----12.19.2012 #V12 maha
	if not(isnull(ll_address_lookup_code)) then
		//select fee into :ll_fee from address_lookup where lookup_code = : ll_address_lookup_code; - moved above - alfee 07.18.2013
	end if
	
	if ll_fee = 0 then
		setnull( ll_fee )
	end if
	if not isnull( ll_fee ) then
		dw_verif.SetItem( li_nr, "verif_info_fee", ll_fee )
	end if
	
	dw_verif.SetItem(li_nr, 'create_date', datetime(today(),now()))
	dw_verif.SetItem(li_nr, 'create_user', gs_user_id)
	//End Code Change ----12.19.2012

	ls_doc_id = String( ll_rec ) + "-" + String( ll_prac ) + "-" + String( li_facility_id ) +  "-" + String( li_seq_no )
	dw_verif.SetItem( li_nr, "doc_id", ls_doc_id )
	//\/maha added for pix last updated 041801
	//check to see if letter should be duplicated
END FOR

dw_verif.SetFocus()
dw_verif.ScrollToRow( li_nr )
dw_verif.SetRow( li_nr )
//End Code Change---04.21.2009

resp = dw_verif.Update()
if resp < 1 then //maha 072204
	messagebox("Update failure" ,"Update failed in of_add_record of pfc_cst_u_verification_info")
else
	commit using sqlca;
end if

RETURN 1
end function

public function string of_prac_name (long ai_pracid);string ls_prac_name

//_pracs.retrieve(il_pracs[])
select full_name into :ls_prac_name from v_full_name where prac_id = :ai_pracid;
//is_prac_name = ls_prac_name

return  ls_prac_name
end function

event open;call super::open;integer li_facility_id
integer s
integer f
datawindowchild dwchild

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.28.2016
//<$>reason:Use resize function
this.of_SetResize(TRUE)
this.inv_resize.of_SetOrigSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
this.inv_resize.of_SetMinSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())

this.inv_resize.of_register(dw_pracs ,inv_resize.scale)
this.inv_resize.of_register(dw_detail ,inv_resize.scale)
//------------------- APPEON END -------------------

inv_data_entry = Create pfc_cst_nv_data_entry_functions //alfee 07.18.2013

//--------------------------- APPEON BEGIN ---------------------------
//$<PT-10>
//$<modify> 02.10.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
il_pracid = message.doubleparm
of_prac_name(il_pracid)

dw_detail.settransobject(sqlca)
dw_detail.GetChild( "carrier_code", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve("Insurance Companies")
dwchild.insertrow(1)
dw_detail.GetChild( "claims_made_occurrence", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve("Coverage Type")
dwchild.insertrow(1)

dw_select_section.settransobject(sqlca)
s = dw_select_section.retrieve(1)
*/

il_pracid = message.doubleparm

//of_prac_name(il_pracid)

dw_detail.GetChild( "claims_made_occurrence", dwchild )
dwchild.settransobject(sqlca)
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('Coverage Type') + "'", dwchild)
dwchild.insertrow(1)
dw_detail.settransobject(sqlca)
dw_detail.GetChild( "carrier_code", dwchild )
dwchild.settransobject(sqlca)

dw_select_section.settransobject(sqlca)

gnv_appeondb.of_startqueue( )

dwchild.retrieve("Insurance Companies")
dw_select_section.retrieve(1)

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

dwchild.insertrow(1)
s=dw_select_section.rowcount()

dw_select_section.setfilter("screen_id = 15")
dw_select_section.filter()
//if f < 1 then
//	messagebox("Error","No Find")
//else
//	dw_select_section.scrolltorow(f)
//	dw_select_section.setrow(f)
//end if

dw_detail.insertrow(1)
dw_detail.setitem(1,"active_status",1)
dw_verif.settransobject(sqlca)
end event

on w_batch_add_insurance.create
int iCurrent
call super::create
this.st_pracs=create st_pracs
this.cb_prac=create cb_prac
this.cb_batch=create cb_batch
this.dw_select_section=create dw_select_section
this.dw_table=create dw_table
this.dw_pracs=create dw_pracs
this.cb_run=create cb_run
this.dw_list=create dw_list
this.rb_ins=create rb_ins
this.rb_add=create rb_add
this.cb_1=create cb_1
this.gb_3=create gb_3
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_detail=create dw_detail
this.st_1=create st_1
this.dw_verifww=create dw_verifww
this.dw_verif=create dw_verif
this.gb_prac=create gb_prac
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_pracs
this.Control[iCurrent+2]=this.cb_prac
this.Control[iCurrent+3]=this.cb_batch
this.Control[iCurrent+4]=this.dw_select_section
this.Control[iCurrent+5]=this.dw_table
this.Control[iCurrent+6]=this.dw_pracs
this.Control[iCurrent+7]=this.cb_run
this.Control[iCurrent+8]=this.dw_list
this.Control[iCurrent+9]=this.rb_ins
this.Control[iCurrent+10]=this.rb_add
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.dw_3
this.Control[iCurrent+14]=this.dw_2
this.Control[iCurrent+15]=this.dw_detail
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.dw_verifww
this.Control[iCurrent+18]=this.dw_verif
this.Control[iCurrent+19]=this.gb_prac
end on

on w_batch_add_insurance.destroy
call super::destroy
destroy(this.st_pracs)
destroy(this.cb_prac)
destroy(this.cb_batch)
destroy(this.dw_select_section)
destroy(this.dw_table)
destroy(this.dw_pracs)
destroy(this.cb_run)
destroy(this.dw_list)
destroy(this.rb_ins)
destroy(this.rb_add)
destroy(this.cb_1)
destroy(this.gb_3)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_detail)
destroy(this.st_1)
destroy(this.dw_verifww)
destroy(this.dw_verif)
destroy(this.gb_prac)
end on

event closequery;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2005-11-15 By: Zhang Lingping
//$<reason> The datawindow "dw_batchlist"  does not need save.
//dw_batchlist.reset()
return super::event closequery() 
//---------------------------- APPEON END ----------------------------


end event

event pfc_save;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 21 December 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

// override
if dw_pracs.rowcount( ) > 0 then 
     super::event pfc_save()
end if

return success
end event

event close;call super::close;IF IsValid(inv_data_entry) Then Destroy inv_data_entry //alfee 07.18.2013
end event

type st_pracs from statictext within w_batch_add_insurance
integer x = 82
integer y = 72
integer width = 777
integer height = 72
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
string text = "No provider selected"
boolean focusrectangle = false
end type

type cb_prac from commandbutton within w_batch_add_insurance
integer x = 878
integer y = 60
integer width = 485
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select Provider"
end type

event clicked;Integer li_nr
Integer li_find
Long ll_prac_id
String ls_full_name
long r
long rc
long i
long ic
gs_search lstr_search
gs_batch_search lst_batch

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS0" 

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF
debugbreak()
rc = UpperBound( il_pracs )
////ll_prac_id = Long( Mid( Message.StringParm, 1, Pos( Message.StringParm, "-" ) -1 ) )

lst_batch = message.powerobjectparm
//maha 091605 allowing for multi selection
ic = upperbound(lst_batch.li_prac_id[])
//maha app101305
for i = 1 to ic
	ll_prac_id = lst_batch.li_prac_id[i] //maha 091605
	for r = 1 to rc
		if il_pracs[r] = ll_prac_id then
			li_find = 1
			exit
		end if
	next
	IF li_find > 0 THEN
		//skip
	else
		rc++
		il_pracs[rc] = ll_prac_id
		//Start Code Change ---- 04.10.2006 #396 maha
		is_prac_names[rc] = lst_batch.ls_name[i]
		//End Code Change---04.10.2006
	END IF
next


st_pracs.Text = String( UpperBound( il_pracs[] ) ) + " Providers selected."

IF UpperBound( il_pracs ) > 0 THEN
	dw_pracs.retrieve(il_pracs)
END IF

 

end event

type cb_batch from commandbutton within w_batch_add_insurance
integer x = 1371
integer y = 60
integer width = 448
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Select"
end type

event clicked;gs_batch_search lst_search

openwithparm(w_batch_prac_select_new, "R" )

if message.stringparm = "Cancel" then return

lst_search = message.powerobjectparm
il_pracs[] = lst_search.li_prac_id[]
is_prac_names[] = lst_search.ls_name[]

st_pracs.Text = String( UpperBound( il_pracs[] ) ) + " Providers selected."

IF UpperBound( il_pracs ) > 0 THEN
	dw_pracs.retrieve(il_pracs)
END IF



 

end event

type dw_select_section from datawindow within w_batch_add_insurance
boolean visible = false
integer x = 69
integer y = 1892
integer width = 343
integer height = 300
integer taborder = 120
string dataobject = "d_data_view_screens_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_table from datawindow within w_batch_add_insurance
boolean visible = false
integer x = 1600
integer y = 2132
integer width = 1088
integer height = 92
integer taborder = 90
string dataobject = "d_table_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;integer r
string find
datawindowchild dwchild

ii_screen = integer(data)

//messagebox("",ii_screen)
//dw_crit1.settransobject(sqlca)
//dw_crit1.retrieve(ii_screen)
//dw_crit1.GetChild( "data_view_fields_screen_id", dwchild )

//is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ii_screen_id, dw_detail, dw_browse, ib_screen_painter, ii_parent_facility_id )
//is_first_column_detail_1 = inv_data_entry.of_get_first_column()
end event

type dw_pracs from datawindow within w_batch_add_insurance
integer x = 23
integer y = 196
integer width = 846
integer height = 1984
integer taborder = 130
boolean titlebar = true
string title = "Providers"
string dataobject = "d_practitioner_list"
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

event constructor;this.settransobject(sqlca)
end event

type cb_run from commandbutton within w_batch_add_insurance
integer x = 2459
integer y = 88
integer width = 768
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "3) Add for Each Practitioner"
end type

event clicked;//Start Code Change ----04.21.2009 #V92 maha - moved create and retrieve of n_ds from of_create_verifs
long recid
long prac
long i
long ic
integer res
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.17.2006 By: Jack (Inova)
//$<reason> Required Documents Check Box on Data Entry Screen.
long ll_prac_id[]
long ll_rec_id[]
long ll_screen_id
//---------------------------- APPEON END ----------------------------

SetPointer (HourGlass!) //alfee 07.18.2013

dw_detail.accepttext()
//check data
ic = dw_pracs.rowcount()

for i = 1 to ic
	ll_prac_id[i] = dw_pracs.getitemnumber(i,"prac_id")
next

if ic < 1 then
	messagebox("No practitioners","Please select a Batch list of practitioners.  If no exists create one IntelliBatch first.")
	return
end if
if isnull(dw_detail.getitemnumber(1,"carrier_code")) then
	messagebox("No Insurance Company","Insurance Company required; Please select.")
	dw_detail.setfocus()
	dw_detail.setcolumn("carrier_code")
	return
end if
if isnull(dw_detail.getitemstring(1,"policy_number")) then
	messagebox("No Policy Number","Policy Number required; Please enter.")
	dw_detail.setfocus()
	dw_detail.setcolumn("policy_number")
	return
end if
if isnull(dw_detail.getitemdatetime(1,"coverage_to")) then
	messagebox("No Expiration Date","Expiration Date required; Please enter.")
	dw_detail.setfocus()
	dw_detail.setcolumn("coverage_to")
	return
end if

//Start Code Change ----04.21.2009 #V92 maha - moved from of_create Verif
gnv_appeondb.of_startqueue( )

ids_ver_orgs_facilities = CREATE n_ds
ids_ver_orgs_facilities.DataObject = "d_verifying_orgs_facilities_prac_list"
ids_ver_orgs_facilities.of_SetTransObject( SQLCA )
ids_ver_orgs_facilities.retrieve(ll_prac_id )

ids_parent_facilities = CREATE n_ds
ids_parent_facilities.DataObject = "d_verifying_parents_of_vers_prac_list"
ids_parent_facilities.of_SetTransObject( SQLCA )
ids_parent_facilities.retrieve(ll_prac_id )

ids_dfl_rsp_code = CREATE n_ds
ids_dfl_rsp_code.DataObject = "d_app_audit_get_hc_dflt_ver_resp_code"
ids_dfl_rsp_code.of_SetTransObject( SQLCA )
//lds_dfl_rsp_code.Retrieve( ll_prac, 15, ls_identifying_number )

ids_verif_facilities = CREATE n_ds
ids_verif_facilities.DataObject = "d_verifying_orgs_facilities_of_pract"
ids_verif_facilities.of_SetTransObject( SQLCA )
gnv_appeondb.of_commitqueue( )

IF appeongetclienttype() = 'WEB' THEN StopIEpopupmsg() //alfee 07.18.2013
recid = gnv_app.of_get_id( "RECORD_ID" ,ic) - 1
for i = 1 to  ic
	recid ++
	prac = dw_pracs.getitemnumber(i,"prac_id")

	dw_detail.SetItemStatus ( 1,0, primary!, Newmodified! )
	dw_detail.setitem(1,"prac_id",prac)
	dw_detail.setitem(1,"rec_id",recid)

	res = dw_detail.triggerevent("pfc_preupdate")
	
	if res = 1 then dw_detail.update()
	Yield () //alfee 07.18.2013
next
IF appeongetclienttype() = 'WEB' THEN ResumeIEpopupmsg() //alfee 07.18.2013

destroy ids_ver_orgs_facilities
destroy ids_parent_facilities 
destroy ids_dfl_rsp_code
destroy ids_verif_facilities

messagebox("Batch add","Data added for " + string(ic) + " Practitioners")

end event

type dw_list from datawindow within w_batch_add_insurance
boolean visible = false
integer x = 471
integer y = 188
integer width = 361
integer height = 80
integer taborder = 100
string dataobject = "d_batch_items_prac_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_pracid = long(data)

//of_prac_name(il_pracid)
end event

type rb_ins from radiobutton within w_batch_add_insurance
boolean visible = false
integer x = 3835
integer y = 88
integer width = 448
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Insurance"
boolean checked = true
end type

type rb_add from radiobutton within w_batch_add_insurance
boolean visible = false
integer x = 1056
integer y = 2140
integer width = 407
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Address"
end type

type cb_1 from commandbutton within w_batch_add_insurance
integer x = 3250
integer y = 88
integer width = 343
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;parent.event pfc_close( )
end event

type gb_3 from groupbox within w_batch_add_insurance
boolean visible = false
integer x = 3785
integer y = 32
integer width = 1138
integer height = 140
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
string text = "Select Table"
end type

type dw_3 from datawindow within w_batch_add_insurance
boolean visible = false
integer x = 1705
integer y = 216
integer width = 242
integer height = 56
integer taborder = 110
string dataobject = "d_distinct_clin_for_prac"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_batch_add_insurance
boolean visible = false
integer x = 2336
integer y = 32
integer width = 265
integer height = 80
integer taborder = 30
string dataobject = "d_prac_priv_list_clin_area"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detail from u_dw within w_batch_add_insurance
integer x = 901
integer y = 196
integer width = 2674
integer height = 1984
integer taborder = 10
string dataobject = "d_insurance_batchadd"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event pfc_preupdate;call super::pfc_preupdate;String ls_screen_name
String ls_ref_1
String ls_val
String ls_ref_2
String ls_ref_3
String ls_exp_field
String ls_reference
String ls_rec_status
DateTime ldt_exp_date
DateTime ldt_null_date
Long ll_rec_id
Long ll_address_code
Long ll_seq_no
Integer li_table_id
Integer li_facility_specific
Integer li_screen_id
Integer li_current_row
Integer i
Integer li_cnt
Integer li_rec_count
Integer il_last_de_row
Integer il_last_row
Integer p
Long il_rec_id
Long il_prac_id
Long li_found
Integer li_data_cr
Integer li_verif_rc
Integer li_retval
Integer li_year //maha031601
Integer li_month//maha031601
Integer li_validate//maha080803
String ls_type1//maha102501
String ls_type2//maha102501
String ls_type3//maha102501

//pfc_cst_nv_data_entry_functions inv_data_entry  - commented by alfee 07.18.2013
//inv_data_entry = Create pfc_cst_nv_data_entry_functions - commented by alfee 07.18.2013

DataWindowChild dwchild

SetPointer (HourGlass!) //alfee 07.18.2013
SetNull( ldt_null_date )

dw_detail.AcceptText()

il_last_de_row = dw_detail.GetRow()

li_data_cr = dw_detail.GetRow()
il_last_row = 1 //dw_select_section.getrow()

ls_ref_1 = dw_select_section.GetItemString( il_last_row, "ref_field_1")
ls_ref_2 = dw_select_section.GetItemString( il_last_row, "ref_field_2")
ls_ref_3 = dw_select_section.GetItemString( il_last_row, "ref_field_3")

ls_type1 = dw_select_section.GetItemString( il_last_row, "ref_1_type") //maha102501
ls_type2 = dw_select_section.GetItemString( il_last_row, "ref_2_type")//maha102501
ls_type3 = dw_select_section.GetItemString( il_last_row, "ref_3_type")//maha102501

ls_exp_field = dw_select_section.GetItemString( il_last_row, "exp_field")
//messagebox("ls_exp_field",ls_exp_field)
li_screen_id = dw_select_section.GetItemNumber( il_last_row, "screen_id")
ls_screen_name = dw_select_section.GetItemString( il_last_row, "screen_name")

li_rec_count = dw_detail.RowCount()

If li_rec_count < 1 Then
	Return -1
End If

If li_rec_count < 1 Then
	MessageBox("","Please select a practitioner list")
	Return -1
End If
i = 1
//FOR p = 1 TO li_rec_count

SetNull( ll_address_code )



ls_rec_status = "New"

il_prac_id = dw_pracs.GetItemNumber(i,"prac_id")
ll_rec_id = dw_detail.GetItemNumber( i, "rec_id" )
//debugbreak()	

If ii_screen = 4 Or ii_screen = 15 Or ii_screen = 5 Then
	//IF dw_detail.Describe( "active_status.dddw.name" ) = 'd_code_lookup_active_inactive' THEN
	If dw_detail.GetItemNumber( i, "active_status" ) = 0 Then
//		If ls_rec_status = "New" Then  //Start Code Change ----01.26.2015 #V14.2 maha - removed as unecessary
			Return 1
//		Else //\/maha 031601
//			Update verif_info
//				Set active_status = 0
//				Where rec_id = :ll_rec_id And active_status = 1;
//			Return 1		 //\maha
//		End If
	End If
	//END IF
End If


li_table_id = dw_select_section.GetItemNumber( dw_select_section.GetRow(), "table_id" )


//verification data
If Not IsNull( ls_ref_1 ) And ls_ref_1 <> "" Then
	dw_detail.ScrollToRow( i )
	dw_detail.SetRow( i )
	
	//move expiration date to verif info table if there is one
	If LenA(ls_exp_field) > 0 Then
		If ls_exp_field = "certification_expires" Then
			ldt_exp_date = DateTime(Date( "12-30-" + String( dw_detail.GetItemNumber( i, ls_exp_field ) ) ),Now()) //maha changed 080101
			//ldt_exp_date = DateTime(Date( "1-1-" + String( dw_detail.GetItemNumber( i, ls_exp_field ) ) ),Now())
		ElseIf ls_exp_field = "cert_expiration_year" Then
			li_month = dw_detail.GetItemNumber( i, "cert_expiration_month" )
			If IsNull(li_month) Then
				ldt_exp_date = DateTime(Date( "12-30-" + String( dw_detail.GetItemNumber( i, ls_exp_field ) ) ),Now()) //maha 061402 fo spec. certs
			Else
				ldt_exp_date = DateTime(Date(String(li_month) + "-28-" + String( dw_detail.GetItemNumber( i, ls_exp_field ) ) ),Now())
			End If
		Else
			ldt_exp_date = dw_detail.GetItemDateTime( i, ls_exp_field )
		End If
	Else
		ldt_exp_date = ldt_null_date
	End If
	
	//get reference 1 data
	
	If dw_detail.Describe(ls_ref_1 + ".ColType") = "!"  Or ls_ref_1 = "" Then //trap for invisible field maha 012104 
		MessageBox("Problem getting reference 1 value for verification","Required Field " + ls_ref_1 + " is invisible.  The verification will not be created.  Contact Customer support for assistance.")
		Return 1
	End If
	li_retval = dw_detail.SetColumn( ls_ref_1 )
	If li_retval = 1 Then
		If IsNull( dw_detail.GetText() ) Or dw_detail.GetText() = "" Then
			SetRedraw( True )
			MessageBox( "Required", "The reference field " + ls_ref_1 + " is required." )
			Return -1
		End If
		li_retval = dw_detail.GetChild(ls_ref_1, dwchild)
		If li_retval = -1 Then
			ls_reference =  dw_detail.GetText()
		Else
			dw_detail.SetColumn( ls_ref_1 )
			li_found = dwchild.Find( "lookup_code = " + dw_detail.GetText(), 1, 100000 )
			//messagebox("li_found",li_found)
			If dw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "code" Then
				ls_reference = dwchild.GetItemString( li_found, "code" )
				
				//IF ls_screen_name = "Licensure" THEN
				If ii_screen = 4 Then
					If dw_detail.Describe("verifying_agency.ColType") = "!" Then //trap for invisible field maha 040403 
						MessageBox("Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter")
						Return -1
					Else
						ll_address_code = dw_detail.GetItemNumber( i, "verifying_agency" )
					End If
				Else
					If ls_type1 = "C" Then //maha 050802 
						ll_address_code = Long(dw_detail.GetItemString( i, ls_ref_1 ))//maha 072501
					ElseIf ls_type1 = "N" Then //maha 050802
						ll_address_code = dw_detail.GetItemNumber( i, ls_ref_1 )
					End If
				End If
			ElseIf dw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name" Then
				ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )
				If ls_type1 = "C" Then //maha 102501 took out specific exceptions and tested field type
					ll_address_code = Long(dw_detail.GetItemString( i, ls_ref_1 ))//maha 072501
				ElseIf ls_type1 = "N" Then //maha 102501
					ll_address_code = dw_detail.GetItemNumber( i, ls_ref_1 )
				End If
			ElseIf dw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "description" Then //maha 110801
				ls_reference = dwchild.GetItemString( li_found, "description" )
				If ls_type1 = "C" Then //maha 102501 took out specific exceptions and tested field type
					ll_address_code = Long(dw_detail.GetItemString( i, ls_ref_1 ))//maha 072501
				ElseIf ls_type1 = "N" Then //maha 102501
					ll_address_code = dw_detail.GetItemNumber( i, ls_ref_1 )
				End If
			Else
				ls_reference = dw_detail.GetText()
			End If
		End If
	Else
		ls_reference = ""
	End If
	
	//get reference 2 data
	If dw_detail.Describe(ls_ref_2 + ".ColType") = "!" Or ls_ref_2 = "" Then //trap for invisible field maha 012104 
		MessageBox("Problem getting reference 2 value for verification","Required Field " + ls_ref_2 + " is invisible.  The verification will not be created.  Contact Customer support for assistance.")
		Return 1
	End If
	li_retval = dw_detail.SetColumn( ls_ref_2 )
	If li_retval = 1 Then
		If IsNull( dw_detail.GetText() ) Or dw_detail.GetText() = "" Then
			SetRedraw( True )
			MessageBox( "Required", "The reference field " + ls_ref_2 + " is required." )
			Return -1
		End If
		li_retval = dw_detail.GetChild(ls_ref_2, dwchild)
		If li_retval = -1 Then
			ls_reference = ls_reference + " - " + dw_detail.GetText()
		Else
			dw_detail.SetColumn( ls_ref_2 )
			li_found = dwchild.Find( "lookup_code = " + dw_detail.GetText(), 1, 100000 )
			If li_found > 0 Then //trap added maha 021704
				If dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "code" Then
					ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "code" )
				ElseIf dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "description" Then
					ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "description" )
				ElseIf dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name" Then
					ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name_original" )
					//ll_address_code = dw_detail.GetItemNumber( i, ls_ref_1 )		removed 072501 maha					
				Else
					ls_reference = ls_reference + " - " + dw_detail.GetText()
				End If
			Else
				ls_reference = ls_reference + " - " + ""
			End If
		End If
	Else
		ls_reference = ls_reference + " - " + ""
	End If
	
	ls_reference = MidA(ls_reference,1,100) //maha 022704 4.1.1
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.17.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen
	is_reference = ls_reference
	//---------------------------- APPEON END ----------------------------

	If of_create_verif(  ls_reference) = -1 Then
		Return -1
		MessageBox("Error","Error adding verification")
	End If
	
End If

inv_data_entry.of_field_audit( dw_detail )
//Destroy pfc_cst_nv_data_entry_functions - commented by alfee 07.18.2013

Return 1


end event

event constructor;call super::constructor;//Start Code Change ----01.26.2015 #V14.2 maha - added calendar dddw
this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_Register("coverage_from",this.iuo_calendar.DDLB)
this.iuo_calendar.of_Register("coverage_to",this.iuo_calendar.DDLB)
this.iuo_calendar.of_Register("previous_expiration_date",this.iuo_calendar.DDLB)
this.iuo_calendar.of_Register("custom_d1",this.iuo_calendar.DDLB)
this.iuo_calendar.of_Register("custom_d2",this.iuo_calendar.DDLB)
//End Code Change ----01.26.2015

This.of_SetReqColumn(TRUE)

end event

type st_1 from statictext within w_batch_add_insurance
integer x = 2469
integer y = 16
integer width = 453
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "2) Enter data"
boolean focusrectangle = false
end type

type dw_verifww from datawindow within w_batch_add_insurance
boolean visible = false
integer x = 2958
integer y = 328
integer width = 485
integer height = 208
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_ver_summary_record_view"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_verif from u_dw within w_batch_add_insurance
boolean visible = false
integer x = 2167
integer y = 180
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_ver_summary_record_view"
end type

type gb_prac from groupbox within w_batch_add_insurance
integer x = 37
integer y = 16
integer width = 1819
integer height = 144
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "1 - Select Providers"
end type

