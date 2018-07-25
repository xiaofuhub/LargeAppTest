$PBExportHeader$w_image_user_access.srw
forward
global type w_image_user_access from window
end type
type cbx_update from checkbox within w_image_user_access
end type
type cb_2 from commandbutton within w_image_user_access
end type
type cbx_2 from checkbox within w_image_user_access
end type
type cbx_1 from checkbox within w_image_user_access
end type
type st_1 from statictext within w_image_user_access
end type
type dw_roles from datawindow within w_image_user_access
end type
type cbx_access from checkbox within w_image_user_access
end type
type dw_users from datawindow within w_image_user_access
end type
type cb_cancel from commandbutton within w_image_user_access
end type
type cb_save from commandbutton within w_image_user_access
end type
type cb_1 from commandbutton within w_image_user_access
end type
type dw_access from datawindow within w_image_user_access
end type
type dw_report from datawindow within w_image_user_access
end type
type gb_1 from groupbox within w_image_user_access
end type
type gb_2 from groupbox within w_image_user_access
end type
end forward

global type w_image_user_access from window
integer width = 4155
integer height = 2392
boolean titlebar = true
string title = "User Image Security"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cbx_update cbx_update
cb_2 cb_2
cbx_2 cbx_2
cbx_1 cbx_1
st_1 st_1
dw_roles dw_roles
cbx_access cbx_access
dw_users dw_users
cb_cancel cb_cancel
cb_save cb_save
cb_1 cb_1
dw_access dw_access
dw_report dw_report
gb_1 gb_1
gb_2 gb_2
end type
global w_image_user_access w_image_user_access

type variables
long il_report = 0
integer il_runtype = 0
string is_user = 'ALL'
string is_type
end variables

on w_image_user_access.create
this.cbx_update=create cbx_update
this.cb_2=create cb_2
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.st_1=create st_1
this.dw_roles=create dw_roles
this.cbx_access=create cbx_access
this.dw_users=create dw_users
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.cb_1=create cb_1
this.dw_access=create dw_access
this.dw_report=create dw_report
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cbx_update,&
this.cb_2,&
this.cbx_2,&
this.cbx_1,&
this.st_1,&
this.dw_roles,&
this.cbx_access,&
this.dw_users,&
this.cb_cancel,&
this.cb_save,&
this.cb_1,&
this.dw_access,&
this.dw_report,&
this.gb_1,&
this.gb_2}
end on

on w_image_user_access.destroy
destroy(this.cbx_update)
destroy(this.cb_2)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.dw_roles)
destroy(this.cbx_access)
destroy(this.dw_users)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.cb_1)
destroy(this.dw_access)
destroy(this.dw_report)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;//Start Code Change ----08.24.2011 #V12 maha -Created copied from iReport security window
string ls_mess
string ls_report
string ls_user
string s
integer p
integer p2
long ll_report

ls_mess = message.stringparm
//All*I@user1
debugbreak()
p = pos(ls_mess,"*",1)

p2 = pos(ls_mess,"@",p) 

ls_report = mid(ls_mess,1, p - 1)
is_type =  mid(ls_mess, p + 1,1)
ls_user = mid(ls_mess, p2 + 1 , len(ls_mess) - p2)

If ls_report = "ALL" and ls_user = "ALL" then 
	il_runtype = 1
elseif ls_report = "ALL" then
	il_runtype = 2
elseif  ls_user = "ALL" then 
	il_runtype = 3
else
	il_runtype = 4
end if


dw_users.SetTransObject(SQLCA)
dw_report.SetTransObject(SQLCA)
dw_access.SetTransObject(SQLCA)

dw_access.retrieve()

if ls_report = "ALL" then
	il_report = 0
	dw_report.Retrieve()
else
	ll_report = long(ls_report)
	select image_type_description into :s from image_type where image_type_id = :ll_report;
	dw_report.insertrow(1)
	dw_report.setitem(1,"image_type_description",s)
	dw_report.setitem(1,"image_type_id", ll_report)
	il_report = ll_report
	dw_access.setfilter(  "image_type = " + string(il_report))
	dw_access.filter()
	dw_report.selectrow(1,true)
end if

if  ls_user = "ALL" then 
	dw_users.retrieve()
else
	dw_users.insertrow(1)
	dw_users.setitem(1, "user_id", ls_user)
	is_user = ls_user
	//dw_roles.enabled = False
	dw_roles.visible = False
	gb_2.visible = False //Added by Appeon long.zhang 03.30.2016 (BugL033004)
	dw_access.setfilter(  'user_id = "' + ls_user + '"')
	dw_access.filter()
	dw_users.selectrow(1,true)
