$PBExportHeader$w_call_log.srw
forward
global type w_call_log from w_main
end type
type dw_user from u_dw within w_call_log
end type
type dw_settings from datawindow within w_call_log
end type
type dw_data from datawindow within w_call_log
end type
type cb_4 from commandbutton within w_call_log
end type
type cb_3 from commandbutton within w_call_log
end type
type cb_2 from commandbutton within w_call_log
end type
type st_10 from statictext within w_call_log
end type
type sle_8 from singlelineedit within w_call_log
end type
type cb_1 from commandbutton within w_call_log
end type
type dw_call from u_dw within w_call_log
end type
end forward

global type w_call_log from w_main
integer width = 3282
integer height = 2200
string title = "Contact Log"
boolean maxbox = false
long backcolor = 33551856
dw_user dw_user
dw_settings dw_settings
dw_data dw_data
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
st_10 st_10
sle_8 sle_8
cb_1 cb_1
dw_call dw_call
end type
global w_call_log w_call_log

forward prototypes
public function integer of_search_entity (string as_type)
public function integer of_retrieve_record (long al_id)
end prototypes

public function integer of_search_entity (string as_type);long ll_id
string ls_name
string ls_val

openwithparm(w_quick_search, as_type)
ls_val = message.stringparm
if ls_val = "0@Cancel" then return 0
	
ll_id = long(mid(ls_val, 1, pos(ls_val,"@",1) - 1))
ls_name = mid(ls_val, pos(ls_val,"@",1) + 1 )

choose case as_type
	case "PRAC"
		dw_call.setitem(1,"prac_id", ll_id)
		dw_call.modify( "st_provider.text = '" + ls_name + "'")
		dw_data.visible = true
		dw_data.retrieve(ll_id)
	case 	"FACIL"
		dw_call.setitem(1,"facility_id", ll_id)
		dw_call.modify( "st_facility.text = '" + ls_name + "'")
	case "GROUP"
		dw_call.setitem(1,"group_id", ll_id)
		dw_call.modify( "st_group.text = '" + ls_name + "'")
	case "LOC"
		dw_call.setitem(1,"location_id", ll_id)
		dw_call.modify( "st_location.text = '" + ls_name + "'")
	case "PAYOR"
		dw_call.setitem(1,"payor_id", ll_id)
		dw_call.modify( "st_payor.text = '" + ls_name + "'")
end choose

return 1


end function

public function integer of_retrieve_record (long al_id);long ll_prac
integer r

r = dw_call.retrieve(al_id)

if r = 0 then return -1

ll_prac = dw_call.getitemnumber(r, "prac_id")

if ll_prac > 0 then
	dw_data.retrieve(ll_prac)
	dw_data.visible = true
end if
	

end function

on w_call_log.create
int iCurrent
call super::create
this.dw_user=create dw_user
this.dw_settings=create dw_settings
this.dw_data=create dw_data
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.st_10=create st_10
this.sle_8=create sle_8
this.cb_1=create cb_1
this.dw_call=create dw_call
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_user
this.Control[iCurrent+2]=this.dw_settings
this.Control[iCurrent+3]=this.dw_data
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.st_10
this.Control[iCurrent+8]=this.sle_8
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.dw_call
end on

on w_call_log.destroy
call super::destroy
destroy(this.dw_user)
destroy(this.dw_settings)
destroy(this.dw_data)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.st_10)
destroy(this.sle_8)
destroy(this.cb_1)
destroy(this.dw_call)
end on

event open;call super::open;//gs_pass_ids
//facility_id
//prac_id
//ls_ref_val
//l_app_id
long ll_id
datawindowchild dwchild

dw_call.settransobject(sqlca)
dw_data.settransobject(sqlca)
dw_user.settransobject(sqlca)
dw_settings.settransobject(sqlca)

dw_user.retrieve()
dw_user.insertrow(1)
dw_settings.retrieve()

ll_id = message.doubleparm

