$PBExportHeader$w_saved_report_user_access.srw
forward
global type w_saved_report_user_access from window
end type
type cbx_update from checkbox within w_saved_report_user_access
end type
type cb_2 from commandbutton within w_saved_report_user_access
end type
type cbx_2 from checkbox within w_saved_report_user_access
end type
type cbx_1 from checkbox within w_saved_report_user_access
end type
type st_1 from statictext within w_saved_report_user_access
end type
type dw_roles from datawindow within w_saved_report_user_access
end type
type cbx_access from checkbox within w_saved_report_user_access
end type
type dw_users from datawindow within w_saved_report_user_access
end type
type cb_cancel from commandbutton within w_saved_report_user_access
end type
type cb_save from commandbutton within w_saved_report_user_access
end type
type cb_1 from commandbutton within w_saved_report_user_access
end type
type dw_access from datawindow within w_saved_report_user_access
end type
type dw_report from datawindow within w_saved_report_user_access
end type
type gb_1 from groupbox within w_saved_report_user_access
end type
type gb_2 from groupbox within w_saved_report_user_access
end type
end forward

global type w_saved_report_user_access from window
integer width = 4064
integer height = 2388
boolean titlebar = true
string title = "Saved Report User Security"
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
global w_saved_report_user_access w_saved_report_user_access

type variables
long il_report = 0
integer il_runtype = 0
string is_user = 'ALL'
string is_type
end variables

on w_saved_report_user_access.create
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

on w_saved_report_user_access.destroy
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

event open;//Start Code Change ----06.24.2011 #V11 maha 
string ls_mess
string ls_report
string ls_user
string s
integer p
integer p2
long ll_report

//ls_mess = message.stringparm
////All*I@user1
//debugbreak()
//p = pos(ls_mess,"*",1)
//
//p2 = pos(ls_mess,"@",p) 
//
//ls_report = mid(ls_mess,1, p - 1)
//is_type =  mid(ls_mess, p + 1,1)
//ls_user = mid(ls_mess, p2 + 1 , len(ls_mess) - p2)
//
//If ls_report = "ALL" and ls_user = "ALL" then 
	il_runtype = 1
//elseif ls_report = "ALL" then
//	il_runtype = 2
//elseif  ls_user = "ALL" then 
//	il_runtype = 3
//else
//	il_runtype = 4
//end if


dw_users.SetTransObject(SQLCA)
dw_report.SetTransObject(SQLCA)
dw_access.SetTransObject(SQLCA)

dw_access.retrieve()
dw_report.Retrieve(gs_user_id)
dw_users.retrieve()

//if ls_report = "ALL" then
	il_report = 0
//	dw_report.Retrieve()
//else
//	ll_report = long(ls_report)
//	select view_name into :s from conv_view where view_id = :ll_report;
//	dw_report.insertrow(1)
//	dw_report.setitem(1,"view_name",s)
//	dw_report.setitem(1,"view_id", ll_report)
//	il_report = ll_report
//	dw_access.setfilter(  "report_id = " + string(il_report))
//	dw_access.filter()
//	dw_report.selectrow(1,true)
//end if

//if  ls_user = "ALL" then 
//	dw_users.retrieve()
//else
//	dw_users.insertrow(1)
//	dw_users.setitem(1, "user_id", ls_user)
//	is_user = ls_user
//	//dw_roles.enabled = False
//	dw_roles.visible = False  //Modified by Appeon long.zhang 03.30.2016 (BugL033004)
//	gb_2.visible = False //Added by Appeon long.zhang 03.30.2016 (BugL033004)
//	dw_access.setfilter(  'user_id = "' + ls_user + '"')
//	dw_access.filter()
//	dw_users.selectrow(1,true)
//end if







end event

type cbx_update from checkbox within w_saved_report_user_access
integer x = 1001
integer y = 76
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
end type

type cb_2 from commandbutton within w_saved_report_user_access
integer x = 3150
integer y = 60
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

