$PBExportHeader$w_dashboard_gadget_summary_config.srw
forward
global type w_dashboard_gadget_summary_config from w_response
end type
type dw_filter from datawindow within w_dashboard_gadget_summary_config
end type
type ddlb_height from dropdownlistbox within w_dashboard_gadget_summary_config
end type
type st_height from statictext within w_dashboard_gadget_summary_config
end type
type rb_bar3d from radiobutton within w_dashboard_gadget_summary_config
end type
type rb_column3d from radiobutton within w_dashboard_gadget_summary_config
end type
type dw_report_selection from datawindow within w_dashboard_gadget_summary_config
end type
type rb_pie from radiobutton within w_dashboard_gadget_summary_config
end type
type rb_line from radiobutton within w_dashboard_gadget_summary_config
end type
type rb_column from radiobutton within w_dashboard_gadget_summary_config
end type
type rb_bar from radiobutton within w_dashboard_gadget_summary_config
end type
type p_1 from picture within w_dashboard_gadget_summary_config
end type
type rb_graph from radiobutton within w_dashboard_gadget_summary_config
end type
type rb_grid from radiobutton within w_dashboard_gadget_summary_config
end type
type cb_cancel from commandbutton within w_dashboard_gadget_summary_config
end type
type cb_ok from commandbutton within w_dashboard_gadget_summary_config
end type
type gb_1 from groupbox within w_dashboard_gadget_summary_config
end type
type gb_2 from groupbox within w_dashboard_gadget_summary_config
end type
type gb_3 from groupbox within w_dashboard_gadget_summary_config
end type
type gb_filter from groupbox within w_dashboard_gadget_summary_config
end type
end forward

global type w_dashboard_gadget_summary_config from w_response
integer width = 1655
integer height = 1604
string title = "Dashboard Gadget Settings"
long backcolor = 33551856
event ue_syscommand pbm_syscommand
dw_filter dw_filter
ddlb_height ddlb_height
st_height st_height
rb_bar3d rb_bar3d
rb_column3d rb_column3d
dw_report_selection dw_report_selection
rb_pie rb_pie
rb_line rb_line
rb_column rb_column
rb_bar rb_bar
p_1 p_1
rb_graph rb_graph
rb_grid rb_grid
cb_cancel cb_cancel
cb_ok cb_ok
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_filter gb_filter
end type
global w_dashboard_gadget_summary_config w_dashboard_gadget_summary_config

type variables
u_cst_gadget_summary_master iuo_current_gadget

Long il_tdl_right
end variables

forward prototypes
public function integer of_filter_report_list (datawindowchild adwc_report, long al_report_id[])
public subroutine of_set_position (integer ai_report_id)
end prototypes

event ue_syscommand;//////////////////////////////////////////////////////////////////////
// $<event>ue_syscommandw_dashboard_config()
// $<arguments>
//		value	unsignedlong	commandtype		
//		value	integer     	xpos       		
//		value	integer     	ypos       		
// $<returns> long
// $<description> If click 'Close' button on title bar, 
// $<description> Need trigger clickced event for 'Cancel' button.
//////////////////////////////////////////////////////////////////////
// $<add> 26/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

public function integer of_filter_report_list (datawindowchild adwc_report, long al_report_id[]);
Long i,ll_row

For i = 1 to UpperBound(al_report_id[])
	ll_row = adwc_report.Find('id = ' + String(al_report_id[i]),1,adwc_report.RowCount() )
	If ll_row > 0 Then
		adwc_report.rowsdiscard(ll_row,ll_row,Primary!)
	End If
Next
Return 1
end function

public subroutine of_set_position (integer ai_report_id);Long ll_cnt
If ai_report_id = 0 or isnull(ai_report_id) Then ai_report_id = 1
Choose Case ai_report_id
	Case 1,2,3,4,5,6 //Contracts
		gb_filter.visible = False
		dw_filter.visible = False
		st_height.y = 1084
		ddlb_height.y = st_height.y
		cb_ok.y = st_height.y
		cb_cancel.y = st_height.y
		This.Height = st_height.y + st_height.height + 160
	Case 7 //To Do List
		Select count(1) Into :ll_cnt From tdl_detail 
			Where graph_category is not null And graph_category <> '' ;
		gb_filter.visible = True
		dw_filter.visible = True
		st_height.y = 1396
		ddlb_height.y = st_height.y
		cb_ok.y = st_height.y
		cb_cancel.y = st_height.y
		This.Height = st_height.y + st_height.height + 160	
		If isnull(ll_cnt) or ll_cnt = 0 Then
			Messagebox('IntelliSoft','All of the To Do Items have no Graph Category Title, please input it in To Do List Painter.')
		End If
	Case Else 
