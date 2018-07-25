$PBExportHeader$pfc_cst_u_multi_app_painter_new.sru
forward
global type pfc_cst_u_multi_app_painter_new from userobject
end type
type cb_delete from u_cb within pfc_cst_u_multi_app_painter_new
end type
type cb_add from u_cb within pfc_cst_u_multi_app_painter_new
end type
type cb_close from u_cb within pfc_cst_u_multi_app_painter_new
end type
type cb_save from u_cb within pfc_cst_u_multi_app_painter_new
end type
type dw_app_data from u_dw within pfc_cst_u_multi_app_painter_new
end type
type cb_new from u_cb within pfc_cst_u_multi_app_painter_new
end type
type cb_3 from u_cb within pfc_cst_u_multi_app_painter_new
end type
type dw_select from u_dw within pfc_cst_u_multi_app_painter_new
end type
type gb_1 from groupbox within pfc_cst_u_multi_app_painter_new
end type
end forward

global type pfc_cst_u_multi_app_painter_new from userobject
integer width = 2743
integer height = 2004
boolean border = true
long backcolor = 32891346
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_delete cb_delete
cb_add cb_add
cb_close cb_close
cb_save cb_save
dw_app_data dw_app_data
cb_new cb_new
cb_3 cb_3
dw_select dw_select
gb_1 gb_1
end type
global pfc_cst_u_multi_app_painter_new pfc_cst_u_multi_app_painter_new

type variables
w_multi_app_painter_new iw_win

Integer ii_multi_app_id
end variables

forward prototypes
public function integer of_retrieve_detail (integer multi_app_id)
public function integer of_save ()
public function integer of_close ()
public function integer of_enable_disable_objects (integer ai_enable)
end prototypes

public function integer of_retrieve_detail (integer multi_app_id);Return 0
end function

public function integer of_save ();Integer i
Integer li_rc

li_rc = dw_app_data.RowCount( )

FOR i = 1 TO li_rc
	IF IsNull( dw_app_data.GetItemNumber( i, "parent_facility_id" ) ) OR +&
	   IsNull( dw_app_data.GetItemNumber( i, "app_id" ) ) THEN
	   MessageBox( "Missing Data", "All fields must be filled out.  Please complete." )
	   dw_app_data.SetRow( i )
	   dw_app_data.SetFocus()
	   Return -1
	END IF
END FOR

iw_win.Event pfc_save()


Return 0
end function

public function integer of_close ();Close( Parent )

Return 0
end function

public function integer of_enable_disable_objects (integer ai_enable);IF ai_enable = 1 THEN
	cb_add.Enabled = True
	cb_delete.Enabled = True
	cb_save.Enabled = True
ELSE
	cb_add.Enabled = False
	cb_delete.Enabled = False
	cb_save.Enabled = False
END IF

RETURN 0
end function

on pfc_cst_u_multi_app_painter_new.create
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_app_data=create dw_app_data
this.cb_new=create cb_new
this.cb_3=create cb_3
this.dw_select=create dw_select
this.gb_1=create gb_1
this.Control[]={this.cb_delete,&
this.cb_add,&
this.cb_close,&
this.cb_save,&
this.dw_app_data,&
this.cb_new,&
this.cb_3,&
this.dw_select,&
this.gb_1}
end on

on pfc_cst_u_multi_app_painter_new.destroy
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_app_data)
destroy(this.cb_new)
destroy(this.cb_3)
destroy(this.dw_select)
destroy(this.gb_1)
end on

event constructor;CHOOSE CASE gi_intelliapp_type
		//SINGLE GROUP
	CASE 0
		dw_app_data.Modify( "parent_facility_t.text = 'Payor/Hospital'" )		
		//MULTI SITE GROUP
	CASE 1
	dw_app_data.Modify( "parent_facility_t.text = 'Group'" )		
		//BILLING COMPANY
	CASE 2
	dw_app_data.Modify( "parent_facility_t.text = 'Client'" )		
END CHOOSE



end event

type cb_delete from u_cb within pfc_cst_u_multi_app_painter_new
integer x = 1984
integer y = 68
integer height = 84
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Delete"
end type

event clicked;call super::clicked;Integer li_ans

li_ans = MessageBox("Delete Row", "Are you sure you want to delete the selected row", Question!, YesNo!, 1 )

IF li_ans = 2 THEN
	Return
END IF

dw_app_data.DeleteRow( 0 )


end event

type cb_add from u_cb within pfc_cst_u_multi_app_painter_new
integer x = 1600
integer y = 68
integer width = 370
integer height = 84
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Add"
end type

event clicked;call super::clicked;Integer li_nr

li_nr = dw_app_data.InsertRow( 0 )
dw_app_data.SetRow( li_nr )
dw_app_data.ScrollToRow( li_nr )
dw_app_data.SetFocus()

dw_app_data.SetItem( li_nr, "multi_app_id", ii_multi_app_id )

dw_app_data.SetColumn( "parent_facility_id" )

end event

