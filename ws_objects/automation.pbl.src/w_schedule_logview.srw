$PBExportHeader$w_schedule_logview.srw
forward
global type w_schedule_logview from window
end type
type cb_sort from commandbutton within w_schedule_logview
end type
type ddlb_flag from dropdownlistbox within w_schedule_logview
end type
type st_1 from statictext within w_schedule_logview
end type
type cb_go from commandbutton within w_schedule_logview
end type
type st_to from statictext within w_schedule_logview
end type
type st_from from statictext within w_schedule_logview
end type
type cb_reset from commandbutton within w_schedule_logview
end type
type em_to from editmask within w_schedule_logview
end type
type cb_filter from commandbutton within w_schedule_logview
end type
type em_from from editmask within w_schedule_logview
end type
type dw_schedule_veri_log from datawindow within w_schedule_logview
end type
type tv_log from treeview within w_schedule_logview
end type
type st_tip from statictext within w_schedule_logview
end type
type cb_close from commandbutton within w_schedule_logview
end type
type cb_print from commandbutton within w_schedule_logview
end type
type cb_export from commandbutton within w_schedule_logview
end type
type cb_clear from commandbutton within w_schedule_logview
end type
type dw_viewlog from datawindow within w_schedule_logview
end type
type gb_1 from groupbox within w_schedule_logview
end type
end forward

global type w_schedule_logview from window
integer width = 4357
integer height = 2344
boolean titlebar = true
string title = "Log Viewer"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_sort cb_sort
ddlb_flag ddlb_flag
st_1 st_1
cb_go cb_go
st_to st_to
st_from st_from
cb_reset cb_reset
em_to em_to
cb_filter cb_filter
em_from em_from
dw_schedule_veri_log dw_schedule_veri_log
tv_log tv_log
st_tip st_tip
cb_close cb_close
cb_print cb_print
cb_export cb_export
cb_clear cb_clear
dw_viewlog dw_viewlog
gb_1 gb_1
end type
global w_schedule_logview w_schedule_logview

type variables
string is_values
long   il_focuse_on=3
integer il_sched_type //(Appeon)Stephen 2013-07-08 - Scheduler Feature Request 3600
string is_date_filter_view='',is_date_filter_veri=''
string is_filter_view='',is_filter_veri=''
string is_view_filter='',is_veri_filter=''
w_prac_data_1 iw_prac

Long il_windowH_org  //(Appeon)Harry 11.22.2013 - V141
end variables

forward prototypes
public subroutine of_createschedtree ()
public function integer of_fresh_filter (integer sched_type, integer sched_id)
public function integer of_goto_practitioner (long ll_prac_id, long ll_facility_id, long ll_rec_id, long ll_seq_no)
public function integer of_goto_practitioner_action (long ll_prac_id, long ll_facility_id, long ll_rec_id, long ll_seq_no)
end prototypes

public subroutine of_createschedtree ();Long i, ll_Root,ll_root_2
TreeViewItem ltvi_Item

ltvi_Item.Label = "Sched Type"
ltvi_Item.Data = 0
ltvi_Item.PictureIndex = 1
ltvi_Item.SelectedPictureIndex = 1
ll_Root = tv_log.InsertItemLast(0, ltvi_Item)

n_cst_string  lnv_string
String ls_item[]
String ls_test[]
Long k = 1

lnv_string.of_parsetoarray(is_values, '/', ls_item[])
FOR i = 1 To UpperBound(ls_item[])
	ls_test[k] = lnv_string.of_gettoken(ls_item[i], '	')
	DO WHILE LenA(ls_item[i]) > 0
		k ++
		ls_test[k] = Trim(lnv_string.of_GetToken(ls_item[i], "	"))
	LOOP
	k ++
NEXT
Long j
DataStore lds_sched_name
lds_sched_name = Create DataStore
lds_sched_name.DataObject = 'd_sched_namebytype'
lds_sched_name.SetTransObject( sqlca)
Long ll_rowcnt
Long l
FOR j = 1 To UpperBound(ls_test[] ) Step 2
	debugbreak()
	ltvi_Item.Label = ls_test[j]//+String(ltvi_Item.Data)
	if j + 1 > UpperBound(ls_test[] ) then exit  //Start Code Change ----10.16.2017 #V154 maha
	ltvi_Item.Data = Long(ls_test[j+1])
	ltvi_Item.PictureIndex = 2
	ltvi_Item.SelectedPictureIndex = 3
	ll_root_2 = tv_log.InsertItemLast(ll_Root, ltvi_Item)
	ll_rowcnt = lds_sched_name.Retrieve(ltvi_Item.Data )
	FOR l = 1 To ll_rowcnt
		ltvi_Item.Label = lds_sched_name.Object.sched_name[l]//+String(lds_sched_name.Object.sched_type[l])
		ltvi_Item.Data =  lds_sched_name.Object.sched_id[l]
		ltvi_Item.PictureIndex = 2
		ltvi_Item.SelectedPictureIndex = 3
		tv_log.InsertItemLast(ll_root_2, ltvi_Item)
	NEXT
	
