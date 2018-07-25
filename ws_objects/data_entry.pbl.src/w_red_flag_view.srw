$PBExportHeader$w_red_flag_view.srw
forward
global type w_red_flag_view from pfc_w_response
end type
type cb_save from u_cb within w_red_flag_view
end type
type cb_sort from commandbutton within w_red_flag_view
end type
type dw_select_user from u_dw within w_red_flag_view
end type
type st_4 from statictext within w_red_flag_view
end type
type cb_clear from commandbutton within w_red_flag_view
end type
type ddlb_data_type from dropdownlistbox within w_red_flag_view
end type
type cb_filter from commandbutton within w_red_flag_view
end type
type st_2 from statictext within w_red_flag_view
end type
type dw_facility from datawindow within w_red_flag_view
end type
type st_1 from statictext within w_red_flag_view
end type
type cb_4 from commandbutton within w_red_flag_view
end type
type cb_delete from commandbutton within w_red_flag_view
end type
type cb_search from pfc_u_cb within w_red_flag_view
end type
type sle_prac from singlelineedit within w_red_flag_view
end type
type st_3 from statictext within w_red_flag_view
end type
type cb_reset from commandbutton within w_red_flag_view
end type
type dw_date_range from u_dw within w_red_flag_view
end type
type cb_close from pfc_u_cb within w_red_flag_view
end type
type cb_print from pfc_u_cb within w_red_flag_view
end type
type tab_1 from tab within w_red_flag_view
end type
type tabpage_master from userobject within tab_1
end type
type dw_redflag from u_dw within tabpage_master
end type
type tabpage_master from userobject within tab_1
dw_redflag dw_redflag
end type
type tabpage_detail from userobject within tab_1
end type
type dw_2 from u_dw within tabpage_detail
end type
type tabpage_detail from userobject within tab_1
dw_2 dw_2
end type
type tab_1 from tab within w_red_flag_view
tabpage_master tabpage_master
tabpage_detail tabpage_detail
end type
type gb_5 from groupbox within w_red_flag_view
end type
end forward

global type w_red_flag_view from pfc_w_response
integer width = 3506
integer height = 2048
string title = "View Red Flag Data"
long backcolor = 33551856
boolean center = true
cb_save cb_save
cb_sort cb_sort
dw_select_user dw_select_user
st_4 st_4
cb_clear cb_clear
ddlb_data_type ddlb_data_type
cb_filter cb_filter
st_2 st_2
dw_facility dw_facility
st_1 st_1
cb_4 cb_4
cb_delete cb_delete
cb_search cb_search
sle_prac sle_prac
st_3 st_3
cb_reset cb_reset
dw_date_range dw_date_range
cb_close cb_close
cb_print cb_print
tab_1 tab_1
gb_5 gb_5
end type
global w_red_flag_view w_red_flag_view

type variables
string is_sql
long il_prac_id

integer ii_security[] 
end variables

forward prototypes
public function integer of_select_row (long al_row)
public function integer of_set_security ()
end prototypes

public function integer of_select_row (long al_row);//==========================================
// $<Function> of_select_row ()
// $<arguments>
// 	value    long    al_row : user clicked row
// $<returns>1 - success; -1 - failure 
// $<description>red flag data:get detail information of current row
// $<add> (Appeon) Long.zhang 07.05.2011
//==========================================
long ll_row_count,ll_rfd_id
ll_row_count = tab_1.tabpage_master.dw_redflag.rowcount( )
IF ll_row_count < 1 THEN
	return -1
ELSE
	ll_rfd_id = tab_1.tabpage_master.dw_redflag.getitemnumber( al_row,"rfd_id")
	tab_1.tabpage_detail.dw_2.retrieve( ll_rfd_id)
END IF
Return 1

end function

public function integer of_set_security ();//==========================================
// $<Function> of_set_security ()
// $<arguments> none
// $<returns>1 - success; -1 - failure 
// $<description> set security Rights in view Red flag data
// $<add> (Appeon) Long.zhang 09.16.2011
//==========================================