type cb_close from u_cb within pfc_cst_u_multi_app_painter_new
integer x = 2350
integer y = 68
integer height = 84
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;call super::clicked;of_close()
end event

type cb_save from u_cb within pfc_cst_u_multi_app_painter_new
integer x = 1239
integer y = 68
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Save"
end type

event clicked;call super::clicked;of_save()
end event

type dw_app_data from u_dw within pfc_cst_u_multi_app_painter_new
integer x = 46
integer y = 300
integer width = 2647
integer height = 1568
integer taborder = 30
string dataobject = "d_multi_app_list_new_for_painter"
end type

event constructor;call super::constructor;DataWindowChild dwchild

This.SetTransObject( SQLCA )
//Start Code Change ---- 03.028.2006 #366 maha
This.GetChild( "parent_facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
//End Code Change---03.28.2006


end event

event pfc_preupdate;call super::pfc_preupdate;//duplicate trap added 090204 maha

integer i
integer r
long ll_facid
long ll_appid
integer rc

rc = this.rowcount()
For i = 1 to rc -1
	ll_facid = this.getitemnumber(i,"parent_facility_id")
	ll_appid = this.getitemnumber(i,"app_id")
	for r = i + 1 to rc
		if ll_facid = this.getitemnumber(r,"parent_facility_id") and ll_appid = this.getitemnumber(r,"app_id") then
			messagebox("Duplicate Application","There is a duplcate Application selected for the Facility/Group for the record " + string(r) + ".~rYou must correct before saving. ")
			return -1
		end if
	next
next


return 1
end event

type cb_new from u_cb within pfc_cst_u_multi_app_painter_new
integer x = 87
integer y = 160
integer width = 430
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Create Template"
end type

event clicked;DatawindowChild dwchild
Integer li_multi_app_id
Integer li_nr
String ls_multi_app_name

IF of_save() = -1 THEN
	Return -1
END IF

Open( w_get_multi_app_name )
IF Message.StringParm = "Cancel" THEN
	Return
END IF

ls_multi_app_name = Message.StringParm

SELECT Max( sys_multi_app_hdr.multi_app_id )  
INTO :li_multi_app_id  
FROM sys_multi_app_hdr  ;

IF IsNull( li_multi_app_id ) THEN
	li_multi_app_id = 0
END IF

ii_multi_app_id = li_multi_app_id + 1

dw_select.GetChild( "multi_app_id", dwchild )
dwchild.SetTransObject( SQLCA )
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "multi_app_id", ii_multi_app_id )
dwchild.SetItem( li_nr, "multi_app_description", ls_multi_app_name )
dwchild.Update( )

dw_select.SetItem( 1, "multi_app_id", ii_multi_app_id )
dw_app_data.reset()

of_enable_disable_objects( 1 )


end event

type cb_3 from u_cb within pfc_cst_u_multi_app_painter_new
integer x = 535
integer y = 160
integer width = 453
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Delete Template"
end type

event clicked;Integer li_ans
Integer li_Rc
Integer i
Integer li_multi_app_id
DataWindowChild dwchild

li_rc = dw_app_data.RowCount()

//IF li_rc = 0 THEN
if isNull(dw_select.getItemNumber(1,'multi_app_id')) then //added by long.zhang 03.14.2014 added
	Beep(2)
	Return -1
END IF

li_ans = MessageBox("Delete View", "Are you sure you want to delete the selected multi app", StopSign!, YesNo!, 2 )
IF li_ans = 2 THEN
	Return 
END IF

//li_multi_app_id = dw_app_data.GetItemNumber( 1, "multi_app_id" )
li_multi_app_id = dw_select.GetItemNumber( 1, "multi_app_id" )//long.zhang 03.14.2014
if dw_app_data.RowCount() > 0 then//added if statement by long.zhang 03.14.2014

	FOR i = 1 TO li_rc
		dw_app_data.DeleteRow( 0 )
	END FOR
	
	dw_app_data.Update()

end if

DELETE FROM sys_multi_app_hdr  
WHERE sys_multi_app_hdr.multi_app_id = :li_multi_app_id   ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
	Return -1
END IF


dw_select.GetChild( "multi_app_id" , dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( )

dw_select.Reset()
dw_select.SetTransObject( SQLCA )
dw_select.InsertRow( 0 )








end event

type dw_select from u_dw within pfc_cst_u_multi_app_painter_new
integer x = 73
integer y = 68
integer width = 1038
integer height = 80
integer taborder = 10
string dataobject = "d_select_multi_app"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
This.InsertRow( 0 )
//This.SetItem( 1, "multi_app_id", 1 )
//This.SetRow( 1 )
//This.ScrollToRow( 1 )

//dw_selected.Event pfc_Retrieve()



end event

event itemchanged;call super::itemchanged;dw_app_data.Retrieve( Integer( data ),gs_user_id )
of_enable_disable_objects( 1 )
ii_multi_app_id = Integer( data )
end event

type gb_1 from groupbox within pfc_cst_u_multi_app_painter_new
integer x = 41
integer y = 12
integer width = 1138
integer height = 268
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 32891346
string text = "Select Multi App Template"
end type

