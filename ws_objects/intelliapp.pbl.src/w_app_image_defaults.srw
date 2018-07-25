$PBExportHeader$w_app_image_defaults.srw
forward
global type w_app_image_defaults from window
end type
type st_name from statictext within w_app_image_defaults
end type
type cb_1 from commandbutton within w_app_image_defaults
end type
type cb_save from commandbutton within w_app_image_defaults
end type
type dw_image_list from u_dw within w_app_image_defaults
end type
type dw_image_defaults from u_dw within w_app_image_defaults
end type
end forward

global type w_app_image_defaults from window
integer width = 1253
integer height = 2056
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_name st_name
cb_1 cb_1
cb_save cb_save
dw_image_list dw_image_list
dw_image_defaults dw_image_defaults
end type
global w_app_image_defaults w_app_image_defaults

type variables
long ii_app_id
end variables

on w_app_image_defaults.create
this.st_name=create st_name
this.cb_1=create cb_1
this.cb_save=create cb_save
this.dw_image_list=create dw_image_list
this.dw_image_defaults=create dw_image_defaults
this.Control[]={this.st_name,&
this.cb_1,&
this.cb_save,&
this.dw_image_list,&
this.dw_image_defaults}
end on

on w_app_image_defaults.destroy
destroy(this.st_name)
destroy(this.cb_1)
destroy(this.cb_save)
destroy(this.dw_image_list)
destroy(this.dw_image_defaults)
end on

event open;string ls_name
integer i
integer ic
long ll_Cnt
long ll_Cnt2
long ll_Row
long ll_image_type
long ll_find
long ll_id[]
debugbreak()
ii_app_id = message.doubleparm
ll_id[1] = ii_app_id
ic = dw_image_defaults.retrieve(ll_id)
dw_image_list.Retrieve()

	
ll_Cnt = dw_image_defaults.RowCount()
ll_Cnt2= dw_image_list.RowCount()
For ll_Row = 1 to ll_Cnt
	ll_image_type = dw_image_defaults.GetItemNumber(ll_Row,"image_type")
	ll_Find = dw_image_list.Find("image_type_id=" + String(ll_image_type),1,ll_Cnt2)
	if ll_Find > 0 then 
		dw_image_list.SetItem(ll_Find,"selected",1)
	end if
Next



select application_name into :ls_name from app_hdr where app_id = :ii_app_id;

st_name.text = ls_name


end event

type st_name from statictext within w_app_image_defaults
integer x = 32
integer y = 132
integer width = 1166
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Application Name"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_app_image_defaults
integer x = 846
integer y = 20
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_app_image_defaults
integer x = 485
integer y = 20
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;Long ll_Cnt,ll_Cnt2,ll_Row,ll_Find
Long ll_image_type,ll_selected
dec{0} ldec_app_image_id
Long ll_New,ll_app_id
dwItemStatus ldws_status

	IF dw_image_list.AcceptText() = -1 THEN
		Return -1
	END IF
	

	if dw_image_list.Modifiedcount( ) > 0 then
		//Get max(app_image_id)+1
		SELECT max(app_image_id) INTO :ldec_app_image_id from app_image_defaults;
		if IsNull(ldec_app_image_id) or ldec_app_image_id = 0 then 
			ldec_app_image_id = 1
		else
			ldec_app_image_id ++
		end if
		//Get app_id
//		ll_Row    = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetRow( )
//		if ll_Row > 0 then
//			ll_app_id = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetItemNumber(ll_Row,"app_id")
//		end if 
		ll_app_id = ii_app_id
		//Make changes to dw_image_defaults
		ll_Cnt = dw_image_defaults.RowCount()
		ll_Cnt2= dw_image_list.RowCount()
		FOR ll_Row = 1 to ll_Cnt2
			ldws_status = dw_image_list.GetItemStatus( ll_Row, 0, Primary! )
			If ldws_status = NotModified! or ldws_status = New! Then	Continue
			
			ll_selected  = dw_image_list.GetItemNumber(ll_Row,"selected")
			ll_image_type = dw_image_list.GetItemNumber(ll_Row,"image_type_id")
			ll_Find = dw_image_defaults.Find("image_type=" + String(ll_image_type),1,ll_Cnt)
			if ll_Find > 0 then
				if ll_selected = 0 then dw_image_defaults.deleterow(ll_Find)
			else
				if ll_selected = 1 then
					ll_New = dw_image_defaults.insertRow(0)
					dw_image_defaults.SetItem(ll_New,"app_image_id",ldec_app_image_id)
					dw_image_defaults.SetItem(ll_New,"app_id",ll_app_id)
					dw_image_defaults.SetItem(ll_New,"image_type",ll_image_type)
					ldec_app_image_id ++
				end if
			end if
		Next
		dw_image_defaults.update()
	end if
	
	Close(parent)
end event

type dw_image_list from u_dw within w_app_image_defaults
integer y = 216
integer width = 1239
integer height = 1828
integer taborder = 20
boolean titlebar = true
string title = "Select Image Type"
string dataobject = "d_image_image_type_list_set_defaults"
boolean resizable = true
boolean livescroll = false
end type

event constructor;call super::constructor;//$<add> 07.10.2008 by Andy
this.of_setupdateable( false )
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

type dw_image_defaults from u_dw within w_app_image_defaults
integer x = 1307
integer y = 140
integer width = 1298
integer height = 420
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_app_image_defaults"
boolean livescroll = false
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

