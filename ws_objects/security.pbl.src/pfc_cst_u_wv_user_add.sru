$PBExportHeader$pfc_cst_u_wv_user_add.sru
forward
global type pfc_cst_u_wv_user_add from pfc_cst_u_security_user_painter
end type
type rb_123 from radiobutton within pfc_cst_u_wv_user_add
end type
type rb_ssn from radiobutton within pfc_cst_u_wv_user_add
end type
type cb_set from commandbutton within pfc_cst_u_wv_user_add
end type
type rb_random from radiobutton within pfc_cst_u_wv_user_add
end type
type rb_name from radiobutton within pfc_cst_u_wv_user_add
end type
type st_new from statictext within pfc_cst_u_wv_user_add
end type
type cb_image_sec from commandbutton within pfc_cst_u_wv_user_add
end type
type dw_all_view from datawindow within pfc_cst_u_wv_user_add
end type
type cb_continue from commandbutton within pfc_cst_u_wv_user_add
end type
type cb_getname from commandbutton within pfc_cst_u_wv_user_add
end type
type cb_options from commandbutton within pfc_cst_u_wv_user_add
end type
type cb_resetuser from commandbutton within pfc_cst_u_wv_user_add
end type
type gb_1 from groupbox within pfc_cst_u_wv_user_add
end type
end forward

global type pfc_cst_u_wv_user_add from pfc_cst_u_security_user_painter
integer width = 2789
integer height = 2120
rb_123 rb_123
rb_ssn rb_ssn
cb_set cb_set
rb_random rb_random
rb_name rb_name
st_new st_new
cb_image_sec cb_image_sec
dw_all_view dw_all_view
cb_continue cb_continue
cb_getname cb_getname
cb_options cb_options
cb_resetuser cb_resetuser
gb_1 gb_1
end type
global pfc_cst_u_wv_user_add pfc_cst_u_wv_user_add

type variables
long il_pracid
long il_facility
string is_user
window iw_window

end variables

forward prototypes
public function integer of_set_prac (string as_data)
public function integer of_set_rb (integer ai_which)
end prototypes

public function integer of_set_prac (string as_data);integer p
integer i
string ls_full
string ls_last
string ls_first
string ls_user

p = pos(as_data,"@",1)

il_pracid = long(mid(as_data, 1, p -1))
il_facility = long(mid(as_data,  p +1, len(as_data) - p)) //facility value not being used

select full_name, last_name, first_name into :ls_full, :ls_last, :ls_first from v_full_name where prac_id = :il_pracid;

iw_window.title = "User setup for practitioner: " + ls_full

select count(user_id) into :p from security_users where prac_id = :il_pracid;

select default_prac_pw_option into :i from security_settings;
if isnull(i) then i = 0

if p > 0 then  //if user record exists
	dw_roles.retrieve(il_pracid)
	ls_user = dw_roles.getitemstring(1,"user_id")
	dw_facility.retrieve(ls_user)
	dw_views.retrieve(ls_user)
	st_new.text = "Existing User"
	cb_image_sec.enabled = true //alfee 11.28.2014
	//cb_set.enabled = false
	cb_set.visible = false   //Start Code Change ----02.01.2017 #V153 maha - changed from enabled
	if w_mdi.of_security_access(7796) = 1 then
		cb_resetuser.visible = true
	else
		cb_resetuser.visible = false
		 //Start Code Change ----08.08.2016 #V152 maha - added expiration date
		 //---------Begin Modified by (Appeon)Stephen 12.06.2017 for V15.4 WebView Bug # 5899 --------
		/*
		dw_roles.modify("expiration_date.protect = '1' ") 
		dw_roles.modify("expiration_date.background.color = '15987699' ") 
		*/
		dw_roles.modify("last_pass_update.protect = '1' ") 
		dw_roles.modify("last_pass_update.background.color = '15987699' ") 
		//---------End Modfiied ------------------------------------------------------
		 //End Code Change ----08.08.2016
	end if
	dw_roles.modify("user_id.protect = '1' ")  //Start Code Change ----04.29.2015 #V15 maha
