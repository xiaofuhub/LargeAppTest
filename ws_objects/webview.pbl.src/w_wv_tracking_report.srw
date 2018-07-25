$PBExportHeader$w_wv_tracking_report.srw
forward
global type w_wv_tracking_report from window
end type
type cb_prac_filt from commandbutton within w_wv_tracking_report
end type
type dw_user from datawindow within w_wv_tracking_report
end type
type cb_sort from commandbutton within w_wv_tracking_report
end type
type rb_incomp from radiobutton within w_wv_tracking_report
end type
type rb_comp from radiobutton within w_wv_tracking_report
end type
type cbx_comp from checkbox within w_wv_tracking_report
end type
type cbx_agree from checkbox within w_wv_tracking_report
end type
type cbx_priv from checkbox within w_wv_tracking_report
end type
type cbx_attest from checkbox within w_wv_tracking_report
end type
type cbx_docs from checkbox within w_wv_tracking_report
end type
type cbx_de from checkbox within w_wv_tracking_report
end type
type cb_3 from commandbutton within w_wv_tracking_report
end type
type cb_2 from commandbutton within w_wv_tracking_report
end type
type cb_close from commandbutton within w_wv_tracking_report
end type
type dw_1 from datawindow within w_wv_tracking_report
end type
type gb_1 from groupbox within w_wv_tracking_report
end type
type gb_3 from groupbox within w_wv_tracking_report
end type
type gb_2 from groupbox within w_wv_tracking_report
end type
end forward

global type w_wv_tracking_report from window
integer width = 4832
integer height = 2336
boolean titlebar = true
string title = "Web View Status Tracking"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_prac_filt cb_prac_filt
dw_user dw_user
cb_sort cb_sort
rb_incomp rb_incomp
rb_comp rb_comp
cbx_comp cbx_comp
cbx_agree cbx_agree
cbx_priv cbx_priv
cbx_attest cbx_attest
cbx_docs cbx_docs
cbx_de cbx_de
cb_3 cb_3
cb_2 cb_2
cb_close cb_close
dw_1 dw_1
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
end type
global w_wv_tracking_report w_wv_tracking_report

type variables
string is_user = ""
string is_pracs = ""
end variables

forward prototypes
public function integer of_status_filter ()
end prototypes

public function integer of_status_filter ();string ls_filters[]
string ls_filter
integer a = 1
integer ac
integer r

if rb_comp.checked then  //(Appeon)Stephen 11.19.2013 - add "()" -BugS111201
	if cbx_de.checked then
		ls_filters[a] = " (not isnull(de_compl)) "
		a++
	end if
	
	if cbx_docs.checked then
		ls_filters[a] = " (not isnull(document_compl)) "
		a++
	end if
	
	if cbx_attest.checked then
		ls_filters[a] = " (not isnull(attest_compl)) "
		a++
	end if
	
	if cbx_priv.checked then
		ls_filters[a] = " (not isnull(priv_compl)) "
		a++
	end if
	
	if cbx_agree.checked then
		ls_filters[a] = " (not isnull(agree_compl)) "
		a++
	end if
	
	if cbx_comp.checked then
		ls_filters[a] = " (not isnull(final_compl)) "
		a++
	end if
	
else //incomplete
	if cbx_de.checked then
		ls_filters[a] = " isnull(de_compl) "
		a++
	end if
	
	if cbx_docs.checked then
		ls_filters[a] = " isnull(document_compl) "
		a++
	end if
	
	if cbx_attest.checked then
		ls_filters[a] = " isnull(attest_compl) "
		a++
	end if
	
	if cbx_priv.checked then
		ls_filters[a] = " isnull(priv_compl) "
		a++
	end if
	
	if cbx_agree.checked then
		ls_filters[a] = " isnull(agree_compl) "
		a++
	end if
	
	if cbx_comp.checked then
		ls_filters[a] = " not isnull(final_compl) "
		a++
	end if
end if

ac = upperbound(ls_filters)

ls_filter = ""  //(Appeon)Stephen 11.19.2013 - BugS111201
if ac = 0 then
	ls_filter = ""
else
	for r = 1 to ac
		//---------Begin Modified by (Appeon)Stephen 11.19.2013 for BugS111201--------
		//ls_filter = ls_filters[r] + " and "	
		ls_filter = ls_filter + ls_filters[r] + " and "	
		//---------End Modfiied ------------------------------------------------------
	next
	ls_filter = left(ls_filter, len(ls_filter) - 6 ) 