ii_security[1] =  w_mdi.of_security_access(7160)	//add general comment
ii_security[2] =  w_mdi.of_security_access(7171)	//Edit Rights
ii_security[3] =  w_mdi.of_security_access(7180)	//delete Rights
ii_security[4] =  w_mdi.of_security_access(7190)	//Print Rights

if ii_security[1] = 0 then cb_4.enabled = false
if ii_security[3] = 0 then cb_delete.enabled =  false
if ii_security[4] = 0 then cb_print.enabled =  false

if ii_security[2] > 0 then
	tab_1.tabpage_detail.dw_2.modify( 'msp_note.background.mode="2" msp_note.background.color="16777215" msp_note.edit.displayonly="no"')
end if

return 1
end function

on w_red_flag_view.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_sort=create cb_sort
this.dw_select_user=create dw_select_user
this.st_4=create st_4
this.cb_clear=create cb_clear
this.ddlb_data_type=create ddlb_data_type
this.cb_filter=create cb_filter
this.st_2=create st_2
this.dw_facility=create dw_facility
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_delete=create cb_delete
this.cb_search=create cb_search
this.sle_prac=create sle_prac
this.st_3=create st_3
this.cb_reset=create cb_reset
this.dw_date_range=create dw_date_range
this.cb_close=create cb_close
this.cb_print=create cb_print
this.tab_1=create tab_1
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_sort
this.Control[iCurrent+3]=this.dw_select_user
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.cb_clear
this.Control[iCurrent+6]=this.ddlb_data_type
this.Control[iCurrent+7]=this.cb_filter
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.dw_facility
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.cb_4
this.Control[iCurrent+12]=this.cb_delete
this.Control[iCurrent+13]=this.cb_search
this.Control[iCurrent+14]=this.sle_prac
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.cb_reset
this.Control[iCurrent+17]=this.dw_date_range
this.Control[iCurrent+18]=this.cb_close
this.Control[iCurrent+19]=this.cb_print
this.Control[iCurrent+20]=this.tab_1
this.Control[iCurrent+21]=this.gb_5
end on

on w_red_flag_view.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_sort)
destroy(this.dw_select_user)
destroy(this.st_4)
destroy(this.cb_clear)
destroy(this.ddlb_data_type)
destroy(this.cb_filter)
destroy(this.st_2)
destroy(this.dw_facility)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_delete)
destroy(this.cb_search)
destroy(this.sle_prac)
destroy(this.st_3)
destroy(this.cb_reset)
destroy(this.dw_date_range)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.tab_1)
destroy(this.gb_5)
end on

event open;call super::open;//$<add> long.zhang 07.04.2011
//$<reason> view red flag data

is_sql = tab_1.tabpage_master.dw_redflag.Object.DataWindow.Table.Select

//Start Code Change ---08.11.2011 #V11 maha - set to current practitioner
if gl_prac_id > 0 then
	nv_prac_info lnv_full_name
	lnv_full_name = CREATE nv_prac_info
	String ls_name
	ls_name = lnv_full_name.of_get_name( gl_prac_id )
	DESTROY lnv_full_name	
	sle_prac.Text = ls_name
	il_prac_id = gl_prac_id
	cb_filter.triggerevent( clicked!)
end if
//Start Code Change ---08.11.2011 


end event

type cb_save from u_cb within w_red_flag_view
integer x = 3145
integer y = 240
integer width = 325
integer height = 88
integer taborder = 160
string text = "&Save"
end type

event clicked;call super::clicked;parent.event pfc_save()	//red flag data: added by long.zhang 09.16.2011
end event

type cb_sort from commandbutton within w_red_flag_view
integer x = 3145
integer y = 240
integer width = 325
integer height = 88
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&ort"
end type

event clicked;tab_1.tabpage_master.dw_redflag.event pfc_SortDlg()	//sort red flag data:added by long.zhang 07.05.2011
end event

type dw_select_user from u_dw within w_red_flag_view
integer x = 14
integer y = 108
integer width = 462
integer height = 76
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_select_user_for_audit_trail"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

DataWindowChild dwchild

This.GetChild( "user_id", dwchild )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "user_id", "All" )

This.SetItem( 1, "user_id", "All" )
end event

event itemchanged;call super::itemchanged;//wf_reset_st_run( )
end event

