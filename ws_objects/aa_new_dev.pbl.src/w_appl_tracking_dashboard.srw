$PBExportHeader$w_appl_tracking_dashboard.srw
forward
global type w_appl_tracking_dashboard from window
end type
type st_hit from statictext within w_appl_tracking_dashboard
end type
type cb_close from commandbutton within w_appl_tracking_dashboard
end type
type dw_graph from datawindow within w_appl_tracking_dashboard
end type
type ddlb_1 from dropdownlistbox within w_appl_tracking_dashboard
end type
end forward

global type w_appl_tracking_dashboard from window
integer width = 4585
integer height = 2776
boolean titlebar = true
string title = "Tracking Dashboard"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 32891346
string icon = "AppIcon!"
boolean center = true
st_hit st_hit
cb_close cb_close
dw_graph dw_graph
ddlb_1 ddlb_1
end type
global w_appl_tracking_dashboard w_appl_tracking_dashboard

type variables
string is_current_graph
integer ii_graph_index
end variables

forward prototypes
public function integer of_get_graph_type (grobjecttype mousehit)
end prototypes

public function integer of_get_graph_type (grobjecttype mousehit);string s


choose case mousehit
	case TypeGraph!	
		s = "TypeGraph"
	case TypeTitle!	
		s = "TypeTitle"
	case TypeLegend!	
		s = "TypeLegend"
	case TypeData!	
		s = "TypeData"
	case TypeCategory!		
		s = "TypeCategory"
	case TypeCategoryAxis!
		s = "TypeCatAxis"
	case TypeCategoryLabel!
		s = "TypeCatLabel"
	case TypeSeries!
		s = "TypeSeries"
	case TypeSeriesAxis!	
		s = "TypeSeriesAxis"
	case TypeSeriesLabel!	
		s = "TypeSeriesLabel"
	case TypeValueAxis!	
		s = "TypeValueAxis"
	case TypeValueLabel!
		s = "TypeValueLabel"
end choose

messagebox("Graph hit type",s)


return 1
end function

on w_appl_tracking_dashboard.create
this.st_hit=create st_hit
this.cb_close=create cb_close
this.dw_graph=create dw_graph
this.ddlb_1=create ddlb_1
this.Control[]={this.st_hit,&
this.cb_close,&
this.dw_graph,&
this.ddlb_1}
end on

on w_appl_tracking_dashboard.destroy
destroy(this.st_hit)
destroy(this.cb_close)
destroy(this.dw_graph)
destroy(this.ddlb_1)
end on

type st_hit from statictext within w_appl_tracking_dashboard
integer x = 78
integer y = 180
integer width = 4389
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
boolean border = true
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_appl_tracking_dashboard
integer x = 4142
integer y = 48
integer width = 343
integer height = 92
integer taborder = 20
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

type dw_graph from datawindow within w_appl_tracking_dashboard
integer x = 78
integer y = 276
integer width = 4393
integer height = 1264
integer taborder = 20
string title = "none"
string dataobject = "d_appl_tracking_db_graph_payor"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;//Start Code Change ----06.18.2014 #V14.2 maha-  created
integer SeriesNbr, ItemNbr, r
double ll_data_value
long ll_app
string ls_series_name, ls_category_name
grObjectType MouseHit
gs_pass_ids lst_data


//get the series (1) and the item number in the graph from the buttom
mousehit = this.ObjectAtPointer("gr_1",    SeriesNbr, ItemNbr)
//of_get_graph_type( mousehit )
//messagebox( "hit type", integer(mousehit))

//get the data value of that bar item
ll_data_value = This.GetData("gr_1", SeriesNbr, ItemNbr)

ls_series_name = UPPER(This.SeriesName("gr_1", SeriesNbr))
ls_category_name = UPPER(This.CategoryName("gr_1", ItemNbr))

choose case ii_graph_index
	case 1, 3
		select app_id into :ll_app from app_hdr where application_name = :ls_category_name;
		 lst_data.ls_ref_value = "Payor"
		 lst_data.committee_id = 1
		 lst_data.l_app_id = ll_app
		 lst_data.ls_web_title = ls_category_name
	case 2
		 lst_data.ls_ref_value = "User"
		 lst_data.committee_id = 2 
		  lst_data.s_stringval =  ls_category_name
end choose

openwithparm(w_appl_tracking_dash_drill, lst_data)
//messagebox(  ls_category_name, ll_app)

//this.GetDataValue( "gr_1" , SeriesNbr, 3, ll_data_value)
//messagebox( ls_series_name, ls_category_name)

//r = this.getclickedrow()
//messagebox("row",r)
//ll_app = this.getitemnumber(r,"pd_appl_tracking_app_id")

//messagebox(  ls_category_name,ll_app)
//messagebox( ls_series_name, ls_category_name)


end event

event clicked;integer SeriesNbr, ItemNbr, r
double ll_data_value
long ll_app
string ls_series_name, ls_category_name
string s
grObjectType MouseHit

//get the series (1) and the item number in the graph from the buttom
mousehit = this.ObjectAtPointer("gr_1",    SeriesNbr, ItemNbr)
//of_get_graph_type( mousehit )
//messagebox( "hit type", integer(mousehit))

//get the data value of that bar item
ll_data_value = This.GetData("gr_1", SeriesNbr, ItemNbr)

ls_series_name = UPPER(This.SeriesName("gr_1", SeriesNbr))
ls_category_name = UPPER(This.CategoryName("gr_1", ItemNbr))

choose case ii_graph_index
	case 1, 3
		s = "For Payor " + ls_category_name + " the average days is " + string(ll_data_value)
	case 2
		s = "For User " + ls_category_name + " the average days is " + string(ll_data_value)
end choose

st_hit.text = s


//messagebox(  ls_category_name, ll_app)





end event

type ddlb_1 from dropdownlistbox within w_appl_tracking_dashboard
integer x = 82
integer y = 56
integer width = 1541
integer height = 264
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Application Processing days by Payor","Application Processing days by User","Application Processing days by Payor2"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;

Choose Case index
	case 1
		is_current_graph = "d_appl_tracking_db_graph_payor"
		dw_graph.dataobject = is_current_graph
	case 2
		is_current_graph = "d_appl_tracking_db_graph_user"
		dw_graph.dataobject = is_current_graph
	case 3
		is_current_graph = "d_appl_tracking_db_graph_payor2"
		dw_graph.dataobject = is_current_graph		
end choose

ii_graph_index = index

dw_graph.settransobject(sqlca)
dw_graph.retrieve()
		
end event

