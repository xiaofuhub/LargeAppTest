$PBExportHeader$w_app_audit_setup.srw
forward
global type w_app_audit_setup from w_response
end type
type cb_add_recruit from u_cb within w_app_audit_setup
end type
type dw_prop from u_dw within w_app_audit_setup
end type
type ddlb_itype from dropdownlistbox within w_app_audit_setup
end type
type cb_del_temp from u_cb within w_app_audit_setup
end type
type cb_help from commandbutton within w_app_audit_setup
end type
type cb_additem from u_cb within w_app_audit_setup
end type
type cb_add_temp from u_cb within w_app_audit_setup
end type
type cb_copy from u_cb within w_app_audit_setup
end type
type dw_template from u_dw within w_app_audit_setup
end type
type rb_a from radiobutton within w_app_audit_setup
end type
type rb_b from radiobutton within w_app_audit_setup
end type
type rb_r from radiobutton within w_app_audit_setup
end type
type rb_i from radiobutton within w_app_audit_setup
end type
type cb_rename from u_cb within w_app_audit_setup
end type
type cb_delete from u_cb within w_app_audit_setup
end type
type cb_print from u_cb within w_app_audit_setup
end type
type cb_save from u_cb within w_app_audit_setup
end type
type cb_close from u_cb within w_app_audit_setup
end type
type gb_type from groupbox within w_app_audit_setup
end type
type gb_2 from groupbox within w_app_audit_setup
end type
type st_cover from statictext within w_app_audit_setup
end type
type dw_items from u_dw within w_app_audit_setup
end type
type gb_prop from groupbox within w_app_audit_setup
end type
end forward

global type w_app_audit_setup from w_response
integer x = 133
integer y = 336
integer width = 4261
integer height = 2496
string title = "Checklist Templates"
long backcolor = 33551856
cb_add_recruit cb_add_recruit
dw_prop dw_prop
ddlb_itype ddlb_itype
cb_del_temp cb_del_temp
cb_help cb_help
cb_additem cb_additem
cb_add_temp cb_add_temp
cb_copy cb_copy
dw_template dw_template
rb_a rb_a
rb_b rb_b
rb_r rb_r
rb_i rb_i
cb_rename cb_rename
cb_delete cb_delete
cb_print cb_print
cb_save cb_save
cb_close cb_close
gb_type gb_type
gb_2 gb_2
st_cover st_cover
dw_items dw_items
gb_prop gb_prop
end type
global w_app_audit_setup w_app_audit_setup

type variables
u_dw idw_current

Integer ii_facility_id  //this is really the template id.  Variable name from legacy functionality

end variables

forward prototypes
public function integer of_help (string as_object)
public function integer of_filter (string as_type)
public function integer of_template_child ()
public function integer of_types_vis (boolean ab_vis)
end prototypes

public function integer of_help (string as_object);//Start Code Change ----01.13.2010 #V10 maha
if as_object = "b_ve" then
	messagebox("Use as Verification","This setting used in Conjunction with the Complete from DE setting will allow the completion of verifications at the point of data entry.  Select the Default verification method that will appear in the update window.")
elseif as_object =  "b_aa" then
	messagebox("App Audit Auto Gen","This setting will use a combination of the Data Screen Name and a Reference field from the data entry screen to generate the description of the required element as each data record is being entered on the selected data screen.")
elseif as_object = "b_de" then
	messagebox("Complete from DE","This setting will automatically complete the Required item by inserting the Date Received and Status.~r~rConnected Verifications will be updated as well if Use as Verification is also checked")
end if

return 1
end function

public function integer of_filter (string as_type);string ls_filter = "app_type = "

if as_type = "A" then
	 ls_filter = ""
elseif as_type = "I" then
	 ls_filter += "'I'" 
elseif as_type = "R" then
	 ls_filter += "'R'" 
elseif as_type = "B" then
	 ls_filter += "'B'" 
elseif as_type = "IB" then  //Start Code Change ----08.06.2013 #V14 maha
	ls_filter = "app_type = 'I' or app_type = 'B'"
else //all
	ls_filter = ""
end if

dw_items.setfilter(ls_filter)
dw_items.filter()


return 1
end function

public function integer of_template_child ();datawindowchild dwchild