else //new user
	dw_roles.setitem(1, "prac_id", il_pracid)
	ls_user = leftA(ls_first,1) + ls_last
	ls_user = of_create_password( "ILAST", il_pracid, ls_user) //Start Code Change ----02.14.2013 #V12 maha
	//ls_user = of_strip_char("", ls_user, "@USERNAME@")  
	ls_user = lower(ls_user)
	if len(ls_user) > 10 then ls_user = mid(ls_user,1,10)  //Start Code Change ----02.26.2013 #V12 maha changed to 10 (this is redundant as the function set it to 10)
	select count(user_id) into :p from security_users where user_id = :ls_user;
	
	if p > 0 then
		messagebox("User exists","The user name " + ls_user + " currently exists.  Please manually create another or click the options button.")
	else
		dw_roles.setitem(1, "user_id", ls_user)
	end if
		
	dw_roles.setitem(1, "user_name", ls_first + " " + ls_last )
	//set default role and audit type
	dw_roles.setitem(1, "wv_role_id", 4)
	dw_roles.setitem(1, "audit_type", 2 )
	dw_roles.Setitem( 1, "image_flag", "0")
	dw_roles.Setitem( 1, "active_status", 1)
	dw_roles.Setitem( 1, "read_only", 0)
	cb_set.triggerevent(clicked!) //for password
	cb_continue.visible = true
	cb_options.visible = true
	cb_image_sec.enabled = false //alfee 11.28.2014
	cb_resetuser.visible = false
end if

dw_roles.enabled = true
is_user = ls_user    //Start Code Change ----02.14.2013 #V12 maha
dw_select_user.setitem( 1,'user_id',ls_user)//added by long.zhang appeon 03.22.2013 alpha test 3458

 //Start Code Change ----02.21.2017 #V153 maha
 of_set_rb(i)

 

return 1




end function

public function integer of_set_rb (integer ai_which); //Start Code Change ----02.21.2017 #V153 maha - added; called from of_set_prac
choose case ai_which
	case 0
		rb_123.checked = true
		rb_ssn.checked = false
		rb_name.checked = false
		rb_random.checked = false
	case 1
		rb_123.checked = false
		rb_ssn.checked = true
		rb_name.checked = false
		rb_random.checked = false
	case 2
		rb_123.checked = false
		rb_ssn.checked = false
		rb_name.checked = true
		rb_random.checked = false
	case 3
		rb_123.checked = false
		rb_ssn.checked = false
		rb_name.checked = false
		rb_random.checked = true
end choose
		
return 1
		
end function

on pfc_cst_u_wv_user_add.create
int iCurrent
call super::create
this.rb_123=create rb_123
this.rb_ssn=create rb_ssn
this.cb_set=create cb_set
this.rb_random=create rb_random
this.rb_name=create rb_name
this.st_new=create st_new
this.cb_image_sec=create cb_image_sec
this.dw_all_view=create dw_all_view
this.cb_continue=create cb_continue
this.cb_getname=create cb_getname
this.cb_options=create cb_options
this.cb_resetuser=create cb_resetuser
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_123
this.Control[iCurrent+2]=this.rb_ssn
this.Control[iCurrent+3]=this.cb_set
this.Control[iCurrent+4]=this.rb_random
this.Control[iCurrent+5]=this.rb_name
this.Control[iCurrent+6]=this.st_new
this.Control[iCurrent+7]=this.cb_image_sec
this.Control[iCurrent+8]=this.dw_all_view
this.Control[iCurrent+9]=this.cb_continue
this.Control[iCurrent+10]=this.cb_getname
this.Control[iCurrent+11]=this.cb_options
this.Control[iCurrent+12]=this.cb_resetuser
this.Control[iCurrent+13]=this.gb_1
end on