s = "Click a report name to view existing Access records for that report."
s+= "~r~rClick a user id to view existing access for that user."
s+= "~r~rScan for Missing Access will add access records that have not yet been created and set them with the access indicated by the checkbox.~rNote: the scan will not change the access values for existing records."

Messagebox("About Report Access",s)
end event

type cbx_2 from checkbox within w_saved_report_user_access
integer x = 3063
integer y = 220
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

type cbx_1 from checkbox within w_saved_report_user_access
integer x = 2519
integer y = 220
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

type st_1 from statictext within w_saved_report_user_access
integer x = 2222
integer y = 200
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

type dw_roles from datawindow within w_saved_report_user_access
integer x = 1847
integer y = 64
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

type cbx_access from checkbox within w_saved_report_user_access
integer x = 503
integer y = 76
integer width = 398
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

type dw_users from datawindow within w_saved_report_user_access
integer x = 1851
integer y = 200
integer width = 366
integer height = 2104
integer taborder = 30
string title = "none"
string dataobject = "d_user_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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

type cb_cancel from commandbutton within w_saved_report_user_access
integer x = 3685
integer y = 60
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

type cb_save from commandbutton within w_saved_report_user_access
integer x = 3323
integer y = 60
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

type cb_1 from commandbutton within w_saved_report_user_access
integer x = 73
integer y = 64
integer width = 361
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Scan"
end type

event clicked; //Start Code Change ----03.16.2017 #V153 maha - copied from ireport security
long ll_r
long ll_u
long ll_report
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
		for ll_u = 1 to dw_users.rowcount()
			ls_user = dw_users.getitemstring(ll_u,"user_id")
			dw_access.setfilter(  'user_id = "' + ls_user + '"')
			dw_access.filter()
			dw_users.selectrow(0,false)
			dw_users.selectrow(ll_u,true)
			dw_users.scrolltorow(ll_u)
			ll_access = dw_access.rowcount()
			for ll_r = 1 to dw_report.rowcount()
				ll_report = dw_report.getitemnumber(ll_r,"srs_id")
				ls_name = dw_report.getitemstring(ll_r,"report_name")
				dw_report.selectrow(0,false)
				dw_report.selectrow(ll_r,true)
				dw_report.scrolltorow(ll_r)
				if isnull(ll_report) then 
					messagebox("Prompt","Report is null.")
					return
				end if
				li_find = dw_access.find( "srs_id = " + string(ll_report) , 1, ll_access)
				if li_find = 0 then
					nr = dw_access.insertrow(0)
					dw_access.setitem(nr,"user_id",ls_user)
					dw_access.setitem(nr,"srs_id",ll_report)
					//dw_access.setitem(nr,"report_type",is_type)
					dw_access.setitem(nr,"access_rights",li_access)
					dw_access.setitem(nr,"report_name",ls_name)
				elseif  li_find > 0 and lb_update then  //Start Code Change ----08.17.2011 #V11 maha - if set to update, modify the access setting.
					dw_access.setitem(li_find,"access_rights",li_access)
				end if
			next
		next

end choose
end event

type dw_access from datawindow within w_saved_report_user_access
integer x = 2222
integer y = 284
integer width = 1819
integer height = 2020
integer taborder = 20
string title = "none"
string dataobject = "d_user_saved_report_access"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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

type dw_report from datawindow within w_saved_report_user_access
integer x = 9
integer y = 200
integer width = 1838
integer height = 2104
integer taborder = 10
string title = "none"
string dataobject = "d_saved_reports_list_security"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long r
long ll_report

r = this.getclickedrow( )

if r < 1 then return

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
dw_users.selectrow(0,false)

ll_report = this.getitemnumber(r,"srs_id")

dw_access.setfilter(  "srs_id = " + string(ll_report))
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

type gb_1 from groupbox within w_saved_report_user_access
integer x = 23
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

type gb_2 from groupbox within w_saved_report_user_access
integer x = 1787
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

