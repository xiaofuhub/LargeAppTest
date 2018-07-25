$PBExportHeader$w_select_address.srw
$PBExportComments$Window used to select the from and to address for a letter
forward
global type w_select_address from w_response
end type
type st_3 from statictext within w_select_address
end type
type st_2 from statictext within w_select_address
end type
type st_1 from u_st within w_select_address
end type
type dw_to from u_dw_contract within w_select_address
end type
type dw_from from u_dw_contract within w_select_address
end type
type cbx_print_now from u_cbx within w_select_address
end type
type cb_2 from u_cb within w_select_address
end type
type cb_1 from u_cb within w_select_address
end type
end forward

global type w_select_address from w_response
integer width = 1833
integer height = 624
string title = "Letter Address Selection"
long backcolor = 33551856
st_3 st_3
st_2 st_2
st_1 st_1
dw_to dw_to
dw_from dw_from
cbx_print_now cbx_print_now
cb_2 cb_2
cb_1 cb_1
end type
global w_select_address w_select_address

type variables
str_pass istr_pass 

N_DS IdS_contract_det_contacts

n_cst_ctx_letter ids_letter

datawindowchild idw_from
datawindowchild idw_to

string is_doc_name
long il_from_contact
long il_to_contact
long ll_current_row /* the current row in the dataobject*/
end variables

on w_select_address.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_to=create dw_to
this.dw_from=create dw_from
this.cbx_print_now=create cbx_print_now
this.cb_2=create cb_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_to
this.Control[iCurrent+5]=this.dw_from
this.Control[iCurrent+6]=this.cbx_print_now
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.cb_1
end on

on w_select_address.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_to)
destroy(this.dw_from)
destroy(this.cbx_print_now)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event pfc_postopen;call super::pfc_postopen;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 28 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
string ls_filter
string var1[] 
long ll_i

ids_letter = CREATE n_cst_ctx_letter 

var1[1] = 'I'
var1[2] = 'E'

istr_pass = message.powerobjectparm

IdS_contract_det_contacts =  CREATE N_DS
IdS_contract_det_contacts.DATAOBJECT = 'd_contract_det_contacts'
IdS_contract_det_contacts.SETTRANSOBJECT(SQLCA)

// set the name of the letter
this.st_1.text =  istr_pass.s_string_array[1]

 
is_doc_name = istr_pass.s_string

////////////////////////////////////////////////////////////////////////////
// populate the drop downs
////////////////////////////////////////////////////////////////////////////

if IdS_contract_det_contacts.retrieve(istr_pass.contact_id[1]) > 0 then
   // filter out the internal contacts copy them over to from	
	for ll_i = 1 to upperbound(var1)
			ls_filter = "ic_area = '"+ var1[ll_i] +" '"
			IdS_contract_det_contacts.SetFilter(ls_filter) 
			IdS_contract_det_contacts.filter()
			if ll_i = 1 then 
			  IdS_contract_det_contacts.RowsCopy(1, IdS_contract_det_contacts.RowCount(), Primary!, idw_from, 1, Primary!)
			    else 
			 IdS_contract_det_contacts.RowsCopy(1, IdS_contract_det_contacts.RowCount(), Primary!, idw_to, 1, Primary!)
		   end if 
   next
end if 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-12 By: Liu HongXin
//$<reason> Fix defect.
Boolean lb_from, lb_to
Long ll_row
DatawindowChild ldw_child
//if istr_pass.w_parent_window.ClassName() <> "w_contract" then return
dw_from.GetChild('display', ldw_child)
for ll_i = 1 to ldw_child.RowCount()
	if ldw_child.GetItemString(ll_i, "default_email") = "Y"  and & 
		ldw_child.GetItemString(ll_i, "ic_area") = "I" then
		ls_filter = ldw_child.GetItemString(ll_i, "compute_1")
		//Fixed a defect By Jervis 03/20/2007
		//il_from_contact = ldw_child.GetItemNumber(ll_i, "ctx_id")
		il_from_contact = ldw_child.GetItemNumber(ll_i, "contact_id")
		//Fixed End
		dw_from.SetItem(1, "display", ls_filter)
		
		ldw_child.ScrollToRow(ll_i)
		lb_from = True
		exit
	end if