on pfc_cst_u_wv_user_add.destroy
call super::destroy
destroy(this.rb_123)
destroy(this.rb_ssn)
destroy(this.cb_set)
destroy(this.rb_random)
destroy(this.rb_name)
destroy(this.st_new)
destroy(this.cb_image_sec)
destroy(this.dw_all_view)
destroy(this.cb_continue)
destroy(this.cb_getname)
destroy(this.cb_options)
destroy(this.cb_resetuser)
destroy(this.gb_1)
end on

type cb_cvo from pfc_cst_u_security_user_painter`cb_cvo within pfc_cst_u_wv_user_add
end type

type cb_ad from pfc_cst_u_security_user_painter`cb_ad within pfc_cst_u_wv_user_add
end type

type cb_h2 from pfc_cst_u_security_user_painter`cb_h2 within pfc_cst_u_wv_user_add
end type

type cb_batch_provd from pfc_cst_u_security_user_painter`cb_batch_provd within pfc_cst_u_wv_user_add
integer x = 1385
integer y = 4
end type

type cb_2 from pfc_cst_u_security_user_painter`cb_2 within pfc_cst_u_wv_user_add
end type

type cb_reset from pfc_cst_u_security_user_painter`cb_reset within pfc_cst_u_wv_user_add
integer x = 2821
integer y = 208
integer taborder = 170
end type

type cb_setup_ctx from pfc_cst_u_security_user_painter`cb_setup_ctx within pfc_cst_u_wv_user_add
integer x = 2834
integer taborder = 120
end type

type cb_h1 from pfc_cst_u_security_user_painter`cb_h1 within pfc_cst_u_wv_user_add
integer x = 786
integer y = 36
end type

type cb_image_security from pfc_cst_u_security_user_painter`cb_image_security within pfc_cst_u_wv_user_add
boolean visible = false
integer x = 2834
integer y = 220
integer taborder = 80
end type

type cb_security from pfc_cst_u_security_user_painter`cb_security within pfc_cst_u_wv_user_add
integer x = 82
integer y = 2484
integer taborder = 280
end type

type cb_ldap from pfc_cst_u_security_user_painter`cb_ldap within pfc_cst_u_wv_user_add
integer x = 882
integer y = 36
integer width = 475
integer taborder = 10
end type

type cb_email from pfc_cst_u_security_user_painter`cb_email within pfc_cst_u_wv_user_add
integer x = 521
integer y = 2344
integer taborder = 130
end type

type cb_copy from pfc_cst_u_security_user_painter`cb_copy within pfc_cst_u_wv_user_add
integer x = 1413
integer y = 2696
integer taborder = 90
end type

type dw_departments from pfc_cst_u_security_user_painter`dw_departments within pfc_cst_u_wv_user_add
integer x = 2395
integer y = 2568
integer taborder = 140
end type

type cb_sad from pfc_cst_u_security_user_painter`cb_sad within pfc_cst_u_wv_user_add
integer x = 2647
integer y = 2580
integer taborder = 310
end type

type st_view from pfc_cst_u_security_user_painter`st_view within pfc_cst_u_wv_user_add
integer x = 1490
integer y = 1072
end type

type dw_department from pfc_cst_u_security_user_painter`dw_department within pfc_cst_u_wv_user_add
integer x = 2217
integer y = 2540
integer taborder = 260
end type

type cb_sav from pfc_cst_u_security_user_painter`cb_sav within pfc_cst_u_wv_user_add
integer x = 2400
integer y = 1056
integer taborder = 320
end type

type cb_saf from pfc_cst_u_security_user_painter`cb_saf within pfc_cst_u_wv_user_add
integer x = 1061
integer y = 1064
integer taborder = 300
end type

type dw_facility from pfc_cst_u_security_user_painter`dw_facility within pfc_cst_u_wv_user_add
integer x = 23
integer y = 1140
integer width = 1413
integer height = 932
integer taborder = 250
string dataobject = "d_wv_security_user_facility_access"
end type

