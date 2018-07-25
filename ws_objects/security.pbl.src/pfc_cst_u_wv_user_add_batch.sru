$PBExportHeader$pfc_cst_u_wv_user_add_batch.sru
forward
global type pfc_cst_u_wv_user_add_batch from pfc_cst_u_security_user_painter
end type
type rb_123 from radiobutton within pfc_cst_u_wv_user_add_batch
end type
type rb_ssn from radiobutton within pfc_cst_u_wv_user_add_batch
end type
type cb_set from commandbutton within pfc_cst_u_wv_user_add_batch
end type
type rb_random from radiobutton within pfc_cst_u_wv_user_add_batch
end type
type rb_name from radiobutton within pfc_cst_u_wv_user_add_batch
end type
type st_new from statictext within pfc_cst_u_wv_user_add_batch
end type
type cb_image_sec from commandbutton within pfc_cst_u_wv_user_add_batch
end type
type gb_1 from groupbox within pfc_cst_u_wv_user_add_batch
end type
type dw_all_view from datawindow within pfc_cst_u_wv_user_add_batch
end type
type cb_continue from commandbutton within pfc_cst_u_wv_user_add_batch
end type
type cb_resetuser from commandbutton within pfc_cst_u_wv_user_add_batch
end type
type cb_getname from commandbutton within pfc_cst_u_wv_user_add_batch
end type
type cb_options from commandbutton within pfc_cst_u_wv_user_add_batch
end type
type dw_batch_list from u_dw within pfc_cst_u_wv_user_add_batch
end type
type dw_get_pracs from u_dw within pfc_cst_u_wv_user_add_batch
end type
type cb_batch from commandbutton within pfc_cst_u_wv_user_add_batch
end type
type cb_add from commandbutton within pfc_cst_u_wv_user_add_batch
end type
type rb_first from radiobutton within pfc_cst_u_wv_user_add_batch
end type
type rb_last from radiobutton within pfc_cst_u_wv_user_add_batch
end type
type rb_id from radiobutton within pfc_cst_u_wv_user_add_batch
end type
type rb_npi from radiobutton within pfc_cst_u_wv_user_add_batch
end type
type dw_f_copy from u_dw within pfc_cst_u_wv_user_add_batch
end type
type dw_v_copy from u_dw within pfc_cst_u_wv_user_add_batch
end type
type dw_r_copy from u_dw within pfc_cst_u_wv_user_add_batch
end type
type gb_2 from groupbox within pfc_cst_u_wv_user_add_batch
end type
type cb_run from commandbutton within pfc_cst_u_wv_user_add_batch
end type
end forward

global type pfc_cst_u_wv_user_add_batch from pfc_cst_u_security_user_painter
integer width = 3854
integer height = 2144
rb_123 rb_123
rb_ssn rb_ssn
cb_set cb_set
rb_random rb_random
rb_name rb_name
st_new st_new
cb_image_sec cb_image_sec
gb_1 gb_1
dw_all_view dw_all_view
cb_continue cb_continue
cb_resetuser cb_resetuser
cb_getname cb_getname
cb_options cb_options
dw_batch_list dw_batch_list
dw_get_pracs dw_get_pracs
cb_batch cb_batch
cb_add cb_add
rb_first rb_first
rb_last rb_last
rb_id rb_id
rb_npi rb_npi
dw_f_copy dw_f_copy
dw_v_copy dw_v_copy
dw_r_copy dw_r_copy
gb_2 gb_2
cb_run cb_run
end type
global pfc_cst_u_wv_user_add_batch pfc_cst_u_wv_user_add_batch

type variables
long il_pracid
long il_facility
string is_user
window iw_window

end variables

forward prototypes
public function integer of_set_prac (string as_data)
public function string of_set_userid_pw (long il_prac, long ai_row, string as_type)
public function integer of_get_pracs ()
end prototypes

public function integer of_set_prac (string as_data);//Start Code Change ----06.09.2016 #V152 maha - modified from original
 //Start Code Change ----02.27.2017 #V153 maha - remodifed
//called when window opened
integer p
integer r
integer rc
string ls_full
string ls_last
string ls_first
string ls_user

select top 1 user_id into :ls_user from security_users where prac_id > 0;
if isnull(ls_user) then
	select top 1 user_id into :ls_user from security_users;
end if

dw_roles.insertrow(1)