dw_template.GetChild( "template_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()

return 1


end function

public function integer of_types_vis (boolean ab_vis);
gb_type.visible = ab_vis
rb_i.visible = ab_vis
rb_r.visible = ab_vis
rb_b.visible = ab_vis
rb_a.visible = ab_vis

if ab_vis = false then
	rb_i.checked = false
	rb_r.checked = false
	rb_b.checked = false
	rb_a.checked = true
	of_filter( "A")
end if

return 1

end function

on w_app_audit_setup.create
int iCurrent
call super::create
this.cb_add_recruit=create cb_add_recruit
this.dw_prop=create dw_prop
this.ddlb_itype=create ddlb_itype
this.cb_del_temp=create cb_del_temp
this.cb_help=create cb_help
this.cb_additem=create cb_additem
this.cb_add_temp=create cb_add_temp
this.cb_copy=create cb_copy
this.dw_template=create dw_template
this.rb_a=create rb_a
this.rb_b=create rb_b
this.rb_r=create rb_r
this.rb_i=create rb_i
this.cb_rename=create cb_rename
this.cb_delete=create cb_delete
this.cb_print=create cb_print
this.cb_save=create cb_save
this.cb_close=create cb_close
this.gb_type=create gb_type
this.gb_2=create gb_2
this.st_cover=create st_cover
this.dw_items=create dw_items
this.gb_prop=create gb_prop
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_add_recruit
this.Control[iCurrent+2]=this.dw_prop
this.Control[iCurrent+3]=this.ddlb_itype
this.Control[iCurrent+4]=this.cb_del_temp
this.Control[iCurrent+5]=this.cb_help
this.Control[iCurrent+6]=this.cb_additem
this.Control[iCurrent+7]=this.cb_add_temp
this.Control[iCurrent+8]=this.cb_copy
this.Control[iCurrent+9]=this.dw_template
this.Control[iCurrent+10]=this.rb_a
this.Control[iCurrent+11]=this.rb_b
this.Control[iCurrent+12]=this.rb_r
this.Control[iCurrent+13]=this.rb_i
this.Control[iCurrent+14]=this.cb_rename
this.Control[iCurrent+15]=this.cb_delete
this.Control[iCurrent+16]=this.cb_print
this.Control[iCurrent+17]=this.cb_save
this.Control[iCurrent+18]=this.cb_close
this.Control[iCurrent+19]=this.gb_type
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.st_cover
this.Control[iCurrent+22]=this.dw_items
this.Control[iCurrent+23]=this.gb_prop
end on

on w_app_audit_setup.destroy
call super::destroy
destroy(this.cb_add_recruit)
destroy(this.dw_prop)
destroy(this.ddlb_itype)
destroy(this.cb_del_temp)
destroy(this.cb_help)
destroy(this.cb_additem)
destroy(this.cb_add_temp)
destroy(this.cb_copy)
destroy(this.dw_template)
destroy(this.rb_a)
destroy(this.rb_b)
destroy(this.rb_r)
destroy(this.rb_i)
destroy(this.cb_rename)
destroy(this.cb_delete)
destroy(this.cb_print)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.gb_type)
destroy(this.gb_2)
destroy(this.st_cover)
destroy(this.dw_items)
destroy(this.gb_prop)
end on

event open;call super::open;//Start Code Change ----10.27.2010 #V10 maha - rebuild to simplify functionality, connect to a template rather than a facility; same window for both Cred and App.
dw_template.Retrieve()
//dw_template.SelectRow( 1, True )
if gs_cust_type = "I" then
	dw_items.dataobject = "d_app_audit_rqrd_data_sk"
	dw_items.settransobject(sqlca)
	//st_cover.bringtotop = true  //Start Code Change ----06.10.2016 #V152 maha - no longer used
	//Start Code Change ----08.06.2013 #V14 maha
	//rb_i.triggerevent(clicked!) //removed
	of_filter("A")  //Start Code Change ----06.10.2016 #V152 maha - changed from IB
	//End Code Change ----08.06.2013
	cb_add_temp.visible = false
	cb_copy.visible = false
	dw_items.retrieve(1)
	ii_facility_id = 1
	//Start Code Change ----03.29.2016 #V15 maha
	//dw_items.y = 200  //Start Code Change ----11.27.2012 #V12 maha  //Start Code Change ----06.10.2016 #V152 maha - moved below
	dw_items.bringtotop = true
	gb_type.visible = false