type cb_save from pfc_cst_u_security_user_painter`cb_save within pfc_cst_u_wv_user_add
integer x = 2048
integer y = 40
integer width = 347
integer taborder = 30
boolean default = false
end type

event cb_save::clicked;String	ls_UserId
long f
long cnt = 0
integer res

debugbreak()
ls_UserId = dw_roles.GetItemString(1,'user_id')

if IsNull(ls_UserId) or Trim(ls_UserId) = '' then return

If dw_roles.Rowcount( ) > 0 Then
	dw_roles.Accepttext( )
	
	String ls_image_flag
	ls_image_flag = dw_roles.Getitemstring( 1, "image_flag")
	IF Isnull(ls_image_flag) THEN
		dw_roles.Setitem( 1, "image_flag", "0")
	End If
End If

for f = 1 to dw_facility.rowcount( )
	if dw_facility.getitemnumber ( f , "access_rights") = 1 then cnt++
next

//messagebox("",cnt)

if cnt = 0 then
	messagebox("Facility Access","Please select the appropriate Facility access.")
	return -1
end if

select max(rec_id) into :il_audit_id from sys_audit_user;

res = dw_facility.update()
res = dw_views.update()
res = dw_roles.update()



end event

type cb_delete from pfc_cst_u_security_user_painter`cb_delete within pfc_cst_u_wv_user_add
integer x = 1394
integer y = 2596
integer taborder = 180
end type

type dw_select_user from pfc_cst_u_security_user_painter`dw_select_user within pfc_cst_u_wv_user_add
integer x = 133
integer y = 2592
integer taborder = 50
end type

type cb_new from pfc_cst_u_security_user_painter`cb_new within pfc_cst_u_wv_user_add
integer x = 270
integer y = 2684
integer taborder = 200
end type

type dw_views from pfc_cst_u_security_user_painter`dw_views within pfc_cst_u_wv_user_add
integer x = 1445
integer y = 1140
integer width = 1294
integer height = 932
integer taborder = 240
string dataobject = "d_wv_security_user_views_access"
end type

type st_1 from pfc_cst_u_security_user_painter`st_1 within pfc_cst_u_wv_user_add
integer x = 46
integer y = 1072
end type

type st_department from pfc_cst_u_security_user_painter`st_department within pfc_cst_u_wv_user_add
integer x = 2254
integer y = 2660
end type

type cb_close from pfc_cst_u_security_user_painter`cb_close within pfc_cst_u_wv_user_add
integer x = 2395
integer y = 36
integer width = 366
integer taborder = 60
end type

event cb_close::clicked;Close( iw_window )
end event

type cb_print from pfc_cst_u_security_user_painter`cb_print within pfc_cst_u_wv_user_add
integer x = 2720
integer y = 2524
integer taborder = 270
end type

type gb_select from pfc_cst_u_security_user_painter`gb_select within pfc_cst_u_wv_user_add
integer x = 1742
integer y = 2544
integer width = 306
integer taborder = 100
end type

type gb_main from pfc_cst_u_security_user_painter`gb_main within pfc_cst_u_wv_user_add
integer x = 5
integer y = 992
integer width = 2766
integer height = 1108
integer taborder = 210
end type

type dw_audit from pfc_cst_u_security_user_painter`dw_audit within pfc_cst_u_wv_user_add
integer x = 663
integer y = 2592
integer taborder = 290
end type

