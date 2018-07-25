$PBExportHeader$w_image_type_painter.srw
forward
global type w_image_type_painter from w_response
end type
type cb_rtemp from commandbutton within w_image_type_painter
end type
type cb_img from commandbutton within w_image_type_painter
end type
type dw_image_defaults from u_dw within w_image_type_painter
end type
type st_1 from statictext within w_image_type_painter
end type
type dw_image_type from u_dw within w_image_type_painter
end type
type dw_path from u_dw within w_image_type_painter
end type
type cb_1 from u_cb within w_image_type_painter
end type
type cb_3 from u_cb within w_image_type_painter
end type
type cb_4 from u_cb within w_image_type_painter
end type
type cb_2 from u_cb within w_image_type_painter
end type
type cb_5 from commandbutton within w_image_type_painter
end type
end forward

global type w_image_type_painter from w_response
integer x = 14
integer y = 64
integer width = 3465
integer height = 2260
string title = "Document Types"
long backcolor = 33551856
cb_rtemp cb_rtemp
cb_img cb_img
dw_image_defaults dw_image_defaults
st_1 st_1
dw_image_type dw_image_type
dw_path dw_path
cb_1 cb_1
cb_3 cb_3
cb_4 cb_4
cb_2 cb_2
cb_5 cb_5
end type
global w_image_type_painter w_image_type_painter

type variables
Long   il_new_image_type = 0   // Add by Andy 07.14.2008
String is_del_image_types = '' // Add by Andy 07.15.2008
end variables

on w_image_type_painter.create
int iCurrent
call super::create
this.cb_rtemp=create cb_rtemp
this.cb_img=create cb_img
this.dw_image_defaults=create dw_image_defaults
this.st_1=create st_1
this.dw_image_type=create dw_image_type
this.dw_path=create dw_path
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_2=create cb_2
this.cb_5=create cb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_rtemp
this.Control[iCurrent+2]=this.cb_img
this.Control[iCurrent+3]=this.dw_image_defaults
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_image_type
this.Control[iCurrent+6]=this.dw_path
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.cb_5
end on

on w_image_type_painter.destroy
call super::destroy
destroy(this.cb_rtemp)
destroy(this.cb_img)
destroy(this.dw_image_defaults)
destroy(this.st_1)
destroy(this.dw_image_type)
destroy(this.dw_path)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.cb_5)
end on

event open;call super::open;dw_image_type.of_SetTransObject( SQLCA )
dw_path.of_SetTransObject( SQLCA )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<comment> 02.08.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
dw_image_type.Retrieve()
dw_path.Retrieve()
*/
gnv_appeondb.of_startqueue( )

dw_image_type.Retrieve()
dw_path.Retrieve()

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

dw_image_type.of_SetReqColumn(TRUE)

//Start Code Change ----02.12.2015 #V14.2 maha
if w_mdi.of_security_access( 7721 ) = 0  or of_get_app_setting("set_recruit","I") = 0  THEN	
	dw_image_type.object.recruit_set.Visible = false
	dw_image_type.object.recruit_set_t.Visible = false
end if
//End Code Change ----02.12.2015

//Start Code Change ----07.05.2016 #V152 maha
if w_mdi.of_security_access( 7823 ) = 0 then
	cb_rtemp.visible = false
end if
//End Code Change ----07.05.2016

end event

event pfc_save;String ls_sql
Int i

//$<add> 07.14.2008 by Andy
if il_new_image_type > 0 then
	if MessageBox(gnv_app.iapp_object.DisplayName,"Do you want to add it as a default image type for Applications?",Question!,YesNo!) = 1 then
		//display the list of applications with select checkboxes
		Open(w_app_select)
	end if
	il_new_image_type = 0
end if

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.20.2015
//<$>reason:delete three table together,commit at last (Web Practitioner Photo Allegheny)
//Call super::pfc_save 
sqlca.autocommit = false

//$<add> 07.15.2008 by Andy
if LenA(is_del_image_types) > 0 then
	ls_sql = "DELETE app_image_defaults WHERE image_type in (" + is_del_image_types + ")"
	Execute Immediate :ls_sql;
//	if sqlca.sqlcode < 0 then	
//		Rollback;
//	else
//		commit;
//	end if
	if sqlca.sqlcode < 0 then	
		Rollback;
		sqlca.autocommit = true
		MessageBox("Delete", SQLCA.SQLERRTEXT )	
		Return -1
	end if
	
	ls_sql = "delete from security_user_images where image_type in (" + is_del_image_types + ")"
	Execute Immediate :ls_sql;
	If sqlca.sqlcode < 0 Then 
		Rollback;
		sqlca.autocommit = true
		MessageBox("Delete", SQLCA.SQLERRTEXT )	
		Return -1
	end if

	ls_sql = "delete from wv_required_template_image where image_type_id in (" + is_del_image_types + ")"
	Execute Immediate :ls_sql;
	If sqlca.sqlcode < 0 Then 
		Rollback;
		sqlca.autocommit = true
		MessageBox("Delete", SQLCA.SQLERRTEXT )	
		Return -1
	end if
	
	is_del_image_types = ''
