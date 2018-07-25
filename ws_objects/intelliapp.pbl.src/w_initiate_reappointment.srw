$PBExportHeader$w_initiate_reappointment.srw
forward
global type w_initiate_reappointment from window
end type
type st_1 from statictext within w_initiate_reappointment
end type
type dw_type from datawindow within w_initiate_reappointment
end type
type dw_track from datawindow within w_initiate_reappointment
end type
type dw_acts from datawindow within w_initiate_reappointment
end type
type st_2 from statictext within w_initiate_reappointment
end type
type dw_1 from datawindow within w_initiate_reappointment
end type
type cb_2 from commandbutton within w_initiate_reappointment
end type
type cb_1 from commandbutton within w_initiate_reappointment
end type
end forward

global type w_initiate_reappointment from window
integer x = 1056
integer y = 456
integer width = 2807
integer height = 2704
boolean titlebar = true
string title = "Payor Reappointment"
windowtype windowtype = response!
long backcolor = 33551856
st_1 st_1
dw_type dw_type
dw_track dw_track
dw_acts dw_acts
st_2 st_2
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_initiate_reappointment w_initiate_reappointment

type variables
boolean ib_add = true  //maha 04.21.2015
long il_prac   //maha 04.21.2015
long il_facil   //maha 04.21.2015
long il_action  //maha 04.21.2015
long il_status  //maha 04.21.2015

end variables

on w_initiate_reappointment.create
this.st_1=create st_1
this.dw_type=create dw_type
this.dw_track=create dw_track
this.dw_acts=create dw_acts
this.st_2=create st_2
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.dw_type,&
this.dw_track,&
this.dw_acts,&
this.st_2,&
this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_initiate_reappointment.destroy
destroy(this.st_1)
destroy(this.dw_type)
destroy(this.dw_track)
destroy(this.dw_acts)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open; //Start Code Change ----04.21.2015 #V15 maha - rewrote
 datawindowchild dwchild
 integer f
 integer r

if gi_intelliapp_type = 3 then
	dw_1.dataobject = "d_net_dev_reapp_tv_2_level"
end if
//debugbreak()
dw_1.settransobject(sqlca)
dw_acts.settransobject(sqlca)
dw_track.settransobject(sqlca)
dw_type.settransobject(sqlca)



if of_get_app_setting("set_82" , "I") = 1 then
	il_action = long(gnv_data.of_getitem("app_steps","next step",'0'))
else
	il_action = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Type') + "'" + " and upper(code) = '" + upper('App Out To MD') + "'"))
end if

il_status =  long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Status') + "'" + " and upper(code) = '" + upper('Incomplete') + "'"))

r = dw_type.retrieve()
dw_type.insertrow(1)
dw_type.setitem(1,"lookup_code", il_action)


//dw_type.getchild("lookup_code", dwchild)
//dwchild.insertrow(1)
//dwchild.setitem(1,"lookup_code", -1)
//dwchild.setitem(1,"description", "-No Action-")
//
//f = dw_type.find("lookup_code =" + string(il_action) , 1, dwchild.rowcount())
//if f > 1 then dw_type.setitem(1,"lookup_code", il_action)

il_prac = long(MidA( Message.StringParm, 1, PosA( Message.StringParm, "-" ) -1 ))
il_facil = long( MidA( Message.StringParm, PosA( Message.StringParm, "-" ) +1, 100 ) )

dw_1.retrieve(il_prac,il_facil)
dw_1.expandall()




//Old code
//long ll_fac_id
//long ll_prac

//st_payor.Text = MidA( Message.StringParm, 1, PosA( Message.StringParm, "-" ) -1 )
//
//li_app_id = Integer( MidA( Message.StringParm, PosA( Message.StringParm, "-" ) +1, 100 ) )
//
//IF li_app_id > 0 THEN
//	dw_1.SetItem( 1, "app_id", li_app_id )
//END IF
//

end event

type st_1 from statictext within w_initiate_reappointment
integer x = 59
integer y = 44
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Action Type:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_type from datawindow within w_initiate_reappointment
integer x = 411
integer y = 36
integer width = 745
integer height = 80
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_action_type_select"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject( sqlca)
end event

event itemchanged; //Start Code Change ----04.23.2015 #V15 maha
if data = "-1" then ib_add = false
end event

type dw_track from datawindow within w_initiate_reappointment
boolean visible = false
integer x = 1737
integer y = 328
integer width = 1070
integer height = 1644
integer taborder = 40
string title = "none"
string dataobject = "d_pd_appl_tracking_w_loc"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_acts from datawindow within w_initiate_reappointment
boolean visible = false
integer x = 1033
integer y = 2164
integer width = 1605
integer height = 428
integer taborder = 10
string title = "none"
string dataobject = "d_net_dev_action_items_reapp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_initiate_reappointment
integer x = 101
integer y = 140
integer width = 1088
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "Select Payors/Applications to Reappoint"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_initiate_reappointment
integer x = 18
integer y = 216
integer width = 2734
integer height = 2276
integer taborder = 30
string dataobject = "d_net_dev_reapp_tv_3_level"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;This.SetTransObject( SQLCA )