type dw_roles from pfc_cst_u_security_user_painter`dw_roles within pfc_cst_u_wv_user_add
integer x = 5
integer y = 396
integer width = 2738
integer height = 580
integer taborder = 220
string dataobject = "d_security_user_setup_4_wv"
end type

event dw_roles::buttonclicked;call super::buttonclicked; //Start Code Change ----04.29.2015 #V15 maha
string ls_copy

if dwo.name = "b_copy" then
	ls_copy = this.getitemstring(row,"user_id")
	clipboard(ls_copy)
end if

end event

type gb_sec from pfc_cst_u_security_user_painter`gb_sec within pfc_cst_u_wv_user_add
integer x = 0
integer y = 340
integer width = 2761
integer height = 640
integer taborder = 230
end type

type cb_4 from pfc_cst_u_security_user_painter`cb_4 within pfc_cst_u_wv_user_add
integer x = 1627
integer y = 40
end type

type rb_123 from radiobutton within pfc_cst_u_wv_user_add
integer x = 105
integer y = 220
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "123"
boolean checked = true
end type

type rb_ssn from radiobutton within pfc_cst_u_wv_user_add
integer x = 398
integer y = 216
integer width = 430
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "last 4 of SSN"
end type

type cb_set from commandbutton within pfc_cst_u_wv_user_add
integer x = 1746
integer y = 192
integer width = 338
integer height = 84
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Set"
end type

event clicked;string pw
string ls_user
long ll_prac

ls_user = dw_roles.getitemstring(1,"user_id")
ll_prac = dw_roles.getitemnumber(1,"prac_id")

if rb_123.checked then
	pw = "123"
elseif rb_ssn.checked then
	pw = "SSN"
elseif rb_random.checked then
	pw = "RAND"
elseif rb_name.checked then
	pw = "NAME"
end if


pw = of_create_password( pw,ll_prac, ls_user)
if pw <> "-1" then
	dw_roles.setitem(1, "user_password", pw)
end if
end event

type rb_random from radiobutton within pfc_cst_u_wv_user_add
integer x = 1367
integer y = 212
integer width = 297
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Random"
end type

type rb_name from radiobutton within pfc_cst_u_wv_user_add
integer x = 919
integer y = 212
integer width = 370
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "User Name"
end type

type st_new from statictext within pfc_cst_u_wv_user_add
integer x = 46
integer y = 32
integer width = 745
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "New User"
boolean focusrectangle = false
end type

type cb_image_sec from commandbutton within pfc_cst_u_wv_user_add
integer x = 1394
integer y = 36
integer width = 631
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Image Type User Security"
end type

event clicked;//string s
//
//s = "ALL*S@" + is_user
//openwithparm(w_image_user_access,s)

//alfee 11.28.2014 - for CRITICAL - Allegheny issues
string s, ls_UserId

IF dw_roles.GetRow () < 1 THEN RETURN

ls_UserId = dw_roles.GetItemString(dw_roles.GetRow(), 'user_id')
IF IsNull(ls_UserId) OR Trim(ls_UserId) = '' THEN RETURN
	
s = "ALL*S@" + ls_UserId
OpenWithParm(w_image_user_access,s)
end event

type dw_all_view from datawindow within pfc_cst_u_wv_user_add
boolean visible = false
integer x = 901
integer y = 36
integer width = 78
integer height = 84
integer taborder = 110
string title = "none"
string dataobject = "ds_dataview_all"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_continue from commandbutton within pfc_cst_u_wv_user_add
boolean visible = false
integer x = 2048
integer y = 36
integer width = 347
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Continue"
end type

event clicked;integer p
integer res
long fc
long vc
long ll_facil
long ll_view
long ll_view_phone
long li_rec_id
long li_rc
string ls_user
debugbreak()
if this.text = "Continue" then
	//check for user name and missing data
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 02.06.2015
	//<$>reason:Allegheny webview user creation
	if isnull(dw_roles.getitemstring(1,"user_id")) or trim(dw_roles.getitemstring(1,"user_id")) = '' then
		messagebox("WebView Role","Please select an User Id")
		return
	end if
	is_user = dw_roles.getitemstring(1, "user_id")
	//------------------- APPEON END -------------------
	
	//ls_user = dw_roles.getitemstring(1, "user_id")
	ls_user = is_user    //Start Code Change ----02.14.2013 #V12 maha
	
	select count(user_id) into :p from security_users where user_id = :ls_user;
	if p > 0 then
		messagebox("User exists","The user name " + ls_user + " currently exists.  Please manually create another.")
		return
	end if
	
	ll_view = dw_roles.getitemnumber(1,"default_view")
	if isnull( ll_view ) then
		messagebox("WebView View","Please select a Webview View")
		return
	end if
	//---------Begin Added by (Appeon)Harry 08.14.2015 for phone of webview--------
	ll_view_phone = dw_roles.getitemnumber(1,"default_view_phone")
	if isnull( ll_view_phone ) then
		messagebox("WebView View","Please select a Webview View for phone")
		return
	end if
	//---------End Added ------------------------------------------------------
	
	if isnull(dw_roles.getitemnumber(1,"wv_role_id")) then
		messagebox("WebView Role","Please select a Webview Role")
		return
	end if
	
	if isnull(dw_roles.getitemnumber(1,"audit_type")) then
		messagebox("WebView Audit Type","Please select a Webview Audit Type")
		return
	end if
	
	
	dw_roles.setitem(1,"read_only", 0)  //Start Code Change ----05.30.2014 #V14.2 maha
	//save record
	res = dw_roles.update()
	
	cb_options.visible = false //Added by Appeon long.zhang 02.06.2015 (Allegheny webview user creation)
	
	//get facility and view counts
	fc = ids_facility.rowcount()
	vc = dw_all_view.retrieve()
	
	
	//create facility records
	li_rec_id = gnv_app.of_get_id( "user_facility_id" ,fc) - 1
	
	for p = 1 to fc
		dw_facility.insertrow(p)
		ll_facil = ids_facility.getitemnumber(p,"facility_id")
		dw_facility.setitem(p,"access_rights",0)
		dw_facility.setitem(p,"user_id",ls_user)
		dw_facility.setitem(p,"facility_id",ll_facil)
		li_rec_id ++
		dw_facility.setitem(p,"user_facility_id",li_rec_id)
	next
	
	//create view records
	li_rec_id = gnv_app.of_get_id( "user_view_id" ,vc) - 1
	
	for p = 1 to vc
		li_rec_id ++
		dw_views.InsertRow( 0 )
		dw_views.SetItem( p, "user_view_id", li_rec_id )
		dw_views.setitem(p,"access_rights",0)
		dw_views.setitem(p,"user_id",ls_user)
		dw_views.SetItem( p, "view_id", dw_all_view.GetItemNumber( p, "data_view_id" ) )	
	next
	
	//set view rights based on default view
	p = dw_views.find("view_id = " + string(ll_view), 1 , vc)
	if p > 0 then
		dw_views.setitem(p,"access_rights",1)
	end if
	
	//---------Begin Added by (Appeon)Harry 08.14.2015 for phone of webview--------
	p = dw_views.find("view_id = " + string(ll_view_phone), 1 , vc)
	if p > 0 then
		dw_views.setitem(p,"access_rights",1)
	end if
	//---------End Added ------------------------------------------------------
	
	//debugbreak()
	//save and reretrieve the settings
	res = dw_facility.update()
	res = dw_views.update()
	
	res = dw_facility.retrieve(ls_user)
	res = dw_views.retrieve(ls_user)
	
	this.text = "Save"

else //save

	String	ls_UserId
	long f
	long cnt = 0

	ls_UserId = dw_roles.GetItemString(1,'user_id')
	
	if IsNull(ls_UserId) or Trim(ls_UserId) = '' then return
	
	If dw_roles.Rowcount( ) > 0 Then
		dw_roles.Accepttext( )
		
		String ls_image_flag
		ls_image_flag = dw_roles.Getitemstring( 1, "image_flag")
		IF Isnull(ls_image_flag) THEN
			dw_roles.Setitem( 1, "image_flag", "0")
		End If
	End If
	
	for f = 1 to dw_facility.rowcount( )
		if dw_facility.getitemnumber ( f , "access_rights") = 1 then cnt++
	next
	
	if cnt = 0 then
		messagebox("Facility Access","Please select the appropriate Facility access.")
		return -1
	end if
	
	select max(rec_id) into :il_audit_id from sys_audit_user;
	
	res = dw_facility.update()
	res = dw_views.update()
	res = dw_roles.update()
	cb_image_sec.enabled = true //alfee 11.28.2014
end if
	



end event

type cb_getname from commandbutton within pfc_cst_u_wv_user_add
integer x = 325
integer y = 480
integer width = 293
integer height = 76
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy"
end type

event clicked; //Start Code Change ----05.18.2015 #V15 maha - added because the copy in button clicked did not work.
string ls_copy

ls_copy = dw_roles.getitemstring(1,"user_id")
clipboard(ls_copy)

end event

type cb_options from commandbutton within pfc_cst_u_wv_user_add
boolean visible = false
integer x = 320
integer y = 480
integer width = 293
integer height = 76
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Options"
end type

event clicked;//Start Code Change ----01.26.2012 #V12 maha
long ll_prac
string ls_user
string ls_name
integer cnt

ls_user = dw_roles.getitemstring(1, "user_id")
ll_prac = dw_roles.getitemnumber(1, "prac_id")	

openwithparm(w_security_set_user, ls_user + "@" + string(ll_prac))

ls_name = message.stringparm

if ls_name = "CANCEL" then
	return
else
	select count(user_id) into :cnt from security_users where user_id = :ls_name;
	if cnt  > 0 then
		messagebox("Set user name","A user currently exists with the selected user format.")
		return
	else
		 dw_roles.setitem(1, "user_id", ls_name)
	end if
end if
end event

type cb_resetuser from commandbutton within pfc_cst_u_wv_user_add
integer x = 1746
integer y = 192
integer width = 613
integer height = 84
integer taborder = 200
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset User Password"
end type

event clicked;string pw
string ls_user
long ll_prac
datetime ldt_null
datetime ldt_exp //maha 08.08.2016
integer r
integer ll_days //maha 08.08.2016

r = messagebox("Reset user password","This will reset the temporary password, clear the lockout, and reset to Active.  Continue?", question!, yesno!, 2)

setnull(ldt_null)

ls_user = dw_roles.getitemstring(1,"user_id")
ll_prac = dw_roles.getitemnumber(1,"prac_id")

if rb_123.checked then
	pw = "123"
elseif rb_ssn.checked then
	pw = "SSN"
elseif rb_random.checked then
	pw = "RAND"
elseif rb_name.checked then
	pw = "NAME"
end if

select default_prac_pw_reset_days into :ll_days from security_settings;   //Start Code Change ----08.08.2016 #V152 maha

pw = of_create_password( pw,ll_prac, ls_user)
if pw <> "-1" then
	dw_roles.setitem(1, "user_password", pw)
	dw_roles.setitem(1, "active_status", 1)
	dw_roles.setitem(1, "lock_until", ldt_null)
	//Start Code Change ----08.08.2016 #V152 maha
	if ll_days > 0 then
		ldt_exp = datetime( relativedate(today(), ll_days), time("59.59.59"))
		//---------Begin Modified by (Appeon)Stephen 12.05.2017 for V15.4 WebView Bug # 5899 --------
		//dw_roles.setitem(1, "expiration_date", ldt_exp)
		dw_roles.setitem(1, "last_pass_update", ldt_exp)
		//---------End Modfiied ------------------------------------------------------
	end if
	//End Code Change ----08.08.2016
end if
end event

type gb_1 from groupbox within pfc_cst_u_wv_user_add
integer y = 148
integer width = 2414
integer height = 172
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Set Temporary Password to:"
end type

