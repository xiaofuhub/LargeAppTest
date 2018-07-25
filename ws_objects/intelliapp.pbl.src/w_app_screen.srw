$PBExportHeader$w_app_screen.srw
forward
global type w_app_screen from w_master
end type
type dw_properties from u_dw within w_app_screen
end type
type dw_browse from u_dw within w_app_screen
end type
type cb_clear from commandbutton within w_app_screen
end type
type cb_close from commandbutton within w_app_screen
end type
type dw_filter from u_dw within w_app_screen
end type
type dw_detail from u_dw within w_app_screen
end type
end forward

global type w_app_screen from w_master
integer width = 2693
integer height = 1840
string title = "Application Screens"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 33551856
dw_properties dw_properties
dw_browse dw_browse
cb_clear cb_clear
cb_close cb_close
dw_filter dw_filter
dw_detail dw_detail
end type
global w_app_screen w_app_screen

type variables
pfc_cst_nv_data_entry_functions inv_data_entry
long il_data_view_id
long il_screen_id

string is_drag_field_name
boolean ib_dw_field_dclick
end variables

forward prototypes
public function integer of_retrievedddw ()
public function integer of_showinvisible (boolean ab_show)
public function integer of_setprotect (datawindow adw)
end prototypes

public function integer of_retrievedddw ();//////////////////////////////////////////////////////////////////////
// $<function> of_retrievedddw
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.01.2010
//////////////////////////////////////////////////////////////////////

datawindowchild ldwc_child

dw_filter.GetChild("app_filter_id", ldwc_child)
ldwc_child.SetTransObject(SQLCA)
ldwc_child.Retrieve(il_screen_id)
ldwc_child.InsertRow(1)
ldwc_child.SelectRow(0, false)

dw_filter.GetChild("screen_field", ldwc_child)
ldwc_child.SetTransObject(SQLCA)
ldwc_child.Retrieve(il_data_view_id, il_screen_id)
ldwc_child.InsertRow(1)

Return 1
end function

public function integer of_showinvisible (boolean ab_show);//////////////////////////////////////////////////////////////////////
// $<function> of_showinvisible
// $<arguments>
//			boolean	ab_show
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.01.2010
//////////////////////////////////////////////////////////////////////

Integer li_rc
Integer i
String ls_fld

dw_properties.SetFilter("")
dw_properties.Filter( )
li_rc = dw_properties.RowCount()

FOR i = 1 TO li_rc
	IF dw_properties.GetItemString( i, "data_view_fields_visible" ) = "Y" THEN
		CONTINUE
	END IF
	ls_fld = dw_properties.GetItemString( i, "sys_fields_field_name" )
	IF ab_show THEN
		dw_detail.Modify( ls_fld + ".Visible = 1")	
		dw_detail.Modify( ls_fld + "_t.Visible = 1")	
	ELSE
		dw_detail.Modify( ls_fld + ".Visible = 0")	
		dw_detail.Modify( ls_fld + "_t.Visible = 0")			
	END IF
END FOR

RETURN 1
end function

public function integer of_setprotect (datawindow adw);//////////////////////////////////////////////////////////////////////
// $<function> of_setprotect
// $<arguments>
//			datawindow	adw
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.01.2010
//////////////////////////////////////////////////////////////////////

long  li_col_cnt
String is_object_list[]
long i

li_col_cnt = Integer(adw.Describe("DataWindow.Column.Count"))
FOR i = 1 TO li_col_cnt
	is_object_list[i] = adw.GetColumnName()
	adw.Modify(is_object_list[i]+".Protect=1")
END FOR

Return 1
end function

on w_app_screen.create
int iCurrent
call super::create
this.dw_properties=create dw_properties
this.dw_browse=create dw_browse
this.cb_clear=create cb_clear
this.cb_close=create cb_close
this.dw_filter=create dw_filter
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_properties
this.Control[iCurrent+2]=this.dw_browse
this.Control[iCurrent+3]=this.cb_clear
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.dw_filter
this.Control[iCurrent+6]=this.dw_detail
end on

