$PBExportHeader$w_app_audit_setup_ia.srw
forward
global type w_app_audit_setup_ia from w_response
end type
type st_1 from statictext within w_app_audit_setup_ia
end type
type tab_audit from tab within w_app_audit_setup_ia
end type
type tabpage_initial from userobject within tab_audit
end type
type dw_initial from u_dw within tabpage_initial
end type
type tabpage_initial from userobject within tab_audit
dw_initial dw_initial
end type
type tabpage_reapp from userobject within tab_audit
end type
type dw_reapp from u_dw within tabpage_reapp
end type
type cb_copy from u_cb within tabpage_reapp
end type
type tabpage_reapp from userobject within tab_audit
dw_reapp dw_reapp
cb_copy cb_copy
end type
type tab_audit from tab within w_app_audit_setup_ia
tabpage_initial tabpage_initial
tabpage_reapp tabpage_reapp
end type
type cb_add from u_cb within w_app_audit_setup_ia
end type
type cb_delete from u_cb within w_app_audit_setup_ia
end type
type cb_print from u_cb within w_app_audit_setup_ia
end type
type cb_save from u_cb within w_app_audit_setup_ia
end type
type cb_close from u_cb within w_app_audit_setup_ia
end type
end forward

global type w_app_audit_setup_ia from w_response
string tag = "no longer used"
integer x = 535
integer y = 224
integer width = 2546
integer height = 1952
string title = "Application Audit Painter"
long backcolor = 32891346
st_1 st_1
tab_audit tab_audit
cb_add cb_add
cb_delete cb_delete
cb_print cb_print
cb_save cb_save
cb_close cb_close
end type
global w_app_audit_setup_ia w_app_audit_setup_ia

type variables
u_dw idw_current

Integer ii_facility_id = 1

end variables

forward prototypes
public function integer of_help (string as_object)
end prototypes

public function integer of_help (string as_object);//Start Code Change ----01.13.2010 #V10 maha
if as_object = "b_ve" then
	messagebox("Use as Verification","This setting used in Conjunction with the Complete from DE setting will allow the completion of verifications at the point of data entry.  Select the Default verification method that will appear in the update window.")
elseif as_object =  "b_aa" then
	messagebox("App Audit Auto Gen","This setting will use a combination of the Data Screen Name and a Reference field from the data entry screen to generate the description of the required element as each data record is being entered on the selected data screen.")
elseif as_object = "b_de" then
	messagebox("Complete from DE","This setting will automatically complete the Required item by inserting the Date Received and Status.  Connected Verifications will be updated as well if Use as Verification is also checked")
end if

return 1
end function

on w_app_audit_setup_ia.create
int iCurrent
call super::create
this.st_1=create st_1
this.tab_audit=create tab_audit
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_print=create cb_print
this.cb_save=create cb_save
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.tab_audit
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.cb_close
end on

on w_app_audit_setup_ia.destroy
call super::destroy
destroy(this.st_1)
destroy(this.tab_audit)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_print)
destroy(this.cb_save)
destroy(this.cb_close)
end on

event open;call super::open;//dw_data_view.Retrieve()

tab_audit.SelectTab(1)
tab_audit.tabpage_initial.dw_initial.SetFocus()

//dw_data_view.SelectRow( 1, True )
//dw_data_view.ScrollToRow( 1 )
//dw_data_view.SetRow( 1 )
end event

type st_1 from statictext within w_app_audit_setup_ia
integer x = 686
integer y = 48
integer width = 923
integer height = 104
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "No longer used"
boolean focusrectangle = false
end type

type tab_audit from tab within w_app_audit_setup_ia
integer x = 50
integer width = 2437
integer height = 1792
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_initial tabpage_initial
tabpage_reapp tabpage_reapp
end type

on tab_audit.create
this.tabpage_initial=create tabpage_initial
this.tabpage_reapp=create tabpage_reapp
this.Control[]={this.tabpage_initial,&
this.tabpage_reapp}
end on

on tab_audit.destroy
destroy(this.tabpage_initial)
destroy(this.tabpage_reapp)
end on

event selectionchanged;IF newindex = 1 THEN
	tab_audit.tabpage_initial.dw_initial.SetFocus()