end if

if is_user <> "" then
	if len(ls_filter) > 0 then ls_filter+= " and "
	 ls_filter+= "priority_user = '" + is_user + "'"
end if

if is_pracs <> "" then
	if len(ls_filter) > 0 then ls_filter+= " and "
	 ls_filter= ls_filter + is_pracs
end if
		

r = dw_1.setfilter(ls_filter)

if r < 1 then 
	messagebox("Filter Failed",ls_filter)
else
	dw_1.filter()
end if

return 1


end function

on w_wv_tracking_report.create
this.cb_prac_filt=create cb_prac_filt
this.dw_user=create dw_user
this.cb_sort=create cb_sort
this.rb_incomp=create rb_incomp
this.rb_comp=create rb_comp
this.cbx_comp=create cbx_comp
this.cbx_agree=create cbx_agree
this.cbx_priv=create cbx_priv
this.cbx_attest=create cbx_attest
this.cbx_docs=create cbx_docs
this.cbx_de=create cbx_de
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_close=create cb_close
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.Control[]={this.cb_prac_filt,&
this.dw_user,&
this.cb_sort,&
this.rb_incomp,&
this.rb_comp,&
this.cbx_comp,&
this.cbx_agree,&
this.cbx_priv,&
this.cbx_attest,&
this.cbx_docs,&
this.cbx_de,&
this.cb_3,&
this.cb_2,&
this.cb_close,&
this.dw_1,&
this.gb_1,&
this.gb_3,&
this.gb_2}
end on

on w_wv_tracking_report.destroy
destroy(this.cb_prac_filt)
destroy(this.dw_user)
destroy(this.cb_sort)
destroy(this.rb_incomp)
destroy(this.rb_comp)
destroy(this.cbx_comp)
destroy(this.cbx_agree)
destroy(this.cbx_priv)
destroy(this.cbx_attest)
destroy(this.cbx_docs)
destroy(this.cbx_de)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_close)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
end on

event open;//Start Code Change ----08.24.2011 #V11 maha - window created
dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user_id)
end event

event resize;//Start Code Change ----02.18.2016 #V15 maha
dw_1.width = this.width - 100
dw_1.height = this.height - dw_1.y - 172
end event

type cb_prac_filt from commandbutton within w_wv_tracking_report
integer x = 1637
integer y = 208
integer width = 411
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Provider Filter"
end type

event clicked;//Start Code Change ----07.27.2016 #V152 maha
long ll_batch_id
integer i
integer ic
long ll_pracs[]
long p
string ls_filt
string ls_pracs
integer test = 0
gs_batch_search lst_search //maha 01.28.2015


open(w_practitioner_filter_choice_new)

if message.stringparm = "C" then  //cancel
	return -1
else 
	lst_search = message.powerobjectparm
	ll_pracs[] = lst_search.li_prac_id
end if	

for p = 1 to upperbound(ll_pracs[])
	ls_pracs = ls_pracs + string(ll_pracs[p]) + ","
next

ls_pracs = MidA(ls_pracs,1,LenA(ls_pracs) - 1)

is_pracs = " wv_prac_tracking_prac_id in (" + ls_pracs + ")"

of_status_filter( )





end event

type dw_user from datawindow within w_wv_tracking_report
integer x = 1614
integer y = 60
integer width = 462
integer height = 84
integer taborder = 30
string title = "none"
string dataobject = "d_users_utl"
boolean border = false
boolean livescroll = true
end type

event constructor; //Start Code Change ----09.25.2015 #V15 maha
this.settransobject( sqlca)
this.retrieve()
this.insertrow(1)
end event

event itemchanged;is_user = data
of_status_filter()

end event

type cb_sort from commandbutton within w_wv_tracking_report
integer x = 3698
integer y = 96
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.SetSort(null_str)

dw_1.Sort( )
end event

type rb_incomp from radiobutton within w_wv_tracking_report
integer x = 503
integer y = 88
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Incomplete"
end type

event clicked;of_status_filter()
end event

type rb_comp from radiobutton within w_wv_tracking_report
integer x = 133
integer y = 88
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Complete"
boolean checked = true
end type

event clicked;of_status_filter()
end event

type cbx_comp from checkbox within w_wv_tracking_report
integer x = 1143
integer y = 236
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Completed"
end type

event clicked;of_status_filter()
end event

