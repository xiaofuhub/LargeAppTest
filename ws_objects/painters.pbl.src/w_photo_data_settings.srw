$PBExportHeader$w_photo_data_settings.srw
forward
global type w_photo_data_settings from w_popup
end type
type cb_1 from commandbutton within w_photo_data_settings
end type
type cb_save from commandbutton within w_photo_data_settings
end type
type cb_close from commandbutton within w_photo_data_settings
end type
type dw_data from u_dw within w_photo_data_settings
end type
end forward

global type w_photo_data_settings from w_popup
integer width = 3653
integer height = 1984
string title = "Photo Data Settings"
boolean controlmenu = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
cb_1 cb_1
cb_save cb_save
cb_close cb_close
dw_data dw_data
end type
global w_photo_data_settings w_photo_data_settings

type variables
long il_prac_id
long il_facility
end variables

forward prototypes
public function integer of_get_prac ()
end prototypes

public function integer of_get_prac (); //Start Code Change ----05.31.2017 #V154 maha - copied from verious places in App populate
 
Long ll_prac_id
Integer li_ans
String ls_name
string ls_prac_id
string ls_facility_id
gs_search lstr_search
Boolean lb_need_research = false  //Modified by Harry 11.08.2017
Int li_count //Modified by Harry 11.08.2017
Long ll_facility  //Modified by Harry 11.08.2017

ls_prac_id = ProfileString(gs_IniFilePathName, "Setup", "default_practitioner", "None")
ls_facility_id = ProfileString(gs_IniFilePathName, "Setup", "default_parent_facility", "None")

//IF ls_prac_id = "" THEN //maha mod 042604
IF ls_prac_id = "" or (Not IsNumber(ls_prac_id)) or ls_facility_id = "" or (Not IsNumber(ls_facility_id)) THEN //Modified by Harry 10.23.2017 FW: Alpha Testing Bug # 5852 - Photo Profile Design: Test preview is not working 
	lb_need_research = True
ELSE  //Modified by Harry 11.08.2017 FW: Alpha Testing Bug # 5852 - Photo Profile Design: Test preview is not working 
	ll_prac_id = long( ls_prac_id)
	ll_facility = long(ls_facility_id)
	
	SELECT  ISNULL(COUNT(*),0) 
	INTO :li_count
    FROM v_full_name LEFT OUTER JOIN v_mailing_address ON v_full_name.prac_id = v_mailing_address.prac_id and   v_mailing_address.facility_id = :ll_facility
 	LEFT OUTER JOIN v_primary_specialty ON v_full_name.prac_id = v_primary_specialty.prac_id  ,
	pd_affil_stat LEFT OUTER JOIN v_dept ON pd_affil_stat.rec_id = v_dept.rec_id and v_dept.primary_dept = 1  
	LEFT OUTER JOIN v_affil_staff_cat_active ON pd_affil_stat.rec_id = v_affil_staff_cat_active.rec_id and v_affil_staff_cat_active.requested = 1,
	pd_basic LEFT OUTER JOIN code_lookup ON pd_basic.mobile_carrier = code_lookup.lookup_code
 	WHERE   
			pd_affil_stat.prac_id  = v_full_name.prac_id and
			pd_basic.prac_id  = v_full_name.prac_id and
			v_full_name.prac_id = :ll_prac_id and 
			pd_affil_stat.parent_facility_id = :ll_facility and
			pd_affil_stat.active_status in (1,4)	;

	IF li_count < 1 THEN 
		lb_need_research = True
	ELSE
		lb_need_research = false
	END IF
END IF

IF lb_need_research THEN  //Modified by Harry 11.08.2017 FW: Alpha Testing Bug # 5852 - Photo Profile Design: Test preview is not working 
	lstr_search.stran_transaction = SQLCA
	lstr_search.ls_open_for = "MEETINGS*LOC"//"REPORTS" + String( 1 ) //Start Code Change ----04.15.2014 #V14.2 maha- added LOC
	
	//Start Code Change ----12.13.2010 #V10 maha
	if gb_sk_ver then
		lstr_search.ls_open_for = "SKL"
		OpenWithParm( w_extended_search_app , lstr_search )
	else
		OpenWithParm( w_extended_search_new , lstr_search )  
	end if
	//Start Code Change ----12.13.2010
	
	
	IF Message.DoubleParm = -1 THEN
		Return -1
	END IF
	
	il_prac_id = Long( MidA( Message.StringParm, 1, PosA( Message.StringParm, "-" )-1) )
	ls_name = MidA( Message.StringParm, PosA( Message.StringParm, "-" )+1, 100 )
	il_facility = gi_parent_facility
	
	
	li_ans = MessageBox("Default Practitioner", "Would you like to use the selected practitioner as your Default Provider?", Question!, YesNo!, 2 )
	IF li_ans = 1 THEN
		SetProfileString(gs_IniFilePathName, "Setup", "default_practitioner", String( il_prac_id ) )
		SetProfileString(gs_IniFilePathName, "Setup", "default_parent_facility", String(gi_parent_facility) )
	
	END IF
		
ELSE
	il_prac_id = long( ls_prac_id)
	il_facility = long(ls_facility_id)
	
END IF

Return 1
end function

on w_photo_data_settings.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_data=create dw_data
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.dw_data
end on

on w_photo_data_settings.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_data)
end on

event open;call super::open;dw_data.settransobject(sqlca)
dw_data.retrieve()
end event

type cb_1 from commandbutton within w_photo_data_settings
integer x = 18
integer y = 20
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Test"
end type

event clicked;gs_pass_ids lst_ids

dw_data.update()

of_get_prac()

lst_ids.prac_id = il_prac_id
lst_ids.facility_id = il_facility


openwithparm(w_photo_data_settings_test, lst_ids)
end event

type cb_save from commandbutton within w_photo_data_settings
integer x = 2990
integer y = 12
integer width = 311
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_data.update()

end event

type cb_close from commandbutton within w_photo_data_settings
integer x = 3314
integer y = 12
integer width = 311
integer height = 92
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

type dw_data from u_dw within w_photo_data_settings
integer x = 14
integer y = 128
integer width = 3630
integer height = 1768
integer taborder = 10
string dataobject = "d_personal_data_settings"
boolean hscrollbar = true
end type

event buttonclicked;call super::buttonclicked;long ll_color
string ls_query

if dwo.name = "b_pick" then

	ll_color = this.getitemnumber(row, "set_color")
	
	openwithparm(w_photo_data_pick_color, ll_color)
	
	if message.doubleparm = -1 then
		//cancel
	else
		this.setitem(row,"set_color", message.doubleparm)
	end if
	
elseif dwo.name = "b_query" then
	ls_query = this.getitemstring(row, "cust_query")
	if isnull(ls_query) then ls_query = ""
	openwithparm(w_query_create, ls_query)
	
	ls_query = message.stringparm
	
	if ls_query = "Cancel" then
		return
	else
		this.setitem(row, "cust_query", ls_query)
	end if
end if
	
	



end event