rc = dw_facility.retrieve(ls_user)
for r = 1 to rc
	dw_facility.setitem(r, "access_rights", 0)
next

rc = dw_views.retrieve(ls_user)
for r = 1 to rc
	dw_views.setitem(r, "access_rights", 0)
next

dw_roles.setitem(1, "wv_role_id", 4)
dw_roles.setitem(1, "audit_type", 2 )
dw_roles.Setitem( 1, "image_flag", "0")
dw_roles.Setitem( 1, "active_status", 1)
dw_roles.Setitem( 1, "read_only", 0)

dw_roles.enabled = true

of_get_pracs( )

return 1




end function

public function string of_set_userid_pw (long il_prac, long ai_row, string as_type);//Start Code Change ----01.26.2012 #V12 maha - created
string ls_type
string s
integer p //maha 09.23.2014
string pw
string ls_ssn
string ls_name
string ls_npi
string ls_id
string ls_last
string ls_first


ls_name = dw_batch_list.getitemstring(ai_row, "v_full_name_full_name")
ls_last = dw_batch_list.getitemstring(ai_row, "v_full_name_last_name")
ls_first = dw_batch_list.getitemstring(ai_row, "v_full_name_first_name")
ls_type = as_type

choose case ls_type
	case "123"
		pw = "123"
	case  "SSN", "SSN6"
		ls_ssn = dw_batch_list.getitemstring(ai_row, "v_full_name_ssn")
		if isnull(ls_ssn) or len(ls_ssn) < 4 then
			messagebox("Password set","Practitioner " + ls_name + " does not have an SSN value to set as a password.")
		return "fail"
		else
			ls_ssn = of_strip_char ("",ls_ssn,"@NUM@" )
			if ls_type = "SSN"  then
				pw = RightA( ls_ssn , 4)
			elseif ls_type = "SSN6"  then
				pw = LeftA( ls_ssn , 6)
			end if 
		end if
	case "LASTI"
		ls_last = of_strip_char("", ls_last, "@USERNAME@")  //Start Code Change ----02.14.2012 #V12 maha
		pw = lower(LeftA( ls_last , 9) + LeftA( ls_first , 1))
	case "ILAST"
		ls_last = of_strip_char("", ls_last, "@USERNAME@")  //Start Code Change ----02.14.2012 #V12 maha
		pw = lower(LeftA( ls_first , 1) + LeftA( ls_last , 9 ))
	case "PROVID"
		ls_id = dw_batch_list.getitemstring(ai_row, "v_full_name_provider_id")
		if isnull(ls_id) then  //Start Code Change ----06.09.2016 #V152 maha
			messagebox("Password set","Practitioner " + ls_name + " does not have a provider_id value to set as a password.")
			return "fail"
		end if
		pw = ls_id
	case "NPI"
		ls_npi = dw_batch_list.getitemstring(ai_row, "v_full_name_npi_number")
		if isnull(ls_npi) then   //Start Code Change ----06.09.2016 #V152 maha
			messagebox("Password set","Practitioner " + ls_name + " does not have an NPI value to set as a password.")
			return "fail"
		end if
		pw = ls_npi
end choose

if isnull(pw ) then pw = "fail"


return pw

end function

public function integer of_get_pracs (); //Start Code Change ----02.27.2017 #V153 maha - modified
long r
long rc
long ll_prac
long ll_find


rc = dw_batch_list.retrieve()

//for r = 1 to rc
//	ll_prac = dw_get_pracs.getitemnumber(r, "prac_id")
//	ll_find = dw_batch_list.find("prac_id = " + string(ll_prac)  , 1, dw_batch_list.rowcount())
//	if ll_find = 0 then
//		dw_get_pracs.rowscopy( r, r, primary!, dw_batch_list, 100000, primary!)
//		
//	end if
//next
//
//dw_batch_list.sort()
//
//for r = 1 to  dw_batch_list.rowcount( )
//	if len(dw_batch_list.getitemstring(r,"security_users_user_id")) > 0 then
//		dw_batch_list.setitem(r,"selected", 0)
//	else
//		dw_batch_list.setitem(r,"selected", 1)
//	end if
//next


return 1
end function