NEXT
tv_log.ExpandAll(ll_Root)



end subroutine

public function integer of_fresh_filter (integer sched_type, integer sched_id);//IF sched_type >= 41 And sched_type <= 43 THEN
IF sched_type = 41 Or sched_type = 43 Or sched_type = 4201 Or sched_type = 4202 THEN
	dw_schedule_veri_log.Visible = True
	dw_viewlog.Height = tv_log.Height/2 //552
	//---------Begin Modified by (Appeon)Harry 11.22.2013 for V141 for BugH112201 of IntelliCredApp V14.1 Issues of Reintegration------
	dw_schedule_veri_log.Move( dw_viewlog.x,  dw_viewlog.y + dw_viewlog.Height)
	dw_schedule_veri_log.Width =  dw_viewlog.Width
	dw_schedule_veri_log.Height = dw_viewlog.Height
	//---------End Modfiied ------------------------------------------------------
	
	//Added by  Nova 03.31.2010
	IF gs_cust_type = "I" Or gs_cust_type = "X" THEN
		cb_go.visible = False
	ELSE
		IF gb_AutoSchedule THEN
			cb_go.visible = False
		ELSE
			cb_go.visible = True
		END IF
	END IF
	//end Nova 03.31.2010
ELSE
	dw_viewlog.Height = tv_log.Height
	dw_schedule_veri_log.Visible = False
	cb_go.visible = False	//Added by  Nova 03.31.2010
END IF

IF sched_type > 0 And sched_id > 0 THEN
	is_view_filter = "sched_type =" + String(sched_type) + " and  sched_id = " + String(sched_id)
	is_veri_filter = "scheduler_id = " + String(sched_id)
ELSEIF sched_type > 0 And sched_id = 0 THEN
	is_view_filter = "sched_type ="+ String(sched_type)
	is_veri_filter = "sched_log_sched_type ="+ String(sched_type)
ELSEIF sched_type = 0 And sched_id = 0 THEN
	is_view_filter = ""
END IF

IF is_veri_filter <> '' And is_date_filter_veri <> ''   THEN
	is_filter_veri = is_veri_filter+' and '+is_date_filter_veri
ELSEIF is_veri_filter <> '' And is_date_filter_veri = ''  THEN
	is_filter_veri = is_veri_filter
ELSE
	is_filter_veri = is_date_filter_veri
END IF
dw_schedule_veri_log.SetFilter(is_filter_veri)
dw_schedule_veri_log.Filter()

IF is_view_filter <> '' And is_date_filter_view <> ''   THEN
	is_filter_view = is_view_filter+' and '+is_date_filter_view
ELSEIF is_view_filter <> '' And is_date_filter_view = ''  THEN
	is_filter_view = is_view_filter
ELSE
	is_filter_view = is_date_filter_view
END IF
//messagebox("",is_filter)
dw_viewlog.SetFilter(is_filter_view)
dw_viewlog.Filter()

RETURN 1






end function

public function integer of_goto_practitioner (long ll_prac_id, long ll_facility_id, long ll_rec_id, long ll_seq_no);
//Initiate serach
IF iw_prac.tab_1.SelectedTab <> 1 THEN
	iw_prac.tab_1.SelectTab( 1 )
END IF

// Find appropriate practitioner
pfc_cst_u_extended_search luo_search
luo_search = iw_prac.tab_1.tabpage_search.uo_search

luo_search.dw_org_facility_select.SetItem( 1, "facility_id", 0 )
luo_search.ddlb_search_type.Text = "Last Name"
luo_search.sle_srch_val.Text = ""
luo_search.cb_search.TriggerEvent(Clicked!)

// Check rights
Long ll_row
ll_row = luo_search.dw_search.Find("prac_id = " + String(ll_prac_id) + " AND parent_facility_id = " +&
	String(ll_facility_id), 1, luo_search.dw_search.RowCount())
IF ll_row <= 0 THEN
	MessageBox("Warning", "The #" + String(ll_prac_id) + " practitioner does not exist!")
	RETURN 0
END IF

luo_search.dw_search.SetRow(ll_row)
luo_search.dw_search.ScrollToRow(ll_row)
IF iw_prac.tab_1.tabpage_verif.Visible = False THEN
	Close(iw_prac)
	IF IsValid( w_auto_schedule ) THEN
		w_auto_schedule.BringToTop = True
	END IF
	IF IsValid( w_schedule_logview ) THEN
		w_schedule_logview.BringToTop = True
	END IF
	RETURN 0