//	gb_prop.visible = false
	rb_a.visible = false
	rb_r.visible = false
	rb_i.visible = false
	rb_b.visible = false
	//End Code Change ----03.29.2016
	 if of_get_app_setting("set_recruit","I") = 0 then  //Start Code Change ----06.20.2016 #V152 maha - added recruitment check
	 	dw_template.visible = false
		gb_2.visible = false
		cb_del_temp.visible = false
		gb_prop.visible = false
		dw_prop.visible = false
		dw_items.y = 200
		dw_items.height = this.height - 280
	else
		dw_prop.modify( "temp_type.protect = 1")
		dw_prop.modify( "temp_type.background.color = 14803425")
		cb_add_recruit.visible = true
		dw_template.setitem(1,"template_id",1)
		dw_prop.retrieve(1)
	end if
		
	
end if

 //Start Code Change ----10.26.2015 #V15 maha - simple
 if of_get_app_setting("set_86","I") = 1 then
	cb_add_temp.visible = false
	cb_copy.visible = false
	cb_del_temp.visible = false
end if
 //End Code Change ----10.26.2015 
	


end event

type cb_add_recruit from u_cb within w_app_audit_setup
boolean visible = false
integer x = 1083
integer y = 60
integer width = 805
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "Add Recruitment Template"
end type

event clicked;//Start Code Change ----06.20.2016 #V152 maha - added for App recruitment
Integer li_nr
Integer li_id
string ls_name

openwithparm(w_get_new_checklist, "R")

ls_name = message.stringparm
li_id = message.doubleparm

if ls_name = "Cancel" then 
	return
elseif li_id  > 0 then
	ii_facility_id = li_id
	dw_items.dataobject = "d_app_audit_rqrd_data_recruit"
	dw_items.settransobject(sqlca)
	dw_template.retrieve()
	dw_prop.retrieve(li_id)
	of_template_child()
	dw_template.setitem(1,"template_id",ii_facility_id)
	dw_items.reset()
	cb_additem.triggerevent( clicked!)
end if

end event

type dw_prop from u_dw within w_app_audit_setup
integer x = 50
integer y = 236
integer width = 2345
integer height = 96
integer taborder = 90
string dataobject = "d_checklist_template_detail"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;
This.of_SetTransObject(SQLCA)


end event

event getfocus;call super::getfocus;idw_current = This
end event

event itemchanged;call super::itemchanged; //Start Code Change ----10.19.2015 #V15 maha
Long rec

if dwo.name = "temp_type" then
	this.accepttext()
	rec = this.getitemnumber(1,"temp_type")
	if rec = 2 then  //recruitment
		dw_items.dataobject = "d_app_audit_rqrd_data_recruit"
		of_types_vis(false)
	elseif rec = 3 then  //file review
		dw_items.dataobject = "d_app_audit_rqrd_data_review"
		of_types_vis(false)
	else
		dw_items.dataobject = "d_app_audit_rqrd_data"
		of_types_vis(true)
	end if
	
	dw_items.settransobject(sqlca)
	dw_items.retrieve(ii_facility_id)
end if


end event