if ll_id < 1 then
	dw_call.insertrow(1)
	dw_call.setitem(1, "issue_cat_1", dw_settings.getitemstring(1,"issue_cat_1"))
	dw_call.setitem(1, "issue_cat_2", dw_settings.getitemstring(1,"issue_cat_2"))
	dw_call.setitem(1, "issue_cat_3", dw_settings.getitemstring(1,"issue_cat_3"))
	dw_call.setitem(1, "issue_cat_4", dw_settings.getitemstring(1,"issue_cat_4"))
	dw_call.setitem(1, "issue_cat_5", dw_settings.getitemstring(1,"issue_cat_5"))
	dw_call.setitem(1, "log_status", 1)
	dw_call.setitem(1, "facility_id", 0)
	dw_call.setitem(1, "ent_date", datetime(today(),now()))
	dw_call.setitem(1, "user_id", gs_user_id )
	dw_call.setitem(1, "assigned_user", gs_user_id )
	dw_call.setitem(1, "note_type", 2)	 //Start Code Change ----12.03.2013 #V14 maha - corrected from 1
	dw_call.getchild( "issue_type", dwchild)
	dwchild.settransobject(sqlca)
	dwchild.retrieve()
else
	of_retrieve_record(ll_id)
end if
end event

event close;call super::close;if isValid(w_call_log_open_calls) then w_call_log_open_calls.uo_1.post of_refresh_data()//added by long.zhang 11.22.2013
end event

type dw_user from u_dw within w_call_log
integer x = 1399
integer y = 1620
integer width = 622
integer height = 80
integer taborder = 30
string dataobject = "d_user_select_current"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;dw_call.setitem(1, "assigned_user", data)
end event

event constructor;call super::constructor;this.of_setupdateable( false)
end event

type dw_settings from datawindow within w_call_log
boolean visible = false
integer x = 2990
integer y = 152
integer width = 187
integer height = 84
integer taborder = 40
string title = "none"
string dataobject = "d_call_log_settings"
boolean border = false
boolean livescroll = true
end type

type dw_data from datawindow within w_call_log
boolean visible = false
integer x = 1691
integer y = 392
integer width = 1426
integer height = 1160
integer taborder = 30
string title = "none"
string dataobject = "d_call_log_prac_data"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_call_log
integer x = 2798
integer y = 24
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;//---------Begin Added by (Appeon)Stephen 11.25.2013 for BugS102405--------
integer li_ret

if dw_call.modifiedcount() > 0 then
	li_ret = messagebox("Prompt", "Do you want to save changes?", Exclamation!, yesnocancel!)
	if li_ret = 1 then
		cb_3.event clicked()
	end if
	if li_ret = 3 then return
end if
//---------End Added ------------------------------------------------------
close (parent)

end event

type cb_3 from commandbutton within w_call_log
integer x = 2437
integer y = 24
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Save"
end type

event clicked;long ll_id

if isnull(dw_call.getitemnumber(1,"record_id")) then
	select max(record_id) 	into :ll_id from pd_notes;
	
	if ll_id < 1 or isnull(ll_id) then ll_id = 0
	ll_id++
	dw_call.setitem(1,"record_id", ll_id)
end if

if isnull(dw_call.getitemnumber(1,"facility_id")) then dw_call.setitem(1,"facility_id", 0)
if isnull(dw_call.getitemnumber(1,"prac_id")) then dw_call.setitem(1,"prac_id", 0)

dw_call.update()
end event

type cb_2 from commandbutton within w_call_log
integer x = 3333
integer y = 1960
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "View Parent"
end type

type st_10 from statictext within w_call_log
integer x = 3273
integer y = 1784
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32891346
string text = "Parent ID"
boolean focusrectangle = false
end type

type sle_8 from singlelineedit within w_call_log
integer x = 3269
integer y = 1852
integer width = 553
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 134217750
end type

type cb_1 from commandbutton within w_call_log
integer x = 1957
integer y = 24
integer width = 457
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Search for Existing"
end type

