$PBExportHeader$w_app_audit_print.srw
forward
global type w_app_audit_print from window
end type
type rb_no from radiobutton within w_app_audit_print
end type
type rb_yes from radiobutton within w_app_audit_print
end type
type cb_email from commandbutton within w_app_audit_print
end type
type rb_comp from radiobutton within w_app_audit_print
end type
type rb_miss from radiobutton within w_app_audit_print
end type
type rb_all from radiobutton within w_app_audit_print
end type
type cb_export from commandbutton within w_app_audit_print
end type
type cb_1 from commandbutton within w_app_audit_print
end type
type cb_close from commandbutton within w_app_audit_print
end type
type cb_filter from commandbutton within w_app_audit_print
end type
type cb_sort from commandbutton within w_app_audit_print
end type
type gb_1 from groupbox within w_app_audit_print
end type
type dw_1 from u_dw within w_app_audit_print
end type
type gb_yes from groupbox within w_app_audit_print
end type
end forward

global type w_app_audit_print from window
integer width = 3675
integer height = 1976
boolean titlebar = true
string title = "Item Report"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
rb_no rb_no
rb_yes rb_yes
cb_email cb_email
rb_comp rb_comp
rb_miss rb_miss
rb_all rb_all
cb_export cb_export
cb_1 cb_1
cb_close cb_close
cb_filter cb_filter
cb_sort cb_sort
gb_1 gb_1
dw_1 dw_1
gb_yes gb_yes
end type
global w_app_audit_print w_app_audit_print

type variables
long il_rec
string is_stat = "A"  //maha 08.13.2015
end variables

forward prototypes
public function integer of_filter_stat (string as_stat)
end prototypes

public function integer of_filter_stat (string as_stat); //Start Code Change ----08.13.2015 #V15 maha - added
 string ls_filter
 datawindowchild dwchild
 integer r
 
 choose case as_stat
	case "A"
		ls_filter = ""
	case "M"
		ls_filter = "isnull(date_completed)"	
 	case "C"
		ls_filter = " not isnull(date_completed)"
end choose

 //Start Code Change ----04.13.2017 #V153 maha - commented part of filter
 if rb_no.checked then
	dw_1.Setfilter(ls_filter)
	dw_1.filter( )
	dw_1.sort()	
else //(Appeon)Stephen 06.02.2017 - V15.3 Bug #5665 - Checklist Report: Get Expression not vaild when including Attempts
	r = dw_1.getchild( "dw_body", dwchild)
	dwchild.settransobject(sqlca)
	dwchild.retrieve(il_rec)
	r = dwchild.Setfilter(ls_filter)
	r = dwchild.filter( )
	dwchild.sort()
end if

return 1
end function

on w_app_audit_print.create
this.rb_no=create rb_no
this.rb_yes=create rb_yes
this.cb_email=create cb_email
this.rb_comp=create rb_comp
this.rb_miss=create rb_miss
this.rb_all=create rb_all
this.cb_export=create cb_export
this.cb_1=create cb_1
this.cb_close=create cb_close
this.cb_filter=create cb_filter
this.cb_sort=create cb_sort
this.gb_1=create gb_1
this.dw_1=create dw_1
this.gb_yes=create gb_yes
this.Control[]={this.rb_no,&
this.rb_yes,&
this.cb_email,&
this.rb_comp,&
this.rb_miss,&
this.rb_all,&
this.cb_export,&
this.cb_1,&
this.cb_close,&
this.cb_filter,&
this.cb_sort,&
this.gb_1,&
this.dw_1,&
this.gb_yes}
end on

on w_app_audit_print.destroy
destroy(this.rb_no)
destroy(this.rb_yes)
destroy(this.cb_email)
destroy(this.rb_comp)
destroy(this.rb_miss)
destroy(this.rb_all)
destroy(this.cb_export)
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.cb_filter)
destroy(this.cb_sort)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.gb_yes)
end on

event open;//Start Code Change ----08.25.2009 #V92 maha - window added
//gs_variable_array ls_array
//datawindow ls_dw
datawindowchild dwchild
long ll_rec
string ls_user

ll_rec = message.doubleparm

il_rec = ll_rec

dw_1.settransobject( sqlca)
dw_1.retrieve(ll_rec)
dw_1.GetChild( "data_status", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('required data status') + "'", dwchild)

ls_user = "t_printed_by.text = 'Printed by: " + gs_user_id + "'"
dw_1.modify(ls_user)
dw_1.Modify("DataWindow.Print.Preview=Yes")   //Start Code Change ----04.13.2017 #V153 maha






end event

event resize; //Start Code Change ----04.13.2017 #V153 maha - added
long ww
long wh

ww = this.workspacewidth( )
wh = this.workspaceheight( )

dw_1.width = ww - 10
dw_1.height = wh - dw_1.y - 20
end event

type rb_no from radiobutton within w_app_audit_print
integer x = 1509
integer y = 96
integer width = 279
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "No"
boolean checked = true
end type

event clicked; //Start Code Change ----08.11.2015 #V15 maha

datawindowchild dwchild
string ls_user

dw_1.dataobject = "d_pd_app_audit_rqrd_data_print"
dw_1.settransobject( sqlca)

 //Start Code Change ----04.14.2017 #V153 maha - added setredraw
dw_1.setredraw(false)
dw_1.retrieve(il_rec)
of_filter_stat( is_stat)
dw_1.setredraw(true)
 //End Code Change ----04.14.2017

dw_1.GetChild( "data_status", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('required data status') + "'", dwchild)

ls_user = "t_printed_by.text = 'Printed by: " + gs_user_id + "'"
dw_1.modify(ls_user)
dw_1.Modify("DataWindow.Print.Preview=Yes")   //Start Code Change ----04.13.2017 #V153 maha