type cbx_agree from checkbox within w_wv_tracking_report
integer x = 704
integer y = 236
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Agreements"
end type

event clicked;of_status_filter()
end event

type cbx_priv from checkbox within w_wv_tracking_report
integer x = 78
integer y = 240
integer width = 594
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Privileges Requested"
end type

event clicked;of_status_filter()
end event

type cbx_attest from checkbox within w_wv_tracking_report
integer x = 1143
integer y = 176
integer width = 411
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Attestations"
end type

event clicked;of_status_filter()
end event

type cbx_docs from checkbox within w_wv_tracking_report
integer x = 704
integer y = 176
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Documents"
end type

event clicked;of_status_filter()
end event

type cbx_de from checkbox within w_wv_tracking_report
integer x = 78
integer y = 184
integer width = 411
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Data Entry"
end type

event clicked;of_status_filter()
end event

type cb_3 from commandbutton within w_wv_tracking_report
integer x = 1038
integer y = 76
integer width = 343
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear Filter"
end type

event clicked;cbx_agree.checked = false
cbx_attest.checked = false
cbx_comp.checked = false
cbx_de.checked = false
cbx_docs.checked = false
cbx_priv.checked = false

is_user = ""
is_pracs = ""  //Start Code Change ----07.27.2016 #V152 maha
dw_user.insertrow(1)

of_status_filter()

end event

type cb_2 from commandbutton within w_wv_tracking_report
integer x = 4069
integer y = 96
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print "
end type

event clicked;gs_report_variables lst_val

lst_val.as_report_object = "d_wv_pd_tracking_print"
lst_val.ai_num_variables = 0
	
if isvalid(w_report_view) then close(w_report_view)
		
openwithparm(w_report_view,lst_val)
end event

type cb_close from commandbutton within w_wv_tracking_report
integer x = 4439
integer y = 96
integer width = 343
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

type dw_1 from datawindow within w_wv_tracking_report
integer x = 14
integer y = 348
integer width = 4777
integer height = 1876
integer taborder = 10
string title = "none"
string dataobject = "d_wv_pd_tracking_view"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked; //Start Code Change ----07.06.2015 #V15 maha - copied from recent prac gadget

Long ll_data_id
str_dashboard str_para
w_prac_data_1 lw_prac  // maha 04.27.2012
w_prac_data_2 lw_prac1  //maha 06.18.2013
w_prac_data_intelliapp_2 lw_prac2 //maha 06.18.2013
w_prac_data_sk_2 lw_prac3 //maha 06.18.2013

If row <= 0 Then Return 1

//ll_data_id = dw_1.GetItemNumber(row,'dashboard_gadgets_recent_data_id')
str_para.data_id = 1
str_para.data_id = dw_1.Object. wv_prac_tracking_prac_id[row]
str_para.data_name = dw_1.Object.facility_facility_name[row]
//str_para.data_ext_id = dw_1.Object.dashboard_gadgets_recent_facility_id[row]
str_para.color = 16773365 //Start Code Change ----10.04.2012 #V12 maha - for 12.3

IF gs_cust_type = "I" THEN
	IF gb_sk_ver = False THEN	//app
		OpenSheetWithParm(lw_prac2 ,str_para,w_mdi,4,Original!)
		lw_prac = lw_prac2
	ELSEIF gb_sk_ver = true  THEN//sk
		OpenSheetWithParm(lw_prac3 ,str_para,w_mdi,4,Original!)
		lw_prac = lw_prac3
	END IF
	IF gi_prac_tab = 1 THEN
		OpenSheetWithParm( lw_prac3 ,str_para,w_mdi,4,Original!)
		lw_prac = lw_prac3 //Bug 3375 - Alfee 01.08.2013 
	end if
ELSE //cred
	OpenSheetWithParm(lw_prac1 ,str_para,w_mdi,4,Original!)
	lw_prac = lw_prac1  //12.04.2012  maha - changed from w_prac_data_1
END IF

w_mdi.iw_prac_window = lw_prac 


return 1
end event

type gb_1 from groupbox within w_wv_tracking_report
integer x = 1586
integer width = 512
integer height = 172
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Assigned User:"
end type

type gb_3 from groupbox within w_wv_tracking_report
integer x = 96
integer y = 52
integer width = 782
integer height = 116
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
end type

type gb_2 from groupbox within w_wv_tracking_report
integer x = 41
integer width = 1527
integer height = 324
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Completion Filter:"
end type

