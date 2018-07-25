$PBExportHeader$w_ai_update_values.srw
forward
global type w_ai_update_values from window
end type
type st_1 from statictext within w_ai_update_values
end type
type cb_2 from commandbutton within w_ai_update_values
end type
type cb_1 from commandbutton within w_ai_update_values
end type
type dw_1 from u_dw within w_ai_update_values
end type
end forward

global type w_ai_update_values from window
integer x = 1088
integer y = 224
integer width = 2528
integer height = 1028
boolean titlebar = true
string title = "Batch Update Values "
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_ai_update_values w_ai_update_values

type variables
boolean ib_top = true  //maha 01.28.2012
end variables

forward prototypes
public function integer of_update_checklist (long al_ids[])
end prototypes

public function integer of_update_checklist (long al_ids[]);//Start Code Change ----06.18.2012 #V12 maha 

long r
long rc
datetime ld_rcv
long ll_code
string ls_notes
string ls_cur_note
datastore lds_items

lds_items = create datastore
lds_items.dataobject = "d_app_audit_missing_ai_batch_update"
lds_items.settransobject(sqlca)

rc = lds_items.retrieve(al_ids)
//messagebox("rc",rc)

ld_rcv = dw_1.getitemdatetime(1,"date_completed")
ll_code = dw_1.getitemnumber(1,"data_status")
ls_notes = dw_1.getitemstring(1,"pd_app_audit_notes")

for r = 1 to rc
	lds_items.setitem(r,"data_status",ll_code)
	lds_items.setitem(r,"date_completed",ld_rcv)
	//Start Code Change ----01.28.2013 #V12 maha
	ls_cur_note = lds_items.getitemstring(r,"notes")
	if isnull(ls_cur_note) then ls_cur_note	 = ""
	if len(ls_cur_note) > 0 then
		if ib_top then
			ls_notes = ls_notes + "~r~n" + ls_cur_note
		else
			ls_notes =  ls_cur_note + "~r~n" + ls_notes
		end if
	end if
	//End Code Change ----01.28.2013	
	lds_items.setitem(r,"notes",ls_notes)
next

lds_items.update()
commit using sqlca;


return 1
end function

on w_ai_update_values.create
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_ai_update_values.destroy
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;datawindowchild dwchild
string p 

p = message.stringparm
//messagebox("p",p)

if p = "A" then //app audit
	dw_1.dataobject = "d_ai_update_missing_items"
end if

dw_1.settransobject(sqlca)
dw_1.insertrow(1)	
dw_1.of_SetDropDownCalendar( TRUE )
dw_1.iuo_calendar.of_Register(dw_1.iuo_calendar.DDLB)

if p = "A" then //app audit
	dw_1.GetChild( "data_status", dwchild )
	dwchild.settransobject(sqlca)
	dwchild.retrieve()	
	dw_1.setitem(1,"date_completed",today())
else
	dw_1.GetChild( "response_code", dwchild )
	dwchild.settransobject(sqlca)
	dwchild.retrieve("Credentials Verification Response")
	dw_1.GetChild( "verification_method", dwchild )
	dwchild.settransobject(sqlca)
	dwchild.retrieve("Verification Method")
//	dw_1.setitem(1,"date_recieved",today())
//	dw_1.setitem(1,"user_name",gs_user_id)
end if

ib_top = gb_notes_at_top  //Start Code Change ----01.28.2013 #V12 maha

end event

type st_1 from statictext within w_ai_update_values
integer x = 46
integer y = 512
integer width = 2391
integer height = 200
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "This Function will update the selected records with the above values "
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_ai_update_values
integer x = 1221
integer y = 808
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_ai_update_values
integer x = 946
integer y = 808
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update"
end type

event clicked;integer res
long ic
long i
long ll_meth
long rcode
long ll_appt_ids[] //maha 06.18.2012
long cnt = 0
datetime drcv
datetime dd
string notes
string uname
string aname
string ls_cur_note
string ls_notes_input  //stephen 12.24.2013
w_action_items lw_win
u_dw ldw_browse //maha 08.03.2011


//Start Code Change ----06.18.2012 #V12 maha - modified code for updating checklist items
if gs_cust_type = "I" then //added 041204 maha for 4.19
	lw_win = w_action_items_ia
else
	lw_win = w_action_items
end if

ldw_browse =  lw_win.tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse //06.18.2012 #V12 maha - moved from below

if dw_1.dataobject = "d_ai_update_missing_items" then  //06.18.2012 #V12 maha - added different message
	res = messagebox("Batch Update","When batch updating Checklist items, All incomplete items connected to the selected provider(s) will be updated.~r~rDo you wish to continue the update?",question!,yesno!,2)
else
	res = messagebox("Batch","Are you sure you wish to update the selected records?",question!,yesno!,1)
end if	

if res = 2 then return


//Start Code Change ----08.03.2011 #V11 maha - added dw variable and modified code below to make it easier to read.
//ldw_browse =  lw_win.tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse

