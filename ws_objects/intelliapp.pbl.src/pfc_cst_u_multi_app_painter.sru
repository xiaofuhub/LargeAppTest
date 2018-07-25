$PBExportHeader$pfc_cst_u_multi_app_painter.sru
forward
global type pfc_cst_u_multi_app_painter from userobject
end type
type cb_2 from u_cb within pfc_cst_u_multi_app_painter
end type
type cb_1 from u_cb within pfc_cst_u_multi_app_painter
end type
type cb_delete from u_cb within pfc_cst_u_multi_app_painter
end type
type cb_add from u_cb within pfc_cst_u_multi_app_painter
end type
type cb_close from u_cb within pfc_cst_u_multi_app_painter
end type
type cb_save from u_cb within pfc_cst_u_multi_app_painter
end type
type dw_app_data from u_dw within pfc_cst_u_multi_app_painter
end type
type cb_new from u_cb within pfc_cst_u_multi_app_painter
end type
type cb_3 from u_cb within pfc_cst_u_multi_app_painter
end type
type dw_select from u_dw within pfc_cst_u_multi_app_painter
end type
end forward

global type pfc_cst_u_multi_app_painter from userobject
integer width = 3474
integer height = 2392
boolean border = true
long backcolor = 33551856
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_2 cb_2
cb_1 cb_1
cb_delete cb_delete
cb_add cb_add
cb_close cb_close
cb_save cb_save
dw_app_data dw_app_data
cb_new cb_new
cb_3 cb_3
dw_select dw_select
end type
global pfc_cst_u_multi_app_painter pfc_cst_u_multi_app_painter

type variables
w_multi_app_painter iw_win

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

//---------Begin Added by (Appeon)Stephen 06.10.2015 for MultiApp Setup problem Case#55180--------
if gs_cust_type = "I" then
	FOR i = 1 TO li_rc
		IF IsNull( dw_app_data.GetItemNumber( i, "parent_facility_id" ) ) OR IsNull( dw_app_data.GetItemNumber( i, "app_id" ) ) THEN
			MessageBox( "Missing Data", "All fields must be filled out.  Please complete." )
			dw_app_data.SetRow( i )
			dw_app_data.SetFocus()
			Return -1
		end if
	next
else
//---------End Added ------------------------------------------------------
	FOR i = 1 TO li_rc
		IF IsNull( dw_app_data.GetItemNumber( i, "parent_facility_id" ) ) OR +&
			  IsNull( dw_app_data.GetItemNumber( i, "application_audit_facility" ) ) OR +&
			IsNull( dw_app_data.GetItemNumber( i, "verifying_facility" ) ) OR +&
			IsNull( dw_app_data.GetItemString( i, "apptmnt_type" ) ) OR +&
			IsNull( dw_app_data.GetItemNumber( i, "app_id" ) ) THEN
			MessageBox( "Missing Data", "All fields must be filled out.  Please complete." )
			dw_app_data.SetRow( i )
			dw_app_data.SetFocus()
			Return -1
		END IF
	END FOR
end if

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

on pfc_cst_u_multi_app_painter.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_app_data=create dw_app_data
this.cb_new=create cb_new
this.cb_3=create cb_3
this.dw_select=create dw_select
this.Control[]={this.cb_2,&
this.cb_1,&
this.cb_delete,&
this.cb_add,&
this.cb_close,&
this.cb_save,&
this.dw_app_data,&
this.cb_new,&
this.cb_3,&
this.dw_select}
end on

on pfc_cst_u_multi_app_painter.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_app_data)
destroy(this.cb_new)
destroy(this.cb_3)
destroy(this.dw_select)
end on

type cb_2 from u_cb within pfc_cst_u_multi_app_painter
integer x = 2322
integer y = 36
integer height = 84
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Copy"
end type

event clicked;call super::clicked;//Start Code Change ----05.05.2014 #V14.2 maha
Integer li_nr

li_nr = dw_app_data.getrow()

dw_app_data.rowscopy( li_nr,li_nr,primary!, dw_app_data,li_nr+1, primary!)
dw_app_data.SetRow( li_nr + 1 )
dw_app_data.ScrollToRow( li_nr + 1)
dw_app_data.SetFocus()

 

end event

type cb_1 from u_cb within pfc_cst_u_multi_app_painter
integer x = 41
integer y = 36
integer width = 430
integer taborder = 10
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
debugbreak()
ls_multi_app_name = Message.StringParm

SELECT Max( sys_multi_app_hdr.multi_app_id )  
INTO :li_multi_app_id  
FROM sys_multi_app_hdr  ;

IF IsNull( li_multi_app_id ) THEN
	li_multi_app_id = 0
END IF

//Start Code Change ----07.09.2014 #V14.2 maha - modified code to use the local variable rather than the instance
li_multi_app_id++