on pfc_cst_u_wv_user_add_batch.create
int iCurrent
call super::create
this.rb_123=create rb_123
this.rb_ssn=create rb_ssn
this.cb_set=create cb_set
this.rb_random=create rb_random
this.rb_name=create rb_name
this.st_new=create st_new
this.cb_image_sec=create cb_image_sec
this.gb_1=create gb_1
this.dw_all_view=create dw_all_view
this.cb_continue=create cb_continue
this.cb_resetuser=create cb_resetuser
this.cb_getname=create cb_getname
this.cb_options=create cb_options
this.dw_batch_list=create dw_batch_list
this.dw_get_pracs=create dw_get_pracs
this.cb_batch=create cb_batch
this.cb_add=create cb_add
this.rb_first=create rb_first
this.rb_last=create rb_last
this.rb_id=create rb_id
this.rb_npi=create rb_npi
this.dw_f_copy=create dw_f_copy
this.dw_v_copy=create dw_v_copy
this.dw_r_copy=create dw_r_copy
this.gb_2=create gb_2
this.cb_run=create cb_run
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_123
this.Control[iCurrent+2]=this.rb_ssn
this.Control[iCurrent+3]=this.cb_set
this.Control[iCurrent+4]=this.rb_random
this.Control[iCurrent+5]=this.rb_name
this.Control[iCurrent+6]=this.st_new
this.Control[iCurrent+7]=this.cb_image_sec
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.dw_all_view
this.Control[iCurrent+10]=this.cb_continue
this.Control[iCurrent+11]=this.cb_resetuser
this.Control[iCurrent+12]=this.cb_getname
this.Control[iCurrent+13]=this.cb_options
this.Control[iCurrent+14]=this.dw_batch_list
this.Control[iCurrent+15]=this.dw_get_pracs
this.Control[iCurrent+16]=this.cb_batch
this.Control[iCurrent+17]=this.cb_add
this.Control[iCurrent+18]=this.rb_first
this.Control[iCurrent+19]=this.rb_last
this.Control[iCurrent+20]=this.rb_id
this.Control[iCurrent+21]=this.rb_npi
this.Control[iCurrent+22]=this.dw_f_copy
this.Control[iCurrent+23]=this.dw_v_copy
this.Control[iCurrent+24]=this.dw_r_copy
this.Control[iCurrent+25]=this.gb_2
this.Control[iCurrent+26]=this.cb_run
end on

on pfc_cst_u_wv_user_add_batch.destroy
call super::destroy
destroy(this.rb_123)
destroy(this.rb_ssn)
destroy(this.cb_set)
destroy(this.rb_random)
destroy(this.rb_name)
destroy(this.st_new)
destroy(this.cb_image_sec)
destroy(this.gb_1)
destroy(this.dw_all_view)
destroy(this.cb_continue)
destroy(this.cb_resetuser)
destroy(this.cb_getname)
destroy(this.cb_options)
destroy(this.dw_batch_list)
destroy(this.dw_get_pracs)
destroy(this.cb_batch)
destroy(this.cb_add)
destroy(this.rb_first)
destroy(this.rb_last)
destroy(this.rb_id)
destroy(this.rb_npi)
destroy(this.dw_f_copy)
destroy(this.dw_v_copy)
destroy(this.dw_r_copy)
destroy(this.gb_2)
destroy(this.cb_run)
end on

type cb_cvo from pfc_cst_u_security_user_painter`cb_cvo within pfc_cst_u_wv_user_add_batch
integer x = 3895
integer y = 64
end type

type cb_ad from pfc_cst_u_security_user_painter`cb_ad within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 2939
integer y = 24
end type

type cb_h2 from pfc_cst_u_security_user_painter`cb_h2 within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 3886
end type

type cb_batch_provd from pfc_cst_u_security_user_painter`cb_batch_provd within pfc_cst_u_wv_user_add_batch
integer x = 3922
integer y = 424
end type

type cb_2 from pfc_cst_u_security_user_painter`cb_2 within pfc_cst_u_wv_user_add_batch
integer x = 105
integer y = 2360
end type

type cb_reset from pfc_cst_u_security_user_painter`cb_reset within pfc_cst_u_wv_user_add_batch
integer x = 1335
integer y = 2884
integer taborder = 170
end type

type cb_setup_ctx from pfc_cst_u_security_user_painter`cb_setup_ctx within pfc_cst_u_wv_user_add_batch
integer x = 1349
integer y = 2804
integer taborder = 120
end type

type cb_h1 from pfc_cst_u_security_user_painter`cb_h1 within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 2633
integer y = 40
end type