lw_win.lb_response_cd_entered = true

ic = ldw_browse.rowcount()
dw_1.accepttext()

if dw_1.dataobject = "d_ai_update_missing_items" then
	drcv = dw_1.getitemdatetime(1,"date_completed")
	rcode = dw_1.getitemnumber(1,"data_status")
	notes = dw_1.getitemstring(1,"pd_app_audit_notes")
else
	drcv = dw_1.getitemdatetime(1,"date_recieved")
	rcode = dw_1.getitemnumber(1,"response_code")
	uname = dw_1.getitemstring(1,"user_name")
	aname = dw_1.getitemstring(1,"priority_user")
	notes = dw_1.getitemstring(1,"notes")
	dd = dw_1.getitemdatetime(1,"due_date")  //Start Code Change ----11.24.2014 #V14.2 maha
	ll_meth = dw_1.getitemnumber(1,"verification_method")  //Start Code Change ----11.06.2008 #V85 maha
end if

for i = 1 to ic
	if ldw_browse.getitemnumber(i,"selected") = 1 then
		ldw_browse.SetItemStatus ( i,0, primary!,datamodified! )
		if dw_1.dataobject = "d_ai_update_missing_items" then
			cnt ++
			ll_appt_ids[cnt] = ldw_browse.getitemnumber(i,"appt_stat_id") //06.18.2012 #V12 maha - get appointment ids
//			ldw_browse.setitem(i,"data_status",rcode)
//			ldw_browse.setitem(i,"date_completed",drcv)
			//--------Begin Modified by  Nova 09.09.2010------------------------
			//ldw_browse.setitem(i,"pd_app_audit_notes",notes)
//			ldw_browse.setitem(i,"notes",notes)
			//--------End Modified --------------------------------------------
		else
			if not isnull(rcode) then
				ldw_browse.setitem(i,"response_code",rcode)
				//Start Code Change ----06.16.2008 #V81 maha - moved from below to update only if rsponse code is updated
				ldw_browse.setitem(i,"exp_credential_flag",0) //maha 032805
				//End Code Change---06.16.2008
			end if
			if not isnull(drcv) then
				ldw_browse.setitem(i,"date_recieved",drcv)
			end if
			if not isnull(uname) then
				ldw_browse.setitem(i,"user_name",uname)
			end if
			if not isnull(aname) then
				ldw_browse.setitem(i,"priority_user",aname)
			end if

			if not isnull(notes) or dw_1.getitemstring(1,"notes") = "" then
				//Start Code Change ----01.28.2013 #V12 maha - if exist add to current notes
				ls_cur_note = ldw_browse.getitemstring(i,"notes")
				if isnull(ls_cur_note) then ls_cur_note	 = ""
				//---------Begin Modified by (Appeon)Stephen 12.24.2013 for Bug 3799 : Batch updating notes in action items--------
				/*
				if len(ls_cur_note) > 0 then
					if ib_top then
						notes = notes + "~r~n" + ls_cur_note
					else
						notes =  ls_cur_note + "~r~n" + notes
					end if
				end if
				//End Code Change ----01.28.2013	
				ldw_browse.setitem(i,"notes",notes) 
				*/
				if len(ls_cur_note) > 0 then
					if ib_top then
						ls_notes_input = notes + "~r~n" + ls_cur_note
					else
						ls_notes_input =  ls_cur_note + "~r~n" + notes
					end if
				else
					ls_notes_input = notes 
				end if
				//End Code Change ----01.28.2013	
				ldw_browse.setitem(i,"notes",ls_notes_input) 
				//---------End Modfiied ------------------------------------------------------
			end if
			if ll_meth > 1 then  //Start Code Change ----11.06.2008 #V85 maha
				ldw_browse.setitem(i,"verification_method",ll_meth)
			end if
			
			if not isnull(dd) then  //Start Code Change ----11.24.2014 #V14.2 maha
				ldw_browse.setitem(i,"due_date",dd)
			end if
			
			//Start Code Change ----08.03.2011 #V11 maha - set prior mod values 
			ldw_browse.SetItem( i, "mod_user", gs_user_id )
			ldw_browse.SetItem( i, "mod_date", datetime(today(),now()) )
			//End Code Change ----08.03.2011 
				
//Start Code Change ----06.16.2008 #V81 maha moved above  -   lw_win.tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.setitem(i,"exp_credential_flag",0) //maha 032805
		end if
	end if
next

if dw_1.dataobject = "d_ai_update_missing_items" then
	of_update_checklist(ll_appt_ids)
end if
//End Code Change ----06.18.2012 #V12 maha

		
close(parent)

end event

type dw_1 from u_dw within w_ai_update_values
integer x = 23
integer y = 36
integer width = 2441
integer height = 384
integer taborder = 30
string dataobject = "d_ai_batch_update_values"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;if this.GetColumnName() = "response_code" then
	this.setitem(1,"date_recieved",today())
	this.setitem(1,"user_name",gs_user_id)
end if
end event

