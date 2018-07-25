$PBExportHeader$w_recred_prac.srw
forward
global type w_recred_prac from w_master
end type
type cb_1 from commandbutton within w_recred_prac
end type
type cb_help from commandbutton within w_recred_prac
end type
type dw_verif from u_dw within w_recred_prac
end type
type dw_exp from u_dw within w_recred_prac
end type
type cbx_verif from checkbox within w_recred_prac
end type
type cb_close from commandbutton within w_recred_prac
end type
type cb_run from commandbutton within w_recred_prac
end type
type cbx_priv from checkbox within w_recred_prac
end type
type gb_1 from groupbox within w_recred_prac
end type
end forward

global type w_recred_prac from w_master
integer width = 3438
integer height = 2260
string title = "Initiate Reappointment Process"
long backcolor = 33551856
cb_1 cb_1
cb_help cb_help
dw_verif dw_verif
dw_exp dw_exp
cbx_verif cbx_verif
cb_close cb_close
cb_run cb_run
cbx_priv cbx_priv
gb_1 gb_1
end type
global w_recred_prac w_recred_prac

type variables
long ii_facil
long il_pracs[]
long il_appt_id
pfc_n_cst_ai_printletters inv_recred
end variables

on w_recred_prac.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_help=create cb_help
this.dw_verif=create dw_verif
this.dw_exp=create dw_exp
this.cbx_verif=create cbx_verif
this.cb_close=create cb_close
this.cb_run=create cb_run
this.cbx_priv=create cbx_priv
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_help
this.Control[iCurrent+3]=this.dw_verif
this.Control[iCurrent+4]=this.dw_exp
this.Control[iCurrent+5]=this.cbx_verif
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_run
this.Control[iCurrent+8]=this.cbx_priv
this.Control[iCurrent+9]=this.gb_1
end on

on w_recred_prac.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_help)
destroy(this.dw_verif)
destroy(this.dw_exp)
destroy(this.cbx_verif)
destroy(this.cb_close)
destroy(this.cb_run)
destroy(this.cbx_priv)
destroy(this.gb_1)
end on

event open;call super::open;//this object created 7-2008 for new batch recredential functionality - maha
long f
string ls_from
gs_batch_search lstr_array
datawindowchild dwchild

lstr_array =  message.powerobjectparm

if upperbound(lstr_array.li_prac_id) = 0 then
	messagebox("???","No pracs in array")
else
	il_pracs  =lstr_array.li_prac_id
	ii_facil = lstr_array.ll_facility[1]
	ls_from= "R"
end if

dw_exp.settransobject(sqlca)
//dw_exp.retrieve(il_pracs[1], ii_facil)
dw_exp.retrieve(il_pracs, ii_facil) //Bug #5333 - alfee 09.18.2016

inv_recred = create pfc_n_cst_ai_printletters

inv_recred.of_retrieve_recred(dw_verif,il_pracs[1], ii_facil)








end event

event closequery;return 0
end event

event close;call super::close;destroy inv_recred
end event

type cb_1 from commandbutton within w_recred_prac
integer x = 41
integer y = 196
integer width = 763
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Check for Missing Verification"
end type

event clicked;inv_recred.of_find_missing_verifs(il_pracs[1] , ii_facil, 0, "R")

inv_recred.of_retrieve_recred(dw_verif,il_pracs[1], ii_facil)

end event

type cb_help from commandbutton within w_recred_prac
integer x = 1234
integer y = 52
integer width = 462
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&About Options"
end type

event clicked;string ls_mes

ls_mes = "The Reverify Credentials setting will copy the appropriate verifications per the verification rules and will also check for any missing ones and add them.~r~rThe Rollover Privileges setting will add Requested privileges for any Granted privileges the provider has currently.~r~rThe Check Missing Verifications setting will look for records that should exist based on verification rules."

Messagebox ("About Run Options",ls_mes )
end event

type dw_verif from u_dw within w_recred_prac
integer x = 41
integer y = 316
integer width = 3323
integer height = 1800
integer taborder = 60
string dataobject = "d_copy_verification"
end type

type dw_exp from u_dw within w_recred_prac
boolean visible = false
integer x = 3159
integer y = 212
integer width = 146
integer height = 64
integer taborder = 50
string dataobject = "d_ver_exp_appt_for_batch"
end type