end if

Call super::pfc_save
If AncestorReturnValue = 1 Then 
	Commit;
Else
	Rollback;
End if

sqlca.autocommit = true
//------------------- APPEON END -------------------

return 1
//end add 07.14.2008

end event

type cb_rtemp from commandbutton within w_image_type_painter
integer x = 1536
integer y = 28
integer width = 530
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Required Templates"
end type

event clicked;open(w_image_required_templates)
end event

type cb_img from commandbutton within w_image_type_painter
integer x = 1001
integer y = 28
integer width = 530
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Image Type Security"
end type

event clicked;//Start Code Change ----09.26.2012 #V12 maha - added for 12.3
string ls_parm
//report*I@ALL
long ll_type

//Added by Appeon long.zhang 01.20.2015
If Parent.Event pfc_save() < 0 Then
	Return -1
End If

if dw_image_type.getrow() > 0 then
	ll_type = dw_image_type.getitemnumber(dw_image_type.getrow(),"image_type_id")
else
	return
end if


ls_parm = string(ll_type ) + "*I@ALL"
openwithparm(w_image_user_access,ls_parm)



end event

type dw_image_defaults from u_dw within w_image_type_painter
boolean visible = false
integer x = 2176
integer y = 2068
integer width = 658
integer height = 144
integer taborder = 60
string dataobject = "d_app_image_defaults"
boolean vscrollbar = false
boolean livescroll = false
end type

type st_1 from statictext within w_image_type_painter
integer x = 37
integer y = 240
integer width = 2775
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Add image Description and select the data screen to which to link the image.  If unsure select Basic Information."
boolean focusrectangle = false
end type

type dw_image_type from u_dw within w_image_type_painter
integer x = 18
integer y = 312
integer width = 3419
integer height = 1856
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_image_painter"
end type

event buttonclicked;call super::buttonclicked;Long ll_image_id

 //Start Code Change ----11.04.2010 #V10 maha - removed code for help buttons; changed to tool tips.
	This.Update( )
	ll_image_id = This.GetItemNumber( row, "image_type_id" )
	OpenWithParm( w_ezflow_setup, ll_image_id )

end event

event pfc_preupdate;call super::pfc_preupdate;//Start Code Change ---- 03.29.2006 #355 maha
integer i
debugbreak()
for i = 1 to this.rowcount()
	if this.getitemnumber(i,"link_to_screen") = 27 then //maha 032906 trap for personal data screen
		this.setitem(i,"link_to_screen",1 ) //Start Code Change ----06.25.2014 #V14.2 maha - changed to variable from 1
	end if
	//Start Code Change ----03.26.2008 #V8 maha - added trap for null values
	if isnull(this.getitemnumber(i,"link_to_app_id")  ) then this.setitem(i,"link_to_app_id",0)
	if isnull(this.getitemnumber(i,"de_queue")  ) then this.setitem(i,"de_queue",0)
	//End Code Change---03.26.2008
next

return 1
//End Code Change---03.29.2006
end event

event itemchanged;call super::itemchanged;if IsNull(this.object.de_queue[Row]) then //Add by Evan 2008-03-14
	this.SetItem(Row, "de_queue", 0)
end if
end event

type dw_path from u_dw within w_image_type_painter
integer x = 27
integer y = 136
integer width = 2085
integer height = 104
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_image_path"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event pfc_preupdate;call super::pfc_preupdate;//Start Code Change ---- 03.01.2006 #301 maha
//	IF Right(dw_path.GetItemString( 1, "imaging_path" ), 1 ) <> "\" THEN
//		MessageBox("Validation Error", "The image path field must end with the charactor \")
//		dw_path.SetFocus()
//		dw_path.SetColumn( "imaging_path" )
//		Return -1
//	else
//		return 1
//	END IF

if this.getitemstatus( 1, 0, primary!) = datamodified! then
	this.setitem(1,"imaging_path",of_check_path(this.GetItemString( 1, "imaging_path" ),1)) 
end if

return 1
//End Code Change---03.01.2006


end event

type cb_1 from u_cb within w_image_type_painter
integer x = 32
integer y = 28
integer width = 311
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string text = "&Save"
end type

event clicked;Parent.Event pfc_save()
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: Jack (Inova)
//$<reason> Queue Images for Scanning from Data Entry.
gnv_data.of_retrieve('image_type')
//---------------------------- APPEON END ----------------------------
dw_image_type.sort()  //Start Code Change ----04.02.2008 #V8 maha

end event

type cb_3 from u_cb within w_image_type_painter
integer x = 681
integer y = 28
integer width = 311
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "&Delete"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-13 By: Liu HongXin
//$<reason> Fix defect.
Long ll_Row, ll_image_type_id, ll_Count

ll_Row = dw_image_type.GetRow()
If ll_Row < 1 Then Return

ll_image_type_id = dw_image_type.GetItemNumber(ll_Row, "image_type_id")

SELECT Count(*) 
  INTO :ll_Count
  FROM pd_images
 WHERE image_type_id = :ll_image_type_id;