event clicked;long ll_id

open(w_call_log_search)

ll_id = message.doubleparm

if ll_id > 0 then
	of_retrieve_record( ll_id)
end if


end event

type dw_call from u_dw within w_call_log
integer width = 3223
integer height = 2080
integer taborder = 40
string dataobject = "d_call_log_detail"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;datawindowchild dwchild
string ls_filter
integer li_days
datetime ld_date

if dwo.name = "type_of_contact" then
	this.setitem(1,"contact_type", data)
elseif dwo.name = "request_from" then
	this.setitem(1,"req_from", data)
elseif dwo.name = "issue_category" then
	this.getchild("issue_type", dwchild)	
	choose case data
		case "1"
			ls_filter = "category1 = 1" 	
		case"2"
			ls_filter = "category2 = 1" 	
		case "3"
			ls_filter = "category3 = 1" 	
		case "4"
			ls_filter = "category4 = 1" 	
		case "5"
			ls_filter = "category5 = 1" 
	end choose
	
	dwchild.setfilter( ls_filter)
	dwchild.filter()
	parent.setfocus() //(Appeon)Stephen 11.22.2013 - BugS102501
elseif dwo.name = "log_status" then
	li_days = dw_settings.getitemnumber(1,"followup_days")
	if isnull(li_days) then li_days = 2
	ld_date = datetime(relativedate(today(),li_days),time("00:00:00"))
	
	if data = "3" then //forward
		dw_user.visible = true
		this.setitem(1,"follow_up_date", ld_date)
	elseif data = "2" then //followup	
		dw_user.visible = false
		this.setitem(1,"follow_up_date", ld_date)	
		this.setitem(1, "assigned_user", gs_user_id)
	elseif data = "1" then //new
		dw_user.visible = false
	elseif data = "0" then //complete
		dw_user.visible = false
		ld_date  = datetime(today(),now())
		this.setitem(1,"compl_date", ld_date)
		li_days = daysafter(date(this.getitemdatetime(1,"ent_date")),date(ld_date))
		this.setitem(1,"days_open",li_days )	
	end if
	
//	Clear completion if set to another status
	if data <> "0" then
		setnull(ld_date)
		this.setitem(1,"compl_date", ld_date)
		setnull(li_days)
		this.setitem(1,"days_open",li_days )
	end if
	
end if
end event

event buttonclicked;call super::buttonclicked;long ll_id
string ls_name
string ls_val
datawindowchild dwchild


//entity search
if dwo.name = "b_s_prac" then
	of_search_entity( "PRAC")
elseif dwo.name = "b_s_facil" then
	of_search_entity( "FACIL")
elseif dwo.name = "b_s_group" then
	of_search_entity( "GROUP")
elseif dwo.name = "b_s_loc" then
	of_search_entity( "LOC")
elseif dwo.name = "b_s_payor" then
	of_search_entity( "PAYOR")
end if

IF dwo.name = 'b_notes' THEN
	string s

	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
	//OpenWithParm( w_ai_notes_new, "A#" +  This.GetItemString( row, "note" ))
	string ls_notes
	ls_notes = This.GetItemString( row, "note" )
	if isnull(ls_notes) then ls_notes = ""
	OpenWithParm( w_ai_notes_new,  "A#" + ls_notes)
	//---------End Modfiied ------------------------------------------------------

	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		s = Message.StringParm
		This.SetItem( row, "note", s )	
	END IF
End if

//Start Code Change ----11.05.2013 #V14 maha
IF dwo.name = 'b_add_issue' then
	openwithparm(w_call_log_issue_lookup, "LOG")
	dw_call.getchild("issue_type", dwchild)	
	dwchild.settransobject( sqlca)//added by long.zhang 11.22.2013 BugL111401 
	dwchild.retrieve()
	dwchild.filter()
end if


	

end event

event constructor;call super::constructor;This.of_SetUpdateAble( False )  //(Appeon)Stephen 11.25.2013 - BugS102405
end event