End Choose
end subroutine

on w_dashboard_gadget_summary_config.create
int iCurrent
call super::create
this.dw_filter=create dw_filter
this.ddlb_height=create ddlb_height
this.st_height=create st_height
this.rb_bar3d=create rb_bar3d
this.rb_column3d=create rb_column3d
this.dw_report_selection=create dw_report_selection
this.rb_pie=create rb_pie
this.rb_line=create rb_line
this.rb_column=create rb_column
this.rb_bar=create rb_bar
this.p_1=create p_1
this.rb_graph=create rb_graph
this.rb_grid=create rb_grid
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_filter=create gb_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filter
this.Control[iCurrent+2]=this.ddlb_height
this.Control[iCurrent+3]=this.st_height
this.Control[iCurrent+4]=this.rb_bar3d
this.Control[iCurrent+5]=this.rb_column3d
this.Control[iCurrent+6]=this.dw_report_selection
this.Control[iCurrent+7]=this.rb_pie
this.Control[iCurrent+8]=this.rb_line
this.Control[iCurrent+9]=this.rb_column
this.Control[iCurrent+10]=this.rb_bar
this.Control[iCurrent+11]=this.p_1
this.Control[iCurrent+12]=this.rb_graph
this.Control[iCurrent+13]=this.rb_grid
this.Control[iCurrent+14]=this.cb_cancel
this.Control[iCurrent+15]=this.cb_ok
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.gb_2
this.Control[iCurrent+18]=this.gb_3
this.Control[iCurrent+19]=this.gb_filter
end on

on w_dashboard_gadget_summary_config.destroy
call super::destroy
destroy(this.dw_filter)
destroy(this.ddlb_height)
destroy(this.st_height)
destroy(this.rb_bar3d)
destroy(this.rb_column3d)
destroy(this.dw_report_selection)
destroy(this.rb_pie)
destroy(this.rb_line)
destroy(this.rb_column)
destroy(this.rb_bar)
destroy(this.p_1)
destroy(this.rb_graph)
destroy(this.rb_grid)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_filter)
end on

event pfc_preopen;call super::pfc_preopen;iuo_current_gadget = Message.Powerobjectparm
end event

event open;call super::open;Long ll_row,i
Long ll_report_id[],ll_empty[]
String ls_filter
This.Title = 'Summary '+String(iuo_current_gadget.ii_summary_id) + ' Settings'

Choose Case iuo_current_gadget.istr_current_gadget.adec_height_ier
	Case 1
		ddlb_height.SelectItem(1)
	Case 1.2
		ddlb_height.SelectItem(2)
	Case 1.5
		ddlb_height.SelectItem(3)
	Case 1.8
		ddlb_height.SelectItem(4)		
	Case 2
		ddlb_height.SelectItem(5)
	Case Else
		ddlb_height.SelectItem(1)
End Choose

//Reset
of_set_position(1)

Datawindowchild ldwc_report
dw_report_selection.GetChild('report_id',ldwc_report)
ldwc_report.SetTransobject(SQLCA)

Datawindowchild ldwc_user
dw_filter.GetChild('user_id',ldwc_user)
ldwc_user.SetTransObject(SQLCA)

String ls_module[]
n_cst_tdl_function lnv_tdl_function
Datawindowchild ldwc_tdl
//---------Begin Modified by (Appeon)Harry 01.09.2014 for V141 for Bug # 3816 only contract support Graph--------
//lnv_tdl_function.of_get_module( ls_module)
ls_module[1] = "03"									
ls_module[2] = "04"	
//---------End Modfiied ------------------------------------------------------