end event

event buttonclicked; //Start Code Change ----04.21.2015 #V15 maha
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

type cb_2 from commandbutton within w_initiate_reappointment
integer x = 2469
integer y = 56
integer width = 283
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn ( w_initiate_reappointment, "Cancel" )
end event

type cb_1 from commandbutton within w_initiate_reappointment
integer x = 2139
integer y = 56
integer width = 283
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked; //Start Code Change ----04.21.2015 #V15 maha - moved functionality here from provider folder

long r
long a
long ac
long tc
long  ll_app
long ll_loc
long ll_rec_id
long nr
long ll_id
datetime ld_now
pfc_cst_nv_data_entry_functions  lnv_data_entry //(Appeon)Stephen 07.12.2016 - V15.2-Application Tracking full Auditing

r = messagebox("Payor Reappointment","This function will make all Actions and Tracking records inactive for the selected Payor/Applications, as well as create a new Action of the selected type. ~r Do you want to continue?", question!,yesno!, 2)
if r = 2 then return


ld_now = datetime(today(),now())
lnv_data_entry = create pfc_cst_nv_data_entry_functions   //(Appeon)Stephen 07.12.2016 - V15.2-Application Tracking full Auditing
		
for r = 1 to dw_1.rowcount()
	If dw_1.getitemnumber(r,"selected") = 1 then
		ll_app = dw_1.getitemnumber(r,"app_id")
		ll_loc = dw_1.getitemnumber(r,"gp_id")
		if isnull(ll_loc) then ll_loc = 0
debugbreak()		
		//get actions and tracking
		ac = dw_acts.retrieve(il_prac, il_facil, ll_app, ll_loc  )
		tc = dw_track.retrieve(il_prac, ll_app,  il_facil, ll_loc  )
		
		if ac > 0 then
			//set actions inactive
			for a = 1 to ac
				dw_acts.setitem(a, "active_status", 0)
				dw_acts.setitem(a, "net_dev_action_items_mod_user", gs_user_id)
				dw_acts.setitem(a, "net_dev_action_items_mod_date", ld_now)
			next
		end if
		
		//set tracker inactive
		if tc > 0 then
			for a = 1 to tc
				dw_track.setitem(a,"active_status", 0)
			next
		end if		
		
		
		//add new action/tracker
		if ib_add then
			nr = dw_acts.insertrow(0)
			dw_acts.setitem(nr, "prac_id", il_prac)
			dw_acts.setitem(nr, "facility_id", il_facil )
			dw_acts.setitem(nr, "app_id", ll_app)
			dw_acts.setitem(nr, "gp_id", ll_loc)
			ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")
			dw_acts.setitem(nr, "rec_id", ll_rec_id )
			dw_acts.setitem(nr, "active_status", 1)
			dw_acts.setitem(nr, "app_type", "R"  )
			dw_acts.setitem(nr, "net_dev_action_items_create_user", gs_user_id)
			dw_acts.setitem(nr, "net_dev_action_items_create_date", ld_now)
			dw_acts.setitem(nr, "action_type", il_action)
			dw_acts.setitem(nr, "action_status", il_status)
			//Modified by (appeon) Harry 10.16.2017
			/*
			select max(track_id) into :ll_id from pd_appl_tracking;
			if isnull(ll_id) then ll_id = 0
			ll_id++
			*/
			ll_id =  gnv_app.of_get_id("track_id")
			dw_acts.setitem(nr, "net_dev_action_items_track_id", ll_id)
			nr = dw_track.insertrow(0)
			dw_track.setitem(nr, "active_status", 1)
			dw_track.setitem(nr, "prac_id", il_prac)
			dw_track.setitem(nr, "facility_id", il_facil)
			dw_track.setitem(nr, "app_id", ll_app)
			dw_track.setitem(nr, "gp_id", ll_loc)
			dw_track.setitem(nr, "track_id", ll_id)
			
		end if //add new
		
		//---------Begin Modified by (Appeon)Stephen 07.12.2016 for Bug id 5226 - Initiate Re-Appointment for Payors--------		
//		dw_acts.update()
//		dw_track.update()
		dw_track.accepttext()
		dw_acts.accepttext()
		lnv_data_entry.of_field_audit(dw_acts)
		lnv_data_entry.of_field_audit(dw_track)
		
		dw_acts.update()
		dw_track.update()
		//---------End Modfiied ------------------------------------------------------
	End if  //selected

next

//---------Begin Modified by (Appeon)Stephen 07.12.2016 for Bug id 5226 - Initiate Re-Appointment for Payors--------
//CloseWithReturn( w_initiate_reappointment, "OK" )
destroy lnv_data_entry
CloseWithReturn( w_initiate_reappointment, "OK" )
//---------End Modfiied ------------------------------------------------------




end event