on w_app_screen.destroy
call super::destroy
destroy(this.dw_properties)
destroy(this.dw_browse)
destroy(this.cb_clear)
destroy(this.cb_close)
destroy(this.dw_filter)
destroy(this.dw_detail)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.01.2010
//////////////////////////////////////////////////////////////////////

string ls_msg[]
string ls_screen_name
n_cst_string lnv_string

// Retrieve data for all DDDWs
lnv_string.of_ParseToArray(Message.StringParm, ",", ls_msg)
il_data_view_id = Long(ls_msg[1])
il_screen_id = Long(ls_msg[2])
ls_screen_name = ls_msg[3]
of_RetrieveDddw()

// Dynamic create screen
inv_data_entry = Create pfc_cst_nv_data_entry_functions
inv_data_entry.of_setup_cache()
inv_data_entry.of_refresh_cache()
inv_data_entry.of_create_dynamic_dw(0, il_data_view_id, il_screen_id, dw_detail, dw_browse, true, 0, True)
Destroy inv_data_entry

dw_properties.Retrieve(il_data_view_id, il_screen_id)
of_ShowInvisible(false)
of_SetProtect(dw_detail)

// Do other actions
this.Move(0, 0)
this.Title = ls_screen_name
end event

event closequery;// Do not extend ancestor script
end event

type dw_properties from u_dw within w_app_screen
boolean visible = false
integer x = 663
integer y = 1784
integer width = 457
integer taborder = 60
string dataobject = "d_sys_field_properties"
end type

event constructor;call super::constructor;This.of_SetTransObject( SQLCA )
end event

type dw_browse from u_dw within w_app_screen
boolean visible = false
integer x = 64
integer y = 1276
integer width = 2528
integer height = 388
integer taborder = 50
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type cb_clear from commandbutton within w_app_screen
integer x = 2258
integer y = 80
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear &Query"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.01.2010
//////////////////////////////////////////////////////////////////////

dw_filter.Reset()
dw_filter.InsertRow(0)
end event

type cb_close from commandbutton within w_app_screen
integer x = 2258
integer y = 200
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
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.01.2010
//////////////////////////////////////////////////////////////////////

Close(Parent)
end event

type dw_filter from u_dw within w_app_screen
integer y = 4
integer width = 2226
integer height = 356
integer taborder = 10
string dataobject = "d_app_filters"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;long ll_Row
datawindowchild ldwc_child

choose case dwo.name
	case "app_filter_id"
		this.GetChild("app_filter_id", ldwc_child)
		ll_Row = ldwc_child.GetRow()
		this.SetItem(Row, "screen_field", ldwc_child.GetItemString(ll_Row, "screen_field"))
		this.SetItem(Row, "operator", ldwc_child.GetItemString(ll_Row, "operator"))
		this.SetItem(Row, "filter_value", ldwc_child.GetItemString(ll_Row, "filter_value"))
end choose
end event

type dw_detail from u_dw within w_app_screen
integer x = 9
integer y = 360
integer width = 2665
integer height = 1388
integer taborder = 40
string dragicon = "droparrow.ico"
boolean bringtotop = true
boolean hscrollbar = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.02.2010
//////////////////////////////////////////////////////////////////////

if dwo.type = "column" then
	is_drag_field_name = dwo.name
	this.Drag(Begin!)
else
	is_drag_field_name = ""
end if
end event

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////
// $<event> doubleclicked
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.02.2010
//////////////////////////////////////////////////////////////////////

if dwo.type = "column" then
	is_drag_field_name = dwo.name
	if IsValid(w_train_app) then
		//Parent.WindowState = Minimized! //Delete by Evan 02.09.2011
		w_train_app.tab_1.tabpage_design.SetRedraw(true)
		ib_dw_field_dclick = true
		w_train_app.of_AddFieldFromSP()
		ib_dw_field_dclick = false
	end if
else
	is_drag_field_name = ""
end if
end event

