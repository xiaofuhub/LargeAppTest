$PBExportHeader$w_utilities_old.srw
forward
global type w_utilities_old from window
end type
type dw_3 from datawindow within w_utilities_old
end type
type dw_data_view_list from datawindow within w_utilities_old
end type
type dw_dvfieldcopy from datawindow within w_utilities_old
end type
type cb_close from commandbutton within w_utilities_old
end type
type cb_6 from commandbutton within w_utilities_old
end type
type cb_5 from commandbutton within w_utilities_old
end type
type cb_4 from commandbutton within w_utilities_old
end type
type cb_3 from commandbutton within w_utilities_old
end type
type cb_2 from commandbutton within w_utilities_old
end type
type cb_1 from commandbutton within w_utilities_old
end type
type cb_fix from commandbutton within w_utilities_old
end type
type cb_requested from commandbutton within w_utilities_old
end type
type cb_bd_exp from commandbutton within w_utilities_old
end type
type cb_prem_utl from commandbutton within w_utilities_old
end type
type cb_date_fields from commandbutton within w_utilities_old
end type
type cb_caqh_fields from commandbutton within w_utilities_old
end type
end forward

global type w_utilities_old from window
integer width = 987
integer height = 864
boolean titlebar = true
string title = "Legacy Utilities"
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_3 dw_3
dw_data_view_list dw_data_view_list
dw_dvfieldcopy dw_dvfieldcopy
cb_close cb_close
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_fix cb_fix
cb_requested cb_requested
cb_bd_exp cb_bd_exp
cb_prem_utl cb_prem_utl
cb_date_fields cb_date_fields
cb_caqh_fields cb_caqh_fields
end type
global w_utilities_old w_utilities_old

on w_utilities_old.create
this.dw_3=create dw_3
this.dw_data_view_list=create dw_data_view_list
this.dw_dvfieldcopy=create dw_dvfieldcopy
this.cb_close=create cb_close
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_fix=create cb_fix
this.cb_requested=create cb_requested
this.cb_bd_exp=create cb_bd_exp
this.cb_prem_utl=create cb_prem_utl
this.cb_date_fields=create cb_date_fields
this.cb_caqh_fields=create cb_caqh_fields
this.Control[]={this.dw_3,&
this.dw_data_view_list,&
this.dw_dvfieldcopy,&
this.cb_close,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.cb_fix,&
this.cb_requested,&
this.cb_bd_exp,&
this.cb_prem_utl,&
this.cb_date_fields,&
this.cb_caqh_fields}
end on

on w_utilities_old.destroy
destroy(this.dw_3)
destroy(this.dw_data_view_list)
destroy(this.dw_dvfieldcopy)
destroy(this.cb_close)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_fix)
destroy(this.cb_requested)
destroy(this.cb_bd_exp)
destroy(this.cb_prem_utl)
destroy(this.cb_date_fields)
destroy(this.cb_caqh_fields)
end on

type dw_3 from datawindow within w_utilities_old
boolean visible = false
integer x = 1152
integer y = 284
integer width = 247
integer height = 92
integer taborder = 20
string dataobject = "d_fix_dob"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)

end event

type dw_data_view_list from datawindow within w_utilities_old
boolean visible = false
integer x = 1175
integer y = 496
integer width = 283
integer height = 76
integer taborder = 20
string dataobject = "d_data_view_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_dvfieldcopy from datawindow within w_utilities_old
boolean visible = false
integer x = 1161
integer y = 392
integer width = 261
integer height = 76
integer taborder = 20
string dataobject = "d_dvf_field_copy"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_utilities_old
integer x = 667
integer y = 20
integer width = 270
integer height = 92
integer taborder = 10
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

type cb_6 from commandbutton within w_utilities_old
integer x = 23
integer y = 140
integer width = 919
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = " Fix DOB Year"
end type

event clicked;integer r
integer rc
integer d
integer m
integer yr
date dob


 r = 	messagebox("About","This function will correct any prac dob that shows a year greater than 2000",Question!,yesno!,2)