ELSE
	tab_audit.tabpage_reapp.dw_reapp.SetFocus()
END IF
end event

type tabpage_initial from userobject within tab_audit
integer x = 18
integer y = 112
integer width = 2400
integer height = 1664
long backcolor = 32891346
string text = "Required Documents/Data"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
string picturename = "DataWindow!"
long picturemaskcolor = 553648127
dw_initial dw_initial
end type

on tabpage_initial.create
this.dw_initial=create dw_initial
this.Control[]={this.dw_initial}
end on

on tabpage_initial.destroy
destroy(this.dw_initial)
end on

type dw_initial from u_dw within tabpage_initial
integer x = 46
integer y = 60
integer width = 2309
integer height = 1440
integer taborder = 31
string dataobject = "d_app_audit_rqrd_data_ia"
end type

event constructor;DataWindowChild dwchild

This.of_SetTransObject(SQLCA)

This.GetChild( "default_ver_response_code", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("credentials verification response")

This.Retrieve( 1, "i" )


end event

event getfocus;call super::getfocus;idw_current = This
end event

event itemchanged;call super::itemchanged;Long ll_null_num

SetNull(ll_null_num)

IF (This.GetItemStatus( row, 0, Primary! ) = New! OR +&
	This.GetItemStatus( row, 0, Primary! ) = NewModified!) AND +&
	This.GetColumnName() = "description" THEN
	This.SetItem( row, "fax_description", data )
ELSEIF This.GetColumnName() = "use_as_verification" AND data = "N" THEN
	This.SetItem( row, "default_ver_response_code", ll_null_num )
	This.SetItem( row, "screen_id", ll_null_num )
END IF
end event

event buttonclicked;call super::buttonclicked;of_help(dwo.name)  //Start Code Change ----01.13.2010 #V10 maha
end event

type tabpage_reapp from userobject within tab_audit
boolean visible = false
integer x = 18
integer y = 112
integer width = 2400
integer height = 1664
long backcolor = 32891346
string text = "Reappointment Required Data"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
string picturename = "DataWindow5!"
long picturemaskcolor = 553648127
dw_reapp dw_reapp
cb_copy cb_copy
end type

on tabpage_reapp.create
this.dw_reapp=create dw_reapp
this.cb_copy=create cb_copy
this.Control[]={this.dw_reapp,&
this.cb_copy}
end on

on tabpage_reapp.destroy
destroy(this.dw_reapp)
destroy(this.cb_copy)
end on

type dw_reapp from u_dw within tabpage_reapp
integer x = 46
integer y = 60
integer width = 2309
integer height = 1440
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_app_audit_rqrd_data_ia"
end type

event constructor;This.of_SetTransObject(SQLCA)
This.of_SetRowManager(TRUE)

DataWindowChild dwchild

This.of_SetTransObject(SQLCA)

This.GetChild( "default_ver_response_code", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("credentials verification response")

This.Retrieve( 1, "i" )


end event

event getfocus;call super::getfocus;idw_current = This
end event

event itemchanged;call super::itemchanged;Long ll_null_num

SetNull( ll_null_num )

IF (This.GetItemStatus( row, 0, Primary! ) = New! OR +&
	This.GetItemStatus( row, 0, Primary! ) = NewModified!) AND +&
	This.GetColumnName() = "description" THEN
	This.SetItem( row, "fax_description", data )
ELSEIF This.GetColumnName() = "use_as_verification" AND data = "N" THEN
	This.SetItem( row, "default_ver_response_code", ll_null_num )
	This.SetItem( row, "screen_id", ll_null_num )
END IF
end event

event buttonclicked;call super::buttonclicked;of_help(dwo.name)  //Start Code Change ----01.13.2010 #V10 maha
end event

type cb_copy from u_cb within tabpage_reapp
integer x = 1088
integer y = 1564
integer width = 325
integer height = 84
integer taborder = 11
boolean bringtotop = true
string text = "Copy Inititial"
end type

event clicked;Integer li_rc
Integer i
Long li_id

li_rc = tab_audit.tabpage_reapp.dw_reapp.RowCount()

IF li_rc > 0 THEN
	MessageBox("Copy Error", "The reappointment audit list must be empty to copy the initial appointment audit list to it." )
	Return -1
END IF

tab_audit.tabpage_initial.dw_initial.RowsCopy(1, 1000, Primary!, tab_audit.tabpage_reapp.dw_reapp, 1, Primary!)

li_rc = tab_audit.tabpage_reapp.dw_reapp.RowCount()

FOR i = 1 TO li_rc
	li_id = Integer( gnv_app.of_get_id("APPAUDIT") )
	tab_audit.tabpage_reapp.dw_reapp.SetItem( i, "app_audit_id", li_id )
	tab_audit.tabpage_reapp.dw_reapp.SetItem( i, "app_type", "R" )
END FOR
end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 01.12.2006 By: LeiWei
//$<reason> Due to one slight defect in Appeon product, the position of this button is incorrect to some degree after migration.
//$<modification> Adjust the position for this button to make sure the presentation of this button looks the same as in PowerBuilder.
If appeongetclienttype() <> 'PB' Then
	this.y += 12
End If
//---------------------------- APPEON END ----------------------------

end event

type cb_add from u_cb within w_app_audit_setup_ia
integer x = 96
integer y = 1692
integer width = 325
integer height = 84
integer taborder = 10
boolean bringtotop = true
string text = "&Add"
end type

event clicked;Integer li_nr
Integer li_id


li_id = Integer( gnv_app.of_get_id("APPAUDIT") )

li_nr = idw_current.InsertRow( 0 )
idw_current.SetItem( li_nr, "facility_id", ii_facility_id )
idw_current.SetItem( li_nr, "app_audit_id", li_id )
//idw_current.SetItem( li_nr, "description", "" )//maha 100400 added to avoid null field database error
IF tab_audit.SelectedTab = 1 THEN
	idw_current.SetItem( li_nr, "app_type", "I" )
ELSE
	idw_current.SetItem( li_nr, "app_type", "R" )
END IF

//Start Code Change ---- 1.25.2007 #V7 maha
idw_current.SetItem(li_nr,'use_as_verification',0)
idw_current.SetItem(li_nr,'auto_generate',0)
idw_current.SetItem(li_nr,'receive_from_de',0)
//End Code Change---1.25.2007

idw_current.ScrollToRow( li_nr )
idw_current.SetRow( li_nr )
idw_current.SetFocus( )
idw_current.SetColumn( "description" )
end event

type cb_delete from u_cb within w_app_audit_setup_ia
integer x = 443
integer y = 1692
integer width = 325
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "&Delete "
end type

event clicked;Integer li_ans

li_ans = MessageBox("Delete Row", "Are you sure you want to delete selected row?", Question!, YesNo!, 1 )

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.13.2006 By: Rodger Wu
//$<reason> Fix a defect.

//IF li_ans = 1 THEN
//	idw_current.DeleteRow( 0 )
//END IF
//
//idw_current.SetFocus( )

IF li_ans = 1 THEN
	If tab_audit.selectedtab = 1 Then
		tab_audit.tabpage_initial.dw_initial.DeleteRow(0)
	Else
		tab_audit.tabpage_reapp.dw_reapp.DeleteRow(0)
	End If
END IF
//---------------------------- APPEON END ----------------------------
end event

type cb_print from u_cb within w_app_audit_setup_ia
integer x = 791
integer y = 1692
integer width = 325
integer height = 84
integer taborder = 30
boolean bringtotop = true
string text = "&Print "
end type

event clicked;idw_current.Print(True)

idw_current.SetFocus( )
end event

type cb_save from u_cb within w_app_audit_setup_ia
integer x = 1723
integer y = 1692
integer width = 325
integer height = 84
integer taborder = 40
boolean bringtotop = true
string text = "&Save"
end type

event clicked;Parent.Event pfc_Save()
end event

type cb_close from u_cb within w_app_audit_setup_ia
integer x = 2075
integer y = 1692
integer width = 325
integer height = 84
integer taborder = 50
boolean bringtotop = true
string text = "&Close"
end type

event clicked;Close( Parent )
end event