type st_4 from statictext within w_red_flag_view
integer x = 27
integer y = 52
integer width = 361
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Created By"
boolean focusrectangle = false
end type

type cb_clear from commandbutton within w_red_flag_view
integer x = 2039
integer y = 240
integer width = 197
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clea&r"
end type

event clicked;sle_prac.text=""	//red flag data:	added by long.zhang 07.05.011
end event

type ddlb_data_type from dropdownlistbox within w_red_flag_view
integer x = 1518
integer y = 112
integer width = 293
integer height = 652
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean hscrollbar = true
boolean vscrollbar = true
string item[] = {"All","DE","APPT","VER","OFE","PRIV","ATTQ","GEN"}
borderstyle borderstyle = stylelowered!
end type

type cb_filter from commandbutton within w_red_flag_view
integer x = 2263
integer y = 108
integer width = 562
integer height = 88
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run &Filter"
end type

event clicked;//$<add> long.zhang 07.05.2011
//$<reason>FIlter red flag data
string ls_sql
string ls_from_date
string ls_to_date
string ls_facility_id
string ls_user

ls_sql = is_sql
dw_date_range.AcceptText()
ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date = "" OR IsNull( ls_to_date ) OR ls_to_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a Thru Date" )
		dw_date_range.SetColumn( "to_date" )
		Return -1
	END IF
END IF

IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN
	IF ls_from_date = "" OR IsNull( ls_from_date ) OR ls_from_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a From Date" )
		dw_date_range.SetColumn( "from_date" )
		Return -1
	END IF
END IF

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN	
		ls_from_date = "'" + ls_from_date + "'"
		ls_to_date = "'" + ls_to_date + "'"
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar,pd_red_flag_data.Msp_Date,102) )  >= " + ls_from_date +&
								" AND convert(datetime, convert( varchar,pd_red_flag_data.Msp_Date,102) )  <= " + ls_to_date 
	END IF
END IF
this.enabled = false
IF trim(sle_prac.text) <> "" THEN
	ls_sql = ls_sql + " AND pd_red_flag_data.prac_id="+String(il_prac_id)
END IF

ls_facility_id = String(dw_facility.getitemnumber( 1, "facility_id"))

IF  ls_facility_id<>"0" THEN
	ls_sql = ls_sql + " AND pd_red_flag_data.facility_id=" + ls_facility_id
END IF

IF ddlb_data_type.text <> "" AND ddlb_data_type.text <> "All" THEN
	ls_sql = ls_sql + " AND pd_red_flag_data.data_type='" + ddlb_data_type.text + "'"
END IF

ls_user = dw_select_user.GetItemString(1,"user_id")
ls_user =  of_ReviseExpValue(ls_user, "'") 
IF ls_user <> "All" THEN
	ls_sql = ls_sql + " AND pd_red_flag_data.Msp_id='"+ ls_user +"'"
END IF
tab_1.tabpage_master.dw_redflag.setsqlselect( ls_sql)
tab_1.tabpage_master.dw_redflag.settransobject( SQLCA )
tab_1.tabpage_master.dw_redflag.retrieve( )
tab_1.tabpage_master.dw_redflag.Object.DataWindow.Table.UpdateTable = "pd_red_flag_data"
IF tab_1.selectedtab = 2 THEN
	IF tab_1.tabpage_master.dw_redflag.rowcount( ) >0 THEN
		of_select_row(tab_1.tabpage_master.dw_redflag.getrow())
	ELSE
		tab_1.tabpage_detail.dw_2.reset( )
	END IF
END IF
this.enabled = true


end event

type st_2 from statictext within w_red_flag_view
integer x = 727
integer y = 192
integer width = 393
integer height = 56
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
string text = "Provider"
boolean focusrectangle = false
end type

type dw_facility from datawindow within w_red_flag_view
integer x = 27
integer y = 244
integer width = 654
integer height = 76
integer taborder = 40
string title = "none"
string dataobject = "d_ddlb_priv_facility"
boolean border = false
boolean livescroll = true
end type