if r = 2 then return
dw_3.settransobject(sqlca)
rc = dw_3.retrieve()
for r = 1 to rc
	 yr = year(date(dw_3.getitemdatetime(r,"date_of_birth"))) 
	 //messagebox("yr",yr)
if yr > 2000 then		
	yr = yr - 100
	//messagebox("yr-100",yr)
	m = month(date(dw_3.getitemdatetime(r,"date_of_birth")))
	d = day(date(dw_3.getitemdatetime(r,"date_of_birth")))
	dob = date(string(yr)  + "/" + string(m) + "/" + string(d))
	//messagebox("",string(dob))
	dw_3.setitem(r,"date_of_birth",datetime(dob))
end if
next

dw_3.update()
commit using sqlca;


	messagebox("done","Completed")
end event

type cb_5 from commandbutton within w_utilities_old
integer x = 23
integer y = 244
integer width = 919
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Set Staff Cat Status "
end type

event clicked;integer r

 r = 	messagebox("About","This function will update the status value for all Staff Category records based on to_date.~rDate  = inactive; no date = active.~r~rContinue?",Question!,yesno!,2)
if r = 2 then return

string ls_sql


update pd_affil_staff_cat set requested = 0 where to_date is not null;
update pd_affil_staff_cat set requested = 1 where to_date is null;
commit using sqlca;

 r = 	messagebox("Requested","Do you want to update the status of records where there is no FROM or TO dates to 'Requested' status?",Question!,yesno!,2)
if r = 1 then 
	update pd_affil_staff_cat set requested = 2 where to_date is null and from_date is null;
	commit using sqlca;
end if

messagebox("Done"," Update Completed")
end event

type cb_4 from commandbutton within w_utilities_old
integer x = 23
integer y = 348
integer width = 919
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "New Board/Specialty Fields"
end type

event clicked;
integer r
integer dvid
integer rc
integer v
integer find
integer vc
integer a
long fid = 9810 //expiration date

r = messagebox("About","This function will Copy the new specialty exp date and certified fields to all views, and set the Bd/Spec expiration field to expiration date, and create expiration date data from certificate expires.~r~rContinue?",Question!,yesno!,2)
if r = 2 then return

SetPointer ( hourglass! )
debugbreak()
dw_data_view_list.settransobject(sqlca)
vc = dw_data_view_list.retrieve()
dw_dvfieldcopy.settransobject(sqlca)

for a = 1 to 2
	if a = 2 then fid = 9811 //board certified
	dw_dvfieldcopy.reset()
	rc = dw_dvfieldcopy.retrieve(fid)
	for v = 1 to vc  //go down list of views and add if not found
		dvid = dw_data_view_list.getitemnumber(v,"data_view_id")
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04.01.2006 By: LiuHongXin
		//$<reason> Fix a defect.
		/*
		find = dw_dvfieldcopy.Find ( "data_view_id = " + string(dvid), 1, vc )
		*/
		find = dw_dvfieldcopy.Find ( "data_view_id = " + string(dvid), 1, rc )
		//---------------------------- APPEON END ----------------------------
		if find < 0 then
			messagebox("","bad find")
			return
			end if
		if find = 0 then 
			dw_dvfieldcopy.rowscopy(1,1,primary!,dw_dvfieldcopy,1000,primary!)
			dw_dvfieldcopy.setitem(dw_dvfieldcopy.rowcount(),"data_view_id",dvid)
		end if
	next
next

gnv_appeondb.of_startqueue( )
		
dw_dvfieldcopy.update()
commit using sqlca;

//update exp dv field
update data_view_screen set exp_field = 9810 where screen_id =  19;
//update exp data
update pd_board_specialty set expiration_date = convert(char(4),certification_expires) + '-12-30' + ' 00:00:00' where certification_expires is not null and expiration_date is null;
//update certified
update pd_board_specialty set board_certified = 581 where board_code is not null;
update pd_board_specialty set board_certified = 582 where board_code is null;

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

SetPointer ( arrow! )
messagebox("Done"," Update Completed")
end event

type cb_3 from commandbutton within w_utilities_old
boolean visible = false
integer x = 23
integer y = 556
integer width = 923
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "iPrem Utilities"
end type

