$PBExportHeader$w_req_data_error_list.srw
forward
global type w_req_data_error_list from w_popup
end type
type cb_1 from commandbutton within w_req_data_error_list
end type
type dw_1 from u_dw within w_req_data_error_list
end type
end forward

global type w_req_data_error_list from w_popup
integer width = 3278
integer height = 1820
string title = "Required Data Errors"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
long backcolor = 33551856
boolean center = true
cb_1 cb_1
dw_1 dw_1
end type
global w_req_data_error_list w_req_data_error_list

type variables
long il_prac
w_prac_data_1 iw_prac

end variables

forward prototypes
public function integer of_open_prac_folder (integer al_row)
public function integer of_navigate (integer ai_row)
end prototypes

public function integer of_open_prac_folder (integer al_row);Long ll_data_id
str_dashboard str_para
 

If al_row <= 0 Then Return 1

//ll_data_id = dw_content.GetItemNumber(al_row,'dashboard_gadgets_recent_data_id')
str_para.data_id = 0 //ll_data_id
str_para.data_id = dw_1.Object.prac_id[al_row]
str_para.data_name = '0'
str_para.color = gl_bg_color2   


IF gs_cust_type = "I" THEN
	IF gb_sk_ver = False THEN	//app
		iw_prac = w_prac_data_sk
	ELSEIF gb_sk_ver = true  THEN//sk
		iw_prac = w_prac_data_intelliapp
	END IF
ELSE //cred
	iw_prac = w_prac_data_1
END IF

if not isvalid (iw_prac) then 
	OpenSheetWithParm(iw_prac ,str_para,w_mdi,4,Original!)
	w_mdi.iw_prac_window = iw_prac
end if


Return 1
end function

public function integer of_navigate (integer ai_row);integer li_screen
long ll_recid
integer li_find
integer li_record
u_dw dw_select
u_dw dw_browse 


li_screen = dw_1.getitemnumber(ai_row,"screen_id")
iw_prac.tab_1.selecttab(2)
dw_select = iw_prac.tab_1.tabpage_detail.uo_data_entry.dw_select_section
dw_browse = iw_prac.tab_1.tabpage_detail.uo_data_entry.dw_browse
debugbreak()
li_find = dw_select.find( "screen_id = " + string(li_screen), 1, dw_select.rowcount())

if li_find > 0 then
	dw_select.setrow(li_find)
	ll_recid = dw_1.getitemnumber(ai_row,"rec_id")
	if ll_recid > 0 then
		li_record = dw_browse.find( "rec_id = " + string(ll_recid), 1, dw_browse.rowcount())
		if li_record > 0 then
			dw_browse.setrow(li_record)
		end if
	end if
end if


return 1
end function

event open;call super::open;il_prac = message.doubleparm

dw_1.retrieve(il_prac)
end event

on w_req_data_error_list.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
end on

on w_req_data_error_list.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_req_data_error_list
integer x = 2885
integer y = 8
integer width = 329
integer height = 80
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

type dw_1 from u_dw within w_req_data_error_list
integer x = 14
integer y = 104
integer width = 3218
integer height = 1600
integer taborder = 10
string dataobject = "d_req_data_errors_list"
end type

event constructor;call super::constructor;this.of_setupdateable( false)
this.settransobject(sqlca)
end event

event buttonclicked;call super::buttonclicked;


if dwo.name = "b_go" then
	of_open_prac_folder(row)
	post of_navigate(row)
end if	

	
	

end event