type cb_image_security from pfc_cst_u_security_user_painter`cb_image_security within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 1349
integer y = 2896
integer taborder = 80
end type

type cb_security from pfc_cst_u_security_user_painter`cb_security within pfc_cst_u_wv_user_add_batch
integer x = 82
integer y = 2484
integer taborder = 280
end type

type cb_ldap from pfc_cst_u_security_user_painter`cb_ldap within pfc_cst_u_wv_user_add_batch
integer x = 1403
integer y = 2328
integer width = 475
integer taborder = 10
end type

type cb_email from pfc_cst_u_security_user_painter`cb_email within pfc_cst_u_wv_user_add_batch
integer x = 521
integer y = 2344
integer taborder = 130
end type

type cb_copy from pfc_cst_u_security_user_painter`cb_copy within pfc_cst_u_wv_user_add_batch
integer x = 1413
integer y = 2696
integer taborder = 90
end type

type dw_departments from pfc_cst_u_security_user_painter`dw_departments within pfc_cst_u_wv_user_add_batch
integer x = 2395
integer y = 2568
integer taborder = 140
end type

type cb_sad from pfc_cst_u_security_user_painter`cb_sad within pfc_cst_u_wv_user_add_batch
integer x = 2647
integer y = 2580
integer taborder = 310
end type

type st_view from pfc_cst_u_security_user_painter`st_view within pfc_cst_u_wv_user_add_batch
integer x = 2533
integer y = 1060
end type

type dw_department from pfc_cst_u_security_user_painter`dw_department within pfc_cst_u_wv_user_add_batch
integer x = 2217
integer y = 2540
integer taborder = 260
end type

type cb_sav from pfc_cst_u_security_user_painter`cb_sav within pfc_cst_u_wv_user_add_batch
integer x = 3442
integer y = 1052
integer taborder = 320
end type

type cb_saf from pfc_cst_u_security_user_painter`cb_saf within pfc_cst_u_wv_user_add_batch
integer x = 2103
integer y = 1052
integer taborder = 300
end type

type dw_facility from pfc_cst_u_security_user_painter`dw_facility within pfc_cst_u_wv_user_add_batch
integer x = 1065
integer y = 1128
integer width = 1413
integer height = 956
integer taborder = 250
string dataobject = "d_wv_security_user_facility_access"
boolean hscrollbar = true
end type

type cb_save from pfc_cst_u_security_user_painter`cb_save within pfc_cst_u_wv_user_add_batch
integer x = 1975
integer y = 2344
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

type cb_delete from pfc_cst_u_security_user_painter`cb_delete within pfc_cst_u_wv_user_add_batch
integer x = 1394
integer y = 2596
integer taborder = 180
end type

type dw_select_user from pfc_cst_u_security_user_painter`dw_select_user within pfc_cst_u_wv_user_add_batch
integer x = 133
integer y = 2592
integer taborder = 50
end type

type cb_new from pfc_cst_u_security_user_painter`cb_new within pfc_cst_u_wv_user_add_batch
integer x = 270
integer y = 2684
integer taborder = 200
end type

type dw_views from pfc_cst_u_security_user_painter`dw_views within pfc_cst_u_wv_user_add_batch
integer x = 2487
integer y = 1128
integer width = 1294
integer height = 956
integer taborder = 240
string dataobject = "d_wv_security_user_views_access"
boolean hscrollbar = true
end type

type st_1 from pfc_cst_u_security_user_painter`st_1 within pfc_cst_u_wv_user_add_batch
integer x = 1088
integer y = 1060
end type

type st_department from pfc_cst_u_security_user_painter`st_department within pfc_cst_u_wv_user_add_batch
integer x = 2254
integer y = 2660
end type

type cb_close from pfc_cst_u_security_user_painter`cb_close within pfc_cst_u_wv_user_add_batch
integer x = 3424
integer y = 20
integer width = 366
integer height = 92
integer taborder = 60
end type

event cb_close::clicked;Close( iw_window )
end event

type cb_print from pfc_cst_u_security_user_painter`cb_print within pfc_cst_u_wv_user_add_batch
integer x = 2720
integer y = 2524
integer taborder = 270
end type

type gb_select from pfc_cst_u_security_user_painter`gb_select within pfc_cst_u_wv_user_add_batch
integer x = 1742
integer y = 2544
integer width = 306
integer taborder = 100
end type