end if

//---------Begin Modified by (Appeon)Stephen 05.19.2017 for Bug id 5648 - Message should read Image Type Security but reads IntelliReport SaaS, C/s Latest 15.3--------
/*
if of_get_app_setting("set_60","I") = 0 then
	messagebox("Security off","In order for the IntellReport User level security to be used in the system, it must be turned on the the Utilities->Application settings.")
end if
*/
if of_get_app_setting("set_69","I") = 0 then
	messagebox("Security off","In order for the Image Type User level security to be used in the system, it must be turned on the the Utilities->Application settings.")
end if
//---------End Modfiied ------------------------------------------------------


end event

type cbx_update from checkbox within w_image_user_access
integer x = 997
integer y = 84
integer width = 645
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Update existing records"
boolean checked = true
end type

type cb_2 from commandbutton within w_image_user_access
integer x = 3227
integer y = 68
integer width = 146
integer height = 92
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

s = "Click an Image Type to view existing Access records for that type."
s+= "~r~rClick a user id to view existing access for that user."
s+= "~r~rScan for Missing Access will add access records that have not yet been created and set them with the access indicated by the checkbox.~rNote: the scan will not change the access values for existing records unless Update Existing Records is Checked."

Messagebox("About Report Access",s)
end event

type cbx_2 from checkbox within w_image_user_access
integer x = 3154
integer y = 248
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
boolean enabled = false
string text = "No Access"
end type

type cbx_1 from checkbox within w_image_user_access
integer x = 2610
integer y = 248
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
boolean enabled = false
string text = "Access"
boolean checked = true
end type

type st_1 from statictext within w_image_user_access
integer x = 2313
integer y = 232
integer width = 1819
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_roles from datawindow within w_image_user_access
integer x = 1801
integer y = 72
integer width = 608
integer height = 88
integer taborder = 30
string title = "none"
string dataobject = "d_role_select"
boolean border = false
boolean livescroll = true
end type

event constructor;datawindowchild dwchild

this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)

this.getchild("role_id",dwchild)
dwchild.insertrow(1)
dwchild.setitem(1,"role_id",0)
dwchild.setitem(1,"role_name","All")

end event

event itemchanged;string r,s

r = data

if data = "0" then
	s = ""
else
	s = "role_id = " + data
end if

dw_users.setfilter(s)
dw_users.filter()
end event

type cbx_access from checkbox within w_image_user_access
integer x = 503
integer y = 84
integer width = 393
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Set Access as:"
boolean checked = true
boolean lefttext = true
end type

type dw_users from datawindow within w_image_user_access
integer x = 1838
integer y = 228
integer width = 457
integer height = 2072
integer taborder = 30
string title = "none"
string dataobject = "d_user_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;Integer li_value
Long i,ll_cnt
If dwo.name = 'b_select' Then
	ll_cnt = dw_users.Rowcount()
	If dw_users.describe('b_select.text') = 'Select All' Then
		dw_users.Modify("b_select.text = 'Deselect All'")
		li_value = 1
	Else
		dw_users.Modify("b_select.text = 'Select All'")		
		li_value = 0
	End If
	For i = 1 To ll_cnt
		dw_users.setitem(i,"access_rights",li_value)
	Next
	
End If
end event

event clicked;long r
string ls_user

r = this.getclickedrow( )

if r < 1 then return

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
dw_report.selectrow(0,false)

ls_user = this.getitemstring(r,"user_id")
is_user = ls_user

dw_access.setfilter(  'user_id = "' + ls_user + '"')
dw_access.filter()
dw_access.sort()

end event

type cb_cancel from commandbutton within w_image_user_access
integer x = 3749
integer y = 68
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_save from commandbutton within w_image_user_access
integer x = 3392
integer y = 68
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;dw_access.update()

end event

type cb_1 from commandbutton within w_image_user_access
integer x = 73
integer y = 72
integer width = 361
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Scan"
end type

event clicked;long ll_r
long ll_u
long ll_type
long ll_access
long nr
long li_find
string ls_user
string ls_name
integer li_access
boolean lb_update



if cbx_access.checked then 
	li_access = 1 
else
	li_access = 0
end if

if cbx_update.checked then 
	lb_update = true
else
	lb_update = false
end if