END IF
// Go to tabpage
//Verification Status->Detail Tab
iw_prac.tab_1.SelectTab( 5 )
iw_prac.tab_1.tabpage_verif.uo_verif_summary.tab_view.Post SelectTab ( 2 )


// Perform action
Post Of_goto_practitioner_action( ll_prac_id, ll_facility_id,  ll_rec_id, ll_seq_no )

RETURN 1





end function

public function integer of_goto_practitioner_action (long ll_prac_id, long ll_facility_id, long ll_rec_id, long ll_seq_no);//Added by  Nova 03.31.2010
// Go to appropriate row
u_dw	ldw
Long ll_row

iw_prac.tab_1.tabpage_verif.uo_verif_summary.rb_stat_both.Checked = True
iw_prac.tab_1.tabpage_verif.uo_verif_summary.rb_stat_both.Event Clicked( )

iw_prac.tab_1.tabpage_verif.uo_verif_summary.rb_ver_stat_both.Checked = True
iw_prac.tab_1.tabpage_verif.uo_verif_summary.rb_ver_stat_both.Event Clicked( )

ldw = iw_prac.tab_1.tabpage_verif.uo_verif_summary.dw_detail
ll_row = ldw.Find("prac_id = " + String(ll_prac_id) + " and verif_info_facility_id = " +&
	String(ll_facility_id) + " and rec_id = " + String(ll_rec_id) +&
	" and seq_no = " + String(ll_seq_no), 1, ldw.RowCount( ))
IF ll_row > 0 THEN
	ldw.SetRow( ll_row )
	ldw.ScrollToRow( ll_row)
END IF
RETURN 1





end function

on w_schedule_logview.create
this.cb_sort=create cb_sort
this.ddlb_flag=create ddlb_flag
this.st_1=create st_1
this.cb_go=create cb_go
this.st_to=create st_to
this.st_from=create st_from
this.cb_reset=create cb_reset
this.em_to=create em_to
this.cb_filter=create cb_filter
this.em_from=create em_from
this.dw_schedule_veri_log=create dw_schedule_veri_log
this.tv_log=create tv_log
this.st_tip=create st_tip
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_export=create cb_export
this.cb_clear=create cb_clear
this.dw_viewlog=create dw_viewlog
this.gb_1=create gb_1
this.Control[]={this.cb_sort,&
this.ddlb_flag,&
this.st_1,&
this.cb_go,&
this.st_to,&
this.st_from,&
this.cb_reset,&
this.em_to,&
this.cb_filter,&
this.em_from,&
this.dw_schedule_veri_log,&
this.tv_log,&
this.st_tip,&
this.cb_close,&
this.cb_print,&
this.cb_export,&
this.cb_clear,&
this.dw_viewlog,&
this.gb_1}
end on

on w_schedule_logview.destroy
destroy(this.cb_sort)
destroy(this.ddlb_flag)
destroy(this.st_1)
destroy(this.cb_go)
destroy(this.st_to)
destroy(this.st_from)
destroy(this.cb_reset)
destroy(this.em_to)
destroy(this.cb_filter)
destroy(this.em_from)
destroy(this.dw_schedule_veri_log)
destroy(this.tv_log)
destroy(this.st_tip)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_export)
destroy(this.cb_clear)
destroy(this.dw_viewlog)
destroy(this.gb_1)
end on

event open;
//il_sched_id=message.DoubleParm
is_values=message.stringParm

il_windowH_org = This.WorkSpaceHeight() //(Appeon)Harry 11.22.2013 - V141 BugH112201

of_createschedtree()

dw_viewlog.retrieve()
dw_schedule_veri_log.retrieve()

tv_log.setfocus()
tv_log.SelectItem(1)


end event

event resize;//---------Begin Added by (Appeon)Harry 11.22.2013 for V141 for BugH112201 of IntelliCredApp V14.1 Issues of Reintegration------
Long ll_resizeheight

if sizetype = 1 then return 
if newheight <= 0 then return
this.setredraw( false)
ll_resizeheight = newheight - il_windowH_org 

 //Start Code Change ----03.26.2015 #V15 maha -removed the buttons from this
//st_tip.y = st_tip.y + ll_resizeheight
//gb_1.y = gb_1.y + ll_resizeheight
//st_from.y = st_from.y + ll_resizeheight
//em_from.y = em_from.y + ll_resizeheight
//st_to.y = st_to.y + ll_resizeheight
//em_to.y = em_to.y + ll_resizeheight
//cb_reset.y = cb_reset.y + ll_resizeheight
//st_1.y = st_1.y + ll_resizeheight
//ddlb_flag.y = ddlb_flag.y + ll_resizeheight
//cb_filter.y = cb_filter.y + ll_resizeheight
//cb_go.y = cb_go.y + ll_resizeheight
//cb_clear.y = cb_clear.y + ll_resizeheight
//cb_export.y = cb_export.y + ll_resizeheight
//cb_print.y = cb_print.y + ll_resizeheight
//cb_close.y = cb_close.y + ll_resizeheight