type gb_main from pfc_cst_u_security_user_painter`gb_main within pfc_cst_u_wv_user_add_batch
integer x = 1047
integer y = 992
integer width = 2766
integer height = 1108
integer taborder = 210
end type

type dw_audit from pfc_cst_u_security_user_painter`dw_audit within pfc_cst_u_wv_user_add_batch
integer x = 3419
integer y = 2280
integer taborder = 290
end type

type dw_roles from pfc_cst_u_security_user_painter`dw_roles within pfc_cst_u_wv_user_add_batch
integer x = 1047
integer y = 396
integer width = 2738
integer height = 552
integer taborder = 220
string dataobject = "d_security_user_batch_settings"
end type

event dw_roles::buttonclicked;call super::buttonclicked; //Start Code Change ----04.29.2015 #V15 maha
string ls_copy

if dwo.name = "b_copy" then
	ls_copy = this.getitemstring(row,"user_id")
	clipboard(ls_copy)
end if

end event

type gb_sec from pfc_cst_u_security_user_painter`gb_sec within pfc_cst_u_wv_user_add_batch
integer x = 1042
integer y = 340
integer width = 2761
integer height = 640
integer taborder = 230
end type

type cb_4 from pfc_cst_u_security_user_painter`cb_4 within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 2889
integer y = 28
end type

type rb_123 from radiobutton within pfc_cst_u_wv_user_add_batch
integer x = 2395
integer y = 236
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

type rb_ssn from radiobutton within pfc_cst_u_wv_user_add_batch
integer x = 2647
integer y = 236
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
string text = "Last 6 of SSN"
end type

type cb_set from commandbutton within pfc_cst_u_wv_user_add_batch
integer x = 846
integer y = 2476
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

type rb_random from radiobutton within pfc_cst_u_wv_user_add_batch
integer x = 3474
integer y = 236
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

type rb_name from radiobutton within pfc_cst_u_wv_user_add_batch
integer x = 3127
integer y = 236
integer width = 274
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "User Id"
end type

type st_new from statictext within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 3872
integer y = 492
integer width = 379
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

type cb_image_sec from commandbutton within pfc_cst_u_wv_user_add_batch
integer x = 2734
integer y = 2352
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

type gb_1 from groupbox within pfc_cst_u_wv_user_add_batch
integer x = 2290
integer y = 148
integer width = 1513
integer height = 192
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

type dw_all_view from datawindow within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 3712
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

type cb_continue from commandbutton within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 1975
integer y = 2344
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

type cb_resetuser from commandbutton within pfc_cst_u_wv_user_add_batch
integer x = 1225
integer y = 2472
integer width = 613
integer height = 84
integer taborder = 200
boolean bringtotop = true
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
integer r

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


pw = of_create_password( pw,ll_prac, ls_user)
if pw <> "-1" then
	dw_roles.setitem(1, "user_password", pw)
	dw_roles.setitem(1, "active_status", 1)
	dw_roles.setitem(1, "lock_until", ldt_null)
	//dw_roles.setitem(1, "expiration_date", ldt_null)
end if
end event

type cb_getname from commandbutton within pfc_cst_u_wv_user_add_batch
integer x = 3973
integer y = 1236
integer width = 338
integer height = 80
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

type cb_options from commandbutton within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 4000
integer y = 944
integer width = 338
integer height = 80
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

type dw_batch_list from u_dw within pfc_cst_u_wv_user_add_batch
integer x = 18
integer y = 12
integer width = 1010
integer height = 2072
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_user_batch_add_list"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_setupdateable( false)
this.of_settransobject( sqlca)
end event

event buttonclicked;call super::buttonclicked; //Start Code Change ----02.27.2017 #V153 maha
if dwo.name = "b_select" then
	integer li_rc
	integer v
	integer i
	li_rc = this.RowCount()

	IF dwo.Text = "Select All" THEN
		dwo.Text = "Deselect All"
		v = 1
	ELSE
		dwo.Text = "Select All"
		v = 0
	END IF
	
	FOR i = 1 TO li_rc
			this.SetItem( i, "selected", v )
	END FOR
end if
end event

type dw_get_pracs from u_dw within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 1083
integer y = 12
integer width = 82
integer height = 64
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_user_batch_add_list"
boolean hscrollbar = true
end type

type cb_batch from commandbutton within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 2674
integer y = 28
integer width = 453
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch Select"
end type

event clicked;////Start Code Change ----06.07.2016 #V152 maha - copied from meetings
//openwithparm(w_batch_prac_select_new,"R")
//
//if message.stringparm = "Cancel" then 
//	return
//else
//	long i
//	long ic
//	long li_prac_id
//	long li_find
//	long li_nr
//	long ll_id
//	string ls_full_name[]
//	gs_batch_search ist_search
//	
//	if not isvalid(message.powerobjectparm) then return 0
//	ist_search = message.powerobjectparm
//	
//	ic = upperbound(ist_search.li_prac_id[])
//	
//
//	
//	of_get_pracs(ist_search.li_prac_id[])
//
//end if

end event

type cb_add from commandbutton within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 2661
integer y = 36
integer width = 453
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select Providers"
end type

event clicked;////Start Code Change ----06.07.2016 #V152 maha - copied from meetings
//Integer li_nr
//Integer li_find
//long li_prac_id
//String ls_full_name[]
//integer i
//integer ic
//long ll_id
//gs_batch_search ist_search
//
//gs_search lstr_search
//
//lstr_search.stran_transaction = SQLCA
//lstr_search.ls_open_for = "REPORTS0" 
//
//OpenWithParm( w_extended_search_new , lstr_search )
//
//IF Message.DoubleParm = -1 THEN
//	Return -1
//END IF
//
//ist_search = message.powerobjectparm
//
//if not isvalid(message.powerobjectparm) then return 0
//
//
//ic = upperbound(ist_search.li_prac_id[])
//
//
//of_get_pracs(ist_search.li_prac_id[])
//
end event

type rb_first from radiobutton within pfc_cst_u_wv_user_add_batch
integer x = 1125
integer y = 200
integer width = 654
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "First initial + Last name"
boolean checked = true
end type

type rb_last from radiobutton within pfc_cst_u_wv_user_add_batch
integer x = 1125
integer y = 264
integer width = 635
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Last name + first initial"
end type

type rb_id from radiobutton within pfc_cst_u_wv_user_add_batch
integer x = 1842
integer y = 260
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Provider Id"
end type

type rb_npi from radiobutton within pfc_cst_u_wv_user_add_batch
integer x = 1842
integer y = 196
integer width = 361
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "NPI number"
end type

type dw_f_copy from u_dw within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 1179
integer y = 16
integer width = 82
integer height = 64
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_wv_security_user_facility_access"
boolean hscrollbar = true
end type

type dw_v_copy from u_dw within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 1285
integer y = 16
integer width = 82
integer height = 64
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_wv_security_user_views_access"
boolean hscrollbar = true
end type

type dw_r_copy from u_dw within pfc_cst_u_wv_user_add_batch
boolean visible = false
integer x = 1385
integer y = 16
integer width = 82
integer height = 64
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_security_user_batch_settings"
boolean hscrollbar = true
end type

type gb_2 from groupbox within pfc_cst_u_wv_user_add_batch
integer x = 1093
integer y = 144
integer width = 1170
integer height = 196
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "User id Format (max 12 characters)"
end type

type cb_run from commandbutton within pfc_cst_u_wv_user_add_batch
integer x = 1083
integer y = 8
integer width = 731
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add User Ids"
end type

event clicked;//Start Code Change ----06.09.2016 #V152 maha - added
long rc
long r
long c
long cnt
long li_check
long ll_prac
long ll_ret[]
long fid
long vid
integer f_cnt
integer v_cnt
integer li_skip
integer li_find
string ls_user
string ls_pw
string ls_name
string ls_last
string ls_first 
string ls_type
string ls_find
gs_variable_array lst_list



//check missing values
if isnull(dw_roles.getitemnumber(1,"wv_role_id")) then 
	messagebox("Batch add","Value missing for WebView Role")
	return 
end if
if isnull(dw_roles.getitemnumber(1,"default_view")) then 
	messagebox("Batch add","Value missing for WebView View")
	return 
end if
if isnull(dw_roles.getitemnumber(1,"audit_type")) then 
	messagebox("Batch add","Value missing for WebView Audit Type")
	return 
end if

 //Start Code Change ----.2017 #V153 maha
ls_find = "access_rights = 1"
li_find = dw_facility.find( ls_find, 1,dw_facility.rowcount())

if li_find < 1 then
	messagebox("Batch add","There must be at least one Facility selected")
	return 
end if

ls_find = "access_rights = 1"
li_find = dw_views.find( ls_find, 1,dw_views.rowcount())

if li_find < 1 then
	messagebox("Batch add","There must be at least one View selected")
	return 
end if


//copy to copy dws
dw_roles.rowscopy( 1, 1, primary!, dw_r_copy, 100, primary!)
dw_facility.rowscopy( 1, dw_facility.rowcount(), primary!, dw_f_copy, 100, primary!)
dw_views.rowscopy( 1, dw_views.rowcount(), primary!, dw_v_copy, 100, primary!)


for r = 1 to dw_batch_list.rowcount()
	if dw_batch_list.getitemnumber(r, "selected") = 0 then continue
	
	ll_prac = dw_batch_list.getitemnumber(r,"prac_id")
	ll_ret[r] = ll_prac
	
	if dw_batch_list.getitemnumber(r,"selected") = 0 then continue
	
	ls_name = dw_batch_list.getitemstring(r,"v_full_name_full_name") 
	ls_last = dw_batch_list.getitemstring(r, "v_full_name_last_name")
	ls_first = dw_batch_list.getitemstring(r, "v_full_name_first_name")
//set user id
	if rb_last.checked then
		ls_type = "LASTI"
	elseif rb_first.checked then
		ls_type = "ILAST"
	elseif rb_id.checked then
		ls_type = "PROVID"
	elseif rb_npi.checked then
		ls_type = "NPI"
	end if
	
	ls_user = of_set_userid_pw(ll_prac, r, ls_type)  //get user id
	if ls_user = "fail" then continue
	
	li_check = 1 //initial reset
	Do until li_check = 0
		select count(user_id) into :li_check from security_users where user_id = :ls_user;
		if li_check > 0 then
			lst_list.as_string[1] = ls_user
			lst_list.as_string[2] = ls_name
			openwithparm(w_user_id_check, lst_list)
			ls_user = message.stringparm
			if ls_user = "Cancel" then
				li_check = 0
				li_skip = 1
			end if
		end if
	Loop
	
	if li_skip = 1 then  //if canceled, skip user creation
		li_skip = 0
		continue
	end if
		

//set password
	if rb_123.checked then
		ls_type = "123"
	elseif rb_ssn.checked then
		ls_type = "SSN6"
	elseif rb_name.checked then
		ls_type = "USER"
	elseif rb_random.checked then
		ls_type = "RAND"
	end if
	
	if ls_type = "USER" then
		ls_pw = ls_user
	else
		ls_pw = of_set_userid_pw(ll_prac, r, ls_type)
	end if
	if ls_pw = "fail" then continue
	//messagebox("",1)
	//create row
	dw_roles.reset()
	dw_r_copy.rowscopy( 1, 1, primary!, dw_roles, 100, primary!)
	dw_roles.setitem(1,"user_name" , ls_first + " " + ls_last)
	dw_roles.setitem(1,"user_id" , ls_user)
	dw_roles.setitem(1,"user_password" , ls_pw )
	dw_roles.setitem(1,"prac_id" , ll_prac )
	debugbreak()
	//facility
	dw_facility.reset()
	dw_f_copy.rowscopy( 1, dw_f_copy.rowcount(), primary!, dw_facility, 100, primary!)
	f_cnt = dw_facility.rowcount()
	fid = gnv_app.of_get_id( "user_facility_id" ,f_cnt) - 1
	
	for c = 1 to f_cnt
		fid++
		dw_facility.setitem(c,"user_facility_id" ,fid)
		dw_facility.setitem(c,"user_id" ,ls_user)
	next

	//views
	dw_views.reset()

	dw_v_copy.rowscopy( 1, dw_v_copy.rowcount(), primary!, dw_views, 100, primary!)
	v_cnt = dw_views.rowcount()
	vid = gnv_app.of_get_id( "user_view_id" ,v_cnt) - 1
	
	for c = 1 to v_cnt
		vid++
		dw_views.setitem(c,"user_view_id" ,vid)
		dw_views.setitem(c,"user_id" ,ls_user)
	next

//update
	dw_roles.update()
	dw_facility.update()
	dw_views.update()
	cnt++
next

messagebox("Batch Users", string(cnt) + " user record(s) created.")

//re-retrieve list
dw_batch_list.retrieve(ll_ret[])
end event