choose case il_runtype
	case 1,2	
		//for each user
		for ll_u = 1 to dw_users.rowcount()
			ls_user = dw_users.getitemstring(ll_u,"user_id")
			dw_access.setfilter(  'user_id = "' + ls_user + '"')
			dw_access.filter()  //filter the access
			dw_users.selectrow(0,false)
			dw_users.selectrow(ll_u,true)
			dw_users.scrolltorow(ll_u)
			ll_access = dw_access.rowcount()
			for ll_r = 1 to dw_report.rowcount()
				ll_type = dw_report.getitemnumber(ll_r,"image_type_id")
				ls_name = dw_report.getitemstring(ll_r,"image_type_description")
				dw_report.selectrow(0,false)
				dw_report.selectrow(ll_r,true)
				dw_report.scrolltorow(ll_r)
				if isnull(ll_type) then 
					messagebox("???","Report is null.")
					return
				end if
				li_find = dw_access.find( "image_type = " + string(ll_type) , 1, ll_access)
//				li_find = dw_access.find( "image_type = " + string(ll_type)  " and user_id = '" + ls_user + "'", 1, ll_access)
				if li_find = 0 then
					nr = dw_access.insertrow(0)
					dw_access.setitem(nr,"user_id",ls_user)
					dw_access.setitem(nr,"image_type",ll_type)
					dw_access.setitem(nr,"view_rights",li_access)
					dw_access.setitem(nr,"image_type_description",ls_name)
				elseif  li_find > 0 and lb_update then  //Start Code Change ----08.17.2011 #V11 maha - if set to update, modify the access setting.
					dw_access.setitem(li_find,"view_rights",li_access)  //Start Code Change ----05.06.2013 #V12 maha - corrected for appl error
				end if
			next
		next
	case 3
		for ll_r = 1 to dw_report.rowcount()
			ll_type = dw_report.getitemnumber(ll_r,"image_type_id")
			ls_name = dw_report.getitemstring(ll_r,"image_type_description")
			dw_report.selectrow(0,false)
			dw_report.selectrow(ll_r,true)
			dw_report.scrolltorow(ll_r)
			dw_access.setfilter("image_type = " + string(ll_type))
			dw_access.filter()
			ll_access = dw_access.rowcount()
			for ll_u = 1 to dw_users.rowcount()
				ls_user = dw_users.getitemstring(ll_u,"user_id")
				dw_users.selectrow(0,false)
				dw_users.selectrow(ll_u,true)
				dw_users.scrolltorow(ll_u)
				li_find = dw_access.find( 'user_id = "' + ls_user + '"' , 1, ll_access)
				if li_find = 0 then
					nr = dw_access.insertrow(0)
					dw_access.setitem(nr,"user_id",ls_user)
					dw_access.setitem(nr,"image_type",ll_type)
					dw_access.setitem(nr,"view_rights",li_access)
					dw_access.setitem(nr,"image_type_description",ls_name)
				elseif  li_find > 0 and lb_update then  //Start Code Change ----04.15.2016 #V15 maha- if set to update, modify the access setting.
					dw_access.setitem(li_find,"view_rights",li_access)  
				end if
			next
		next
		
end choose
end event

type dw_access from datawindow within w_image_user_access
integer x = 2313
integer y = 312
integer width = 1819
integer height = 1988
integer taborder = 20
string title = "none"
string dataobject = "d_security_user_images"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;Integer li_value
Long i,ll_cnt
If dwo.name = 'b_select' Then
	ll_cnt = this.Rowcount()
	If this.describe('b_select.text') = 'Select All' Then
		this.Modify("b_select.text = 'Deselect All'")
		li_value = 1
	Else
		this.Modify("b_select.text = 'Select All'")		
		li_value = 0
	End If
	For i = 1 To ll_cnt
		this.setitem(i,"access_rights",li_value)
	Next
	
End If
end event

type dw_report from datawindow within w_image_user_access
integer x = 14
integer y = 228
integer width = 1801
integer height = 2072
integer taborder = 10
string title = "none"
string dataobject = "d_image_types_security"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long r
long ll_report

r = this.getclickedrow( )

if r < 1 then return

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
dw_users.selectrow(0,false)

ll_report = this.getitemnumber(r,"image_type_id")

dw_access.setfilter(  "image_type = " + string(ll_report))
dw_access.filter()
dw_access.sort()
end event

event rowfocuschanged;//
//this.selectrow(0,false)
//this.selectrow(currentrow, true)
//
//il_report = this.getitemnumber(currentrow,"view_id")
//
//dw_access.setfilter(  "report_id = " + string(il_report))
//dw_access.filter()
//
////dw_users.retrieve(il_report)
end event

type gb_1 from groupbox within w_image_user_access
integer x = 23
integer y = 8
integer width = 1637
integer height = 184
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Scan for Missing Access Records "
end type

type gb_2 from groupbox within w_image_user_access
integer x = 1742
integer y = 8
integer width = 713
integer height = 184
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Role filter "
end type