tv_log.height = tv_log.height + ll_resizeheight
if dw_schedule_veri_log.visible then
	dw_viewlog.move(dw_viewlog.x, dw_viewlog.y )
	dw_viewlog.Resize(newwidth - tv_log.width - 30, tv_log.height/2)
	dw_schedule_veri_log.move(dw_schedule_veri_log.x, dw_viewlog.y + dw_viewlog.height)
	dw_schedule_veri_log.Resize(dw_viewlog.width, tv_log.height/2)
else
	dw_viewlog.move(dw_viewlog.x, dw_viewlog.y )
	dw_viewlog.Resize(newwidth - tv_log.width - 30, tv_log.height )
end if

il_windowH_org = newheight
this.setredraw( true)
end event

type cb_sort from commandbutton within w_schedule_logview
integer x = 3131
integer y = 60
integer width = 279
integer height = 84
integer taborder = 60
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

dw_viewlog.SetSort(null_str)

dw_viewlog.Sort( )
end event

type ddlb_flag from dropdownlistbox within w_schedule_logview
integer x = 2318
integer y = 60
integer width = 361
integer height = 324
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"All","Successful","Failure"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_schedule_logview
integer x = 2327
integer y = 12
integer width = 183
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Status"
boolean focusrectangle = false
end type

type cb_go from commandbutton within w_schedule_logview
boolean visible = false
integer x = 2976
integer y = 60
integer width = 151
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Go"
end type

event clicked;//Added by  Nova 03.31.2010
String   ls_arr[ ],ls_doc_id
Integer li_numstats
Long ll_rec_id,ll_prac_id,ll_facility_id,ll_seq_no
IF dw_schedule_veri_log.RowCount( ) < 1 THEN RETURN
n_cst_string  lnv_string
ls_doc_id = dw_schedule_veri_log.Object.doc_id[dw_schedule_veri_log.GetRow()]
li_numstats = lnv_string.of_Parsetoarray (ls_doc_id, "-", ls_arr)
ll_rec_id = Long(ls_arr[1])
ll_prac_id = Long(ls_arr[2])
ll_facility_id = Long( ls_arr[3])
ll_seq_no = Long( ls_arr[4])
//open window
IF Not IsValid(w_prac_data_1) THEN
	OpenSheet( w_prac_data_1, w_mdi, 4, original!)
END IF
iw_prac = w_prac_data_1

iw_prac.BringToTop = True

Post of_goto_practitioner( ll_prac_id, ll_facility_id,  ll_rec_id, ll_seq_no)





end event

type st_to from statictext within w_schedule_logview
integer x = 1541
integer y = 72
integer width = 105
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "To: "
boolean focusrectangle = false
end type

type st_from from statictext within w_schedule_logview
integer x = 905
integer y = 72
integer width = 151
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "From: "
boolean focusrectangle = false
end type

type cb_reset from commandbutton within w_schedule_logview
integer x = 2080
integer y = 60
integer width = 210
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reset"
end type

event clicked;//mm/dd/yyyy hh:mm:ss 
em_from.text='00/00/0000'
em_to.text='00/00/0000'
is_date_filter_view=''
is_date_filter_veri=''
is_filter_veri = is_veri_filter
dw_schedule_veri_log.SetFilter(is_filter_veri)
dw_schedule_veri_log.Filter()
is_filter_view = is_view_filter
dw_viewlog.SetFilter(is_filter_view)
dw_viewlog.Filter()
end event

type em_to from editmask within w_schedule_logview
integer x = 1659
integer y = 64
integer width = 407
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
boolean autoskip = true
boolean spin = true
end type

type cb_filter from commandbutton within w_schedule_logview
integer x = 2688
integer y = 60
integer width = 279
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run &Filter"
end type

event clicked;
String ld_today_date
string ls_filte_flag
//DateTime ldt_from,ldt_to //00/00/0000 00:00:00 
Date ldt_from,ldt_to