event clicked;integer res
//res = messagebox("This operation:","This utility will add missing facility committees to current appointments.  Used when committees have been added to a facility after the appointments were created.  ~rContinue?",question!,yesno!,2)

//Open(w_premium_sync)






end event

type cb_2 from commandbutton within w_utilities_old
integer x = 27
integer y = 660
integer width = 919
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add New Date Fields to Views"
end type

event clicked;integer r

// r = 	messagebox("About","This function will clear double quotes in all Credentialing Data screen labels and text items.~rContinue?",Question!,yesno!,2)
//if r = 2 then return
//
open(w_add_new_date_fields)


end event

type cb_1 from commandbutton within w_utilities_old
integer x = 23
integer y = 452
integer width = 919
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add CAQH Fields to Views"
end type

event clicked;integer r


open(w_caqh_add_fields)


end event

type cb_fix from commandbutton within w_utilities_old
integer x = 4325
integer y = 1432
integer width = 919
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = " Fix DOB Year"
end type

event clicked;integer r
integer rc
integer d
integer m
integer yr
date dob


 r = 	messagebox("About","This function will correct any prac dob that shows a year greater than 2000",Question!,yesno!,2)
if r = 2 then return
dw_3.settransobject(sqlca)
rc = dw_3.retrieve()
for r = 1 to rc
	 yr = year(date(dw_3.getitemdatetime(r,"date_of_birth"))) 
	 //messagebox("yr",yr)
if yr > 2000 then		
	yr = yr - 100
	//messagebox("yr-100",yr)
	m = month(date(dw_3.getitemdatetime(r,"date_of_birth")))
	d = day(date(dw_3.getitemdatetime(r,"date_of_birth")))
	dob = date(string(yr)  + "/" + string(m) + "/" + string(d))
	//messagebox("",string(dob))
	dw_3.setitem(r,"date_of_birth",datetime(dob))
end if
next

dw_3.update()
commit using sqlca;


	messagebox("done","Completed")
end event

type cb_requested from commandbutton within w_utilities_old
integer x = 4325
integer y = 1536
integer width = 919
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Set Staff Cat Status "
end type

event clicked;integer r

 r = 	messagebox("About","This function will update the status value for all Staff Category records based on to_date.~rDate  = inactive; no date = active.~r~rContinue?",Question!,yesno!,2)
if r = 2 then return

string ls_sql


update pd_affil_staff_cat set requested = 0 where to_date is not null;
update pd_affil_staff_cat set requested = 1 where to_date is null;
commit using sqlca;

 r = 	messagebox("Requested","Do you want to update the status of records where there is no FROM or TO dates to 'Requested' status?",Question!,yesno!,2)
if r = 1 then 
	update pd_affil_staff_cat set requested = 2 where to_date is null and from_date is null;
	commit using sqlca;
end if

messagebox("Done"," Update Completed")
end event

type cb_bd_exp from commandbutton within w_utilities_old
integer x = 4325
integer y = 1640
integer width = 919
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "New Board/Specialty Fields"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.23.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
integer r
integer dvid
integer rc
integer v
integer find
integer vc
integer a
long fid = 9810 //expiration date

 r = 	messagebox("About","This function will Copy the new specialty exp date and certified fields to all views, and set the Bd/Spec expiration field to expiration date, and create expiration date data from certificate expires.~r~rContinue?",Question!,yesno!,2)
if r = 2 then return

SetPointer ( hourglass! )
debugbreak()
dw_data_view_list.settransobject(sqlca)
vc = dw_data_view_list.retrieve()
dw_dvfieldcopy.settransobject(sqlca)

for a = 1 to 2
	if a = 2 then fid = 9811 //board certified
	dw_dvfieldcopy.reset()
	rc = dw_dvfieldcopy.retrieve(fid)
	for v = 1 to vc  //go down list of views and add if not found
		dvid = dw_data_view_list.getitemnumber(v,"data_view_id")
		find = dw_dvfieldcopy.Find ( "data_view_id = " + string(dvid), 1, vc )
		if find < 0 then
			messagebox("","bad find")
			return
			end if
		if find = 0 then 
			dw_dvfieldcopy.rowscopy(1,1,primary!,dw_dvfieldcopy,1000,primary!)
			dw_dvfieldcopy.setitem(dw_dvfieldcopy.rowcount(),"data_view_id",dvid)
		end if
	next
	dw_dvfieldcopy.update()
	commit using sqlca;