next

dw_to.GetChild('display', ldw_child)
for ll_i = 1 to ldw_child.RowCount()
	if ldw_child.GetItemString(ll_i, "default_email") = "Y"  and & 
		ldw_child.GetItemString(ll_i, "ic_area") <> "I" then
		ls_filter = ldw_child.GetItemString(ll_i, "compute_1")
		dw_to.SetItem(1, "display", ls_filter)
		//Fixed a defect By Jervis 03/20/2007
		//il_to_contact = ldw_child.GetItemNumber(ll_i, "ctx_id")
		il_to_contact = ldw_child.GetItemNumber(ll_i, "contact_id")
		//Fixed End
		
		ldw_child.ScrollToRow(ll_i)
		lb_to = true
		if lb_from = True then
			cb_2.TriggerEvent(Clicked!)
			if IsValid(this) then
				Close(This)
			end if
		end if
		exit
	end if
next
if lb_from = False or lb_to = False then
	this.Show()
end if
//---------------------------- APPEON END ----------------------------
end event

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-12 By: Liu HongXin
//$<reason> New requirement.
This.Hide()
//---------------------------- APPEON END ----------------------------
end event

event close;call super::close;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(ids_letter) then Destroy ids_letter
//---------------------------- APPEON END ----------------------------
end event

type st_3 from statictext within w_select_address
string tag = "Contracted Company Contact Info"
integer x = 82
integer y = 264
integer width = 187
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "To"
boolean focusrectangle = false
end type

type st_2 from statictext within w_select_address
string tag = "Our Company Contact Info"
integer x = 82
integer y = 136
integer width = 201
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "From"
boolean focusrectangle = false
end type

type st_1 from u_st within w_select_address
integer x = 78
integer y = 8
integer width = 1262
integer height = 96
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
long backcolor = 33551856
boolean enabled = true
string text = ""
alignment alignment = center!
end type

type dw_to from u_dw_contract within w_select_address
string tag = "Contracted Company Contact Info"
integer x = 288
integer y = 252
integer width = 1065
integer height = 88
integer taborder = 30
string dataobject = "d_ext_contact"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_retrieve_drop_downs = true
end type

event constructor;insertrow(0)
settransobject(sqlca)
getchild('display', idw_to)

end event

event getfocus;//
end event

event itemchanged;call super::itemchanged;






choose case dwo.name 
	case 'display'
		il_to_contact = long(data)
end choose 





end event

type dw_from from u_dw_contract within w_select_address
string tag = "Our Company Contact Info"
integer x = 288
integer y = 124
integer width = 1065
integer height = 88
integer taborder = 10
string dataobject = "d_ext_contact"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_retrieve_drop_downs = true
end type

event constructor;
insertrow(0)

getchild('display', idw_from)


//////////////////////////////////////////////////////////////////////
//  do not run this code if we are not using contract
//////////////////////////////////////////////////////////////////////

long i

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 03.14.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
select set_cont into :i from icred_settings;
*/
i = Long(gnv_data.of_getitem( "icred_settings", "set_cont", False))
//---------------------------- APPEON END ----------------------------
if i = 0 then return success


ib_rmbmenu	= true

of_setbase( true)
inv_base.of_SetColumnDisplayNameStyle ( inv_base.HEADER )
of_settransobject( sqlca)
////////////////////////////////////////////////////////////////////
// do not display filter errors
////////////////////////////////////////////////////////////////////
//if GetApplication ( ) <> 0 then 
 // do not display eval/ filter error to the user
 Modify("DataWindow.NoUserPrompt='yes'")
//end if

//---------Begin Modified by (Appeon)Harry 07.13.2013 for V141 ISG-CLX--------
//is_notify_who[1] =  'support@contractlogix.com'
is_notify_who[1] =  'support@intellisoftgroup.com'
//---------End Modfiied ------------------------------------------------------
//is_notify_who[1] =  'mskinner@intellisoftgroup.com'
//is_notify_who[2] =  'maha@intellisoftgroup.com'
//is_notify_who[3] =  'johnd@intellisoftgroup.com'
this.of_setrowmanager( true)
inv_rowmanager.of_setconfirmondelete( true)