If ll_Count > 0 Then
	IF ll_Count = 1 THEN //correct the typo/grammar - alfee 11.17.2009
		MessageBox(gnv_app.iapp_object.DisplayName,"This image type can not be deleted, because there is an image attached.", Exclamation! )
	ELSE
		MessageBox(gnv_app.iapp_object.DisplayName,"This image type can not be deleted, because there are " + string( ll_count ) + " images attached.", Exclamation! )
	END IF
	//MessageBox("Referenced records found","There are " + string( ll_count ) + " images(s) have scanned for this image type." )
	Return -1
End If
//---------------------------- APPEON END ----------------------------
 
 //------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.20.2015
//<$>reason:delete wv_required_template_image when click 'Save' (Web Practitioner Photo Allegheny 

//$<add> 07.15.2008 by Andy
SELECT top 1 1 INTO :ll_Count from app_image_defaults where image_type = :ll_image_type_id;
if ll_Count > 0 then
	if MessageBox(gnv_app.iapp_object.DisplayName,"All Application Image type default records connected to this image type will be deleted.  Are you sure you want to continue?",Question!,YesNo!) = 1 then
//		if is_del_image_types = '' then
//			is_del_image_types =  String(ll_image_type_id)
//		else
//			is_del_image_types = is_del_image_types + ',' + String(ll_image_type_id)
//		end if
	else
		return -1
	end if
end if
//End add 07.15.2008

//Prompt when it is required in WebVew - Required Documents Templates ,Added by Appeon long.zhang 01.21.2015
SELECT count(1) INTO :ll_Count from wv_required_template_image 
where image_type_id = :ll_image_type_id and is_image_linked = 1;
if ll_Count > 0 then
	if MessageBox(gnv_app.iapp_object.DisplayName,"All WebVew Required Documents Templates records connected to this image type will be deleted.  Are you sure you want to continue?",Question!,YesNo!) = 1 then
	else
		return -1
	end if
end if

if is_del_image_types = '' then
	is_del_image_types =  String(ll_image_type_id)
else
	is_del_image_types = is_del_image_types + ',' + String(ll_image_type_id)
end if

//move to w_image_type_painter.pfc_save() by long.zhang 01.20.2015
//delete from security_user_images where image_type_id = :ll_image_type_id;
//commit using sqlca;

 //------------------- APPEON END -------------------

dw_image_type.Event pfc_deleterow()

dw_image_type.SetFocus()
end event

type cb_4 from u_cb within w_image_type_painter
integer x = 2967
integer y = 28
integer width = 311
integer height = 84
integer taborder = 40
boolean bringtotop = true
string text = "&Close"
end type

event clicked;Close( Parent )
end event

type cb_2 from u_cb within w_image_type_painter
integer x = 357
integer y = 28
integer width = 311
integer height = 84
integer taborder = 10
string text = "&Add"
end type

event clicked;Integer li_row, li_lst_order
Integer li_next_id
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.04.2006 By: LeiWei
//$<reason> Fix a defect.
If Parent.Event pfc_save() < 0 Then
	Return -1
End If
//---------------------------- APPEON END ----------------------------

li_row = dw_image_type.InsertRow(0)
dw_image_type.SetRow(li_row)
dw_image_type.ScrollToRow(li_row)
dw_image_type.SetItem(li_Row, "de_queue", 0) //Add by Evan 2008-03-14

SELECT Max( image_type_id )  
INTO :li_next_id  
FROM image_type  ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Database Error", SQLCA.SQLCODE )
	Return -1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2005-11-24 By: Cao YongWang 
//$<reason> set li_next_id to 0 if li_next_id is null
If isnull(li_next_id) Then li_next_id = 0
//---------------------------- APPEON END ----------------------------


li_next_id ++

if li_next_id = 99 then li_next_id++  //Start Code Change ----01.29.2010 #V10 maha - skip the 99 id  (reserved for verifications)

il_new_image_type = li_next_id //$<add> 07.14.2008 by Andy

dw_image_type.SetItem(li_row, "image_type_id", li_next_id)
dw_image_type.SetItem(li_row, "link_to_app_id", 0)  //maha 013003
//Start Code Change ----03.25.2011 #V11 maha 
dw_image_type.SetItem(li_row, "default_pages",1)
dw_image_type.SetItem(li_row, "image_order", li_next_id)
//End Code Change ----03.25.2011

dw_image_type.SetFocus()
dw_image_type.SetColumn(1)
	
end event

type cb_5 from commandbutton within w_image_type_painter
integer x = 2830
integer y = 28
integer width = 123
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "?"
end type

event clicked;string s

s = "Default Application Attachment~r"
s += "If checked, when printing Applications, the checked items will be the Image Types selected for attachment to the Applications."
s += "~r~rQueue Image from DE~r"
s += "If checked, when data records are added for the connected data screen, Scan image records will be added to the Image Tab of the Practitioner."
s += "Sort order defines the order the types will appear on the Documents tab, sorted lowest to highest."

	messagebox("Image Setup help",s)
end event