dw_filter.GetChild('tdl_id',ldwc_tdl)
ldwc_tdl.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	ldwc_report.Retrieve()
	ldwc_user.Retrieve(gs_user_id)
	ldwc_tdl.Retrieve(ls_module[])
gnv_appeondb.of_commitqueue( )

SELECT tdl_rights into :il_tdl_right from security_users where user_id = :gs_user_id;

dw_filter.insertrow(0)

//Check Contract module Access Right
If m_pfe_cst_master_menu.m_file.m_contract.Visible = False Then
	//Filter data that have no access.
	ll_report_id[1] = 1
	ll_report_id[2] = 2
	ll_report_id[3] = 3
	ll_report_id[4] = 4
	ll_report_id[5] = 5
	ll_report_id[6] = 6
	ll_report_id[7] = 7//(Appeon)Toney 10.14.2013 - V141 ISG-CLX  Fix Reintegration BugH101101, only support contract biz
	This.of_filter_report_list(ldwc_report,ll_report_id )
	ll_report_id[] = ll_empty[] //Reset
End If

//Check To Do List module Access Right
If m_pfe_cst_master_menu.m_file.m_todolist.Visible = False Then
	ll_report_id[1] = 7
	This.of_filter_report_list(ldwc_report,ll_report_id[] )
	ll_report_id[] = ll_empty[] //Reset	
End If

ll_row = ldwc_report.InsertRow(1)
ldwc_report.SetItem(ll_row,'id',0)
ldwc_report.SetItem(ll_row,'report_name','')
dw_report_selection.InsertRow(0)

If Not isNull(iuo_current_gadget.ii_report_id) and iuo_current_gadget.ii_report_id <> 0 Then
	If ldwc_report.Find('id = ' + String(iuo_current_gadget.ii_report_id),1, ldwc_report.RowCount()) > 0 Then
		dw_report_selection.Setitem(1,'report_id',iuo_current_gadget.ii_report_id)
		of_set_position(iuo_current_gadget.ii_report_id)
	End If
End If

If iuo_current_gadget.ii_isgraph = 1 Then
	rb_graph.checked = True
	rb_grid.checked = False
	rb_graph.Event clicked()
Else
	rb_graph.checked = False
	rb_grid.checked = True
	rb_grid.Event clicked()	
End If

Choose Case iuo_current_gadget.ii_graph_type
	Case 2
		rb_bar.checked = True
	Case 7
		rb_column.checked = True 
	Case 12
		rb_line.checked = True
	Case 13
		rb_pie.checked = True
	Case 6
		rb_bar3d.checked = True
	Case 11
		rb_column3d.checked = True 		
	Case Else
		rb_column.checked = True
End Choose

String ls_access_users
If iuo_current_gadget.is_tdl_user = '' Then
	dw_filter.SetItem(1,'user_id' , gs_user_id )
Else
	dw_filter.SetItem(1,'user_id' , iuo_current_gadget.is_tdl_user )
End If
dw_filter.SetItem(1,'tdl_id' , iuo_current_gadget.il_tdl_id )
If il_tdl_right <> 2 Then
	//Set user_id column to disable
	dw_filter.Modify("user_id.Project = '1'")
	dw_filter.Modify("user_id.TabSequence = '0'")	
	dw_filter.Modify("user_id.Background.Color='"+String(RGB(192,192,192))+"'")
	//Filter TDL column data
	For i = 1 To ldwc_tdl.RowCount()
		If ldwc_tdl.GetItemString(i,'tdl_basic_info_tdl_name') = '-ALL-' Then Continue
		//ls_access_users = ldwc_tdl.GetItemString(i,'tdl_users_access')
		ls_access_users = lnv_tdl_function.of_get_tdl_users ( iuo_current_gadget.il_tdl_id) //BugL120301 - alfee 12.06.2013
		
		If Pos(Upper(ls_access_users),Upper(gs_user_id)) = 0 Then
			ldwc_tdl.Rowsdiscard( i,i, Primary!)
		End If
	Next

End If

end event

type dw_filter from datawindow within w_dashboard_gadget_summary_config
integer x = 91
integer y = 1108
integer width = 1495
integer height = 188
integer taborder = 90
string title = "none"
string dataobject = "d_dashb_todolist_filter"
boolean border = false
boolean livescroll = true
end type