//---------Begin Modified by (Appeon)Stephen 2013-07-04 for Scheduler Feature Request 3600--------
/*
If (em_from.Text = '' And  em_to.Text = '' )THEN 
	RETURN
ElseIf (em_from.Text = '00/00/0000' And  em_to.Text = '00/00/0000' )  THEN
	RETURN
ELSEIF (em_from.Text <> '00/00/0000')  And  (em_to.Text = '00/00/0000') THEN
	MessageBox("Info","End date can not be empty!")
	em_to.SetFocus( )
	RETURN
ELSEIF em_from.Text = '00/00/0000' And  em_to.Text <> '00/00/0000' THEN
	MessageBox("Info","Start date can not be empty!")
	em_from.SetFocus( )
	RETURN
ELSEIF em_from.Text <> '00/00/0000' And  em_to.Text <> '00/00/0000' THEN
	em_from.GetData(ldt_from)
	em_to.GetData(ldt_to)
	IF ldt_from > ldt_to THEN
		MessageBox("","Start date can not be greater than the end date!")
		em_from.SetFocus( )
		RETURN
	END IF
	is_date_filter_view = "string(run_time,'mm-dd-yyyy')>='" +String(ldt_from,'mm-dd-yyyy')+" '" +" and string(run_time,'mm-dd-yyyy')<='" +String(ldt_to,'mm-dd-yyyy')+" '"
	is_date_filter_veri = "string(date_run,'mm-dd-yyyy')>='" +String(ldt_from,'mm-dd-yyyy')+" '" +" and string(date_run,'mm-dd-yyyy')<='" +String(ldt_to,'mm-dd-yyyy')+" '"
END IF
*/
is_date_filter_view =''
is_date_filter_veri = '1=1 '

If (em_from.Text = '' And  em_to.Text = '' and (ddlb_flag.text = '' or ddlb_flag.text='All') )THEN 
	cb_reset.event clicked()
	RETURN
ElseIf (em_from.Text = '00/00/0000' And  em_to.Text = '00/00/0000'  and (ddlb_flag.text = '' or ddlb_flag.text='All'))  THEN
	cb_reset.event clicked()
	RETURN
ELSEIF (em_from.Text <> '00/00/0000' and em_from.Text <> '')  And  (em_to.Text = '00/00/0000' or em_to.Text = '') THEN
	MessageBox("Info","End date can not be empty!")
	em_to.SetFocus( )
	RETURN
ELSEIF (em_from.Text = '00/00/0000' or em_from.Text = '' ) And  (em_to.Text <> '00/00/0000' and em_to.Text <> '') THEN
	MessageBox("Info","Start date can not be empty!")
	em_from.SetFocus( )
	RETURN
ELSEIF (em_from.Text <> '00/00/0000' and em_from.Text <> '') And  (em_to.Text <> '00/00/0000' and em_to.Text <> '') THEN
	em_from.GetData(ldt_from)
	em_to.GetData(ldt_to)
	IF ldt_from > ldt_to THEN
		MessageBox("","Start date can not be greater than the end date!")
		em_from.SetFocus( )
		RETURN
	END IF
	is_date_filter_view = "string(run_time,'mm-dd-yyyy')>='" +String(ldt_from,'mm-dd-yyyy')+" '" +" and string(run_time,'mm-dd-yyyy')<='" +String(ldt_to,'mm-dd-yyyy')+" '"
	is_date_filter_veri = "string(date_run,'mm-dd-yyyy')>='" +String(ldt_from,'mm-dd-yyyy')+" '" +" and string(date_run,'mm-dd-yyyy')<='" +String(ldt_to,'mm-dd-yyyy')+" '"
END IF

if ddlb_flag.text = '' or ddlb_flag.text='All' then
else
	if ddlb_flag.text = 'Successful' then
		ls_filte_flag = "comp_flag = 'Y'"		
	elseif ddlb_flag.text = 'Failure' then
		ls_filte_flag = "(comp_flag = 'N' or isnull(comp_flag))"
	end if
	
	if isnull(is_date_filter_view) or is_date_filter_view = '' then
		is_date_filter_view = ls_filte_flag
	else
		is_date_filter_view = is_date_filter_view + " and " + ls_filte_flag
	end if
	
	if dw_schedule_veri_log.visible  and il_sched_type = 43 then
		if isnull(is_date_filter_veri) or is_date_filter_veri = '' then
			is_date_filter_veri = ls_filte_flag
		else
			is_date_filter_veri = is_date_filter_veri + " and " + ls_filte_flag
		end if		
	end if
	
end if
//---------End Modified ------------------------------------------------------


//ls_filter="run_time >=datetime(date('" +mid(em_from.text,1,10)+"' ),time('"+mid(em_from.text,12,8)+"' ))" +" and run_time <=datetime(date('" +mid(em_to.text,1,10)+"' ),time('"+mid(em_to.text,12,8)+"'))" 


IF is_veri_filter <> '' THEN
	is_filter_veri = is_date_filter_veri+' and '+is_veri_filter
ELSE
	is_filter_veri = is_date_filter_veri
END IF
dw_schedule_veri_log.SetFilter(is_filter_veri)
dw_schedule_veri_log.Filter()

IF is_view_filter <> '' THEN
	is_filter_view = is_date_filter_view+' and '+is_view_filter
ELSE
	is_filter_view = is_date_filter_view
END IF

dw_viewlog.SetFilter(is_filter_view)
dw_viewlog.Filter( )








end event