//ii_multi_app_id = li_multi_app_id //Commented by (Appeon)Harry 10.22.2014 - for BugH101001

li_nr = dw_select.InsertRow( 0 )
dw_select.SetItem( li_nr, "multi_app_id", li_multi_app_id )
dw_select.SetItem( li_nr, "multi_app_description", ls_multi_app_name )
dw_select.Update( )

ii_multi_app_id = li_multi_app_id //(Appeon)Harry 10.22.2014 - for BugH101001

dw_select.setrow(li_nr)
dw_select.selectrow(0,false)
dw_select.selectrow(li_nr,true)
dw_select.scrolltorow(li_nr)






end event

type cb_delete from u_cb within pfc_cst_u_multi_app_painter
integer x = 2679
integer y = 36
integer height = 84
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;call super::clicked;Integer li_ans

li_ans = MessageBox("Delete Row", "Are you sure you want to delete the selected row?", Question!, YesNo!, 1 )

IF li_ans = 2 THEN
	Return
END IF

dw_app_data.DeleteRow( 0 )
dw_app_data.update()  //Start Code Change ----10.23.2014 #V14.2 maha


end event

type cb_add from u_cb within pfc_cst_u_multi_app_painter
integer x = 1966
integer y = 36
integer height = 84
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;call super::clicked;Integer li_nr
if dw_select.getrow( ) < 1 then return //(Appeon)Harry 10.22.2014

li_nr = dw_app_data.InsertRow( 0 )
dw_app_data.SetRow( li_nr )
dw_app_data.ScrollToRow( li_nr )
dw_app_data.SetFocus()

dw_app_data.SetItem( li_nr, "multi_app_id", ii_multi_app_id )
dw_app_data.SetItem( li_nr, "apptmnt_type", "I" )

dw_app_data.SetColumn( "parent_facility_id" )

end event

type cb_close from u_cb within pfc_cst_u_multi_app_painter
integer x = 3077
integer y = 36
integer height = 84
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;call super::clicked;of_close()
end event

type cb_save from u_cb within pfc_cst_u_multi_app_painter
integer x = 1600
integer y = 36
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;call super::clicked;of_save()
end event

type dw_app_data from u_dw within pfc_cst_u_multi_app_painter
integer y = 740
integer width = 3461
integer height = 1636
integer taborder = 30
string dataobject = "d_multi_app_list"
end type

event constructor;call super::constructor;if gs_cust_type = "I" then this.dataobject = "d_multi_app_list_app"
This.SetTransObject( SQLCA )

//Start Code Change ----01.06.2015 #V14.2 maha - hide location
choose case gi_intelliapp_type
	case 3, 0 
		this.modify("gp_id.visible=false")
		this.modify("t_gp_id.visible=false")
end choose
//End Code Change ----01.06.2015 
end event

event pfc_preupdate;call super::pfc_preupdate;//duplicate trap added 090204 maha

integer i
integer r
long ll_facid
long ll_appid
long ll_gpid  //maha 05.21.2014
integer rc

rc = this.rowcount()
For i = 1 to rc -1
	ll_facid = this.getitemnumber(i,"parent_facility_id")
	ll_appid = this.getitemnumber(i,"app_id")
	//Start Code Change ----05.21.2014 #V14.2 maha - changes for location
	ll_gpid = this.getitemnumber(i,"gp_id")  
	if isnull(ll_gpid) then ll_gpid = 0
	for r = i + 1 to rc
		//if ll_facid = this.getitemnumber(r,"parent_facility_id") and ll_appid = this.getitemnumber(r,"app_id") then
		if ll_facid = this.getitemnumber(r,"parent_facility_id") and ll_appid = this.getitemnumber(r,"app_id") and ll_gpid = this.getitemnumber(r,"gp_id")  then	
			messagebox("Duplicate Combination","Record " + string(r) + " is a duplicate Facility/Location/Application combination to record " + string(1) + ".~rPlease correct before saving. ")
			return -1
		end if
	//End Code Change ----05.21.2014	
	next
next


return 1
	
end event

event pfc_postupdate;call super::pfc_postupdate;//(Appeon)Harry 10.29.2014 - for BugH092301
this.Retrieve( ii_multi_app_id  )   
return 1
end event

type cb_new from u_cb within pfc_cst_u_multi_app_painter
integer x = 480
integer y = 36
integer width = 439
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Co&py Template"
end type

event clicked;//Start Code Change ----05.05.2014 #V14.2 maha
DatawindowChild dwchild
long li_multi_app_id
long li_nr
long rc
long r
long nc
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

li_nr = dw_select.InsertRow( 0 )
dw_select.SetItem( li_nr, "multi_app_id", ii_multi_app_id )
dw_select.SetItem( li_nr, "multi_app_description", ls_multi_app_name )