//---------Begin Modified by (Appeon)Stephen 12.15.2015 for BugS120403--------
//cb_export.enabled = false
cb_export.enabled = true
//---------End Modfiied ------------------------------------------------------

end event

type rb_yes from radiobutton within w_app_audit_print
integer x = 1170
integer y = 96
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Yes"
end type

event clicked; //Start Code Change ----08.11.2015 #V15 maha
string ls_user
datawindowchild dwchild
//---------Begin Modified by (Appeon)Stephen 05.12.2017 for V15.3 Bug #5639 - Checklist report does not include the attempts--------
//dw_1.dataobject = "d_pd_app_audit_rqrd_print_master"
dw_1.dataobject = "d_pd_app_audit_rqrd_print_master_org"
//---------End Modfiied ------------------------------------------------------
dw_1.settransobject(sqlca)

//---------Begin Commented by (Appeon)Stephen 05.12.2017 for  Bug #5639 - Checklist report does not include the attempts--------
 //Start Code Change ----04.27.2017 #V153 maha
//dw_1.GetChild( "data_status", dwchild )
//dwchild.SetTransObject( SQLCA )
//gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('required data status') + "'", dwchild)
 //End Code Change ----04.27.2017
 //Start Code Change ----04.14.2017 #V153 maha - added setredraw
//---------End Commented ------------------------------------------------------
dw_1.setredraw(false)
dw_1.retrieve(il_rec)
of_filter_stat( is_stat)
dw_1.setredraw(true)
 //End Code Change ----04.14.2017

//---------Begin Added by (Appeon)Stephen 04.14.2017 for Checklist- Service Now INC0152522--------
ls_user = "t_printed_by.text = 'Printed by: " + gs_user_id + "'"
dw_1.modify(ls_user)
//---------End Added ------------------------------------------------------
dw_1.Modify("DataWindow.Print.Preview=Yes")   //Start Code Change ----.04.132017 #V153 maha



cb_export.enabled = false
end event

type cb_email from commandbutton within w_app_audit_print
integer x = 2469
integer y = 84
integer width = 270
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Email"
end type

event clicked;//Start Code Change ----08.25.2009 #V92 maha
debugbreak()
dw_1.triggerevent("ue_email_current_dw")
end event

type rb_comp from radiobutton within w_app_audit_print
integer x = 695
integer y = 100
integer width = 320
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Complete"
end type

event clicked;is_stat = "C"

of_filter_stat( is_stat)

end event

type rb_miss from radiobutton within w_app_audit_print
integer x = 343
integer y = 100
integer width = 297
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Missing"
end type

event clicked;is_stat = "M"

of_filter_stat( is_stat)

end event

type rb_all from radiobutton within w_app_audit_print
integer x = 78
integer y = 100
integer width = 229
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
boolean checked = true
end type

event clicked;is_stat = "A"

of_filter_stat( is_stat)

end event

type cb_export from commandbutton within w_app_audit_print
integer x = 2747
integer y = 84
integer width = 270
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export"
end type

event clicked;gnv_dw.of_SaveAs(dw_1)//.saveas() Modify by Evan 05.11.2010
//For restore current directory  Added by Nova 04.29.2008
ChangeDirectory(gs_current_path)

end event

type cb_1 from commandbutton within w_app_audit_print
integer x = 3026
integer y = 84
integer width = 270
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;//Start Code Change ----10.03.2011 #V12 maha - modify to show print dialog box`
boolean lb_dialog = false

if gi_print_dialog = 1 then
	lb_dialog = true
end if

dw_1.of_print(true,lb_dialog) //Change the "print" to "of_print" - alfee 01.05.2012
//dw_1.print()
//End Code Change ----10.03.2011



end event

type cb_close from commandbutton within w_app_audit_print
integer x = 3305
integer y = 84
integer width = 270
integer height = 84
integer taborder = 80
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

type cb_filter from commandbutton within w_app_audit_print
integer x = 1906
integer y = 84
integer width = 270
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;string null_str
datawindowchild dwchild

if rb_yes.checked then
	dw_1.getchild("dw_body",  dwchild)
	SetNull(null_str)
	dwchild.SetFilter(null_str)
	dwchild.Filter()
else
	SetNull(null_str)
	dw_1.SetFilter(null_str)
	dw_1.Filter()
end if
end event

type cb_sort from commandbutton within w_app_audit_print
integer x = 2185
integer y = 84
integer width = 270
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.SetSort(null_str)

dw_1.Sort( )
end event

type gb_1 from groupbox within w_app_audit_print
integer x = 32
integer y = 28
integer width = 1006
integer height = 172
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filter"
end type

type dw_1 from u_dw within w_app_audit_print
integer y = 228
integer width = 3630
integer height = 1636
integer taborder = 80
string dataobject = "d_pd_app_audit_rqrd_data_print"
boolean hscrollbar = true
boolean livescroll = false
end type

event constructor;//Overrided for popping up the filter & sort dialog - alfee 04.23.2010

ib_rmbmenu	= False

of_setbase( true)
inv_base.of_SetColumnDisplayNameStyle ( inv_base.HEADER )
of_settransobject( sqlca)

////////////////////////////////////////////////////////////////////
// do not display filter errors
////////////////////////////////////////////////////////////////////
//Modify("DataWindow.NoUserPrompt='yes'")

is_notify_who[1] =  'mskinner@intellisoftgroup.com'
is_notify_who[2] =  'maha@intellisoftgroup.com'

end event

type gb_yes from groupbox within w_app_audit_print
integer x = 1102
integer y = 32
integer width = 754
integer height = 168
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Include Attempts"
end type