type em_from from editmask within w_schedule_logview
integer x = 1065
integer y = 64
integer width = 430
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
boolean autoskip = true
boolean spin = true
end type

type dw_schedule_veri_log from datawindow within w_schedule_logview
integer x = 869
integer y = 1176
integer width = 3387
integer height = 1044
integer taborder = 30
boolean titlebar = true
string title = "Schedule Verification Log"
string dataobject = "d_schedule_veri_log"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If row > 0 Then
	This.SelectRow(0, FALSE)
	This.scrolltorow(row)
	This.SelectRow(row, TRUE)
End If

end event

event constructor;this.settransobject(sqlca)
end event

event doubleclicked;IF row > 0  and dwo.name <>'b_go' THEN
	//messagebox("",string(dwo.name ))
	IF IsValid(w_schedule_detail) THEN Close(w_schedule_detail)
	OpenWithParm(w_schedule_detail,'1')
	w_schedule_detail.tab_1.tabpage_1.dw_log_detail.ScrollToRow(row)
END IF

end event

event rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
end event

event losefocus;il_focuse_on=2

end event

event buttonclicked;IF dwo.Name = 'b_go' THEN
	String   ls_arr[ ],ls_doc_id
	Integer li_numstats
	Long ll_rec_id,ll_prac_id,ll_facility_id,ll_seq_no
	n_cst_string  lnv_string
	ls_doc_id = This.Object.doc_id[row]
	li_numstats = lnv_string.of_Parsetoarray (ls_doc_id, "-", ls_arr)
	ll_rec_id = Long(ls_arr[1])
	ll_prac_id = Long(ls_arr[2])
	ll_facility_id = Long( ls_arr[3])
	ll_seq_no = Long( ls_arr[4])
	// Open the practitioner window
	IF gs_cust_type = "I" THEN
		IF Not IsValid(w_prac_data_intelliapp) THEN
				OpenSheet( w_prac_data_intelliapp, w_mdi, 4, original!)
			w_prac_data_intelliapp.Move(0,0)
			w_prac_data_intelliapp.BringToTop = True
		END IF
		iw_prac = w_prac_data_intelliapp
	ELSE
		IF Not IsValid(w_prac_data_intelliapp) THEN
				OpenSheet( w_prac_data_1, w_mdi, 4, original!)
		END IF
		iw_prac = w_prac_data_1
	END IF
	iw_prac.BringToTop = True
	
   Post of_goto_practitioner( ll_prac_id, ll_facility_id,  ll_rec_id, ll_seq_no)
	//MessageBox("","i will go tab5")
END IF


end event

event other;//---------Begin Modified by (Appeon)Harry 11.22.2013 for V141 for BugH112201 of IntelliCredApp V14.1 Issues of Reintegration------
if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
//---------End Modfiied ------------------------------------------------------

end event

type tv_log from treeview within w_schedule_logview
integer y = 176
integer width = 850
integer height = 2048
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean hideselection = false
string picturename[] = {"Application!","aactx_alarm.png","aactx_analysis.png"}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event selectionchanged;Long i, ll_RowCount
Long ll_tvi
treeviewitem l_tvinew,ltviparent

tv_log.GetItem(newhandle, l_tvinew)

IF l_tvinew.Level = 2 THEN
	of_fresh_filter(Long(l_tvinew.Data),0)
	il_sched_type = Long(l_tvinew.Data)//(Appeon)Stephen 2013-07-08 - Scheduler Feature Request 3600
ELSEIF l_tvinew.Level = 3 THEN
	ll_tvi = tv_log.FindItem(ParentTreeItem!, newhandle)
	tv_log.GetItem(ll_tvi,ltviparent)
	of_fresh_filter(Long(ltviparent.Data),Long(l_tvinew.Data))
	il_sched_type = Long(ltviparent.Data)//(Appeon)Stephen 2013-07-08 - Scheduler Feature Request 3600
ELSEIF l_tvinew.Level = 1 THEN
	of_fresh_filter(0,0)
END IF

cb_filter.event clicked( )
dw_viewlog.event rowfocuschanged(1)
dw_schedule_veri_log.event rowfocuschanged(1)
end event

event constructor;//this.backcolor=32897791
end event

type st_tip from statictext within w_schedule_logview
integer x = 18
integer y = 64
integer width = 850
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Double click on Type to view detail"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_schedule_logview
integer x = 4046
integer y = 60
integer width = 206
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;
if isvalid(w_log_detail) then close(w_log_detail)

close(parent)
end event

type cb_print from commandbutton within w_schedule_logview
integer x = 3835
integer y = 60
integer width = 206
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;IF il_focuse_on = 3 THEN
	IF dw_viewlog.RowCount() < 1 THEN
		RETURN
	ELSE
		dw_viewlog.print()
	END IF
	IF dw_schedule_veri_log.RowCount() < 1 THEN
		RETURN
	ELSE
		dw_schedule_veri_log.print()
	END IF