event constructor;datawindowchild dwchild
integer li_return
This.SetTransobject( SQLCA)
This.insertrow( 0)
This.getchild( "facility_id",dwchild)
dwchild.settransobject( SQLCA)
dwchild.retrieve( )
dwchild.insertrow( 1)
dwchild.setitem( 1,"facility_name", "All")
dwchild.setitem( 1,"facility_id",0)
This.setitem( 1,"facility_id",0)
IF dwchild.rowcount( ) >1 THEN dwchild.selectrow( 2, false)
end event

type st_1 from statictext within w_red_flag_view
integer x = 1518
integer y = 52
integer width = 293
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Data Type "
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_red_flag_view
integer x = 2263
integer y = 240
integer width = 562
integer height = 88
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add General Comment"
end type

event clicked;//red flag data:	added by long.zhang 07.05.2011
str_rfd_data ls_str_rfd
ls_str_rfd.s_type = "GEN"
openwithparm(w_red_flag_add ,ls_str_rfd)	
end event

type cb_delete from commandbutton within w_red_flag_view
integer x = 2825
integer y = 240
integer width = 325
integer height = 88
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//$<add> long.zhang 07.05.2011
//$<reason> delete red flag data

long ll_rfd_id,ll_cur_row
IF tab_1.tabpage_master.dw_redflag.rowcount( ) < 1 Then Return

IF MessageBox("DELETE","Are you sure you want to delete this record?",Question!,YesNo!,2) = 2 THEN Return

tab_1.tabpage_master.dw_redflag.deleterow( 0 )
tab_1.tabpage_master.dw_redflag.update( )

//Added by Appeon long.zhang 09.19.2016 (V15.2 Testing Bug #5331: Red Flag and Standing indicators in the top left corner of the screen do not refresh when data is modified)
If IsValid(gw_prac_data) Then gw_prac_data.Event ue_refresh_dw_red_flag()
	
tab_1.tabpage_detail.dw_2.reset( )

end event

type cb_search from pfc_u_cb within w_red_flag_view
integer x = 1842
integer y = 240
integer width = 197
integer height = 84
integer taborder = 60
boolean bringtotop = true
string text = "&Search"
end type

event clicked;call super::clicked;//$<add> long.zhang 07.04.2011
//$<reason> red flag data
//copied and modified  from w_view_audit@tab_1.tabpage_1.cb_search clicked()
gs_search lstr_search
lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "AUDIT" 

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1

ELSE
	nv_prac_info lnv_full_name
	lnv_full_name = CREATE nv_prac_info
	String ls_name
	//---Begin Modified by Alfee 11.30.2012 ------
	il_prac_id = Message.DoubleParm
	ls_name = lnv_full_name.of_get_name( il_prac_id )
	//ls_name = lnv_full_name.of_get_name( gl_prac_id )
	//il_prac_id = gl_prac_id
	//---End Modified --------------------------------
	DESTROY lnv_full_name	
	sle_prac.Text = ls_name
END IF
end event

type sle_prac from singlelineedit within w_red_flag_view
integer x = 727
integer y = 244
integer width = 1083
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean autohscroll = false
boolean displayonly = true
end type

type st_3 from statictext within w_red_flag_view
integer x = 27
integer y = 188
integer width = 265
integer height = 52
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
string text = "Facility"
boolean focusrectangle = false
end type

type cb_reset from commandbutton within w_red_flag_view
integer x = 1842
integer y = 108
integer width = 384
integer height = 88
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reset"
end type

event clicked;//<add> long.zhang 07.06.2011
//<reason> reset query condition
datetime ldt_null
integer li_null
setnull(ldt_null)
setnull(li_null)
dw_date_range.setitem(1,"from_date",ldt_null)
dw_date_range.setitem(1,"to_date",ldt_null)
sle_prac.text = ""
ddlb_data_type.selectitem( 1)
dw_facility.setitem( 1,"facility_id", 0)
dw_select_user.setitem(1,"user_id","All")

end event

type dw_date_range from u_dw within w_red_flag_view
integer x = 512
integer y = 48
integer width = 978
integer height = 144
integer taborder = 20
string dataobject = "d_select_from_thru_date"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)

end event