next
		

//update exp dv field
update data_view_screen set exp_field = 9810 where screen_id =  19;

//update exp data
update pd_board_specialty set expiration_date = string(certification_expires) + '-12-30' + ' 00:00:00' where certification_expires is not null and expiration_date is null;

//update certified
update pd_board_specialty set board_certified = 581 where board_code is not null;
update pd_board_specialty set board_certified = 582 where board_code is null;
*/
integer r
integer dvid
integer rc
integer v
integer find
integer vc
integer a
long fid = 9810 //expiration date

r = messagebox("About","This function will Copy the new specialty exp date and certified fields to all views, and set the Bd/Spec expiration field to expiration date, and create expiration date data from certificate expires.~r~rContinue?",Question!,yesno!,2)
if r = 2 then return

SetPointer ( hourglass! )
debugbreak()
dw_data_view_list.settransobject(sqlca)
vc = dw_data_view_list.retrieve()
dw_dvfieldcopy.settransobject(sqlca)

for a = 1 to 2
	if a = 2 then fid = 9811 //board certified
	dw_dvfieldcopy.reset()
	rc = dw_dvfieldcopy.retrieve(fid)
	for v = 1 to vc  //go down list of views and add if not found
		dvid = dw_data_view_list.getitemnumber(v,"data_view_id")
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04.01.2006 By: LiuHongXin
		//$<reason> Fix a defect.
		/*
		find = dw_dvfieldcopy.Find ( "data_view_id = " + string(dvid), 1, vc )
		*/
		find = dw_dvfieldcopy.Find ( "data_view_id = " + string(dvid), 1, rc )
		//---------------------------- APPEON END ----------------------------
		if find < 0 then
			messagebox("","bad find")
			return
			end if
		if find = 0 then 
			dw_dvfieldcopy.rowscopy(1,1,primary!,dw_dvfieldcopy,1000,primary!)
			dw_dvfieldcopy.setitem(dw_dvfieldcopy.rowcount(),"data_view_id",dvid)
		end if
	next
next

gnv_appeondb.of_startqueue( )
		
dw_dvfieldcopy.update()
commit using sqlca;

//update exp dv field
update data_view_screen set exp_field = 9810 where screen_id =  19;
//update exp data
update pd_board_specialty set expiration_date = convert(char(4),certification_expires) + '-12-30' + ' 00:00:00' where certification_expires is not null and expiration_date is null;
//update certified
update pd_board_specialty set board_certified = 581 where board_code is not null;
update pd_board_specialty set board_certified = 582 where board_code is null;

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

SetPointer ( arrow! )
messagebox("Done"," Update Completed")
end event

type cb_prem_utl from commandbutton within w_utilities_old
boolean visible = false
integer x = 4325
integer y = 1848
integer width = 923
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "iPrem Utilities"
end type

event clicked;integer res
//res = messagebox("This operation:","This utility will add missing facility committees to current appointments.  Used when committees have been added to a facility after the appointments were created.  ~rContinue?",question!,yesno!,2)

//Open(w_premium_sync)






end event

type cb_date_fields from commandbutton within w_utilities_old
integer x = 4329
integer y = 1952
integer width = 919
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add New Date Fields to Views"
end type

event clicked;integer r

// r = 	messagebox("About","This function will clear double quotes in all Credentialing Data screen labels and text items.~rContinue?",Question!,yesno!,2)
//if r = 2 then return
//
open(w_add_new_date_fields)


end event

type cb_caqh_fields from commandbutton within w_utilities_old
integer x = 4325
integer y = 1744
integer width = 919
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add CAQH Fields to Views"
end type

event clicked;integer r


open(w_caqh_add_fields)


end event