ELSEIF il_focuse_on = 1 THEN
	IF dw_viewlog.RowCount() < 1 THEN
		RETURN
	ELSE
		dw_viewlog.print()
	END IF
ELSEIF il_focuse_on = 2 THEN
	IF dw_schedule_veri_log.RowCount() < 1 THEN
		RETURN
	ELSE
		dw_schedule_veri_log.print()
	END IF
END IF

end event

type cb_export from commandbutton within w_schedule_logview
integer x = 3625
integer y = 60
integer width = 206
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export"
end type

event clicked;//Reconstructed by Alfee 09.12.2013 for the Feature Request 3663 

CHOOSE CASE il_focuse_on
	CASE 1
		IF dw_viewlog.RowCount() > 0 THEN
			gnv_dw.of_SaveAs(dw_viewlog,"",text!,true)
		END IF
	CASE 2 
		IF dw_schedule_veri_log.RowCount() > 0 THEN
			gnv_dw.of_SaveAs(dw_schedule_veri_log,"",text!,true)
		END IF	
	CASE 3
		IF dw_viewlog.RowCount() > 0 THEN
			gnv_dw.of_SaveAs(dw_viewlog,"",text!,true)
		ELSEIF dw_schedule_veri_log.RowCount() > 0 THEN
			gnv_dw.of_SaveAs(dw_schedule_veri_log,"",text!,true)
		END IF
END CHOOSE

ChangeDirectory(gs_current_path)

//Integer Value
//Long ll_pos
//String docname,named
//String ls_extend_type
//saveastype ls_type
//IF AppeonGetClientType() = 'PB' THEN
//	Value = GetFileSaveName("Save As File",&
//		+ docname, named, "DOC", &
//		+ "Excel (*.xls),*.xls," &
//		+ "Text (*.txt),*.txt," &
//		+ "CSV (*.csv),*.csv," &
//		+ "HTMLTable (*.html),*.html," &
//		+ "XML (*.xml),*.xml," &
//		+ "PDF (*.pdf),*.pdf")
//ELSE
//	Value = GetFileSaveName("Save As File",&
//		+ docname, named, "DOC", &
//		+ "Excel (*.xls),*.xls," &
//		+ "Text (*.txt),*.txt," &
//		+ "HTMLTable (*.html),*.html," &
//		+ "PDF (*.pdf),*.pdf")
//END IF
//IF Value = 0 THEN RETURN
//ll_pos = LastPos(named, ".")
//IF ll_pos = 0 THEN RETURN
//ls_extend_type = Lower(RightA(named,LenA(Trim(named)) -ll_pos))
//CHOOSE CASE Trim(ls_extend_type)
//	CASE  'xls'
//		ls_type = Excel!
//	CASE  'txt'
//		ls_type = Text!
//	CASE  'csv'
//		ls_type = CSV!
//	CASE  'html'
//		ls_type = HTMLTable!
//	CASE  'xml'
//		ls_type = XML!
//	CASE  'pdf'
//		ls_type = PDF!
//		appeon_pdfservice lnv_pdf
//		lnv_pdf = Create appeon_pdfservice
//	CASE ELSE
//END CHOOSE
//IF il_focuse_on = 3 THEN
//	IF dw_viewlog.RowCount() < 1 THEN
//		RETURN
//	ELSE
//		IF ls_extend_type <> 'pdf' THEN
//			dw_viewlog.SaveAs(docname,ls_type,True)
//		ELSE
//			lnv_pdf.of_Print(dw_viewlog, docname)
//		END IF
//	END IF
//	IF dw_schedule_veri_log.RowCount() < 1 THEN
//		RETURN
//	ELSE
//		IF ls_extend_type <> 'pdf' THEN
//			dw_schedule_veri_log.SaveAs(docname,ls_type,True)
//		ELSE
//			lnv_pdf.of_Print(dw_schedule_veri_log, docname)
//		END IF
//	END IF
//ELSEIF il_focuse_on = 1 THEN
//	IF dw_viewlog.RowCount() < 1 THEN
//		RETURN
//	ELSE
//		IF ls_extend_type <> 'pdf' THEN
//			dw_viewlog.SaveAs(docname,ls_type,True)
//		ELSE
//			lnv_pdf.of_Print(dw_viewlog, docname)
//		END IF
//	END IF
//ELSEIF il_focuse_on = 2 THEN
//	IF dw_schedule_veri_log.RowCount() < 1 THEN
//		RETURN
//	ELSE
//		IF ls_extend_type <> 'pdf' THEN
//			dw_schedule_veri_log.SaveAs(docname,ls_type,True)
//		ELSE
//			lnv_pdf.of_Print(dw_schedule_veri_log, docname)
//		END IF
//	END IF
//END IF
//Destroy lnv_pdf