type cbx_verif from checkbox within w_recred_prac
integer x = 59
integer y = 68
integer width = 544
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Reverify Credentials"
boolean checked = true
end type

type cb_close from commandbutton within w_recred_prac
integer x = 2871
integer y = 52
integer width = 462
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_run from commandbutton within w_recred_prac
integer x = 1390
integer y = 196
integer width = 599
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Initiate Recredentialing"
end type

event clicked;long ll_req
integer res
integer li_silent
integer li_yield
long p
long pc
long pid
long v
long vc
long ll_rec
long ll_row
long dc
long ck
string ls_priv = ''
string ls_auto = ''
string ls_verif = ''
string ls_mes
string ls_ver_arg //maha 11.09.09
datetime ldt_null


//datastore lds_prac_privs
n_ds lds_prac_privs  //maha 02.21.2014 - changed datatype
//dw_pracs.accepttext( )

////setup checking
//if dw_facility.visible = true and ii_facil = 0 then
//	messagebox("Batch Recredentialing","Please select a facility")
//	return
//end if
//
//pc = dw_pracs.rowcount() 

//priv setup
if cbx_priv.checked then
	ll_req = long(gnv_data.of_getitem('code_lookup','lookup_code',"upper(lookup_name) = 'PRIVILEGE STATUS'  and upper(code) = 'REQST'"))
	if ll_req < 19 then
		messagebox("Lookup table error", "Unable to find the Requested Status Record for Privileges.  Unable to continue.~rCheck your Privilege Status lookup table for a record with the code of 'REQST' ")
		Return
	end if
	
	ls_priv = "~r~rAdd Requested privileges based on existing granted privileges,"
	lds_prac_privs  = create n_ds  //Start Code Change ----02.21.2014 #V14 maha - changed from datastore
	lds_prac_privs.dataobject = "d_prac_priv_granted_all_area"
	lds_prac_privs.settransobject( sqlca)
	setnull(ldt_null)
end if

//Start Code Change ----11.09.2009 #V10 maha - modification to allow no recred
//verif message
if cbx_verif.checked then
	ls_verif = "~r~rRecredential verifications based on the verifying facility verification rules,"	
	ls_ver_arg = "R"
else
	ls_verif = "~r~rNot have Credentials be reverified,"	
	ls_ver_arg = "NOVER"
end if
//End Code Change---11.09.2009

li_silent = 0

//res = messagebox("Batch Recred Process","This function will run the recredentialing process for the selected provider.  You have selected to:" + ls_verif  + ls_priv + "  ~r~r Do you wish to continue?" ,question!,yesno!,2)
//if res = 2 then return

pid = il_pracs[1]
	
	//Start Code Change ----11.09.2009 #V10 maha - modifiaction to allow no recred
	//check for missing verifications

	
inv_recred.of_start_reappointment_processing_new(dw_verif, dw_exp  , ii_facil,pid, ls_ver_arg, li_silent ) 
	//End Code Change---11.09.2009
	
if cbx_priv.checked then
		//check to see if renewal privs already exist
	SELECT count( pd_priv_list.rec_id ) INTO :pc	FROM pd_priv_list where prac_id = :pid and facility_id = :ii_facil and active_status = 1 and status_code = :ll_req ;
	if pc > 0 then //if any requested privileges
		//skip
	else
		ls_mes = "R*" + string(ii_facil) + "@" + string(pid) //format P*1@234   //Start Code Change ----04.02.2015 #V15 maha - changed from P
		openwithparm(w_clin_area_select,ls_mes)   //Start Code Change ----04.02.2015 #V15 maha - changed from w_priv_prac_renewal
	end if
end if
			

if isvalid(lds_prac_privs) then destroy lds_prac_privs

messagebox("Recredentialing","The Recredentialing process has been completed.")
//---------Begin Added by (Appeon)Stephen 02.28.2017 for Bug ID #5513 for Case #00069440 assigning correct user name when initialing recred--------
if isvalid(w_prac_data_1) then
	w_prac_data_1.of_retrieve_affil_stat()
end if
//---------End Added ------------------------------------------------------
close(parent)
end event

type cbx_priv from checkbox within w_recred_prac
integer x = 658
integer y = 68
integer width = 517
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Rollover Privileges"
boolean checked = true
end type

type gb_1 from groupbox within w_recred_prac
integer x = 32
integer y = 4
integer width = 1184
integer height = 160
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Recred Options"
end type