//invo_dwsrv =  create n_cst_dwsrv 	2007.7.12 By Jervis



end event

event losefocus;//
end event

event getfocus;//
end event

event itemchanged;call super::itemchanged;


choose case dwo.name 
	case 'display'
		il_from_contact = long(data)
	end choose 



end event

type cbx_print_now from u_cbx within w_select_address
integer x = 288
integer y = 384
integer width = 370
integer height = 68
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Print Now"
boolean checked = true
end type

type cb_2 from u_cb within w_select_address
string tag = "Create the letter"
integer x = 1390
integer y = 120
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;call super::clicked;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 28 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
string ls_return 
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.20.2006 By: LeiWei
Datetime ldt_today
//---------------------------- APPEON END ----------------------------

if il_from_contact = 0 then 
    messagebox('Missing data','The contact FROM is missing. Please select one.')
	 return -1
end if

if il_to_contact = 0 then 
   messagebox('Missing data','The contact TO is misssing. Please select one.')
   return -1
end if
long ll_currentrow
ll_currentrow = istr_pass.s_u_dw.getrow()
istr_pass.s_u_dw.setredraw(false)
istr_pass.s_u_dw.RETrieve(istr_pass.contact_id[1] )
istr_pass.s_u_dw.setItem(ll_currentrow,'letter_from',il_from_contact )
istr_pass.s_u_dw.setItem(ll_currentrow,'letter_to',il_to_contact )
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.28.2006 By: LeiWei
//$<reason> Fix a defect.
istr_pass.s_u_dw.Accepttext()
//---------------------------- APPEON END ----------------------------

istr_pass.s_u_dw.UPDATE()
istr_pass.s_u_dw.setrow( ll_currentrow)
istr_pass.s_u_dw.setredraw(true)
if parent.cbx_print_now.checked then
	
   ls_return = ids_letter.of_start(istr_pass)
	
	if ls_return  <> 'success' then
		messagebox('Letter error', ls_return)
		return failure
		else
				istr_pass.s_u_dw.object.print_flag[istr_pass.s_u_dw.getrow()] = 1
				
				//--------------------------- APPEON BEGIN ---------------------------
				//$<add> 06.20.2006 By: LeiWei
				ldt_today = f_get_server_dtm()
				//---------------------------- APPEON END ----------------------------

				if not f_validstr(string(istr_pass.s_u_dw.object.first_attempt[istr_pass.s_u_dw.getrow()]  )) then
					//--------------------------- APPEON BEGIN ---------------------------
					//$<modify> 06.20.2006 By: LeiWei
					//istr_pass.s_u_dw.object.first_attempt[istr_pass.s_u_dw.getrow()] = f_get_server_dtm()
					istr_pass.s_u_dw.object.first_attempt[istr_pass.s_u_dw.getrow()] = ldt_today
					//---------------------------- APPEON END ----------------------------
				end if 		
				
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 06.20.2006 By: LeiWei
				//istr_pass.s_u_dw.object.last_attempt[istr_pass.s_u_dw.getrow()] = f_get_server_dtm()
				istr_pass.s_u_dw.object.last_attempt[istr_pass.s_u_dw.getrow()] = ldt_today
				//---------------------------- APPEON END ----------------------------
				
				if not f_validstr(string(istr_pass.s_u_dw.object.no_attempts[istr_pass.s_u_dw.getrow()])) then
					istr_pass.s_u_dw.object.no_attempts[istr_pass.s_u_dw.getrow()] =  + 1
				else 
				  istr_pass.s_u_dw.object.no_attempts[istr_pass.s_u_dw.getrow()] = istr_pass.s_u_dw.object.no_attempts[istr_pass.s_u_dw.getrow()] + 1
				end if
				istr_pass.s_u_dw.accepttext( )
				istr_pass.s_u_dw.UPDATE()
		
	end if 
end if 



parent.event pfc_close( )

end event

type cb_1 from u_cb within w_select_address
integer x = 1390
integer y = 240
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;call super::clicked;
parent.event pfc_close( )
end event