end event

type cb_clear from commandbutton within w_schedule_logview
integer x = 3415
integer y = 60
integer width = 206
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;Long ll_return
//MessageBox("focuse",String(il_focuse_on))

ll_return = MessageBox("Delete Logs", "This will Delete the log files shown.  Do you want to continue?", Question!, YesNo!)
if ll_return = 2 then return 


IF il_focuse_on = 3 THEN
	ll_return = MessageBox("Log save", "Do you want to Export before before deleting?", Question!, YesNoCancel!)
	IF  ll_return = 3 THEN
		RETURN
	ELSEIF ll_return = 1 THEN
		cb_export.TriggerEvent(Clicked!)
		dw_viewlog.RowsMove(1, dw_viewlog.RowCount(), Primary!, dw_viewlog, 1, DELETE!)
		dw_schedule_veri_log.RowsMove(1, dw_schedule_veri_log.RowCount(), Primary!, dw_schedule_veri_log, 1, DELETE!)
	ELSEIF ll_return = 2 THEN
		dw_viewlog.RowsMove(1, dw_viewlog.RowCount(), Primary!, dw_viewlog, 1, DELETE!)
		dw_schedule_veri_log.RowsMove(1, dw_schedule_veri_log.RowCount(), Primary!, dw_schedule_veri_log, 1, DELETE!)
	END IF
	IF dw_viewlog.Update() = 1 THEN
		IF dw_schedule_veri_log.Update() = 1 THEN
			COMMIT Using sqlca;
		ELSE
			ROLLBACK Using sqlca;
		END IF
	ELSE
		ROLLBACK Using sqlca;
	END IF
ELSEIF il_focuse_on = 1 THEN
	IF dw_viewlog.RowCount() < 1 THEN RETURN
	ll_return = MessageBox("Log save", "Do you want to Export before deleting "+dw_viewlog.Title+"?", Question!, YesNoCancel!)
	IF  ll_return = 3 THEN
		RETURN
	ELSEIF ll_return = 1 THEN
		cb_export.TriggerEvent(Clicked!)
		dw_viewlog.RowsMove(1, dw_viewlog.RowCount(), Primary!, dw_viewlog, 1, DELETE!)
	ELSEIF ll_return = 2 THEN
		dw_viewlog.RowsMove(1, dw_viewlog.RowCount(), Primary!, dw_viewlog, 1, DELETE!)
	END IF
	IF dw_viewlog.Update() = 1 THEN
		COMMIT Using sqlca;
	ELSE
		ROLLBACK Using sqlca;
	END IF
ELSEIF il_focuse_on = 2 THEN
	IF dw_schedule_veri_log.RowCount() < 1 THEN RETURN
	ll_return = MessageBox("Log save", "Do you want to Export  before Deleting "+dw_schedule_veri_log.Title+"?", Question!, YesNoCancel!)
	IF  ll_return = 3 THEN
		RETURN
	ELSEIF ll_return = 1 THEN
		cb_export.TriggerEvent(Clicked!)
		dw_schedule_veri_log.RowsMove(1, dw_schedule_veri_log.RowCount(), Primary!, dw_schedule_veri_log, 1, DELETE!)
	ELSEIF ll_return = 2 THEN
		dw_schedule_veri_log.RowsMove(1, dw_schedule_veri_log.RowCount(), Primary!, dw_schedule_veri_log, 1, DELETE!)
	END IF
	IF dw_schedule_veri_log.Update() = 1 THEN
		COMMIT Using sqlca;
	ELSE
		ROLLBACK Using sqlca;
	END IF
END IF




end event

type dw_viewlog from datawindow within w_schedule_logview
integer x = 869
integer y = 172
integer width = 3387
integer height = 980
integer taborder = 10
boolean titlebar = true
string title = "Schedule Log"
string dataobject = "d_schedule_log"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;If row > 0 Then
	This.SelectRow(0, FALSE)
	This.scrolltorow(row)
	This.SelectRow(row, TRUE)
End If

end event

event rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
end event

event doubleclicked;IF row > 0 THEN
	IF IsValid(w_schedule_detail) THEN Close(w_schedule_detail)
	OpenWithParm(w_schedule_detail,'0')
	w_schedule_detail.tab_1.tabpage_1.dw_log_detail.ScrollToRow(row)
END IF

end event

event losefocus;il_focuse_on=1
end event

event other;//---------Begin Modified by (Appeon)Harry 11.22.2013 for V141 for BugH112201 of IntelliCredApp V14.1 Issues of Reintegration------
if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
//---------End Modfiied ------------------------------------------------------


end event

type gb_1 from groupbox within w_schedule_logview
integer x = 873
integer y = 4
integer width = 1435
integer height = 160
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Date Range"
end type