rc = dw_app_data.rowcount()
debugbreak()
if rc > 0 then
	dw_app_data.rowscopy( 1,rc ,primary!,dw_app_data,1000, primary!)

	nc = dw_app_data.rowcount()
	
	for r = rc + 1 to nc
		dw_app_data.SetItem( r, "multi_app_id", ii_multi_app_id )
	next
end if
// return
dw_select.update()
rc = dw_app_data.update()
if rc < 0 then messagebox("Copy","Item Creation failed")

dw_select.setrow(li_nr)
dw_select.selectrow(0,false)
dw_select.selectrow(li_nr,true)
dw_select.scrolltorow(li_nr)

dw_select.sort() //Start Code Change ----10.02.2014 #V14.2 maha


end event

type cb_3 from u_cb within pfc_cst_u_multi_app_painter
integer x = 923
integer y = 36
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
integer r, r2
DataWindowChild dwchild

//---------Begin Modified by (Appeon)Stephen 06.10.2015 MultiApp Setup problem Case#55180--------
//li_rc = dw_app_data.RowCount()
li_rc = dw_select.RowCount()
//---------End Modfiied ------------------------------------------------------

r = dw_select.getrow()
//Start Code Change ----05.05.2014 #V14.2 maha - Modified for new dw format
IF li_rc = 0 THEN return -1
	//Start Code Change ----07.09.2014 #V14.2 maha - removed
//if isNull(dw_select.getItemNumber(dw_select.getrow(),'multi_app_id')) then //added by long.zhang 03.14.2014 added
//	//Beep(2)
//	Return -1
//END IF

li_ans = MessageBox("Delete Template", "Are you sure you want to delete the selected multi app?", Question!, YesNo!, 2 )
IF li_ans = 2 THEN
	Return 
END IF

//li_multi_app_id = dw_app_data.GetItemNumber( 1, "multi_app_id" )
li_multi_app_id = dw_select.GetItemNumber( dw_select.getrow(), "multi_app_id" )//long.zhang 03.14.2014
if dw_app_data.RowCount() > 0 then //added if statement by long.zhang 03.14.2014

	FOR i = 1 TO li_rc
		dw_app_data.DeleteRow( 0 )
	END FOR

	dw_app_data.Update()
end if

dw_select.deleterow(0)
dw_select.update()

//Start Code Change ---10.02.2014 #V14.2 maha
r2 = dw_select.getrow()

if r2 = r then
	ii_multi_app_id = dw_select.getitemnumber(r2,"multi_app_id")
	dw_app_data.Retrieve( ii_multi_app_id  )
	
	dw_select.selectrow(0,false)
	dw_select.selectrow(r2,true)
end if
//Start Code Change ---10.02.2014
//DELETE FROM sys_multi_app_hdr  
//WHERE sys_multi_app_hdr.multi_app_id = :li_multi_app_id   ;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox( "Error", SQLCA.SQLERRTEXT )
//	Return -1
//END IF




//dw_select.Reset()
//dw_select.SetTransObject( SQLCA )
//dw_select.InsertRow( 0 )








end event

type dw_select from u_dw within pfc_cst_u_multi_app_painter
integer x = 5
integer y = 156
integer width = 3461
integer height = 576
integer taborder = 10
string dataobject = "d_multi_app_templates"
end type

event constructor;This.of_SetTransObject( SQLCA )
//This.of_SetUpdateAble( False )
this.retrieve()


	
//This.InsertRow( 0 )
//This.SetItem( 1, "multi_app_id", 1 )
//This.SetRow( 1 )
//This.ScrollToRow( 1 )

//dw_selected.Event pfc_Retrieve()



end event

event itemchanged;call super::itemchanged;//Start Code Change ----05.05.2014 #V14.2 maha
//dw_app_data.Retrieve( Integer( data ) )
//of_enable_disable_objects( 1 )
//ii_multi_app_id = Integer( data )
end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow <= 0 then return  //(Appeon)Harry 10.22.2014 - for BugH101001
ii_multi_app_id = this.getitemnumber(currentrow,"multi_app_id")
dw_app_data.Retrieve( ii_multi_app_id  )

this.selectrow(0,false)
this.selectrow(currentrow,true)
//of_enable_disable_objects( 1 )

end event

event buttonclicked;call super::buttonclicked;
//Start Code Change ----05.06.2014 #V14.2 maha - added
IF dwo.name = 'b_notes' THEN
	string s
	
	s =  This.GetItemString( row, "notes" )
	if isnull(s) then s = ""

	OpenWithParm( w_ai_notes_new, "M#" + s )

	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		s = Message.StringParm
		This.SetItem( row, "notes", s )	//long.zhang 10.19.2012 history record do not set notes BugL100905
	END IF
End if
end event

