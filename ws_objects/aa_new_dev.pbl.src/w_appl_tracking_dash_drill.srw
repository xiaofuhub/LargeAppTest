$PBExportHeader$w_appl_tracking_dash_drill.srw
forward
global type w_appl_tracking_dash_drill from window
end type
type st_hit from statictext within w_appl_tracking_dash_drill
end type
type cb_close from commandbutton within w_appl_tracking_dash_drill
end type
type dw_data from datawindow within w_appl_tracking_dash_drill
end type
end forward

global type w_appl_tracking_dash_drill from window
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
dw_data dw_data
end type
global w_appl_tracking_dash_drill w_appl_tracking_dash_drill

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

on w_appl_tracking_dash_drill.create
this.st_hit=create st_hit
this.cb_close=create cb_close
this.dw_data=create dw_data
this.Control[]={this.st_hit,&
this.cb_close,&
this.dw_data}
end on

on w_appl_tracking_dash_drill.destroy
destroy(this.st_hit)
destroy(this.cb_close)
destroy(this.dw_data)
end on

event open;//Start Code Change ----06.19.2014 #V14.2 maha - created
string ls_from
string ls_user
string ls_name
integer li_index
long ll_app

gs_pass_ids lst_data

lst_data = message.powerobjectparm

ls_from = lst_data.ls_ref_value

li_index = lst_data.committee_id

choose case li_index
	case 1,3
		dw_data.dataobject = "d_appl_track_db_detail1"
		ls_name = lst_data.ls_web_title
		ll_app = lst_data.l_app_id
		dw_data.settransobject(sqlca)
		dw_data.retrieve(ll_app)
		st_hit.text = "Tracking Records for Application: " + ls_name
	case 2
		dw_data.dataobject = "d_appl_track_db_detail2"
		ls_user = lst_data.s_stringval
		dw_data.settransobject(sqlca)
		dw_data.retrieve(ls_user)
		st_hit.text = "Tracking Records for user: " + ls_user
end choose


end event

type st_hit from statictext within w_appl_tracking_dash_drill
integer x = 78
integer y = 144
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

type cb_close from commandbutton within w_appl_tracking_dash_drill
integer x = 4142
integer y = 32
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

type dw_data from datawindow within w_appl_tracking_dash_drill
integer x = 78
integer y = 236
integer width = 4393
integer height = 2348
integer taborder = 20
string title = "none"
string dataobject = "d_appl_track_db_detail1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;//integer SeriesNbr, ItemNbr, r
//double ll_data_value
//long ll_app
//
//string ls_series_name, ls_category_name
//grObjectType MouseHit
//
////get the series (1) and the item number in the graph from the buttom
//mousehit = this.ObjectAtPointer("gr_1",    SeriesNbr, ItemNbr)
////of_get_graph_type( mousehit )
////messagebox( "hit type", integer(mousehit))
//
////get the data value of that bar item
//ll_data_value = This.GetData("gr_1", SeriesNbr, ItemNbr)
//
//ls_series_name = UPPER(This.SeriesName("gr_1", SeriesNbr))
//ls_category_name = UPPER(This.CategoryName("gr_1", ItemNbr))
//
//choose case ii_graph_index
//	case 1
//		select app_id into :ll_app from app_hdr where application_name = :ls_category_name;
//	case 2
//		//
//end choose
//
//
//messagebox(  ls_category_name, ll_app)
//
//this.GetDataValue( "gr_1" , SeriesNbr, 3, ll_data_value)
////messagebox( ls_series_name, ls_category_name)
//
////r = this.getclickedrow()
////messagebox("row",r)
////ll_app = this.getitemnumber(r,"pd_appl_tracking_app_id")
//
////messagebox(  ls_category_name,ll_app)
////messagebox( ls_series_name, ls_category_name)
end event