type ddlb_height from dropdownlistbox within w_dashboard_gadget_summary_config
integer x = 224
integer y = 1396
integer width = 411
integer height = 440
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Single","1.2 Height","1.5 Height","1.8 Height","Double"}
borderstyle borderstyle = stylelowered!
end type

type st_height from statictext within w_dashboard_gadget_summary_config
integer x = 37
integer y = 1396
integer width = 178
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Height:"
boolean focusrectangle = false
end type

type rb_bar3d from radiobutton within w_dashboard_gadget_summary_config
integer x = 279
integer y = 840
integer width = 302
integer height = 64
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Bar3D"
end type

type rb_column3d from radiobutton within w_dashboard_gadget_summary_config
integer x = 704
integer y = 840
integer width = 343
integer height = 64
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Column3D"
end type

type dw_report_selection from datawindow within w_dashboard_gadget_summary_config
integer x = 82
integer y = 72
integer width = 827
integer height = 96
integer taborder = 10
string title = "none"
string dataobject = "d_dashb_gadget_reports_selection"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;of_set_position(Integer(data))

end event

type rb_pie from radiobutton within w_dashboard_gadget_summary_config
integer x = 1152
integer y = 840
integer width = 201
integer height = 64
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Pie"
end type

type rb_line from radiobutton within w_dashboard_gadget_summary_config
integer x = 1138
integer y = 536
integer width = 201
integer height = 64
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Line"
end type

type rb_column from radiobutton within w_dashboard_gadget_summary_config
integer x = 699
integer y = 536
integer width = 293
integer height = 64
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Column"
end type

type rb_bar from radiobutton within w_dashboard_gadget_summary_config
integer x = 279
integer y = 536
integer width = 233
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Bar"
end type

type p_1 from picture within w_dashboard_gadget_summary_config
integer x = 101
integer y = 276
integer width = 1445
integer height = 716
string picturename = "graph_type.JPG"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
boolean map3dcolors = true
end type

event constructor;This.picturename = 'graph_type.JPG'
end event

type rb_graph from radiobutton within w_dashboard_gadget_summary_config
integer x = 1312
integer y = 84
integer width = 256
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Graph"
end type

event clicked;rb_bar.enabled = True
rb_column.enabled = True
rb_line.enabled = True
rb_pie.enabled = True
rb_bar3d.enabled = True
rb_column3d.enabled = True
end event

type rb_grid from radiobutton within w_dashboard_gadget_summary_config
integer x = 1047
integer y = 84
integer width = 270
integer height = 64
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Grid"
boolean checked = true
end type

event clicked;rb_bar.enabled = False
rb_column.enabled = False
rb_line.enabled = False
rb_pie.enabled = False
rb_bar3d.enabled = False
rb_column3d.enabled = False
end event

type cb_cancel from commandbutton within w_dashboard_gadget_summary_config
integer x = 1225
integer y = 1396
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;ClosewithReturn(Parent,'CANCEL')
end event

type cb_ok from commandbutton within w_dashboard_gadget_summary_config
integer x = 846
integer y = 1396
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;Integer li_isgraph,li_graph_type
Decimal ldec_height_ier
Long ll_row
Long ll_report_id
String ls_user_filter
Long ll_tdl_id
n_ds nds_reports

Choose Case Upper(ddlb_height.Text) 
	Case Upper('Single')
		ldec_height_ier = 1
	Case Upper('1.2 Height')
		ldec_height_ier = 1.2		
	Case Upper('1.5 Height')
		ldec_height_ier = 1.5
	Case Upper('1.8 Height')
		ldec_height_ier = 1.8		
	Case Upper('Double')
		ldec_height_ier = 2
	Case	Else
		ldec_height_ier = 1			
End Choose

ls_user_filter = dw_filter.GetItemString(1,'user_id')
ll_tdl_id = dw_filter.GetItemNumber(1,'tdl_id')

//Save Height IER
If ldec_height_ier <> iuo_current_gadget.istr_current_gadget.adec_height_ier Then
	iuo_current_gadget.istr_current_gadget.adec_height_ier = ldec_height_ier
	If iuo_current_gadget.of_update_to_db() > 0 Then
		If iuo_current_gadget.istr_current_gadget.gadget_maximize = 1 Then
			iuo_current_gadget.Event ue_max()		
			iuo_current_gadget.iuo_tabpge_gadget.of_refresh_ui()
		End If
	End If