type cb_close from pfc_u_cb within w_red_flag_view
integer x = 3145
integer y = 108
integer width = 325
integer height = 88
integer taborder = 110
boolean bringtotop = true
string text = "&Close"
boolean cancel = true
end type

event clicked;Close( Parent )	//close view red flag data window:added by long.zhang 07.05.2011
end event

type cb_print from pfc_u_cb within w_red_flag_view
integer x = 2825
integer y = 108
integer width = 325
integer height = 88
integer taborder = 100
boolean bringtotop = true
string text = "&Print"
boolean cancel = true
end type

event clicked;call super::clicked;//$<add> long.zhang 07.06.2011
//$<reason> print red flag data
string ls_sql
str_report_cur  lstr_report
IF tab_1.tabpage_master.dw_redflag.rowcount( ) < 1 THEN Return 0
//ls_sql = tab_1.tabpage_master.dw_redflag.getsqlselect( )
//openwithparm(w_print_report_red,ls_sql)
lstr_report.s_name =  "d_rpt_red_flag"
lstr_report.s_type = 'datawindow'
lstr_report.dw_rep = tab_1.tabpage_master.dw_redflag
openwithparm(w_print_report_cur,lstr_report)

end event

type tab_1 from tab within w_red_flag_view
integer y = 356
integer width = 3506
integer height = 1612
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_master tabpage_master
tabpage_detail tabpage_detail
end type

on tab_1.create
this.tabpage_master=create tabpage_master
this.tabpage_detail=create tabpage_detail
this.Control[]={this.tabpage_master,&
this.tabpage_detail}
end on

on tab_1.destroy
destroy(this.tabpage_master)
destroy(this.tabpage_detail)
end on

event selectionchanged;
long ll_cur_row
if UpperBound(ii_security) = 0 then
	of_set_security()
end if

IF newindex = 2 THEN
	cb_sort.visible = false
	cb_save.visible = true
	if ii_security[2] = 0 then	//no edit rights
		cb_save.enabled = false
	else
		cb_save.enabled = true 
	end if
	ll_cur_row	=	this.tabpage_master.dw_redflag.getrow( )
	of_select_row(ll_cur_row)
ElSEIF newindex = 1 THEN
	cb_sort.visible = true
	cb_save.visible = false
END IF

end event

type tabpage_master from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3470
integer height = 1496
long backcolor = 33551856
string text = "Browse "
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_redflag dw_redflag
end type

on tabpage_master.create
this.dw_redflag=create dw_redflag
this.Control[]={this.dw_redflag}
end on

on tabpage_master.destroy
destroy(this.dw_redflag)
end on

type dw_redflag from u_dw within tabpage_master
integer y = 4
integer width = 3470
integer height = 1484
integer taborder = 11
string dataobject = "d_red_flag_master"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;//red flag data:	added by long.zhang 07.05.2011
IF this.rowcount( ) < 1 THEN Return 0
tab_1.selecttab( 2)
end event

event constructor;call super::constructor;//red flag data:	added by long.zhang 07.05.2011
This.of_SetUpdateAble( False )

This.of_SetTransObject(SQLCA)

This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.inv_sort.of_SetColumnDisplayNameStyle( 2 )

This.of_SetFilter(True)
This.inv_Filter.of_SetStyle(1)

//This.inv_sort.of_SetColumnHeader(True)
end event

type tabpage_detail from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3470
integer height = 1496
long backcolor = 33551856
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_detail.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_detail.destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw within tabpage_detail
integer y = 4
integer width = 3470
integer height = 1492
integer taborder = 11
string dataobject = "d_red_flag_detail"
end type

event pfc_preupdate;call super::pfc_preupdate;//red flag data:added by long.zhang 09.16.2011
long ll_cur_row
ll_cur_row =  tab_1.tabpage_master.dw_redflag.getrow();
if ll_cur_row <1 or this.getrow( ) < 1 then return -1
tab_1.tabpage_master.dw_redflag.setitem(ll_cur_row ,"msp_note",this.getItemString(this.getrow(),"msp_note"))
return 1
end event

type gb_5 from groupbox within w_red_flag_view
integer x = 5
integer width = 2249
integer height = 348
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filters:"
end type