type ddlb_itype from dropdownlistbox within w_app_audit_setup
boolean visible = false
integer x = 4183
integer y = 168
integer width = 539
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean border = false
boolean sorted = false
string item[] = {"All","Initial","Reappointment","Both I & R","Midcycle"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;choose case index
	case 1
		of_filter("A")
	case 2
		of_filter("I")
	case 3
		of_filter("R")
	case 4
		of_filter("B")
	case 5
		of_filter("M")
end choose
end event

type cb_del_temp from u_cb within w_app_audit_setup
integer x = 1897
integer y = 60
integer width = 443
integer height = 84
integer taborder = 30
boolean bringtotop = true
string text = "Delete Template"
end type

event clicked;call super::clicked;//Start Code Change ----06.28.2011 #V11 maha - added
Integer li_ans
integer r
long ll_app_id
long cnt

//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 07.29.2011
//$<reason>  filter echo record
/*
select count(record_id) into :cnt from pd_app_audit where app_audit_id in (select app_audit_id from data_view_app_audit where facility_id = :ii_facility_id);
*/
select count(1) into :cnt FROM pd_app_audit,   
         data_view_app_audit,  
         pd_affil_stat 
where pd_app_audit.app_audit_id = data_view_app_audit.app_audit_id
   and data_view_app_audit.facility_id = pd_affil_stat.application_audit_facility
   and pd_affil_stat.rec_id = pd_app_audit.appt_stat_id
   and data_view_app_audit.facility_id = :ii_facility_id;
//------------------- APPEON END ---------------------

//Start Code Change ----06.20.2016 #V152 maha
if gs_cust_type = "I" then
	if ii_facility_id = 1 then
		MessageBox("Delete Template", "The Credentialing Template cannot be deleted." )
		return
	end if
end if
//End Code Change ----06.20.2016

if cnt > 0 then
	MessageBox("Delete Template", "This template has " + string(cnt) + " practitioner records connected to it and cannot be deleted." )
	return
else
	li_ans = MessageBox("Delete Template", "Are you sure you want to delete the selected Template and all connected Items?", Question!, YesNo!, 1 )
end if

//delete row
IF li_ans = 1 THEN
	delete from data_view_app_audit where facility_id = :ii_facility_id;
	delete from data_view_app_audit_template where template_id = :ii_facility_id;
	commit using sqlca;
	dw_items.reset()
	dw_template.retrieve()
	of_template_child()
	dw_prop.reset()
END IF
//---------------
end event

type cb_help from commandbutton within w_app_audit_setup
integer x = 3726
integer y = 60
integer width = 133
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "?"
end type

event clicked;//Start Code Change ----12.17.2011 #V11 maha - created as an alternative to unsupported tool tips.

string s

s = "Screen Description~rThe value in this field is the text that will appear on the Provider Checklist tab.~r~r" 
s += "Letter Description~rThis is the value that will appear when a Missing Information letter is produced.~r~r"

if gs_cust_type <> 'I' then
	s += "Appt Type~rDetermines if the item appears in Initial, Recred, or both templates .~r~r" //evan 02.10.2011
end if
s += "Auto Generate~rThe Auto Generate setting will use a combination of the Data Screen Name and a Reference field from the data entry screen to generate the description of the required element, as each data record is being entered on the selected data screen.~r~r" //evan 02.10.2011
s += "Complete from DE~rThe Complete from DE setting will automatically complete the Required item by inserting the Date Received and Status.  Connected Verifications will be updated as well if Use as Verification is also checked.~r~r"
s += "Use As Verification~rThis setting used in Conjunction with the Complete from DE setting will allow the completion of verifications at the point of data entry.  Select the Default verification method that will appear in the update window.~r~r"
s += "DE Linking Screen~rFor Checklist items that are connected to a specific data screen, select the screen from this dropdown.~r~r"

if gs_cust_type <> 'I' then
	s += "Default Verif Response~rIf verifications will be completed from data entry, select the default Response Code (typically Hard Copy)~r~r"
end if

Messagebox("About Checklist Setup",s)
end event

type cb_additem from u_cb within w_app_audit_setup
integer x = 2702
integer y = 60
integer width = 325
integer height = 84
integer taborder = 40
boolean bringtotop = true
string text = "&Add Item"
end type

event clicked;//Start Code Change ----09.2010 #V10 maha - rerwote based on removal of tab
Integer li_nr
Integer li_id

idw_current = dw_items
li_id = Integer( gnv_app.of_get_id("APPAUDIT") )

li_nr = idw_current.InsertRow( 0 )
idw_current.SetItem( li_nr, "facility_id", ii_facility_id )
idw_current.SetItem( li_nr, "app_audit_id", li_id )
idw_current.SetItem(li_nr,'use_as_verification',0)
idw_current.SetItem(li_nr,'auto_generate',0)
idw_current.SetItem(li_nr,'receive_from_de',0)

//set appointment type based on filter
if gs_cust_type = "I" then
	idw_current.SetItem( li_nr, "app_type", "I" )
else
	IF rb_i.checked THEN
		idw_current.SetItem( li_nr, "app_type", "I" )
	ELSEIF rb_r.checked THEN
		idw_current.SetItem( li_nr, "app_type", "R" )
	ELSEIF rb_b.checked THEN
		idw_current.SetItem( li_nr, "app_type", "B" )
	else
		idw_current.SetItem( li_nr, "app_type", "I" )
	END IF
end if

idw_current.ScrollToRow( li_nr )
idw_current.SetRow( li_nr )
idw_current.SetFocus( )
idw_current.SetColumn( "description" )


end event

type cb_add_temp from u_cb within w_app_audit_setup
integer x = 1083
integer y = 60
integer width = 398
integer height = 84
integer taborder = 30
boolean bringtotop = true
string text = "Add &Template"
end type

event clicked; //Start Code Change ----02.23.2015 #V15 maha - changed to use new get window
Integer li_nr
Integer li_id
string ls_name

openwithparm(w_get_new_checklist,"A")

ls_name = message.stringparm
li_id = message.doubleparm

if ls_name = "Cancel" then 
	return
elseif li_id  > 0 then
	
//	select max(template_id) into :li_id from data_view_app_audit_template;
//	if isnull(li_id) then li_id = 0
//	li_id++
//	insert into data_view_app_audit_template (template_id,template_name) values(:li_id,:ls_name);
//	commit using sqlca;
	ii_facility_id = li_id
	
	dw_template.retrieve()
	dw_prop.retrieve(li_id)
	of_template_child()
	dw_template.setitem(1,"template_id",ii_facility_id)
	dw_items.reset()
	cb_additem.triggerevent( clicked!)
end if

end event

type cb_copy from u_cb within w_app_audit_setup
integer x = 1490
integer y = 60
integer width = 398
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "Copy Template"
end type

event clicked;Integer rc
integer r
long li_id
string ls_name

open(w_get_checklist_name)

ls_name = message.stringparm

if ls_name = "Cancel" then 
	return
else
	select max(template_id) into :li_id from data_view_app_audit_template;
	if isnull(li_id) then li_id = 0
	li_id++
	insert into data_view_app_audit_template (template_id,template_name) values(:li_id,:ls_name);
	commit using sqlca;
	ii_facility_id = li_id
	//copy items
	rc = dw_items.rowcount()
	dw_items.rowscopy( 1, rc,primary!, dw_items, 10000,primary!)
	li_id = long( gnv_app.of_get_id("APPAUDIT",rc) )  //Start Code Change ----06.28.2011 #V11 maha 
	for r = rc + 1 to dw_items.rowcount()
		dw_items.SetItem( r, "facility_id", ii_facility_id )
		dw_items.SetItem( r, "app_audit_id", li_id )
		li_id++
	next
	dw_items.update()
	
	dw_template.retrieve()
	of_template_child()
	dw_template.setitem(1,"template_id",ii_facility_id)
	dw_items.retrieve(ii_facility_id)
	dw_prop.retrieve(ii_facility_id)
end if
end event

type dw_template from u_dw within w_app_audit_setup
integer x = 87
integer y = 64
integer width = 933
integer height = 84
integer taborder = 20
string title = "Select Facility"
string dataobject = "d_checklist_templates"
boolean controlmenu = true
boolean vscrollbar = false
boolean border = false
end type

event clicked;call super::clicked;This.ScrollToRow( This.GetClickedRow() )
end event

event constructor;
This.of_SetUpdateable( False )
This.of_SetTransObject( SQLCA )


end event

event itemchanged;call super::itemchanged;integer f
integer rec
datawindowchild dwchild

ii_facility_id = integer(data)

 //Start Code Change ----02.23.2015 #V15 maha
 this.getchild( "template_id", dwchild)
f = dwchild.find("template_id = " + string(ii_facility_id), 1,dwchild.rowcount())
if f > 0 then
	rec = dwchild.getitemnumber(f,"temp_type")
	if rec = 2 then  //recruitment
		dw_items.dataobject = "d_app_audit_rqrd_data_recruit"
		of_types_vis(false)
	elseif rec = 3 then  //file review
		dw_items.dataobject = "d_app_audit_rqrd_data_review"
		of_types_vis(false)
	else
		//Start Code Change ----06.20.2016 #V152 maha - trap for App
		if gs_cust_type = "I" then
			dw_items.dataobject = "d_app_audit_rqrd_data_sk"
		else
			dw_items.dataobject = "d_app_audit_rqrd_data"
		end if
		//End Code Change ----06.20.2016 
		of_types_vis(true)
	end if
	
	dw_items.settransobject( sqlca )
	dw_items.retrieve(ii_facility_id	)
	dw_prop.retrieve(ii_facility_id)   //Start Code Change ----10.19.2015 #V15 maha
end if






end event

event retrieveend;call super::retrieveend;this.insertrow(1)
dw_items.retrieve(ii_facility_id) //for after copy
end event

type rb_a from radiobutton within w_app_audit_setup
integer x = 2725
integer y = 252
integer width = 146
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
boolean checked = true
end type

event clicked;of_filter("A")
end event

type rb_b from radiobutton within w_app_audit_setup
integer x = 3607
integer y = 252
integer width = 210
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Both"
end type

event clicked;of_filter("B")
end event

type rb_r from radiobutton within w_app_audit_setup
integer x = 3122
integer y = 252
integer width = 471
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Reappointment"
end type

event clicked;of_filter("R")
end event

type rb_i from radiobutton within w_app_audit_setup
integer x = 2889
integer y = 252
integer width = 238
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Initial"
end type

event clicked;of_filter("I")
end event

type cb_rename from u_cb within w_app_audit_setup
boolean visible = false
integer x = 4183
integer y = 216
integer width = 443
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "Properties"
end type

event clicked; //Start Code Change ----02.23.2015 #V15 maha - changed to use new get window
Integer li_nr
Integer li_id
string ls_name

openwithparm(w_get_new_checklist,ii_facility_id)

if ls_name = "Cancel" then 
	return
else
	dw_template.retrieve()
	of_template_child()
	dw_template.setitem(1,"template_id",ii_facility_id)
end if

//////////////////////////////////////////////////////

//Integer li_id
//string ls_name
//datawindowchild ldw_child
//
//if ii_facility_id > 0 then
//	li_id = ii_facility_id
//else
//	MessageBox("Rename", "Please select a template.")
//	dw_template.SetFocus()
//	Return
//end if
//
//Open(w_get_checklist_name)
//ls_name = message.stringparm
//if ls_name = "Cancel" then Return
//
//gnv_appeondb.of_StartQueue()
//UPDATE data_view_app_audit_template
//SET template_name = :ls_name
//WHERE template_id = :li_id;
//COMMIT;
//gnv_appeondb.of_CommitQueue()
//
//dw_template.GetChild("template_id", ldw_child)
//ldw_child.SetItem(ldw_child.getrow(), "template_name", ls_name)
//dw_template.SetItem(dw_template.getrow(), "template_id", li_id)
//dw_template.SetRedraw(true)
end event

type cb_delete from u_cb within w_app_audit_setup
integer x = 3049
integer y = 60
integer width = 325
integer height = 84
integer taborder = 30
boolean bringtotop = true
string text = "&Delete Item"
end type

event clicked;Integer li_ans
long ll_type  //maha 10.20.2015
long ll_app_id //maha 081009
long cnt//maha 081009
datawindow ldw_current //maha 081009

ldw_current = dw_items
if ldw_current.GetRow() < 1 then Return //Add by Evan on 11.23.2010

//check to see if practitioner item exists
ll_app_id = ldw_current.getitemnumber(ldw_current.getrow(), "app_audit_id")
 //Start Code Change ----10.20.2015 #V15 maha - test based on type
ll_type = dw_prop.getitemnumber(1, "temp_type")

choose case ll_type
	case 1 //checklist
		//------------------- APPEON BEGIN -------------------
		//$<modify> Stephen 07.29.2011
		//$<reason> filter echo record  - more efficient
		/*
		select count(record_id) into :cnt from pd_app_audit where app_audit_id = :ll_app_id;
		*/
		select count(1) into :cnt FROM pd_app_audit,   
					data_view_app_audit,  
					pd_affil_stat 
		where pd_app_audit.app_audit_id = data_view_app_audit.app_audit_id
			and data_view_app_audit.facility_id = pd_affil_stat.application_audit_facility
			and pd_affil_stat.rec_id = pd_app_audit.appt_stat_id
			and data_view_app_audit.facility_id = :ii_facility_id
			and data_view_app_audit.app_audit_id = :ll_app_id;
		//------------------- APPEON END ---------------------
	case 2 //recruitment
		select count(act_id) into :cnt from pd_recruit_actions where clist_item_id = :ll_app_id;
		
	case 3 //appt review audit
		select count(record_id) into :cnt from pd_affil_stat_review_checklist where checklist_item_id = :ll_app_id;
		
end choose

if cnt > 0 then
	choose case ll_type
		case 1
			MessageBox("Delete Row", "This item is connected to " + string(cnt) + " provider records and cannot be deleted. Setting the Appt Type to INACTIVE will prevent it from being added to new Provider Checklists" )
		case 2
			MessageBox("Delete Row", "This item is connected to " + string(cnt) + " Recruitment Actions and cannot be deleted. Setting the Status to INACTIVE will prevent it from being added to new Checklists" )
		case 3
			MessageBox("Delete Row", "This item is connected to " + string(cnt) + " Appointment Review records and cannot be deleted. Setting the Status to INACTIVE will prevent it from being added to new Checklists" )
	end choose	
	return
else
	li_ans = MessageBox("Delete Row", "Are you sure you want to delete selected Item?", Question!, YesNo!, 1 )
end if

//delete row
IF li_ans = 1 THEN
	ldw_current.DeleteRow(0)
END IF
//---------------------------- APPEON END ----------------------------
end event

type cb_print from u_cb within w_app_audit_setup
integer x = 3383
integer y = 60
integer width = 325
integer height = 84
integer taborder = 40
boolean bringtotop = true
string text = "&Print "
end type

event clicked;dw_items.Print(True)

dw_items.SetFocus( )
end event

type cb_save from u_cb within w_app_audit_setup
integer x = 2363
integer y = 60
integer width = 325
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string text = "&Save"
end type

event clicked;string ls_description
string ls_fax[]  //maha 04.04.2008
long ll_row
long ll_aa_id[]  //maha 04.04.2008
integer li_up_cnt= 0 //maha 04.04.2008
integer i  //maha 04.04.2008

//trap for description
dw_items.accepttext()
for i = 1 to dw_items.rowcount()
	ls_description =dw_items.getitemstring(i,'description')
	if isnull(ls_description) or trim(ls_description) = '' then
		messagebox('IntelliSoftGroup','Required value missing for description on row ' + string(1) + '. ' + 'Please enter a value.')
		dw_items.setfocus()
		dw_items.setcolumn('description')
		return
	end if
next

//save
Parent.Event pfc_Save()
end event

type cb_close from u_cb within w_app_audit_setup
integer x = 3881
integer y = 60
integer width = 325
integer height = 84
integer taborder = 60
boolean bringtotop = true
string text = "&Close"
end type

event clicked;Close( Parent )
end event

type gb_type from groupbox within w_app_audit_setup
integer x = 2683
integer y = 184
integer width = 1166
integer height = 176
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Item Type Filter"
end type

type gb_2 from groupbox within w_app_audit_setup
integer x = 32
integer y = 8
integer width = 1038
integer height = 168
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Template"
end type

type st_cover from statictext within w_app_audit_setup
integer x = 4178
integer y = 4
integer width = 82
integer height = 44
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type dw_items from u_dw within w_app_audit_setup
integer x = 5
integer y = 388
integer width = 4247
integer height = 2020
integer taborder = 80
string dataobject = "d_app_audit_rqrd_data"
boolean hscrollbar = true
end type

event buttonclicked;call super::buttonclicked;of_help(dwo.name)  //Start Code Change ----01.13.2010 #V10 maha
end event

event constructor;DataWindowChild dwchild

This.of_SetTransObject(SQLCA)

This.GetChild( "default_ver_response_code", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("credentials verification response")
dwchild.insertrow(1)

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

event retrievestart;call super::retrievestart;//Added by alfee 11.14.2016
DataWindowChild dwchild

If This.dataobject = "d_app_audit_rqrd_data" Then
	This.GetChild( "default_ver_response_code", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve("Credentials Verification Response")
	dwchild.insertrow(1)
End If	
end event

type gb_prop from groupbox within w_app_audit_setup
integer x = 32
integer y = 184
integer width = 2395
integer height = 176
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Properties"
end type