End If

//Save Report 
ll_report_id = dw_report_selection.GetItemnumber(1,'report_id')
If isnull(ll_report_id) Then ll_report_id = 0
If rb_graph.checked Then
	li_isgraph = 1
Else
	li_isgraph = 0
End If

If rb_bar.checked = True Then li_graph_type = 2
If rb_column.checked = True Then li_graph_type = 7
If rb_line.checked = True Then li_graph_type = 12
If rb_pie.checked = True Then li_graph_type = 13
If rb_bar3d.checked = True Then li_graph_type = 6
If rb_column3d.checked = True Then li_graph_type = 11

If ll_report_id = 0 Then
	ClosewithReturn(Parent,'CANCEL')
	Return 1	
End If

//If no changes
If ll_report_id = iuo_current_gadget.ii_report_id and &
		li_isgraph = iuo_current_gadget.ii_isgraph and &
		li_graph_type = iuo_current_gadget.ii_graph_type and &
		ls_user_filter = iuo_current_gadget.is_tdl_user and &
		ll_tdl_id = iuo_current_gadget.il_tdl_id	Then
	ClosewithReturn(Parent,'CANCEL')
	Return 1
Else
	iuo_current_gadget.is_tdl_user = ls_user_filter
	iuo_current_gadget.il_tdl_id = ll_tdl_id
End If

nds_reports = w_dashboard.inv_dashboard.ids_dashboard_reports

ll_row = nds_reports.Find('user_id = "'+gs_user_id +'" And tab_id = '+String(iuo_current_gadget.iuo_tabpge_gadget.istr_current_tab.sl_tab_id) + ' And summary_id = '+ String(iuo_current_gadget.ii_summary_id) ,1,nds_reports.RowCount()) 
If ll_row > 0 Then
	nds_reports.SetItem(ll_row,'report_id',ll_report_id)
	nds_reports.SetItem(ll_row,'is_graph',li_isgraph)
	nds_reports.SetItem(ll_row,'graph_type',li_graph_type)
	nds_reports.SetItem(ll_row,'tdl_user',ls_user_filter)
	nds_reports.SetItem(ll_row,'tdl_id',ll_tdl_id)
	
Else
	ll_row = nds_reports.InsertRow(0)
	nds_reports.SetItem(ll_row,'user_id',gs_user_id)
	nds_reports.SetItem(ll_row,'tab_id',iuo_current_gadget.iuo_tabpge_gadget.istr_current_tab.sl_tab_id)
	nds_reports.SetItem(ll_row,'summary_id',iuo_current_gadget.ii_summary_id )
	nds_reports.SetItem(ll_row,'report_id',ll_report_id)
	nds_reports.SetItem(ll_row,'is_graph',li_isgraph)
	nds_reports.SetItem(ll_row,'graph_type',li_graph_type)	
	nds_reports.SetItem(ll_row,'tdl_user',ls_user_filter)
	nds_reports.SetItem(ll_row,'tdl_id',ll_tdl_id)	
End If

gnv_appeondb.of_autocommitrollback( )
If nds_reports.update() = 1 Then
	Commit;
Else
	Rollback;
	Messagebox('Save Error','Failed to save the changes, please call support.')
End If
nds_reports.Retrieve(gs_user_id) //Refresh report_name data


ClosewithReturn(Parent,'OK')
end event

type gb_1 from groupbox within w_dashboard_gadget_summary_config
integer x = 55
integer y = 212
integer width = 1541
integer height = 816
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Graph Type"
end type

type gb_2 from groupbox within w_dashboard_gadget_summary_config
integer x = 1001
integer y = 12
integer width = 581
integer height = 184
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Summary Style"
end type

type gb_3 from groupbox within w_dashboard_gadget_summary_config
integer x = 50
integer y = 12
integer width = 896
integer height = 184
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Report Selection"
end type

type gb_filter from groupbox within w_dashboard_gadget_summary_config
integer x = 55
integer y = 1044
integer width = 1541
integer height = 284
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Filter"
end type

